Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRS4-0004Cw-Dp
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRRz-0003xn-Bw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:57:20 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:34172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTRRz-0003xa-3v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:57:15 -0500
Received: by mail-vk0-x229.google.com with SMTP id r136so89927387vke.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 02:57:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170117094950.5dqdpbk6u7p4yhms@kamzik.brq.redhat.com>
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
	<CAKv+Gu-hAzng0ff4=r2JZF5p=nEhhv12-kwg7wz+m7Uj4w42DA@mail.gmail.com>
	<CAFEAcA8n5grNz+z1ZcNcX9Er9s=uXRPgV-b1-3tkrzWEv-=1Uw@mail.gmail.com>
	<CAKv+Gu_+O-_x-CwQdiTf4efWAMue6LdXK3Afo9YW8Xz+6BFyzw@mail.gmail.com>
	<20170117094950.5dqdpbk6u7p4yhms@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 10:56:53 +0000
Message-ID: <CAFEAcA-Cdyq-dQ0U79TSsjJWQ2TO0R11RCWzAemSRS_1M65meg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 17 January 2017 at 09:49, Andrew Jones <drjones@redhat.com> wrote:
> In some cases the problem we're solving with the compat guards is
> a bit hypothetical, but, IMHO, nonetheless a good practice. While
> we may be sure that AAVMF and Linux will be fine with this table
> changing under their feet, we can't be sure there aren't other
> mach-virt users that have more sensitive firmwares/OSes. An ACPI-
> sensitive OS may notice the change on its next reboot after a
> migration, and then simply refuse to continue.

There's also the case where you do a VM migration midway through
UEFI booting up, I think, which might cause things to go wrong
if you catch it just at the wrong moment.

> Now, that said, I just spoke with Igor in order to learn the x86
> practice. He says that the policy has been more lax than what I
> suggest above. Hypothetical, low-risk issues are left unguarded,
> and only when a bug is found during testing is it then managed.
> The idea is to try and reduce the amount of compat variables and
> conditions needed in the ACPI generation code, but, of course, at
> some level of risk to users expecting their versioned machine type
> to always appear the same.
>
> So far we've been strict with mach-virt, guarding all hypothetical
> issues. Perhaps this patch is a good example to get a discussion
> started on whether or not we should be so strict though.

That said, I don't have a very strong opinion here, beyond that
we should be consistent at least with x86 practice.

thanks
-- PMM
