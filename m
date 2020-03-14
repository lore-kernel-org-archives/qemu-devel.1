Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF231C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F66920575
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqJTAT4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F66920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEcy-0005Wi-QZ
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEcI-000528-26
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEcF-0006C4-PM
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:46:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEcF-0006Be-Lh
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584222403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFMhiLtBpilaLlJIrRto+B9qeNXM2B6m9U05kOYWD5E=;
 b=dqJTAT4h9NwMhnogLhd4m9RfOZjIsrECKB1dBmqAtNymJtnyJBuZRbBcAebxMIEXHi1zkI
 93OugIw/jq9/G9jZIjuZXN8VnZ7tDTRKnnlKtP+QyM7I+Bl4hF8xQvx0/rhSDZX3gxTXTA
 tHoKLLCQbg9U/KYu8Cf2e7EXz0rqJxk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-DdB81026MderIsEXmZsUKA-1; Sat, 14 Mar 2020 17:46:41 -0400
X-MC-Unique: DdB81026MderIsEXmZsUKA-1
Received: by mail-wr1-f71.google.com with SMTP id 94so1788986wrr.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fpndlkWduUksWFX4N1aXFb3mgNipbmhqnJ4Nq+IGKdc=;
 b=hnVYrHFTh2Gr5Qo6rxTC5q3OHYqoMe3qq+w2lQEIjXfb9jVv47o+kRX4O7z6zBH2Rw
 KZOitP68A9gKA+VvctXW1f+/3F5jsmc3WHqLRwKSr6ObSn9yxgL8yaFl5cMQ9GjMfNoV
 8SVV3huRrWOnh1BJFPTWerRG5jyW+R5IPOQ5/ixRpdX0PfK9h/DZRrF27FMrOlVGlwCn
 uiElp5hYJjIq0DI0a3luVSHJaytxDC0yo9pVz1gP7WyLFnHDVEd4Zajb/yuY6SYydtn+
 jMrewAgorQ4ZXSCPcurwSRMAEajHZcMSoJcfi83ByyZ2PDt0Kh8SpSznxVKqGHbAisVs
 o0jA==
X-Gm-Message-State: ANhLgQ1CLwHtXBMjXluhX+CzLlfKx1CGcGLSzuT5jEhFuPbTpiD7Renh
 HwOwoZqA+ZL74awrKIaGSLssLyTAQkIyrt781BSGLfUmojf2n1n6jLAGe/sbrfk+ZOnpBM2dHO1
 qqf4aMKV3NviwtGA=
X-Received: by 2002:a1c:2701:: with SMTP id n1mr18352423wmn.180.1584222400148; 
 Sat, 14 Mar 2020 14:46:40 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs7pAuqZjQXsCLErNIboYVOusT+xzOG1KYZCtU1Z2YElrKCE6ao5SNgJ21dRiLWLd2HCDoF/Q==
X-Received: by 2002:a1c:2701:: with SMTP id n1mr18352406wmn.180.1584222399852; 
 Sat, 14 Mar 2020 14:46:39 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id l64sm23226791wmf.30.2020.03.14.14.46.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 14:46:39 -0700 (PDT)
Subject: Re: [PATCH 1/8] hw: Move i.MX watchdog driver to hw/watchdog
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200314172736.24528-1-linux@roeck-us.net>
 <20200314172736.24528-2-linux@roeck-us.net>
 <2f4064d2-445c-19a4-b873-b9dd0b09ff1c@redhat.com>
Message-ID: <60882898-e604-8474-627c-715bae9fd320@redhat.com>
Date: Sat, 14 Mar 2020 22:46:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2f4064d2-445c-19a4-b873-b9dd0b09ff1c@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 10:43 PM, Philippe Mathieu-Daud=E9 wrote:
> Hi Guenter,
>=20
> On 3/14/20 6:27 PM, Guenter Roeck wrote:
>> In preparation for a full implementation, move i.MX watchdog driver
>> from hw/misc to hw/watchdog. While at it, add the watchdog files
>> to MAINTAINERS.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> =A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 ++
>> =A0 hw/misc/Makefile.objs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 -
>> =A0 hw/watchdog/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 5 +++++
>> =A0 hw/watchdog/Makefile.objs=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 1 +
>> =A0 hw/{misc/imx2_wdt.c =3D> watchdog/wdt_imx2.c}=A0=A0=A0=A0=A0=A0=A0=
=A0 | 2 +-
>> =A0 include/hw/arm/fsl-imx6.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
>> =A0 include/hw/arm/fsl-imx6ul.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
>> =A0 include/hw/arm/fsl-imx7.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
>> =A0 include/hw/{misc/imx2_wdt.h =3D> watchdog/wdt_imx2.h} | 0
>> =A0 9 files changed, 12 insertions(+), 5 deletions(-)
>> =A0 rename hw/{misc/imx2_wdt.c =3D> watchdog/wdt_imx2.c} (98%)
>> =A0 rename include/hw/{misc/imx2_wdt.h =3D> watchdog/wdt_imx2.h} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 32867bc636..d1197014e8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -603,8 +603,10 @@ S: Odd Fixes
>> =A0 F: hw/arm/fsl-imx25.c
>> =A0 F: hw/arm/imx25_pdk.c
>> =A0 F: hw/misc/imx25_ccm.c
>> +F: hw/watchdog/wdt_imx2.c
>> =A0 F: include/hw/arm/fsl-imx25.h
>> =A0 F: include/hw/misc/imx25_ccm.h
>> +F: include/hw/watchdog/wdt_imx2.h
>> =A0 i.MX31 (kzm)
>> =A0 M: Peter Chubb <peter.chubb@nicta.com.au>
>> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
>> index 68aae2eabb..b25181b711 100644
>> --- a/hw/misc/Makefile.objs
>> +++ b/hw/misc/Makefile.objs
>> @@ -44,7 +44,6 @@ common-obj-$(CONFIG_IMX) +=3D imx6_ccm.o
>> =A0 common-obj-$(CONFIG_IMX) +=3D imx6ul_ccm.o
>> =A0 obj-$(CONFIG_IMX) +=3D imx6_src.o
>> =A0 common-obj-$(CONFIG_IMX) +=3D imx7_ccm.o
>> -common-obj-$(CONFIG_IMX) +=3D imx2_wdt.o
>> =A0 common-obj-$(CONFIG_IMX) +=3D imx7_snvs.o
>> =A0 common-obj-$(CONFIG_IMX) +=3D imx7_gpr.o
>> =A0 common-obj-$(CONFIG_IMX) +=3D imx_rngc.o
>> diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
>> index 2118d897c9..2c225b4b17 100644
>> --- a/hw/watchdog/Kconfig
>> +++ b/hw/watchdog/Kconfig
>> @@ -14,3 +14,8 @@ config WDT_IB700
>> =A0 config WDT_DIAG288
>> =A0=A0=A0=A0=A0 bool
>> +
>> +config WDT_IMX2
>> +=A0=A0=A0 bool
>> +=A0=A0=A0 default y
>> +=A0=A0=A0 depends on IMX
>=20
> - it does not depend of IMX (you could use it in another SoC)
> - since it is not user-creatable, it is pointless as a default device.
>=20
> Instead, select it in each iMX SoC:
>=20
> -- >8 --
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index e5a876c8d1..cdb01c4e03 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -358,6 +358,7 @@ config FSL_IMX25
>  =A0=A0=A0=A0 select IMX
>  =A0=A0=A0=A0 select IMX_FEC
>  =A0=A0=A0=A0 select IMX_I2C
> +=A0=A0=A0 select WDT_IMX2
>  =A0=A0=A0=A0 select DS1338
>=20
>  =A0config FSL_IMX31
> @@ -365,6 +366,7 @@ config FSL_IMX31
>  =A0=A0=A0=A0 select SERIAL
>  =A0=A0=A0=A0 select IMX
>  =A0=A0=A0=A0 select IMX_I2C
> +=A0=A0=A0 select WDT_IMX2
>  =A0=A0=A0=A0 select LAN9118
>=20
>  =A0config FSL_IMX6
> @@ -373,6 +375,7 @@ config FSL_IMX6
>  =A0=A0=A0=A0 select IMX
>  =A0=A0=A0=A0 select IMX_FEC
>  =A0=A0=A0=A0 select IMX_I2C
> +=A0=A0=A0 select WDT_IMX2
>  =A0=A0=A0=A0 select SDHCI
>=20
> ---

Corrected hunk:

-- >8 --
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e5a876c8d1..c662d5f1e0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -373,6 +373,7 @@ config FSL_IMX6
      select IMX
      select IMX_FEC
      select IMX_I2C
+    select WDT_IMX2
      select SDHCI

  config ASPEED_SOC
@@ -410,6 +411,7 @@ config FSL_IMX7
      select IMX
      select IMX_FEC
      select IMX_I2C
+    select WDT_IMX2
      select PCI_EXPRESS_DESIGNWARE
      select SDHCI
      select UNIMP
@@ -423,6 +425,7 @@ config FSL_IMX6UL
      select IMX
      select IMX_FEC
      select IMX_I2C
+    select WDT_IMX2
      select SDHCI
      select UNIMP

---

>=20
> With this hunk amended (and removing "default y" and "depends on IMX"):
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
>> diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
>> index 3f536d1cad..dd9b37f642 100644
>> --- a/hw/watchdog/Makefile.objs
>> +++ b/hw/watchdog/Makefile.objs
>> @@ -4,3 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) +=3D wdt_i6300esb.o
>> =A0 common-obj-$(CONFIG_WDT_IB700) +=3D wdt_ib700.o
>> =A0 common-obj-$(CONFIG_WDT_DIAG288) +=3D wdt_diag288.o
>> =A0 common-obj-$(CONFIG_ASPEED_SOC) +=3D wdt_aspeed.o
>> +common-obj-$(CONFIG_WDT_IMX) +=3D wdt_imx2.o
>> diff --git a/hw/misc/imx2_wdt.c b/hw/watchdog/wdt_imx2.c
>> similarity index 98%
>> rename from hw/misc/imx2_wdt.c
>> rename to hw/watchdog/wdt_imx2.c
>> index 2aedfe803a..ad1ef02e9e 100644
>> --- a/hw/misc/imx2_wdt.c
>> +++ b/hw/watchdog/wdt_imx2.c
>> @@ -14,7 +14,7 @@
>> =A0 #include "qemu/module.h"
>> =A0 #include "sysemu/watchdog.h"
>> -#include "hw/misc/imx2_wdt.h"
>> +#include "hw/watchdog/wdt_imx2.h"
>> =A0 #define IMX2_WDT_WCR_WDA=A0=A0=A0 BIT(5)=A0=A0=A0=A0=A0 /* -> Extern=
al Reset WDOG_B */
>> =A0 #define IMX2_WDT_WCR_SRS=A0=A0=A0 BIT(4)=A0=A0=A0=A0=A0 /* -> Softwa=
re Reset Signal */
>> diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
>> index 60eadccb42..5b02dc1f4b 100644
>> --- a/include/hw/arm/fsl-imx6.h
>> +++ b/include/hw/arm/fsl-imx6.h
>> @@ -21,7 +21,7 @@
>> =A0 #include "hw/cpu/a9mpcore.h"
>> =A0 #include "hw/misc/imx6_ccm.h"
>> =A0 #include "hw/misc/imx6_src.h"
>> -#include "hw/misc/imx2_wdt.h"
>> +#include "hw/watchdog/wdt_imx2.h"
>> =A0 #include "hw/char/imx_serial.h"
>> =A0 #include "hw/timer/imx_gpt.h"
>> =A0 #include "hw/timer/imx_epit.h"
>> diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
>> index eda389aec7..91c746918a 100644
>> --- a/include/hw/arm/fsl-imx6ul.h
>> +++ b/include/hw/arm/fsl-imx6ul.h
>> @@ -24,7 +24,7 @@
>> =A0 #include "hw/misc/imx7_snvs.h"
>> =A0 #include "hw/misc/imx7_gpr.h"
>> =A0 #include "hw/intc/imx_gpcv2.h"
>> -#include "hw/misc/imx2_wdt.h"
>> +#include "hw/watchdog/wdt_imx2.h"
>> =A0 #include "hw/gpio/imx_gpio.h"
>> =A0 #include "hw/char/imx_serial.h"
>> =A0 #include "hw/timer/imx_gpt.h"
>> diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
>> index 706aef2e7e..3a0041c4c2 100644
>> --- a/include/hw/arm/fsl-imx7.h
>> +++ b/include/hw/arm/fsl-imx7.h
>> @@ -26,7 +26,7 @@
>> =A0 #include "hw/misc/imx7_snvs.h"
>> =A0 #include "hw/misc/imx7_gpr.h"
>> =A0 #include "hw/misc/imx6_src.h"
>> -#include "hw/misc/imx2_wdt.h"
>> +#include "hw/watchdog/wdt_imx2.h"
>> =A0 #include "hw/gpio/imx_gpio.h"
>> =A0 #include "hw/char/imx_serial.h"
>> =A0 #include "hw/timer/imx_gpt.h"
>> diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/watchdog/wdt_imx2.h
>> similarity index 100%
>> rename from include/hw/misc/imx2_wdt.h
>> rename to include/hw/watchdog/wdt_imx2.h
>>


