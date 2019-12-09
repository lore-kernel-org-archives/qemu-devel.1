Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E1C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECF2A2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vz7CR2vt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF2A2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieHl5-0004Ve-0m
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 07:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieHkJ-00044t-OC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieHkG-0001R3-SI
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:02:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieHkG-0001Qc-Nt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:02:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575892951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1NatJ/zvUfiFU/nzbRkmGj2Ai63mjky2WdyB7uJZPgA=;
 b=Vz7CR2vtjK1US+iN6qL+0bGiyVeLLlTtQQA2OMXO/c0UlveLX34y+cp2K08vvLtd8C8yAh
 Ji54NQiJ6t0RMxfmxTHStDZ4q4K8I8rGVoH9puRcCCcMEXY9eGEyiALD9dCqVJ9CJOuOLC
 nLWdveFPYzesgr7pe2Lz+h1GcDhzjxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-h8amcT1FNxSSpOGY-2by9w-1; Mon, 09 Dec 2019 07:02:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 368BF18543A7;
 Mon,  9 Dec 2019 12:02:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A87D660BEC;
 Mon,  9 Dec 2019 12:02:20 +0000 (UTC)
Subject: Re: [PATCH v6 02/21] libqos: Rename i2c_send and i2c_recv
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20191129213424.6290-1-alxndr@bu.edu>
 <20191129213424.6290-3-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8a74a941-b646-3708-c6cc-5dcb0fb1fbca@redhat.com>
Date: Mon, 9 Dec 2019 13:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129213424.6290-3-alxndr@bu.edu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: h8amcT1FNxSSpOGY-2by9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/11/2019 22.34, Oleinik, Alexander wrote:
> The names i2c_send and i2c_recv collide with functions defined in
> hw/i2c/core.c. This causes an error when linking against libqos and
> softmmu simultaneously (for example when using qtest inproc). Rename the
> libqos functions to avoid this.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  tests/libqos/i2c.c   | 10 +++++-----
>  tests/libqos/i2c.h   |  4 ++--
>  tests/pca9552-test.c | 10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
> index 156114e745..38f800dbab 100644
> --- a/tests/libqos/i2c.c
> +++ b/tests/libqos/i2c.c
> @@ -10,12 +10,12 @@
>  #include "libqos/i2c.h"
>  #include "libqtest.h"
>  
> -void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
> +void qi2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
>  {
>      i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
>  }
>  
> -void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> +void qi2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>  {
>      i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
>  }

I'd prefer qos_i2c_send and qos_i2c_recv instead ... but that's just a
matter of taste.

Acked-by: Thomas Huth <thuth@redhat.com>


