Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EACC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D997321741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D997321741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07jx-00023r-4R
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:48:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j07hX-0007lB-QJ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:46:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j07hV-0006hA-I4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:45:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j07hV-0006gh-98; Fri, 07 Feb 2020 12:45:57 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MDN3O-1iqk272ECM-00AZop; Fri, 07 Feb 2020 18:45:01 +0100
Subject: Re: [PATCH v4 1/3] hw: Do not initialize MachineClass::is_default to 0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207161948.15972-1-philmd@redhat.com>
 <20200207161948.15972-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cfa0a061-7987-909a-a7a7-f0e723f9bcbb@vivier.eu>
Date: Fri, 7 Feb 2020 18:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200207161948.15972-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WpmLU6vm2x9syD8t+2SgLRjMhnZpfR3IeFCieIfZJcF4SnFtAsN
 a6qUnmwgjGg8VFklHiqWqWPddn6O7bzS1ZHcePp1CUCMk0UvVYI2BajqvFymuXFrnZkvm41
 GPCIpFGbxCRpNeEMp0VGoADXyQo9UkJMgBtKqC0TnMzRfl5GNg+/XGkctFPLSV7/hGeaesq
 YvsbZ93ZaatAzuMTd+1Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/5iHhfPxcPo=:Ln446UmRjIGVh3L7hJ/zE8
 fvVttgRV8e4V6C1Hf1EB4kDHmmtFnBwi2fpY3D/IL5Fm1hKRwefcQ4olY5PBs6c8fAPNMbqsg
 itRb6tSdRNtH2HgwDW20kN9jKL5ujvSG1jCLsM+hUOWAYPDVWUrvQnaqbU5S/JWBjBJFZyaer
 xZn4MC9AbgHd/HcmyEFeEhcjMa0bPN060t+KMwShsbmmhOJC4BGpO6L8v1GfzCFufbdGDliz/
 sHYe6jet+EM+sNc4t7+a3zLZG41YYx0yX0miAeSCytjGRl29AHoMajLsAVAviNy/V/+XjAUNM
 Klc91PlMnzjUUoHmzxN1B5wr+XJTJQhkJa0mfGZV/EtrJ5sQawtem8fi219VxTNT93D1aEUhs
 2y9+/3pCPzdS0k7iSh+0bsUOtcgO/wotKDbRmVnb/XdekBC2Oadj41ZBwVes6hFzS0Jo5fxkn
 /QhLDHhczCmxsmz0zjF1cg/0QyZSgnTUFUIThS9NPIj9pUoQiDfHlCf0/jK+KG1qYj3zKPHCb
 xvXEf8N1HNH6/+qA2CdCX5kApzDA0tRawEsm96/GVsXQae0MyHmmANy93E85N6U4Fxn/JDGd5
 yWe6DM4R6VndSNq3VCDT8ZIrscW1n50BkYFpJxeYH9SC0zCY3jMeBR0uJfnt+KdOY+foqwnob
 vgbVw6w40z+mupP6CO3fFeRK7vXvQoO5le+VTeNR78k4CvJLMbFcHOEogolPlZQY514yKvkSh
 3Dx5bbtFbjYyNTuXaw8yK/wHM4x2d7P9yenKiAGvbMHcVPDa5UFEoPysVmZygaZmVt+jfk4hZ
 b0toor5W/y6pbTQixV33uHzSGdyygYB5S9mwPxyokIrPO1ubGdgRDe7wD8ChNVoO2CkfkKc
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/02/2020 à 17:19, Philippe Mathieu-Daudé a écrit :
> The MachineClass is already zeroed on creation.
> 
> Note: The code setting is_default=0 in hw/i386/pc_piix.c is
>       different (related to compat options). When adding a
>       new versioned machine, we want it to be the new default,
>       so we have to mark the previous one as not default.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v3: new patch
> ---
>  hw/lm32/lm32_boards.c               | 1 -
>  hw/lm32/milkymist.c                 | 1 -
>  hw/m68k/q800.c                      | 1 -
>  hw/microblaze/petalogix_ml605_mmu.c | 1 -
>  hw/tricore/tricore_testboard.c      | 1 -
>  5 files changed, 5 deletions(-)
> 
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index d1894adab8..156b050abc 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -302,7 +302,6 @@ static void lm32_uclinux_class_init(ObjectClass *oc, void *data)
>  
>      mc->desc = "lm32 platform for uClinux and u-boot by Theobroma Systems";
>      mc->init = lm32_uclinux_init;
> -    mc->is_default = 0;
>      mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>  }
>  
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 6d46134232..9fa5fd7050 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -214,7 +214,6 @@ static void milkymist_machine_init(MachineClass *mc)
>  {
>      mc->desc = "Milkymist One";
>      mc->init = milkymist_init;
> -    mc->is_default = 0;
>      mc->default_cpu_type = LM32_CPU_TYPE_NAME("lm32-full");
>  }
>  
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index 1e32363688..788b5d663f 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -441,7 +441,6 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>      mc->init = q800_init;
>      mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
>      mc->max_cpus = 1;
> -    mc->is_default = 0;
>      mc->block_default_type = IF_SCSI;
>  }
>  
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index 09486bc8bf..0a2640c40b 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -216,7 +216,6 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
>  {
>      mc->desc = "PetaLogix linux refdesign for xilinx ml605 little endian";
>      mc->init = petalogix_ml605_init;
> -    mc->is_default = 0;
>  }
>  
>  DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
> diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
> index 20c9ccb3ce..8ec2b5bddd 100644
> --- a/hw/tricore/tricore_testboard.c
> +++ b/hw/tricore/tricore_testboard.c
> @@ -105,7 +105,6 @@ static void ttb_machine_init(MachineClass *mc)
>  {
>      mc->desc = "a minimal TriCore board";
>      mc->init = tricoreboard_init;
> -    mc->is_default = 0;
>      mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
>  }
>  
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

