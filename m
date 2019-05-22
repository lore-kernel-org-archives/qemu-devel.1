Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC2FC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2936920881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 15:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2936920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTVL-0006LE-EL
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 11:50:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTM9-0007Zk-Ul
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTT8O-0004qP-2s
	for qemu-devel@nongnu.org; Wed, 22 May 2019 11:26:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42411)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTT8N-0004lq-Nj; Wed, 22 May 2019 11:26:27 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
	1M6EKU-1ha4pz2bVI-006jSm; Wed, 22 May 2019 17:26:07 +0200
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
	<20190521151543.92274-3-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cb0d777b-a3eb-fb43-2a9a-55655a0b35ee@vivier.eu>
Date: Wed, 22 May 2019 17:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-3-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7WrvvgV94uA25ZHf2HEgKkiArIwL0biyNwI+uy5Z/+Rd8LadMR+
	pbCQXsI/qGSRZmJ6DHc/xnPnP/ytvpKxlI2hejBEbmBZZWyg2zIHVVEPveJRN63aseAgXNY
	NeIeBbrhYS1isFkQA7xoulSVRHN0JCC76jWD+ShBW+nPWHjhpl0hphgh14QAmliQINxdQ8l
	jCkIsVgviWU+F4vagF/2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gtSL0HsaNk=:g/eFMPUbj4BLoA+NR34IE+
	50hRY6EvZYPTACIEB3UZ20vHKC052sXhid5Uul06spJGBu+vT/Q53nj9cv7+JXhZTo2qwbluK
	eXyCEsIyL01PNc2uHdFSmjos9EO3qhQtKOprBbSsnxFwEfKk9dlQccVzuxLbgC8/POGyhPwH8
	I19UOXMuzxz2LmLRiRCxz+lCTxDPVXqcPj1Jv5uafEgPrWt9JlRgbFh/MTyUuVwT8ghyQIudB
	Wiie/4fDug+MmiJMsVhbP6Fu5DS9CyXSCGw28XTph2I7LruiFCaakgv5hu7Fa8ryD+5ONVpfz
	LarsQGTcQG1eXs3hwuf9CSqdIzAh9eDC2rncaY+rASgI14fATx5Pn1tAroQnHCjbw3vrkMdKx
	j44owWOWLDUDuV0O2zcTT+85qe+Bv5hD1ytELUluIE3/1GSN1EpOYiba7SlLGVmG8x/phdgqU
	lzhJpE1hA8aYn1FfYkpBO8lfOKgh12l348R/09Vsq6pjrQLkqTWzcmlLZb80sCaoR3UFEJXxy
	KAUrStUTh2sXDVvWg7sHSZjgjgoSdlp/hSEWfOPGhglGj99ibduDKaWf1vu2ZIRNZ6EpkIf1k
	uvTjKAIazUBKgPJGVB2YKt7/W5q+jDwpkWN3Aa+4GMSWGZEeMXOQbuKTDY5SzS6DF3mrpo+0C
	hf2fnXs3piPcd7aeWAOc6A2DXVVFEzVQGaJ6xFvByrD53AFz8IIhKeTbjD26PVfvvWQ8T6Sli
	Gnk3rR4y8U0KaYm10eFQH4354AkPDX2Q2pLQAjISFjKb/SC14NN/0cOOYNM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 2/4] hw: vfio: drop
 TYPE_FOO MACRO in VMStateDescription
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
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, philmd@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 17:15, Li Qiang wrote:
> It's recommended that VMStateDescription names are decoupled from QOM
> type names as the latter may freely change without consideration of
> migration compatibility.
> 
> Link: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>   hw/vfio/amd-xgbe.c      | 2 +-
>   hw/vfio/ap.c            | 2 +-
>   hw/vfio/calxeda-xgmac.c | 2 +-
>   hw/vfio/ccw.c           | 2 +-
>   hw/vfio/platform.c      | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> index ee64a3b4a2..1b06c0f3ea 100644
> --- a/hw/vfio/amd-xgbe.c
> +++ b/hw/vfio/amd-xgbe.c
> @@ -26,7 +26,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error **errp)
>   }
>   
>   static const VMStateDescription vfio_platform_amd_xgbe_vmstate = {
> -    .name = TYPE_VFIO_AMD_XGBE,
> +    .name = "vfio-amd-xgbe",
>       .unmigratable = 1,
>   };
>   
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index d8b79ebe53..564751650f 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -155,7 +155,7 @@ static void vfio_ap_reset(DeviceState *dev)
>   }
>   
>   static const VMStateDescription vfio_ap_vmstate = {
> -    .name = VFIO_AP_DEVICE_TYPE,
> +    .name = "vfio-ap",
>       .unmigratable = 1,
>   };
>   
> diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> index e7767c4b02..6cc608b6ca 100644
> --- a/hw/vfio/calxeda-xgmac.c
> +++ b/hw/vfio/calxeda-xgmac.c
> @@ -26,7 +26,7 @@ static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
>   }
>   
>   static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate = {
> -    .name = TYPE_VFIO_CALXEDA_XGMAC,
> +    .name = "vfio-calxeda-xgmac",
>       .unmigratable = 1,
>   };
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 31dd3a2a87..d9e39552e2 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -468,7 +468,7 @@ static Property vfio_ccw_properties[] = {
>   };
>   
>   static const VMStateDescription vfio_ccw_vmstate = {
> -    .name = TYPE_VFIO_CCW,
> +    .name = "vfio-ccw",
>       .unmigratable = 1,
>   };
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 398db38f14..e59a0234dd 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -697,7 +697,7 @@ out:
>   }
>   
>   static const VMStateDescription vfio_platform_vmstate = {
> -    .name = TYPE_VFIO_PLATFORM,
> +    .name = "vfio-platform",
>       .unmigratable = 1,
>   };
>   
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

