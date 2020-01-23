Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622DC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E41A21835
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 05:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIS9dSAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E41A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuV8p-000680-KH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 00:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuV0x-0005zF-L8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuV0v-00029W-DS
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuV0v-00028s-9F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 00:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579757204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=XtvlH/RRuYw8L9kZEG99bzVxLs3XXTKoTGpizGGVmXM=;
 b=SIS9dSAxTNE2eiVYwBLNCvXN/XjLIhtuMWJeKb3uwlnYaTZ9pn1uwH0gdLCz+CIo6yf1jH
 gbWS0MOzTH77wJLQpgPctbgbu94Ox3hHceuTNidfMLkqkEsPQs40ObMrUXfMD33NTQxV2b
 Y76CJYJgP+qhH0OIyo+bChop4zzb4DE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-mozyp-P8M-e4fOGjb32PlA-1; Thu, 23 Jan 2020 00:26:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1AD3800D41;
 Thu, 23 Jan 2020 05:26:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1D052898E;
 Thu, 23 Jan 2020 05:26:36 +0000 (UTC)
Subject: Re: [PATCH] stm32f4xx_syscfg: remove redundant code to fix coverity
 warning
To: pannengyuan@huawei.com, alistair@alistair23.me, peter.maydell@linaro.org
References: <20200123023845.20980-1-pannengyuan@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6aaa3f39-81bd-5333-9083-d95dd3cbe6b9@redhat.com>
Date: Thu, 23 Jan 2020 06:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123023845.20980-1-pannengyuan@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mozyp-P8M-e4fOGjb32PlA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 zhang.zhanghailiang@huawei.com, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 03.38, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Fixes the coverity warning:
>     CID 91708242: (EVALUATION_ORDER)
>     50. write_write_typo: In "config = config = irq / 16", "config" is written twice with the same value.
>     50    uint8_t config = config = irq / 16;
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/misc/stm32f4xx_syscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/stm32f4xx_syscfg.c b/hw/misc/stm32f4xx_syscfg.c
> index dbcdca59f8..f960e4ea1e 100644
> --- a/hw/misc/stm32f4xx_syscfg.c
> +++ b/hw/misc/stm32f4xx_syscfg.c
> @@ -47,7 +47,7 @@ static void stm32f4xx_syscfg_set_irq(void *opaque, int irq, int level)
>      STM32F4xxSyscfgState *s = opaque;
>      int icrreg = irq / 4;
>      int startbit = (irq & 3) * 4;
> -    uint8_t config = config = irq / 16;
> +    uint8_t config = irq / 16;

Thanks, but Philippe already posted a patch for this :

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg04823.html

 Thomas


