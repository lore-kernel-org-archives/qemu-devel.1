Received: from eggs.gnu.org ([209.51.188.92]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3LNS-0003bY-A1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1h3LIT-00044T-Ra
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:48:54 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1h3LIS-00043h-5d
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:48:53 -0400
Received: by mail-wm1-f45.google.com with SMTP id z84so4356471wmg.4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:48:51 -0700 (PDT)
References: <871s3dg3si.fsf@redhat.com>
	<3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
From: Sergio Lopez <slp@redhat.com>
In-reply-to: <3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
Date: Mon, 11 Mar 2019 14:48:48 +0100
Message-ID: <87zhq1ed33.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini writes:

> On 11/03/19 10:26, Sergio Lopez wrote:
>> I guess this is a consequence of having to reset/rebuild the Flatview
>> when altering the PCI BAR regions.
>> 
>> Is this a known issue we're already working on?
>
> What version of QEMU is this?

This upstream as of 6cb4f6db4f4367f (Mar 07 2019).

> The initialization is O(n^2) because the guest initializes one device at
> a time, so you rebuild the FlatView first with 0 devices, then 1, then
> 2, etc.  This is very hard to fix, if at all possible.
>
> However, each FlatView creation should be O(n) where n is the number of
> devices currently configured.  Please check with "info mtree -f" that
> you only have a fixed number of FlatViews.  Old versions had one per device.

I'm seeing 9 FVs with 1 PCI, and 119 with 100 PCIs.

Thanks,
Sergio.
