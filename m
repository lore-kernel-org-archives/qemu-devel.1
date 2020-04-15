Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B27C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 663F5206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk+9drq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 663F5206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObzp-00038m-J4
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jObzD-0002dr-1h
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jObzB-0001n4-2j
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:57:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jObzA-0001mo-TL
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586933843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJQi2M9KIVnaETOieDMG/fpuggri9oUNMANmnWmTkhA=;
 b=Fk+9drq0S4MqBICcJoKgdHdy6BlZn++fCT9jO09YhwGp17uZCG3GpPaB6djdMtLNPhgrLh
 IzFQ9/VUHdKJQta5Sx06twYiGyjIUI4VaHYZriFhdr1VkFB+FyOtViIjiUKPbCoaW0KQy9
 MJBQHW36YPD+gfWVVFdDf/dwHRdlo9M=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-f_hE_0sQNz6V1oWvNNoNuw-1; Wed, 15 Apr 2020 02:57:22 -0400
X-MC-Unique: f_hE_0sQNz6V1oWvNNoNuw-1
Received: by mail-ed1-f71.google.com with SMTP id c2so2094206edx.16
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 23:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TjsvKYig+hUg889o+AG43YcrbCzU5aF+z/Ky9lxIJrM=;
 b=qY9IIHDX0tHch8yQMzFjLGRLUbtuKNnWl7jFXf798O/ff5DUaIS20uOMYcd8mKAZtS
 IJB/XCp56ieER2lFviOzdWdyd1THgDvc+slvIznjwNpGilmGgnULUjsOeoqmZcrmU2wN
 TUjEa/SyuOSFiI0BdUOKolkT8lfTfqfC4KO3ivjcwxxTaPpm0Yjxxp1pWRFU8VwT2+yl
 9hvpd92RIYa2U9rOQ59PUFChkZwtaU+S3lb6s0pCaMDkoGwK4QL32TZbAA4Sy2Kn3eIw
 JhCySggQB3Q3L2xuY754Nxwem5nCPAw5O1n8st2DReDfbpAPH9EemBn23wZAF9XvQReJ
 yRfA==
X-Gm-Message-State: AGi0PubzvZIzPKsU4lPutdWhtCXfeUk4zw5i3I9z8vg6uH7kK3WuEp1K
 F17z6+dGyXZn/w4dbBhrx8TgZWzpXxt+epMiKf3TUH7qS8ovJhLxQi7AyCJ8b4DQtK1KbPZdpdA
 J2sPOMPywk4wllAM=
X-Received: by 2002:a17:906:4542:: with SMTP id
 s2mr3768600ejq.34.1586933841122; 
 Tue, 14 Apr 2020 23:57:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypJVZclsCsr4zBp2flD0W0VNq8iiymKBrsT2YH7Am1E5EMqCslXa+oK8eeclGzjUpycKjekyKA==
X-Received: by 2002:a17:906:4542:: with SMTP id
 s2mr3768586ejq.34.1586933840877; 
 Tue, 14 Apr 2020 23:57:20 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b14sm2447917ejb.17.2020.04.14.23.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 23:57:20 -0700 (PDT)
Subject: Re: [PATCH v7 02/48] nvme: remove superfluous breaks
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-3-its@irrelevant.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <de0bdf7d-2233-0768-8e54-7da3fe5dbe66@redhat.com>
Date: Wed, 15 Apr 2020 08:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415055140.466900-3-its@irrelevant.dk>
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
> These break statements was left over when commit 3036a626e9ef ("nvme:
> add Get/Set Feature Timestamp support") was merged.
>=20
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   hw/block/nvme.c | 4 ----
>   1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 01e18fb9eb1f..da0e8af42823 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -788,7 +788,6 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeCmd=
 *cmd, NvmeRequest *req)
>           break;
>       case NVME_TIMESTAMP:
>           return nvme_get_feature_timestamp(n, cmd);
> -        break;
>       default:
>           trace_nvme_dev_err_invalid_getfeat(dw10);
>           return NVME_INVALID_FIELD | NVME_DNR;
> @@ -832,11 +831,8 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCm=
d *cmd, NvmeRequest *req)
>           req->cqe.result =3D
>               cpu_to_le32((n->num_queues - 2) | ((n->num_queues - 2) << 1=
6));
>           break;
> -
>       case NVME_TIMESTAMP:
>           return nvme_set_feature_timestamp(n, cmd);
> -        break;
> -
>       default:
>           trace_nvme_dev_err_invalid_setfeat(dw10);
>           return NVME_INVALID_FIELD | NVME_DNR;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


