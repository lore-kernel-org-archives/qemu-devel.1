Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE6C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB7920575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkvKqCbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB7920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhsl-0003WO-91
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOhmB-00082A-VL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:08:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOhmA-0006OW-Ps
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:08:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42887
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOhmA-0006O3-Lf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586956102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJJaxyCw3+mZ+OMiRwgzw7jtSLA86QJfVvFFxP8Car8=;
 b=PkvKqCbfACL7QO5zyB1TGwYBLULz5HyzQODOqSyTmnVuJND0oQNvwsiuDpTAO4ymUtiH4a
 eTCNZ4WVHOV8+4ZtJlPOD8amLgQ3SUewvBevc2SvF/47JW82x4Z7nJOHWg6/Uox13CQNRX
 3gxpftCvcztkmhSDdA0tiAiSZ5eWJNk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-zwxSZQOHOLyOzCd25d7OiQ-1; Wed, 15 Apr 2020 09:08:19 -0400
X-MC-Unique: zwxSZQOHOLyOzCd25d7OiQ-1
Received: by mail-ed1-f71.google.com with SMTP id b9so2877319edj.10
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fHd2pg6fXgQjEObz/mE4+e7bLXcjxDYU3+AlQy7iSS0=;
 b=FbT/6sAJ4xbZoQ0l8giaIPk8l/M/p0T7rzWA811FF3Slt8zi9G6swhUSYSi7Rd3hVZ
 c2nNJDQnEjFSMriyR+/Do4V1vYGc685CxXfLbKaqk/pXJcsT9rFwGAxgVuHE4/U76oN8
 NpJQ2dxPcdV3u3JYW/kHmGlZKvq9HcOuTpuQzS5KktHOAjg28Z/E3kIRPD+te5vwfCN7
 OlOBO6gvdEYfaFiESGKuBNVeHKV0fwEw9N6puAsVh1aNgvasbI39w20e/apgsJ+2T3Od
 vsesjeVbvHrL2xHRNG2QHfquh6t7mJqIUQQ24emo8g2eBjbe3Zgk1pducyNDKwvqwqGR
 sRLQ==
X-Gm-Message-State: AGi0PuaCtM1aa7xOatUiaDwin0dbl8w/vF2cStGEsrT2rfCK2vRqbMRG
 ZFuFIIbFMD00HIK58DS3r9V+rRVKeaS1Bqmrv4sufBwHcNnl1y6rHysb5XDcz/ZGQNHtNc1YEvM
 XwSRnz8D2cgVL64k=
X-Received: by 2002:a50:f306:: with SMTP id p6mr23148789edm.363.1586956098344; 
 Wed, 15 Apr 2020 06:08:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgY9S4uggYaSWkrdZuuGDGgSIuCZ3/kI7Q/cuf9ft8mIyJ7t/YqDy+7UA7L8K6pceJosAGhg==
X-Received: by 2002:a50:f306:: with SMTP id p6mr23148749edm.363.1586956098026; 
 Wed, 15 Apr 2020 06:08:18 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a21sm2133673edr.22.2020.04.15.06.08.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:08:17 -0700 (PDT)
Subject: Re: [PATCH v2 09/16] nvme: factor out property/constraint checks
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-10-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41d67c89-6392-265e-6169-691c51d95340@redhat.com>
Date: Wed, 15 Apr 2020 15:08:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415130159.611361-10-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:01 PM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 44856e873fd1..5f9ebbd6a1d5 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1311,24 +1311,19 @@ static const MemoryRegionOps nvme_cmb_ops =3D {
>       },
>   };
>  =20
> -static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
>   {
> -    NvmeCtrl *n =3D NVME(pci_dev);
> -    NvmeIdCtrl *id =3D &n->id_ctrl;
> +    NvmeParams *params =3D &n->params;
>  =20
> -    int i;
> -    int64_t bs_size;
> -    uint8_t *pci_conf;
> -
> -    if (n->params.num_queues) {
> +    if (params->num_queues) {
>           warn_report("num_queues is deprecated; please use max_ioqpairs =
"
>                       "instead");
>  =20
> -        n->params.max_ioqpairs =3D n->params.num_queues - 1;
> +        params->max_ioqpairs =3D params->num_queues - 1;
>       }
>  =20
> -    if (n->params.max_ioqpairs < 1 ||
> -        n->params.max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
> +    if (params->max_ioqpairs < 1 ||
> +        params->max_ioqpairs > PCI_MSIX_FLAGS_QSIZE) {
>           error_setg(errp, "max_ioqpairs must be between 1 and %d",
>                      PCI_MSIX_FLAGS_QSIZE);
>           return;
> @@ -1339,16 +1334,34 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>           return;
>       }
>  =20
> +    if (!params->serial) {
> +        error_setg(errp, "serial property not set");
> +        return;
> +    }
> +}
> +
> +static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    NvmeCtrl *n =3D NVME(pci_dev);
> +    NvmeIdCtrl *id =3D &n->id_ctrl;
> +    Error *err =3D NULL;

Nitpick if you ever have to respin, name this 'local_err'.

> +
> +    int i;
> +    int64_t bs_size;
> +    uint8_t *pci_conf;
> +
> +    nvme_check_constraints(n, &err);
> +    if (err) {
> +        error_propagate(errp, err);

Thanks :)

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        return;
> +    }
> +
>       bs_size =3D blk_getlength(n->conf.blk);
>       if (bs_size < 0) {
>           error_setg(errp, "could not get backing file size");
>           return;
>       }
>  =20
> -    if (!n->params.serial) {
> -        error_setg(errp, "serial property not set");
> -        return;
> -    }
>       blkconf_blocksizes(&n->conf);
>       if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->co=
nf.blk),
>                                          false, errp)) {
>=20


