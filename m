Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8471C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:23:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A3A20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 22:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A3A20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ0nL-0002K0-RZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 18:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33532)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ0mX-0001uP-DZ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ0mV-0000VO-82
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:22:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ0mV-0000Ht-1H
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 18:22:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so162877wrw.13
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 15:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PiHuVItLVi90qs6RyHj90SYLpNy/S8dVTHFhwpf8j2o=;
 b=MvCtfdBkMrVrhRoRrdA+PEoMfH1EPme7B4IxDmXEc4TuHA+sn1xGkfbajDwL3kkDdZ
 d3Nt8hkyKG8rRLtUQMue1mZCq/qYh/62fwI4ITCNvYZgkbTsOegf1zNoSRrmzkBq5yTa
 tKWS1xKIQiK7Io5vC2buMuUiffK/oV7nd6dTrhsK8qwtJC9JydedJYl0002nRnC3nB6/
 hA3tCitY/FlD1Cs26BkMkct9b1iDsZB73lCiuIdJE3ax3nXCaq6HW3ciNWgLGqBjbjy8
 Vjl6gx3PPxu5ig9Gq+74mneenJ7nQp5IcVrpIR1bo7W/mZCQw000jCLfwoG/b4P4FF4r
 Yiug==
X-Gm-Message-State: APjAAAUB9x2Fm/X5sFT8RgbhuXg++ov8/u3o5w4dG0PEG0DMy/idW4RX
 0lMBTOpXoBrcr4mSxFxLKLkLRQ==
X-Google-Smtp-Source: APXvYqzlUl0pyuwKZkvrD4PjSe8PzyOrGJw2Y8TeZE5+nVoP3YAwcjXd7rWYbVn8KeBVsQ3bdt3k5w==
X-Received: by 2002:a5d:624c:: with SMTP id m12mr15885942wrv.354.1559859753140; 
 Thu, 06 Jun 2019 15:22:33 -0700 (PDT)
Received: from [192.168.0.156] ([78.192.181.46])
 by smtp.gmail.com with ESMTPSA id b5sm90174wru.69.2019.06.06.15.22.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Jun 2019 15:22:32 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190606172408.18399-1-armbru@redhat.com>
 <20190606172408.18399-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f494d513-3cb5-41f2-414f-a6fe38839af8@redhat.com>
Date: Fri, 7 Jun 2019 00:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606172408.18399-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 2/3] MAINTAINERS: Improve section
 headlines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 7:24 PM, Markus Armbruster wrote:
> When scripts/get_maintainer.pl reports something like
> 
>     John Doe <jdoe@example.org> (maintainer:Overall)
> 
> the user is left to wonder *which* of our three "Overall" sections
> applies: the one under "Guest CPU cores (TCG)", or the one under
> "Guest CPU Cores (KVM)", or the one under "Usermode emulation".
> 
> Rename sections under
> 
> * "Guest CPU cores (TCG)" from "FOO" to "FOO TCG CPUs"
> 
> * "Guest CPU Cores (KVM)" from "FOO" to "FOO KVM CPUs"
> 
> * "Guest CPU Cores (Xen)" from "FOO" to "FOO Xen CPUs"
> 
> * "Architecture support" from "FOO" to "FOO general architecture
>   support"
> 
> * "Usermode Emulation" from "Overall" to "Overall usermode emulation"
> 
> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target",
>   and from "Common code" to "Common TCG code"

I really prefer "FOO XXX (TCG|KVM|Xen)", it looks less confuse to me,
but I'm not going to lose sleep about this either way it goes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  MAINTAINERS | 80 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d0d8c09cc..bdc82c5735 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -83,7 +83,7 @@ T: git https://github.com/vivier/qemu.git trivial-patches
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
> +Overall TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  R: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> @@ -133,14 +133,14 @@ F: fpu/
>  F: include/fpu/
>  F: tests/fp/
>  
> -Alpha
> +Alpha TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: target/alpha/
>  F: tests/tcg/alpha/
>  F: disas/alpha.c
>  
> -ARM
> +ARM TCG CPUs
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
> @@ -161,7 +161,7 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>  
> -CRIS
> +CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: target/cris/
> @@ -170,14 +170,14 @@ F: include/hw/cris/
>  F: tests/tcg/cris/
>  F: disas/cris.c
>  
> -HPPA (PA-RISC)
> +HPPA (PA-RISC) TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: target/hppa/
>  F: hw/hppa/
>  F: disas/hppa.c
>  
> -LM32
> +LM32 TCG CPUs
>  M: Michael Walle <michael@walle.cc>
>  S: Maintained
>  F: target/lm32/
> @@ -190,20 +190,20 @@ F: include/hw/char/lm32_juart.h
>  F: include/hw/lm32/
>  F: tests/tcg/lm32/
>  
> -M68K
> +M68K TCG CPUs
>  M: Laurent Vivier <laurent@vivier.eu>
>  S: Maintained
>  F: target/m68k/
>  F: disas/m68k.c
>  
> -MicroBlaze
> +MicroBlaze TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
>  F: target/microblaze/
>  F: hw/microblaze/
>  F: disas/microblaze.c
>  
> -MIPS
> +MIPS TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
> @@ -224,7 +224,7 @@ F: include/hw/timer/mips_gictimer.h
>  F: tests/tcg/mips/
>  K: ^Subject:.*(?i)mips
>  
> -Moxie
> +Moxie TCG CPUs
>  M: Anthony Green <green@moxielogic.com>
>  S: Maintained
>  F: target/moxie/
> @@ -232,7 +232,7 @@ F: disas/moxie.c
>  F: hw/moxie/
>  F: default-configs/moxie-softmmu.mak
>  
> -NiosII
> +NiosII TCG CPUs
>  M: Chris Wulff <crwulff@gmail.com>
>  M: Marek Vasut <marex@denx.de>
>  S: Maintained
> @@ -242,14 +242,14 @@ F: hw/intc/nios2_iic.c
>  F: disas/nios2.c
>  F: default-configs/nios2-softmmu.mak
>  
> -OpenRISC
> +OpenRISC TCG CPUs
>  M: Stafford Horne <shorne@gmail.com>
>  S: Odd Fixes
>  F: target/openrisc/
>  F: hw/openrisc/
>  F: tests/tcg/openrisc/
>  
> -PowerPC
> +PowerPC TCG CPUs
>  M: David Gibson <david@gibson.dropbear.id.au>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
> @@ -258,7 +258,7 @@ F: hw/ppc/
>  F: include/hw/ppc/
>  F: disas/ppc.c
>  
> -RISC-V
> +RISC-V TCG CPUs
>  M: Palmer Dabbelt <palmer@sifive.com>
>  M: Alistair Francis <Alistair.Francis@wdc.com>
>  M: Sagar Karandikar <sagark@eecs.berkeley.edu>
> @@ -271,7 +271,7 @@ F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
>  
> -S390
> +S390 TCG CPUs
>  M: Richard Henderson <rth@twiddle.net>
>  M: David Hildenbrand <david@redhat.com>
>  S: Maintained
> @@ -281,7 +281,7 @@ F: disas/s390.c
>  F: tests/tcg/s390x/
>  L: qemu-s390x@nongnu.org
>  
> -SH4
> +SH4 TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> @@ -289,7 +289,7 @@ F: hw/sh4/
>  F: disas/sh4.c
>  F: include/hw/sh4/
>  
> -SPARC
> +SPARC TCG CPUs
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>  M: Artyom Tarasenko <atar4qemu@gmail.com>
>  S: Maintained
> @@ -299,14 +299,14 @@ F: hw/sparc64/
>  F: include/hw/sparc/sparc64.h
>  F: disas/sparc.c
>  
> -UniCore32
> +UniCore32 TCG CPUs
>  M: Guan Xuetao <gxt@mprc.pku.edu.cn>
>  S: Maintained
>  F: target/unicore32/
>  F: hw/unicore32/
>  F: include/hw/unicore32/
>  
> -X86
> +X86 TCG CPUs
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Richard Henderson <rth@twiddle.net>
>  M: Eduardo Habkost <ehabkost@redhat.com>
> @@ -319,7 +319,7 @@ F: disas/i386.c
>  F: docs/qemu-cpu-models.texi
>  T: git https://github.com/ehabkost/qemu.git x86-next
>  
> -Xtensa
> +Xtensa TCG CPUs
>  M: Max Filippov <jcmvbkbc@gmail.com>
>  W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
>  S: Maintained
> @@ -330,7 +330,7 @@ F: disas/xtensa.c
>  F: include/hw/xtensa/xtensa-isa.h
>  F: default-configs/xtensa*.mak
>  
> -TriCore
> +TriCore TCG CPUs
>  M: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>  S: Maintained
>  F: target/tricore/
> @@ -345,7 +345,7 @@ F: tests/tcg/multiarch/
>  Guest CPU Cores (KVM):
>  ----------------------
>  
> -Overall
> +Overall KVM CPUs
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  L: kvm@vger.kernel.org
>  S: Supported
> @@ -356,24 +356,24 @@ F: include/hw/kvm/
>  F: include/sysemu/kvm*.h
>  F: scripts/kvm/kvm_flightrecorder
>  
> -ARM
> +ARM KVM CPUs
>  M: Peter Maydell <peter.maydell@linaro.org>
>  L: qemu-arm@nongnu.org
>  S: Maintained
>  F: target/arm/kvm.c
>  
> -MIPS
> +MIPS KVM CPUs
>  M: James Hogan <jhogan@kernel.org>
>  R: Aleksandar Rikalo <arikalo@wavecomp.com>
>  S: Maintained
>  F: target/mips/kvm.c
>  
> -PPC
> +PPC KVM CPUs
>  M: David Gibson <david@gibson.dropbear.id.au>
>  S: Maintained
>  F: target/ppc/kvm.c
>  
> -S390
> +S390 KVM CPUs
>  M: Halil Pasic <pasic@linux.ibm.com>
>  M: Cornelia Huck <cohuck@redhat.com>
>  M: Christian Borntraeger <borntraeger@de.ibm.com>
> @@ -392,7 +392,7 @@ T: git https://github.com/cohuck/qemu.git s390-next
>  T: git https://github.com/borntraeger/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
> -X86
> +X86 KVM CPUs
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  M: Marcelo Tosatti <mtosatti@redhat.com>
>  L: kvm@vger.kernel.org
> @@ -403,7 +403,7 @@ F: scripts/kvm/vmxcap
>  Guest CPU Cores (Xen):
>  ----------------------
>  
> -X86
> +X86 Xen CPUs
>  M: Stefano Stabellini <sstabellini@kernel.org>
>  M: Anthony Perard <anthony.perard@citrix.com>
>  M: Paul Durrant <paul.durrant@citrix.com>
> @@ -2265,7 +2265,7 @@ F: tests/uefi-test-tools/
>  
>  Usermode Emulation
>  ------------------
> -Overall
> +Overall usermode emulation
>  M: Riku Voipio <riku.voipio@iki.fi>
>  S: Maintained
>  F: thunk.c
> @@ -2286,12 +2286,12 @@ F: scripts/qemu-binfmt-conf.sh
>  
>  Tiny Code Generator (TCG)
>  -------------------------
> -Common code
> +Common TCG code
>  M: Richard Henderson <rth@twiddle.net>
>  S: Maintained
>  F: tcg/
>  
> -AArch64 target
> +AArch64 TCG target
>  M: Claudio Fontana <claudio.fontana@huawei.com>
>  M: Claudio Fontana <claudio.fontana@gmail.com>
>  S: Maintained
> @@ -2300,33 +2300,33 @@ F: tcg/aarch64/
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
> @@ -2334,19 +2334,19 @@ S: Maintained
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

