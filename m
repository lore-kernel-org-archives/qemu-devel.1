Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C74C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9665F20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqL5G0xb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9665F20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDTFT-0003Hg-P8
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDTEf-0002Yk-67
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:55:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDTEd-00064c-9W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:55:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id t10so4501488wrv.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fz0sZhJ6S9T1QaeQN6uzSixARB/wWXtZ3fYXiqLUZaE=;
 b=qqL5G0xb/YZJwgaNt+11jCLn4WAvJ7lHPbRU3eE5aon+nvRp81eXbss09Qdnprav23
 Zc8YBTqLsmU4md0zzkdOOefVAC6lPLrMRiiu8nbs7rKxgmBlsRvWWHALux7h4VPUMC0c
 ach4DbjU5MEY7PK6sjIj9P/38THxtoZqvSSxfJilbl9xIdEOq5NQjK3hzyAyRCzsAMBe
 ZqCsC5IW1T2xrOGNl4cFR0BRSH+nk1Dpv7PtibFcfzn8IOeEcUFgy08TbL7HJFJ4IcuU
 R8UMdgUsxOEETNqyxLSAbgX1JwehCuzqMPx6MEuEh4EaBnAHEaKvJyEAJMUjBgL8JE+a
 WfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fz0sZhJ6S9T1QaeQN6uzSixARB/wWXtZ3fYXiqLUZaE=;
 b=L46Tgh3GaIVkdEMXpXyU+HC7ljQ2IVjC66BhuxgWnPeUXSHQg5jka/ulTKw74mm2IT
 mBuIfmu5goDS4Sx1/2lxNmWHyIRBSMEBe7a/EAmoBxal4zD1bW7AkmSJ+GmPMx6Wysk3
 06KX0pibAD05/jLvkUIAGKywnb4O4+VZQhTOV2cmXWh8FoIrRH18o2hHpw1jMOxCtFiZ
 CVCGxo/TmQbOccTeHljt/L+beEgmTe4sw4xeWFQTI1ybxctLPX4Z+R7Jc532LpRRGFcN
 EI3QnZIPiTFrKuZXAJJEWs+1Qoqier/gwzcnHz82yyogBsZo5iX+u8qndfVIcy/0vrU1
 e5qg==
X-Gm-Message-State: AOAM530ZiJAeDZdPqsTUpuRXq7nFI4oqsTlapVwh88PJiRqgpxcDbBsa
 eq6F+vP57rdHzwzqTT4jiNA=
X-Google-Smtp-Source: ABdhPJw5TcDNZEhh/LFFWLWePB8FFcaWrh4PKSP+tO9+/6Et5emlWn6sqAVIIc6MWH4LD8JUOLvr8Q==
X-Received: by 2002:adf:f189:: with SMTP id h9mr7318898wro.122.1599054933401; 
 Wed, 02 Sep 2020 06:55:33 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o2sm8065792wrh.70.2020.09.02.06.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 06:55:32 -0700 (PDT)
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d594ed8e-1cb5-f9ac-09d3-7da28f5a95d3@amsat.org>
Date: Wed, 2 Sep 2020 15:55:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Huacai Chen <chenhuacai@gmail.com>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 8/24/20 10:11 AM, Huacai Chen wrote:
> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
> libvirt uses a null-machine to detect the kvm capability. In the MIPS
> case, it will return "KVM not supported" on a VZ platform by default.
> So, add the kvm_type() hook to the null-machine.
> 
> This seems not a very good solution, but I cannot do it better now.
> 
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  hw/core/meson.build    | 2 +-
>  hw/core/null-machine.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index fc91f98..b6591b9 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -35,7 +35,6 @@ softmmu_ss.add(files(
>    'machine-hmp-cmds.c',
>    'machine.c',
>    'nmi.c',
> -  'null-machine.c',
>    'qdev-fw.c',
>    'qdev-properties-system.c',
>    'sysbus.c',
> @@ -45,5 +44,6 @@ softmmu_ss.add(files(
>  
>  specific_ss.add(when: 'CONFIG_SOFTMMU', if_true: files(
>    'machine-qmp-cmds.c',
> +  'null-machine.c',
>    'numa.c',
>  ))
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 7e69352..4b4ab76 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -17,6 +17,9 @@
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
>  #include "hw/core/cpu.h"
> +#ifdef TARGET_MIPS
> +#include "kvm_mips.h"
> +#endif
>  
>  static void machine_none_init(MachineState *mch)
>  {
> @@ -55,6 +58,9 @@ static void machine_none_machine_init(MachineClass *mc)
>      mc->no_floppy = 1;
>      mc->no_cdrom = 1;
>      mc->no_sdcard = 1;
> +#ifdef TARGET_MIPS
> +    mc->kvm_type = mips_kvm_type;
> +#endif

I'm a bit confused here, you are taking the same path from your v4...
https://www.mail-archive.com/qemu-devel@nongnu.org/msg712550.html

Did you rebase the correct version?

>  }
>  
>  DEFINE_MACHINE("none", machine_none_machine_init)
> 

