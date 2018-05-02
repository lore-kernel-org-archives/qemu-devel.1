Received: from eggs.gnu.org ([2001:4830:134:3::10]:48320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDqI9-0003hK-2m
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDqI8-0003xJ-C2
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:51:25 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDqI8-0003ww-5l
	for qemu-devel@nongnu.org; Wed, 02 May 2018 07:51:24 -0400
Received: by mail-oi0-x233.google.com with SMTP id a6-v6so12652696oia.2
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 04:51:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <987b683f-e05e-780a-40cf-68b6b8d0641f@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<d50e3a40-d7f3-4c9b-e930-4c2f4d6c8a53@redhat.com>
	<CAFEAcA8wJuJ9464LadgjJOo-7ttdGYcfDQWALbkxBRJCr_knkg@mail.gmail.com>
	<20180427210120.03d037b0@naga.suse.cz>
	<70cb944b-269c-2969-4727-b889298ece30@linaro.org>
	<987b683f-e05e-780a-40cf-68b6b8d0641f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 May 2018 12:51:02 +0100
Message-ID: <CAFEAcA9SKhjHLnX6p51eG9Qs6ke3QahgTwRAH0=mFUBJBZYYng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 2 May 2018 at 11:41, Laszlo Ersek <lersek@redhat.com> wrote:
> What about guest RAM size (more precisely, guest-phys address space)?
>
> The x86_64 target might want to use tens of GBs of guest-phys address
> space, e.g. for cold-plugged RAM, for DIMM hotplug, for 64-bit PCI MMIO
> aperture. To my understanding, all of those have to be expressed with
> host virtual addresses in the QEMU process (regardless of TCG vs. KVM).
> But on a 32-bit host, the QEMU process only has 4GB HVA space.

I think the situation there would be unchanged -- on a 32 bit
host the ramaddr type is 32 bits (unless Xen is configured into
the binary!) regardless of the guest architecture size, and the
limit on RAM size is 2GB, and the hwaddr is 64 bits regardless
of guest architecture size. That wouldn't change whether we had
a single executable or split ones for 32 and 64 bit targets.
You can have more than 4GB of guest physical address space
(we don't map that into the host address space), but there's
a 2GB RAM limit (because we do map all the RAM blocks); these
limits currently apply equally to qemu-system-i386 and
qemu-system_x86-64.

thanks
-- PMM
