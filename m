Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7706C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A076523CE4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 16:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A076523CE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW16c-0001HT-GG
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 12:07:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW13P-0007jP-2U
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hW13M-0008Iv-VU
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:03:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hW13M-0008Hw-Kg
	for qemu-devel@nongnu.org; Wed, 29 May 2019 12:03:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id f8so2213061wrt.1
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 09:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=UdgCX3lhKyBCfIL3R+fEHxibIjw03UosU0QJ2pCYSsc=;
	b=Pgvb4wL2r9CTwc4zlVWfll4o2D61LTl41Ww0dVgv6MnCz3qxA5RA8Bzjs+huVo8f3i
	Ej6yhix3eB9rOZix6bZOI/fbp2qs/RHLKDw0Ma+DLCSkkEYxYT4kwlRIOQWDRmOOL853
	AESgnU3sRQLI0F13ocdUMhhTuNBaVJBeQNd2OXQYdJwAAuuInbWT44VA7JKLlvs5u8jW
	qB+G5Bua2GDZhzeRWSSpnDiqoGZo9jVwSqqnF7odCuEI7Lc38h81Bx6N5FkMRYi5mAs1
	y2ex4/UHxPBxjun381N5FAkKny5x1y42niK3Tx26fQSXDTpsskribz/+XiscTe7rJsqc
	f/lQ==
X-Gm-Message-State: APjAAAU4Efm6Nby7CGeIYDKImVUj3ftE0+Zkgnc2LugGLT2Bw91G3Y1d
	6qp74GiBCbOwK3yD1DOe0ro42UhntDY=
X-Google-Smtp-Source: APXvYqwVaCY8LXBPzuPhljRVUoiC3bJbb9e5+a4FZkKqVkmynQX/oqVFkk7eJR35MiqeAzitj4gsRQ==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr22478517wrw.309.1559145826189; 
	Wed, 29 May 2019 09:03:46 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id
	t6sm13226541wmt.34.2019.05.29.09.03.44
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 09:03:45 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <24e6c800-e3aa-7400-598e-c94b80254de0@redhat.com>
Date: Wed, 29 May 2019 18:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529150853.9772-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/29/19 5:08 PM, Markus Armbruster wrote:
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
> * "Architecture support" from "FOO" to "FOO general architecture
>   support"
> 
> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"

I find the "cores" pattern more confusing now :S

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
> @@ -83,7 +83,7 @@ T: git https://github.com/vivier/qemu.git trivial-patches
>  
>  Architecture support
>  --------------------
> -S390
> +S390 general architecture support

OK

>  M: Cornelia Huck <cohuck@redhat.com>
>  S: Supported
>  F: default-configs/s390x-softmmu.mak
> @@ -108,7 +108,7 @@ L: qemu-s390x@nongnu.org
>  
>  Guest CPU cores (TCG):
>  ----------------------
> -Overall
> +Overall CPU cores (TCG)

What about "TCG (Overall)"?

>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> @@ -133,14 +133,14 @@ F: fpu/
>  F: include/fpu/
>  F: tests/fp/
>  
> -Alpha
> +Alpha CPU cores (TCG)

I find "cores" confusing here, why not use "Alpha CPU (TCG)"?

>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: target/alpha/
>  F: tests/tcg/alpha/
>  F: disas/alpha.c
>  
> -ARM
> +ARM CPU cores (TCG)

Ditto.

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
>  W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
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

"KVM (Overall)"?

>  M: Paolo Bonzini <pbonzini@redhat.com>
>  L: kvm@vger.kernel.org
>  S: Supported
> @@ -356,24 +356,24 @@ F: include/hw/kvm/
>  F: include/sysemu/kvm*.h
>  F: scripts/kvm/kvm_flightrecorder
>  
> -ARM
> +ARM CPU cores (KVM)

"ARM CPU (KVM)"?

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

"Usermode Emulation (Overall)"?

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
> 

