Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284C6C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 16:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED58A20828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED58A20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2HPS-00071g-QT
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1i2HNz-0005r3-Ps
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjt@tls.msk.ru>) id 1i2HNx-0008AB-6s
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:58:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:53593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1i2HNw-00084X-6x
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:58:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0AD7E415A8;
 Mon, 26 Aug 2019 18:58:14 +0300 (MSK)
Received: from [192.168.177.7] (wh.tls.msk.ru [192.168.177.7])
 by tsrv.corpit.ru (Postfix) with ESMTP id E3B423C7;
 Mon, 26 Aug 2019 18:58:13 +0300 (MSK)
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, kraxel@redhat.com
References: <20190628161358.10400-1-liq3ea@163.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=mjt@tls.msk.ru; prefer-encrypt=mutual; keydata=
 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 dCM=
Message-ID: <6b610546-e7e3-45ec-b6d8-e6345d8c65e0@msgid.tls.msk.ru>
Date: Mon, 26 Aug 2019 18:58:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628161358.10400-1-liq3ea@163.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 86.62.121.231
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: check if the resource already
 exists in virtio_gpu_load()
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

28.06.2019 19:13, Li Qiang wrote:
> While loading virtio-gpu, the data can be malicious, we
> should check if the resource already exists.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/display/virtio-gpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 2b0f66b1d6..f1ebed9959 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1002,6 +1002,11 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>  
>      resource_id = qemu_get_be32(f);
>      while (resource_id != 0) {
> +        res = virtio_gpu_find_resource(g, resource_id);
> +        if (res) {
> +            return -EINVAL;

  EEXIST?

/mjt

