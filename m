Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C832BC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:13:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A91B20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 01:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkfunzeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A91B20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXx0X-0000EF-MO
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 21:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwzS-0007c3-84
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:12:18 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33622)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jXwzR-0007ZQ-Ec
 for qemu-devel@nongnu.org; Sun, 10 May 2020 21:12:17 -0400
Received: by mail-lj1-x243.google.com with SMTP id w20so7649312ljj.0
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 18:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZutzGdcPz6+JxaAPOf3e0hyYbea0QZhfKAorj0tD93Q=;
 b=hkfunzeSQ7pZPwaag/6rdGRvzVgaSNa/l4BgJ1KKLOKHYkKdNch5JKaLp4La316QHD
 3453DSy0LYtdrBbEgpm8QtF7pEfoH3ihfOSBvfvHU6xhoAHzYPG9u4wrLISGYoR9SgE8
 nqV4y0OAVavzYLExdU3WtwaimuadMFkKz1fwXaibZ7mR1NvbGO/zZtq+IdtHlack2kZT
 UetBXwG0ksYwGaxGqqx/UgV4MxZdoBeH9YeYURDDB0EEjOHebuG4ZAuSKHVns+ds6lSx
 /6/oa9LzrYhnm7+/7bPZvuSiVmvS5m+6NEoX/2SBAQIDovpfN22vbAktjYJmATzSb1g/
 F2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZutzGdcPz6+JxaAPOf3e0hyYbea0QZhfKAorj0tD93Q=;
 b=c3R4SikCcMqzxIsgJ+UTHiQH2A/xHVbUxBa0S20jlatDKXLRR8pXsXmdDBT8H3CuxA
 ihUd6JSZ5WMAyVv/+NgOf7th2+1qzKMM5IblLn5HchZ923PTJ6KWP12jCA/AsPCvdfyC
 Q1VrKesqJApc+rXCeC1SvKbwyMed/XqJgGClBSzrcckg9Ze/rZS+lMDCZ316WSnisXvu
 rnYanVkoUtDE5twU/qbe+D7sXynbyewOdvgjLeRbIA4QxcW9sv53tbNDzcHtHf02KLI8
 DysO9T0C+JldRrlDDMolPr6L89hSrP/EZr6tuzA06a8zHohqJfbDK09MUGod5KK9z98E
 qHig==
X-Gm-Message-State: AOAM532dArr76wWFk85ZYAw1fMk2SUKRfk3iLdKrvPH66dYqUX46Lube
 UFtWA0v2i0tAhlxFhHkJV8ziZ7wg7Q49Kw4qvG4=
X-Google-Smtp-Source: ABdhPJxDdCz0ebk1p+QrbcNOTF+dtzvIWWXWqiJRiCRWNAfxy1+bXSu7oJmMNNpZLHaxnx6MsI9licr+LuktTXy2aYc=
X-Received: by 2002:a2e:6e13:: with SMTP id j19mr8661793ljc.292.1589159535730; 
 Sun, 10 May 2020 18:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-6-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-6-f4bug@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Mon, 11 May 2020 09:19:57 +0800
Message-ID: <CABDp7VpgMgBK5ndVJtJcGOZHZTZYCiSsHhubCTqzUkrvv58ZpQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] hw/pci-host: Use CONFIG_PCI_BONITO to select the
 Bonito North Bridge
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <chenhc@lemote.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Huacai Chen <chenhc@lemote.com>

On Mon, May 11, 2020 at 5:03 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Ease the kconfig selection by introducing CONFIG_PCI_BONITO to select
> the Bonito North Bridge.
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/Kconfig           | 1 +
>  hw/pci-host/Kconfig       | 4 ++++
>  hw/pci-host/Makefile.objs | 2 +-
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index cd38546689..67d39c56a4 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -43,6 +43,7 @@ config JAZZ
>
>  config FULOONG
>      bool
> +    select PCI_BONITO
>
>  config MIPS_CPS
>      bool
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 9642c77e98..8db41edc7e 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -55,3 +55,7 @@ config PCI_EXPRESS_DESIGNWARE
>      bool
>      select PCI_EXPRESS
>      select MSI_NONBROKEN
> +
> +config PCI_BONITO
> +    select PCI
> +    bool
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index 8c87e8494d..e422e0aca0 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -12,7 +12,7 @@ common-obj-$(CONFIG_PPCE500_PCI) +=3D ppce500.o
>  common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
>
>  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
> -common-obj-$(CONFIG_FULONG) +=3D bonito.o
> +common-obj-$(CONFIG_PCI_BONITO) +=3D bonito.o
>  common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
>  common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) +=3D xen_igd_pt.o
>  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
> --
> 2.21.3
>
>


--=20
Huacai Chen

