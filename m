Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F832C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC55E20768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KetR7jtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC55E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOcCG-0004AA-UW
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOcBZ-0003Sy-MR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOcBY-0005MD-9A
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:10:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57221
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOcBY-0005Lm-5v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586934611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OboI94gbHiAAWu+hheEY2ahcbXXqYx3F8OG0H+cZP/Q=;
 b=KetR7jtOpVymQgsr0etybFHPGB9EKMxu51dsnMo3Noi/9QsrjixiZ27izrorNMhlfeHtdZ
 KCnM1f8EGgrxLF8Gxn/1xO5L5D5aK+DB0lFbZbQ1dbne5JDc1x8ojWXMnNhmIbwK58E34e
 46KgW+qk6xn9Y7qP/68OynYKYgD8sVY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-icWjldBWN3CA89WuPHvFXQ-1; Wed, 15 Apr 2020 03:10:07 -0400
X-MC-Unique: icWjldBWN3CA89WuPHvFXQ-1
Received: by mail-ed1-f72.google.com with SMTP id z25so2147057edx.8
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E4+Dlwx5bVuz4h19y7/KHIoXIYxk5jK2fSrNSNTb1HY=;
 b=cj3Tcvswiig/Fa7tmVfxhzWDNwP/RqV+SngqY/UKRF7Cjnh18KL6ejb8IRX+VPevgd
 4xpOQX9MBpWBHt4iynxqqt+laqmqrIh/85l0psbz8U4Kxm9F37G//wRDWpo9a/eBF4lR
 NqN1KZr1I+sXJ5rBZ3EgStAizLtTDtG5gfvbuHX3FpFsjWBDMcqeZ/Kk+/M9/SbRZUyE
 O/L4I2ncOCXGkRcQml2PkbyU+6EWglK2BzgVsRn7J1pi8TPfcQvqQ5m4mxViCmj2qTce
 Yfl8qniHmIrlZW7iPZiM5NCmfZyw6Aa+POVE9leJdSrbceU6yLMisS5ZzyDhPb8hQDMk
 vSjg==
X-Gm-Message-State: AGi0PuZlaldNlAh/4g1yuwIPz2U9y1S67XnMg4QrxS84wnyLeAXEYd5y
 VxvZpAuZCvCgyi036p/IXL/ux4roQEK+Wmx5hz6fHDicvj8FaabcSHb95bZ2RT+A+uZvUWrHNNG
 ujigemTxFNP7EZNo=
X-Received: by 2002:a17:906:1c56:: with SMTP id
 l22mr3750708ejg.304.1586934606349; 
 Wed, 15 Apr 2020 00:10:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypK46oltSKnjPDv5y1hkubqlr91L0cPpmM/fiAsXIJMwdo+yLdm13M4L7fJJo5YR4zB9aaHIYg==
X-Received: by 2002:a17:906:1c56:: with SMTP id
 l22mr3750683ejg.304.1586934606128; 
 Wed, 15 Apr 2020 00:10:06 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u2sm2033369edj.21.2020.04.15.00.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:10:05 -0700 (PDT)
Subject: Re: [PATCH v7 10/48] nvme: remove redundant cmbloc/cmbsz members
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-11-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62ec4481-a31d-d2cf-efb4-9107ae23bb76@redhat.com>
Date: Wed, 15 Apr 2020 09:10:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-11-its@irrelevant.dk>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 7:51 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/block/nvme.c | 7 ++-----
>   hw/block/nvme.h | 2 --
>   2 files changed, 2 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index f45909dad480..123539a5d0ae 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -63,7 +63,7 @@ static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr=
 addr)
>  =20
>   static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int siz=
e)
>   {
> -    if (n->cmbsz && nvme_addr_is_cmb(n, addr)) {
> +    if (n->bar.cmbsz && nvme_addr_is_cmb(n, addr)) {
>           memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
>           return;
>       }
> @@ -157,7 +157,7 @@ static uint16_t nvme_map_prp(QEMUSGList *qsg, QEMUIOV=
ector *iov, uint64_t prp1,
>       if (unlikely(!prp1)) {
>           trace_nvme_dev_err_invalid_prp();
>           return NVME_INVALID_FIELD | NVME_DNR;
> -    } else if (n->cmbsz && prp1 >=3D n->ctrl_mem.addr &&
> +    } else if (n->bar.cmbsz && prp1 >=3D n->ctrl_mem.addr &&
>                  prp1 < n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size)=
) {
>           qsg->nsg =3D 0;
>           qemu_iovec_init(iov, num_prps);
> @@ -1443,9 +1443,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error =
**errp)
>           NVME_CMBSZ_SET_SZU(n->bar.cmbsz, 2); /* MBs */
>           NVME_CMBSZ_SET_SZ(n->bar.cmbsz, n->params.cmb_size_mb);
>  =20
> -        n->cmbloc =3D n->bar.cmbloc;
> -        n->cmbsz =3D n->bar.cmbsz;
> -
>           n->cmbuf =3D g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
>           memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n=
,
>                                 "nvme-cmb", NVME_CMBSZ_GETSIZE(n->bar.cmb=
sz));
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 98f5b9479244..ad1786953be9 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -88,8 +88,6 @@ typedef struct NvmeCtrl {
>       uint32_t    num_namespaces;
>       uint32_t    max_q_ents;
>       uint64_t    ns_size;
> -    uint32_t    cmbsz;
> -    uint32_t    cmbloc;
>       uint8_t     *cmbuf;
>       uint64_t    irq_status;
>       uint64_t    host_timestamp;                 /* Timestamp sent by th=
e host */
>=20

"hw/block/nvme.h" should not pull in "block/nvme.h", both should include=20
a common "hw/block/nvme_spec.h" (or better named). Not related to this=20
patch although.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


