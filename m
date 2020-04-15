Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BC6C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B7820768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Scj6EKdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B7820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOc55-0007yv-IR
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOc3W-0006di-T4
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOc3V-0002vc-PE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:01:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOc3V-0002vS-Lq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586934113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lLe4rpVqEnI0L7IpcL2Rvk+EqKitnVYUDU44uqmh4lc=;
 b=Scj6EKdcxv5bzys6cWyd8CRD/caMJoYbixEiMYQEF8rxy749q7hnsROYgnSXuNP1uxYwsC
 kAdBWuWisNnbp42gdZEh4WV2NVpsFVqVdoZXA8KudGqMuZyjS7ZqG+r25YUMfq2tfVrOct
 Xs73o0c6Tm/UaSxzSRggjvaXmwRzrPI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-1wPflzAAML-kJ9RmFJT21Q-1; Wed, 15 Apr 2020 03:01:49 -0400
X-MC-Unique: 1wPflzAAML-kJ9RmFJT21Q-1
Received: by mail-wm1-f71.google.com with SMTP id n127so4577692wme.4
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 00:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xqK7t/uFDhN542+ddCDw0V0AeDbbKsv+JobNErZH3iY=;
 b=BguJ7jNdjzHe21P02sVA+OWAdlh38zN0xZOh44JTPU6uMeUVSPJnHzh4ZxyDrZVx12
 30lEurV0J3VWjgHxfC8+LXrwfUSOKmloOF3NjUwTwBEYr84bHVMs1Oa5vG6WmsqCB8P/
 vnIz4R3orro6mTSZcqKexSaqlBRPSQLc+OsCWKxgNiFimd9YIlbgnqJjQpH0EumvHSCA
 qNMVucr4sRzbaXcQe4VMUoXN8MyJHeLRhkp1IMpICzO22L2Dcndeex2VDHaNHuoStekz
 W/g4AlJ6Xq50HwoBBdU5LZaylpOEdScgnLCuWE8ofnops5uYYH2tFP6Nlhd66AseeNrh
 1d4Q==
X-Gm-Message-State: AGi0PuaZksm5MT+10zRxbtFCg8UU7bwv4rY5L1g3aooFatJ7knNRfM4L
 jQw1d3YndOt5k3kavTXkEiSFiyrgfbvcn4w/0LXRttugN9KosLHyxaDSlu0wPytbX3R39MRms5f
 gsbabRwvxqxGi4x8=
X-Received: by 2002:a5d:500a:: with SMTP id e10mr27935036wrt.341.1586934108661; 
 Wed, 15 Apr 2020 00:01:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIDXPJGG77n8RVQMTlzB3C2vGVu//8tm1Ak4MQSMMumDy0D+CgCxvtsPVEGM1ZdRC2MxAV2A==
X-Received: by 2002:a5d:500a:: with SMTP id e10mr27935004wrt.341.1586934108295; 
 Wed, 15 Apr 2020 00:01:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w11sm20999522wmi.32.2020.04.15.00.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 00:01:47 -0700 (PDT)
Subject: Re: [PATCH v7 05/48] nvme: use constants in identify
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-6-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9d1e1237-8496-0e9c-7cd3-679c30f99451@redhat.com>
Date: Wed, 15 Apr 2020 09:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-6-its@irrelevant.dk>
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

On 4/15/20 7:50 AM, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 088668f28bae..622103c42d0a 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -679,7 +679,7 @@ static uint16_t nvme_identify_ns(NvmeCtrl *n, NvmeIde=
ntify *c)
>  =20
>   static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>   {
> -    static const int data_len =3D 4 * KiB;
> +    static const int data_len =3D NVME_IDENTIFY_DATA_SIZE;
>       uint32_t min_nsid =3D le32_to_cpu(c->nsid);
>       uint64_t prp1 =3D le64_to_cpu(c->prp1);
>       uint64_t prp2 =3D le64_to_cpu(c->prp2);
> @@ -709,11 +709,11 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd =
*cmd)
>       NvmeIdentify *c =3D (NvmeIdentify *)cmd;
>  =20
>       switch (le32_to_cpu(c->cns)) {
> -    case 0x00:
> +    case NVME_ID_CNS_NS:
>           return nvme_identify_ns(n, c);
> -    case 0x01:
> +    case NVME_ID_CNS_CTRL:
>           return nvme_identify_ctrl(n, c);
> -    case 0x02:
> +    case NVME_ID_CNS_NS_ACTIVE_LIST:
>           return nvme_identify_nslist(n, c);
>       default:

Ah, NVME_ID_CNS_NS_DESCR_LIST is currently invalid.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
>=20


