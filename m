Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F40C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4F7207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 08:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4F7207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i69QA-0007lq-Ro
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 04:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1i69L3-0002qC-So
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1i69L2-0002Mj-4Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1i69L1-0002M4-R5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 04:11:24 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E7396412E
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 08:11:22 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id v4so790781wmh.9
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 01:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KHY+pZP9sMz8Mhtp7RqD8Ap4xKdcnT/NsASpSXxBuns=;
 b=NVzdjYOG9ieBGaseY3pG/MaT1ak6xFrNOl5Ks5kXLOphakp5LSGwElpvnSi4U/QC/0
 iOsi4qsm1qqbtmC8a+oolHZxSyrkm9asn5CcpArsiryHJuoEpfKHkJvCuZMpOCbCqjvz
 8j9w4K4s517iuSyBl2aLyzYXy0RU1ZuCdsHV8OBlvYalKDdICGy1XSpYtpp/JWG2FQO2
 7qYzRGCl/7Of7s7iScd18UIgtVjnl8Cg/dT7pVQrCepVuhcIxLYDTDjlLdeNz709VI86
 2LQgsqUu3CVU7TZgDig91i08E4TkCwlmA49wf2nR42ZrbjC3UiAO8yv2dyVBxg/sWzlL
 DaDA==
X-Gm-Message-State: APjAAAUnBbhR5vKZxgPGB01Mty0b6VCodl6JWfqCy97cNeA3miaD449S
 Kx6ZJud340W5zj1C1jPXlczbBn+f51Ty2u/37i70LbBbJPw0AJCENPU1SB0+cC0f5qVnOIUFwHF
 Y3ECTEKQXai9JIQA=
X-Received: by 2002:a1c:c1cc:: with SMTP id r195mr6537613wmf.50.1567757480944; 
 Fri, 06 Sep 2019 01:11:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyW83O59EVtda5dZSKvxkz+cvGubH8VsCuOcAd3+aDUVhxxyA0XdjjL1dE1EYJoWvrQ91Y8aQ==
X-Received: by 2002:a1c:c1cc:: with SMTP id r195mr6537576wmf.50.1567757480540; 
 Fri, 06 Sep 2019 01:11:20 -0700 (PDT)
Received: from steredhat (host170-61-dynamic.36-79-r.retail.telecomitalia.it.
 [79.36.61.170])
 by smtp.gmail.com with ESMTPSA id w19sm3015210wmi.12.2019.09.06.01.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 01:11:19 -0700 (PDT)
Date: Fri, 6 Sep 2019 10:11:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190906081117.asr67hq26eqqooxd@steredhat>
References: <20190904210100.10501-1-dmitry.fomichev@wdc.com>
 <20190904210100.10501-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904210100.10501-2-dmitry.fomichev@wdc.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 1/4] block: Add zoned device model
 property
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 04, 2019 at 05:00:57PM -0400, Dmitry Fomichev wrote:
> This commit adds Zoned Device Model (as defined in T10 ZBC and
> T13 ZAC standards) as a block driver property, along with some
> useful access functions.
> 
> A new backend driver permission, BLK_PERM_SUPPORT_HM_ZONED, is also
> introduced. Only the drivers having this permission will be allowed
> to open host managed zoned block devices.
> 
> No code is added yet to initialize or check the value of this new
> property, therefore this commit doesn't change any functionality.
> 
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  block.c                   | 15 +++++++++++++++
>  include/block/block.h     | 19 ++++++++++++++++++-
>  include/block/block_int.h |  3 +++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 874a29a983..69f565e1e9 100644
> --- a/block.c
> +++ b/block.c
> @@ -4679,6 +4679,21 @@ void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr)
>      *nb_sectors_ptr = nb_sectors < 0 ? 0 : nb_sectors;
>  }
>  
> +BdrvZonedModel bdrv_get_zoned_model(BlockDriverState *bs)
> +{
> +    return bs->bl.zoned_model;
> +}
> +
> +bool bdrv_is_hm_zoned(BlockDriverState *bs)
> +{
> +    /*
> +     * Host Aware zone devices are supposed to be able to work
> +     * just like regular block devices. Thus, we only consider
> +     * Host Managed devices to be zoned here.
> +     */
> +    return bdrv_get_zoned_model(bs) == BDRV_ZONED_MODEL_HM;
> +}
> +
>  bool bdrv_is_sg(BlockDriverState *bs)
>  {
>      return bs->sg;
> diff --git a/include/block/block.h b/include/block/block.h
> index 124ad40809..28d065ed80 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -271,18 +271,33 @@ enum {
>       */
>      BLK_PERM_GRAPH_MOD          = 0x10,
>  
> +    /**
> +     * This permission is required to open host-managed zoned block devices.
> +     */
> +    BLK_PERM_SUPPORT_HM_ZONED   = 0x20,
> +
>      BLK_PERM_ALL                = 0x1f,

Should we update BLK_PERM_ALL to 0x3f?

Thanks,
Stefano


