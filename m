Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37650C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 22:41:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E67412378A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 22:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRlsNRHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E67412378A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59944 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWTjm-0004n9-27
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 18:41:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hWTiy-0004IS-Hz
	for qemu-devel@nongnu.org; Thu, 30 May 2019 18:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hWTiv-00053r-UH
	for qemu-devel@nongnu.org; Thu, 30 May 2019 18:40:40 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hWTiv-00053B-L0
	for qemu-devel@nongnu.org; Thu, 30 May 2019 18:40:37 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so7250569oth.10
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=AlW4f1qXn73WvdySZUzKCuVsQeTbEboW3iYcg0LvYCQ=;
	b=GRlsNRHZttjjm0r2UkYh3EoXv2YRT8usE9CJ4JxL6BJ9FJCnHUSSJ7HdLHnfNAnytr
	vwpfcZw3XyzV8dN9PwmZn9pPdbCoDSYwtfj8MRDTDbdAACdv+VEWmT2OXbscQ0HpByjT
	CC0Ji5loII2Zkun36Xv4piuAhRsv1UN12FSeChsbTRdLdgBW4f+ZPy7byyZrhW85OB/E
	HRUOYGlv0WWiO8hvqynFnw789fCR2Lm32CvTAGdCZfPQXPu0GKan66X/+iq9NC9U3T2u
	x3iizhTbjWnq1oJPX7/t/K2eWSQ7Tsm4JRcYDweFpz8TgyoWmSurAcIp4ieEdTBkX1ad
	7nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=AlW4f1qXn73WvdySZUzKCuVsQeTbEboW3iYcg0LvYCQ=;
	b=iGrRRhxLBF4+BIB1IJCJSSjs8d7QtJErxV+GMl1Pe5llTXeD36uUJImdmUpwgN3L4M
	dFWl8PIOt7itj2w3Z/fuFy8jPt/guaye/NS7uppAKca4cZxYKIWwsBLFX33Sa6Y1Kdts
	x9Peei1kKYu4KecyvsaNGc3pXeDfDGAXHkovMuK4kUz9cyLFY7YVsJ7iBrqEOsH7FrxP
	dyO/AsCBnhd4vIjO2crmpKLPusn7bcGDrDR5SirNzGdKWK5qiHKbG9JuH+qb7f0JwOrv
	oxVnN0dPkISaMefdJ+CgU6m4zzeuoohDcPYrvb1Y79aaJ76DgGG6+JE+Dpwmbr0dDP6L
	bVVA==
X-Gm-Message-State: APjAAAVluU33n44gfa96GelSTNnbB7ss5BF+PekCPsSWAnjFNfWg3aXr
	ceKepf4bSQd4RVKV3eNd4jtYS14vFW2kFf+0vWg=
X-Google-Smtp-Source: APXvYqzNMCHcF8MTRIbPIOcPbVpfn/wZX4Hm6/u1jDF0Tp82EVyc40aJvR91aSHpsYY3PnCRqcgOkEXDhtNmvZw7/zM=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr4161otm.64.1559256036258;
	Thu, 30 May 2019 15:40:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7212:0:0:0:0:0 with HTTP; Thu, 30 May 2019 15:40:35
	-0700 (PDT)
Received: by 2002:a9d:7212:0:0:0:0:0 with HTTP; Thu, 30 May 2019 15:40:35
	-0700 (PDT)
In-Reply-To: <20190529150853.9772-3-armbru@redhat.com>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 31 May 2019 00:40:35 +0200
Message-ID: <CAL1e-=iM9VUkH+ao+pseJ+2jky2JM9L0hPQzjEF_-BJQjnzENw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 29, 2019 5:09 PM, "Markus Armbruster" <armbru@redhat.com> wrote:
>
> When scripts/get_maintainer.pl reports something like
>
>     John Doe <jdoe@example.org> (maintainer:Overall)
>
> the user is left to wonder *which* of our three "Overall" sections
> applies.  We have three, one each under "Guest CPU cores (TCG)",
> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>
> Rename sections under
>
> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>
> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>
> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>

In its essence definitely not a bad idea, but I must admit I tend to agree
with Philippe the new titles sound confusing, odd, artificial. Perhaps the
better alternative could be:

=E2=80=9CFOO TCG guest=E2=80=9D
=E2=80=9CFOO KVM guest=E2=80=9D
=E2=80=9CFOO Xen guest=E2=80=9D

> * "Architecture support" from "FOO" to "FOO general architecture
>   support"
>

Here we have a kind of strange situation with S390 architecture - it is the
only one present in this way in MAINTAINERS. Othrr than that, your new
wording looks fine to me.

> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>

I think this one you got it right.

Yours,
Aleksandar

>
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc260e503..196282d165 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -83,7 +83,7 @@ T: git https://github.com/vivier/qemu.git
trivial-patches
>
>  Architecture support
>  --------------------
> -S390
> +S390 general architecture support
>  M: Cornelia Huck <cohuck@redhat.com>
>  S: Supported
>  F: default-configs/s390x-softmmu.mak
> @@ -108,7 +108,7 @@ L: qemu-s390x@nongnu.org
>
>  Guest CPU cores (TCG):
>  ----------------------
> -Overall
> +Overall CPU cores (TCG)
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> @@ -133,14 +133,14 @@ F: fpu/
>  F: include/fpu/
>  F: tests/fp/
>
> -Alpha
> +Alpha CPU cores (TCG)
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: target/alpha/
>  F: tests/tcg/alpha/
>  F: disas/alpha.c
>
> -ARM
> +ARM CPU cores (TCG)
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> @@ -161,7 +161,7 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> -CRIS
> +CRIS CPU cores (TCG)
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: target/cris/
> @@ -170,14 +170,14 @@ F: include/hw/cris/
>  F: tests/tcg/cris/
>  F: disas/cris.c
>
> -HPPA (PA-RISC)
> +HPPA (PA-RISC) CPU cores (TCG)
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: target/hppa/
>  F: hw/hppa/
>  F: disas/hppa.c
>
> -LM32
> +LM32 CPU cores (TCG)
>  M: Michael Walle <michael@walle.cc>
>  S: Maintained
>  F: target/lm32/
> @@ -190,20 +190,20 @@ F: include/hw/char/lm32_juart.h
>  F: include/hw/lm32/
>  F: tests/tcg/lm32/
>
> -M68K
> +M68K CPU cores (TCG)
>  M: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: target/m68k/
>  F: disas/m68k.c
>
> -MicroBlaze
> +MicroBlaze CPU cores (TCG)
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: target/microblaze/
>  F: hw/microblaze/
>  F: disas/microblaze.c
>
> -MIPS
> +MIPS CPU cores (TCG)
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> @@ -224,7 +224,7 @@ F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  K: ^Subject:.*(?i)mips
>
> -Moxie
> +Moxie CPU cores (TCG)
>  M: Anthony Green <green@moxielogic.com>
>  S: Maintained
>  F: target/moxie/
> @@ -232,7 +232,7 @@ F: disas/moxie.c
>  F: hw/moxie/
>  F: default-configs/moxie-softmmu.mak
>
> -NiosII
> +NiosII CPU cores (TCG)
>  M: Chris Wulff <crwulff@gmail.com>
>  M: Marek Vasut <marex@denx.de>
>  S: Maintained
> @@ -242,14 +242,14 @@ F: hw/intc/nios2_iic.c
>  F: disas/nios2.c
>  F: default-configs/nios2-softmmu.mak
>
> -OpenRISC
> +OpenRISC CPU cores (TCG)
>  M: Stafford Horne <shorne@gmail.com>
>  S: Odd Fixes
>  F: target/openrisc/
>  F: hw/openrisc/
>  F: tests/tcg/openrisc/
>
> -PowerPC
> +PowerPC CPU cores (TCG)
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
> @@ -258,7 +258,7 @@ F: hw/ppc/
>  F: include/hw/ppc/
>  F: disas/ppc.c
>
> -RISC-V
> +RISC-V CPU cores (TCG)
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> @@ -271,7 +271,7 @@ F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
>
> -S390
> +S390 CPU cores (TCG)
>  M: Richard Henderson <rth@twiddle.net>
>  M: David Hildenbrand <david@redhat.com>
>  S: Maintained
> @@ -281,7 +281,7 @@ F: disas/s390.c
>  F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>
> -SH4
> +SH4 CPU cores (TCG)
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> @@ -289,7 +289,7 @@ F: hw/sh4/
>  F: disas/sh4.c
>  F: include/hw/sh4/
>
> -SPARC
> +SPARC CPU cores (TCG)
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
> @@ -299,14 +299,14 @@ F: hw/sparc64/
>  F: include/hw/sparc/sparc64.h
>  F: disas/sparc.c
>
> -UniCore32
> +UniCore32 CPU cores (TCG)
>  M: Guan Xuetao <gxt@mprc.pku.edu.cn>
>  S: Maintained
>  F: target/unicore32/
>  F: hw/unicore32/
>  F: include/hw/unicore32/
>
> -X86
> +X86 CPU cores (TCG)
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Richard Henderson <rth@twiddle.net>
>  M: Eduardo Habkost <ehabkost@redhat.com>
> @@ -319,7 +319,7 @@ F: disas/i386.c
>  F: docs/qemu-cpu-models.texi
>  T: git https://github.com/ehabkost/qemu.git x86-next
>
> -Xtensa
> +Xtensa CPU cores (TCG)
>  M: Max Filippov <jcmvbkbc@gmail.com>
>  W: http://wiki.osll.ru/doku.php?id=3Detc:users:jcmvbkbc:qemu-target-xten=
sa
>  S: Maintained
> @@ -330,7 +330,7 @@ F: disas/xtensa.c
>  F: include/hw/xtensa/xtensa-isa.h
>  F: default-configs/xtensa*.mak
>
> -TriCore
> +TriCore CPU cores (TCG)
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>  S: Maintained
>  F: target/tricore/
> @@ -345,7 +345,7 @@ F: tests/tcg/multiarch/
>  Guest CPU Cores (KVM):
>  ----------------------
>
> -Overall
> +Overall CPU cores (KVM)
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  L: kvm@vger.kernel.org
>  S: Supported
> @@ -356,24 +356,24 @@ F: include/hw/kvm/
>  F: include/sysemu/kvm*.h
>  F: scripts/kvm/kvm_flightrecorder
>
> -ARM
> +ARM CPU cores (KVM)
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: target/arm/kvm.c
>
> -MIPS
> +MIPS CPU cores (KVM)
>  M: James Hogan <jhogan@kernel.org>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  S: Maintained
>  F: target/mips/kvm.c
>
> -PPC
> +PPC CPU cores (KVM)
>  M: David Gibson <david@gibson.dropbear.id.au>
>  S: Maintained
>  F: target/ppc/kvm.c
>
> -S390
> +S390 CPU cores (KVM)
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> @@ -392,7 +392,7 @@ T: git https://github.com/cohuck/qemu.git s390-next
>  T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>
> -X86
> +X86 CPU cores (KVM)
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Marcelo Tosatti <mtosatti@redhat.com>
>  L: kvm@vger.kernel.org
> @@ -403,7 +403,7 @@ F: scripts/kvm/vmxcap
>  Guest CPU Cores (Xen):
>  ----------------------
>
> -X86
> +X86 CPU cores (Xen)
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
>  M: Paul Durrant <paul.durrant@citrix.com>
> @@ -2256,7 +2256,7 @@ F: tests/uefi-test-tools/
>
>  Usermode Emulation
>  ------------------
> -Overall
> +Overall usermode emulation
>  M: Riku Voipio <riku.voipio@iki.fi>
>  S: Maintained
>  F: thunk.c
> @@ -2282,7 +2282,7 @@ M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/
>
> -AArch64 target
> +AArch64 TCG target
>  M: Claudio Fontana <claudio.fontana@huawei.com>
>  M: Claudio Fontana <claudio.fontana@gmail.com>
>  S: Maintained
> @@ -2291,33 +2291,33 @@ F: tcg/aarch64/
>  F: disas/arm-a64.cc
>  F: disas/libvixl/
>
> -ARM target
> +ARM TCG target
>  M: Andrzej Zaborowski <balrogg@gmail.com>
>  S: Maintained
>  L: qemu-arm@nongnu.org
>  F: tcg/arm/
>  F: disas/arm.c
>
> -i386 target
> +i386 TCG target
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/i386/
>  F: disas/i386.c
>
> -MIPS target
> +MIPS TCG target
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  S: Maintained
>  F: tcg/mips/
>  F: disas/mips.c
>
> -PPC
> +PPC TCG target
>  M: Richard Henderson <rth@twiddle.net>
>  S: Odd Fixes
>  F: tcg/ppc/
>  F: disas/ppc.c
>
> -RISC-V
> +RISC-V TCG target
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  L: qemu-riscv@nongnu.org
> @@ -2325,19 +2325,19 @@ S: Maintained
>  F: tcg/riscv/
>  F: disas/riscv.c
>
> -S390 target
> +S390 TCG target
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/s390/
>  F: disas/s390.c
>  L: qemu-s390x@nongnu.org
>
> -SPARC target
> +SPARC TCG target
>  S: Odd Fixes
>  F: tcg/sparc/
>  F: disas/sparc.c
>
> -TCI target
> +TCI TCG target
>  M: Stefan Weil <sw@weilnetz.de>
>  S: Maintained
>  F: tcg/tci/
> --
> 2.17.2
>
>
