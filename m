Received: from eggs.gnu.org ([2001:4830:134:3::10]:43109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoHv9-00084t-Fu
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eoHv6-0003xS-66
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:06:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33750 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eoHv6-0003wr-17
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 19:06:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5678A407244E
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 00:05:48 +0000 (UTC)
References: <1519148406-15006-1-git-send-email-thuth@redhat.com>
	<1519148406-15006-9-git-send-email-thuth@redhat.com>
	<55a10378-b99f-f73c-3162-55dcf023453b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <06c04a52-2f9c-2a95-1f47-e8e448c5f2c1@redhat.com>
Date: Wed, 21 Feb 2018 01:05:39 +0100
MIME-Version: 1.0
In-Reply-To: <55a10378-b99f-f73c-3162-55dcf023453b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qemu-doc: Make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 20.02.2018 19:37, Paolo Bonzini wrote:
> On 20/02/2018 18:40, Thomas Huth wrote:
>> "-net" is clearly a legacy option. Yet we still use it in almost all
>> examples in the qemu documentation, and many other spots in the networ=
k
>> chapter. We should make it less prominent that users are not lured int=
o
>> using it so often anymore. So instead of starting the network chapter =
with
>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>> everywhere, all the "-net" related documentation is now moved to the e=
nd
>> of the chapter. And the examples are changed to use the "--device" and
>> "--netdev" options instead of "-net nic -net <backend>".
>=20
> Do we want to change them to "-nic" instead?  The proof is in the
> pudding, they say, :) and "-nic" is way easier to learn than "-device
> -netdev".

While -nic is easier to use than -netdev, I don't think that we should
put the focus in our main qemu-doc on -nic instead of -netdev. -nic is a
convenience option, while -netdev is the "architected" way to configure
network devices. We first should document how to do it "right", and
teach the user to proper distinguish between emulated guest hardware and
host network backend (with the old -net command, a lot of people seemed
to have mixed that up IIRC), and then finally explain -nic on top of it.

> And maybe we *should* go the extra mile and deprecate "-net" altogether=
.
>  The only case where the newer syntax is a bit more uncomfortable is fo=
r
> "-net nic -net nic -net tap|user", which however does work with "-nic
> hubport -nic hubport -netdev tap|user,id=3Dx -netdev hubport,netdev=3Dx=
".

I'd be glad to add such a deprecation patch to this series - I just
thought it might have been too early so far, but if you feel confident
that we can mark it as deprecated, I can spin a v3 with such a patch on
top...

 Thomas
