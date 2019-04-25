Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E2C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CB520651
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 16:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CB520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJh3c-0001dS-PL
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 12:17:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh22-0000Bp-Ik
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJh21-0008Je-Lt
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJh21-0008Iz-Fc
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:15:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so61283wmf.2
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 09:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fh8mKWZcw3h5WDOoN6WH2nwuSENuyzzm0jM4adsai34=;
	b=M2JUqP6Spxs5j70CnkYF4Tw2RiVu6Twom23RQQiT9Lae+jr1VpRBJNMSRk12TGLR7O
	KpW/i1vfNHyfZ04dNQyptSre0dtmxCxL0AAc9Vkv08rvhr07S0qsTgV4ukyeDHbMEmHz
	JIWjaCAIUmb9mwB48D2ftwhKJe/JE7PqUozRNgYRqwXuAXTcd/gNm+lwuPipunkCsKis
	SjUTKTM0n9fArRt0ZWHd8aFwBkcZi9Zarx0dF9ISr9GXFuakYlc74Dj+6g9EoF58pGWy
	PYEb4980trzZQkK/tWtDkJBaGRMWNsyxLyT7YDbhOH7ljfv2DXzspLjLayCAMAr3rh+U
	gqIA==
X-Gm-Message-State: APjAAAUJL9PJhYqx6H7Cgk2niO4B2zpUo6cAvWKLFRgS+NmuyRwMezBA
	D/8u1elpK5xJU3NqRZWnYaE5iw==
X-Google-Smtp-Source: APXvYqxc3gLiIEgfSLvtkMqaqVnP9DPMXnHRyLTn4uDQVHbFFh8Ck8DkyKOPFgyOaYoq9xr9kTAXFg==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr4288211wma.26.1556208928341; 
	Thu, 25 Apr 2019 09:15:28 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	e16sm29083432wrs.0.2019.04.25.09.15.24
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 09:15:27 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, yang.zhong@intel.com,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	pbonzini@redhat.com
References: <20190418180057.3593-1-thuth@redhat.com>
	<20190418180057.3593-28-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ccb95efc-acda-6613-6056-08a08f107a9e@redhat.com>
Date: Thu, 25 Apr 2019 18:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418180057.3593-28-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for-QEMU-4.1 v5 27/29] hw/arm: Express
 dependencies of the xlnx-versal-virt machine with Kconfig
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
Cc: Rob Herring <robh@kernel.org>, Jan Kiszka <jan.kiszka@web.de>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-block@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Beniamino Galvani <b.galvani@gmail.com>, Andrew Jeffery <andrew@aj.id.au>,
	Cedric Le Goater <clg@kaod.org>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>, Gerd Hoffmann <kraxel@redhat.com>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	John Snow <jsnow@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425161523.JSQe4lotZoVx2a9OlW0fA0vF9iSYUFJIAR_TpkvrgU0@z>

On 4/18/19 8:00 PM, Thomas Huth wrote:
> Dependencies have been determined with trial-and-error and by
> looking at the xlnx-versal.c source file.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 32e4cc50e5..22be1e1231 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -291,6 +291,10 @@ config XLNX_ZYNQMP_ARM
>  
>  config XLNX_VERSAL
>      bool
> +    select ARM_GIC
> +    select PL011
> +    select CADENCE
> +    select VIRTIO_MMIO
>  
>  config FSL_IMX25
>      bool
> 

