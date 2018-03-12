Received: from eggs.gnu.org ([2001:4830:134:3::10]:60337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evME8-0001gX-Qp
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1evME2-0006n7-P8
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:06:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49926 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1evME2-0006mP-KL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:06:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6E568182D33
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:06:42 +0000 (UTC)
References: <1520839658-20499-1-git-send-email-thuth@redhat.com>
	<2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75c3173e-507b-e541-4a21-72c980cf1b5c@redhat.com>
Date: Mon, 12 Mar 2018 13:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <2a85941f-48bf-9e9b-0d6d-832a270d882b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-doc: Rework the network options
 chapter to make "-net" less prominent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On 12.03.2018 10:07, Paolo Bonzini wrote:
> On 12/03/2018 08:27, Thomas Huth wrote:
>> "-net" is clearly a legacy option. Yet we still use it in almost all
>> examples in the qemu documentation, and many other spots in the network
>> chapter. We should make it less prominent that users are not lured into
>> using it so often anymore. So instead of starting the network chapter with
>> "-net nic" and documenting "-net <backend>" below "-netdev <backend>"
>> everywhere, all the "-net" related documentation is now moved to the end
>> of the chapter. The new "--nic" option is moved to the beginning of the
>> chapter instead, with a new example that should demonstrate how "--nic"
>> can be used to shortcut "--device" with "--netdev". The examples in this
>> chapter are changed to use the "--device" and "--netdev" options or
>> "--nic" instead of "-net nic -net <backend>".
>>
>> While we're at it, also remove a legacy remark about very old Linux
>> distributions. Also remove the "[...]" from the examples in this chapter
>> since we are not using this ellipsis in any other examples in our docu-
>> mentation.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2:
>>  - Fixed the bad "--device=e1000" example
> 
> Frankly I think this is the proof that double-dash option names are a
> bad idea.  The reason to do that was to make qemu-img and qemu command
> lines more similar in the documentation, but the truth is they are not
> similar and shouldn't be made similar.  The equal sign is one example,
> where qemu-img supports "--format=raw" but QEMU doesn't support
> "--device=e1000", but it's not the only one.
> 
> qemu-img supports things such as "-fraw", qemu doesn't---for example
> "-m1024" doesn't work).  qemu-img can combine single-letter options
> (e.g. "qemu-img convert -pc") but qemu cannot---e.g. "-sm" doesn't
> combine "-s" and "-m".

I guess we could work on most of these issues ... but until we're there,
you're maybe right and we should not switch to double dash options in
the documentation yet. I'll send a v3 without double dashes...

 Thomas
