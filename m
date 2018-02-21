Received: from eggs.gnu.org ([2001:4830:134:3::10]:38669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoQSB-00041A-0J
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoQS7-00013B-SJ
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:43 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:43597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoQS7-00012e-M3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:39 -0500
Received: by mail-wr0-f172.google.com with SMTP id u49so2302974wrc.10
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 01:12:39 -0800 (PST)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-9-git-send-email-thuth@redhat.com>
	<55a10378-b99f-f73c-3162-55dcf023453b@redhat.com>
	<06c04a52-2f9c-2a95-1f47-e8e448c5f2c1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c13de0b1-a35f-950c-a6fe-628a2a99b19d@redhat.com>
Date: Wed, 21 Feb 2018 10:12:36 +0100
MIME-Version: 1.0
In-Reply-To: <06c04a52-2f9c-2a95-1f47-e8e448c5f2c1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qemu-doc: Make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

On 21/02/2018 01:05, Thomas Huth wrote:
> On 20.02.2018 19:37, Paolo Bonzini wrote:
>> On 20/02/2018 18:40, Thomas Huth wrote:
>>> "-net" is clearly a legacy option. Yet we still use it in almost all
>>> examples in the qemu documentation, and many other spots in the network
>>> chapter. We should make it less prominent that users are not lured into
>>> using it so often anymore. So instead of starting the network chapter with
>>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>>> everywhere, all the "-net" related documentation is now moved to the end
>>> of the chapter. And the examples are changed to use the "--device" and
>>> "--netdev" options instead of "-net nic -net <backend>".
>>
>> Do we want to change them to "-nic" instead?  The proof is in the
>> pudding, they say, :) and "-nic" is way easier to learn than "-device
>> -netdev".
> 
> While -nic is easier to use than -netdev, I don't think that we should
> put the focus in our main qemu-doc on -nic instead of -netdev. -nic is a
> convenience option, while -netdev is the "architected" way to configure
> network devices. We first should document how to do it "right", and
> teach the user to proper distinguish between emulated guest hardware and
> host network backend (with the old -net command, a lot of people seemed
> to have mixed that up IIRC), and then finally explain -nic on top of it.

Heh, that's a philosophy question regarding the organization of the
whole manual.  Currently the "architected" way is pretty much confined
to docs/qdev-device-use.txt.  The manual is full of uses of -drive or
-hda, and I think it makes sense because honestly that's what users use.
 I should have explained this in the previous message, sorry.

>> And maybe we *should* go the extra mile and deprecate "-net" altogether.
>>  The only case where the newer syntax is a bit more uncomfortable is for
>> "-net nic -net nic -net tap|user", which however does work with "-nic
>> hubport -nic hubport -netdev tap|user,id=x -netdev hubport,netdev=x".
> 
> I'd be glad to add such a deprecation patch to this series - I just
> thought it might have been too early so far, but if you feel confident
> that we can mark it as deprecated, I can spin a v3 with such a patch on
> top...

I can't deny it's going to be a loooong deprecation.  But we have to
start somewhere, and -nic is a great start.

I think you should send v3 with the minimal changes required to accept
these patches, and then leave the rest to a separate submission, but of
course you don't have to do it that way.

Thanks,

Paolo
