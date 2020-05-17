Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D22C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667D3206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQcyWOpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667D3206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaJE1-0007qu-HN
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 09:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJCd-0006gI-JE
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:19:39 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jaJCc-0000hS-BR
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:19:39 -0400
Received: by mail-wm1-x344.google.com with SMTP id z72so7369954wmc.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VRk87tVAWUKX5DXhqKj+E2G5o6RuhG0PF12fgKHSa58=;
 b=IQcyWOpUxBjQytWSsJZIVkcDMMNtKe9Ka8i7Zvc9DPDaz+UwAbkiuBdvU8k5bpjodZ
 i2MEWBiAfEvytowlU0ndHz/1cjpxL8UpkEXET9bjH0Q1V9xY7pcPjci9hZJiy/DwzhTO
 cB6OspRPNJvWIJqwIOj37Hdg4NUyj1OybDIXFwhloP7/zFve7ODW5SQiR8QNl3znBl2c
 rudmSpwxTrYDBL9xUlSSknbt63fGZGknOcsX1VVxZS6t9dDuXu495LbVD1GdvqQCbdt9
 uh7oFfzvo7gIohLYNK+HJU9KPsuxtGPgADNyXU8vt/JxewNLyZDalo3UA7++k7dmQznE
 hVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VRk87tVAWUKX5DXhqKj+E2G5o6RuhG0PF12fgKHSa58=;
 b=VHxGuh0/MxEYEXLBx7sLcOLRRYRifgyCoKPO3mjDF5nPepNpjcHyQrXGv+mYZKvdol
 FL7RDWf4qtEt6zMxKCtS7jBPUKFm/u3hiGCBr5SJ6cJ/ecu6fBpuIWq891pF61/60ODF
 r8HpNORm6CSFSLQLIhouz+sjHrPOQZQPcStELKZ8zQjV1Tut4k8igPNmuuApwuhc5bxm
 LNdNGmFEBhRUW9yYZ/W4tBGFnsTHNSZKQ9DNcEJW4JZMrW/aWXNzPm+9Y+IC7o1z5xD9
 S9W9gcZUb0NBWFceGbq3xwT7w0/yhcoO9p+ozTkKEaR9DXe074P6tuj07dYUPScDGLph
 JP5w==
X-Gm-Message-State: AOAM533SNCRHrAkTemGCx9MBTaZ48FgKuOOASNFAvtZgN0GavsOfxA11
 QSBoy8Azjk39TO5yDuLgMt0=
X-Google-Smtp-Source: ABdhPJzsQ61pWvQgS+UPxSa02/8OdICO3j9/c5gWMCiIHMlUac75cZ0oIcFQF3419P64rW11CBgtrQ==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr14823826wmb.56.1589721576760; 
 Sun, 17 May 2020 06:19:36 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id q17sm12592991wmk.36.2020.05.17.06.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2020 06:19:36 -0700 (PDT)
Subject: Re: [PATCH v4 19/19] hw/mips: Rename malta/mipssim/r4k/jazz files in
 hw/mips
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
 <20200517092357.1469-20-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b0b12106-e2f1-36de-c3ac-000a89f87eba@amsat.org>
Date: Sun, 17 May 2020 15:19:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200517092357.1469-20-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 5/17/20 11:23 AM, Aleksandar Markovic wrote:
> Machine file names should not have prefix "mips_".
> 
> Folong2 machine source file will be handled in a separate patch,

Typo: "Fuloong2e"

> to avoid conflicts. That patch is pending integration into the
> main tree.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> CC:  Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/mips/Makefile.objs                 | 8 ++++----
>   hw/mips/{mips_jazz.c => jazz.c}       | 0
>   hw/mips/{mips_malta.c => malta.c}     | 0
>   hw/mips/{mips_mipssim.c => mipssim.c} | 0
>   hw/mips/{mips_r4k.c => r4k.c}         | 0
>   5 files changed, 4 insertions(+), 4 deletions(-)
>   rename hw/mips/{mips_jazz.c => jazz.c} (100%)
>   rename hw/mips/{mips_malta.c => malta.c} (100%)
>   rename hw/mips/{mips_mipssim.c => mipssim.c} (100%)
>   rename hw/mips/{mips_r4k.c => r4k.c} (100%)

Thanks for cleaning this, appreciated!

You missed MAINTAINERS:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 1f84e3ae2c..3ad904a73c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1045,3 +1045,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
  S: Maintained
-F: hw/mips/mips_jazz.c
+F: hw/mips/jazz.c
  F: hw/display/jazz_led.c
@@ -1056,3 +1056,3 @@ F: hw/isa/piix4.c
  F: hw/acpi/piix4.c
-F: hw/mips/mips_malta.c
+F: hw/mips/malta.c
  F: hw/mips/gt64xxx_pci.c
@@ -1066,3 +1066,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
  S: Odd Fixes
-F: hw/mips/mips_mipssim.c
+F: hw/mips/mipssim.c
  F: hw/net/mipsnet.c
@@ -1074,3 +1074,3 @@ R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
  S: Obsolete
-F: hw/mips/mips_r4k.c
+F: hw/mips/r4k.c

---

With this snippet amended:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Regards,

Phil.

> 
> diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
> index 525809af07..1d767ed9a8 100644
> --- a/hw/mips/Makefile.objs
> +++ b/hw/mips/Makefile.objs
> @@ -1,8 +1,8 @@
>   obj-y += addr.o mips_int.o
> -obj-$(CONFIG_R4K) += mips_r4k.o
> -obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
> -obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
> -obj-$(CONFIG_JAZZ) += mips_jazz.o
> +obj-$(CONFIG_R4K) += r4k.o
> +obj-$(CONFIG_MALTA) += gt64xxx_pci.o malta.o
> +obj-$(CONFIG_MIPSSIM) += mipssim.o
> +obj-$(CONFIG_JAZZ) += jazz.o
>   obj-$(CONFIG_FULONG) += mips_fulong2e.o
>   obj-$(CONFIG_MIPS_CPS) += cps.o
>   obj-$(CONFIG_MIPS_BOSTON) += boston.o
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/jazz.c
> similarity index 100%
> rename from hw/mips/mips_jazz.c
> rename to hw/mips/jazz.c
> diff --git a/hw/mips/mips_malta.c b/hw/mips/malta.c
> similarity index 100%
> rename from hw/mips/mips_malta.c
> rename to hw/mips/malta.c
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mipssim.c
> similarity index 100%
> rename from hw/mips/mips_mipssim.c
> rename to hw/mips/mipssim.c
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/r4k.c
> similarity index 100%
> rename from hw/mips/mips_r4k.c
> rename to hw/mips/r4k.c
> 

