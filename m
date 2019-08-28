Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDF02173E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPPLOCT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDF02173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2u9g-0006N1-VV
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i2u8e-0005Sz-4M
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i2u8c-0000g5-Rx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:21:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1i2u8c-0000ff-Kf; Wed, 28 Aug 2019 05:21:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id s18so1742055wrn.1;
 Wed, 28 Aug 2019 02:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6608qaDzio5JWCpM25ondsS1CITI10UA29IC5xroKwM=;
 b=OPPLOCT6uwrmfLhD4GmSWmITEHQJY2uXZFry0L4pDP/CMZWHUy93Iv56NQABZ0/TiQ
 18e8aapO3AFb63BNV5rN25pu1B/sQ3goKMj/T/DzW8Wkwgg/ZS1WVI3qbcSA/0DqxW+W
 DSKBhH+/qkcW7eehrk5+Ek7ILH68PvlllOdwbe74ZGkWYezDrNet3ytHaj/TtFP74W2x
 IizU4YoIJCMXBAzSk1VK1MLxgXQtXO8DB2Q8s/zDc3RDUhdfK/GKRJqfbNvV5O4NEc+V
 M2qpUnz4B6kKl8EO/c+v/T3N5HSJF1uSWlwALFcAEL0VUKUxb3crCOCOi7dzD3zlF2eh
 Qtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6608qaDzio5JWCpM25ondsS1CITI10UA29IC5xroKwM=;
 b=d8OiZA85JbHzfhQjF50V+eVdf8Er9Zy7XV2hfGuf8WMa1qjyZTDrOzsEQRV6Oegf+B
 e9kRhQlRene2JBQe7C6+PyP/lJDBb5wMlCjbC0rypZq9jCmcl6tvPZ0GQH+yrZv/5qMX
 bTa3M3Gom78Onmhi4ooC31xpadX8iEXWCXG8a1lRdhNRLU4lbUIE/eJkH+mFqEA2hUl9
 8TKrrLdJ2grZqw6P3tPzHGn/YfaU7oaj5VhK03/+cjOW2dSbbSG+JMJfwD47AraTryya
 VKY6OCGGoY81u8GyqKdeXRPhjdhhtfiGG19zXT5x01usuy6Nhb3ksZsUL8bADT1UzF62
 j9SQ==
X-Gm-Message-State: APjAAAU3uchLZOLdp1xiyaQcFjDrVBnDAQguwSD4wRzQUrOwlgpRQLAV
 GQtuuRemtOOT05dJD+0XhdY=
X-Google-Smtp-Source: APXvYqwk5dgkO/DHDpiB5gmnAst+dZVb5uYvTsrZ6RWf3puOlTau/pvZ+51VGuBp1PBNxCf0hAFMfQ==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr1217011wrm.269.1566984069304; 
 Wed, 28 Aug 2019 02:21:09 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w7sm2052895wrn.11.2019.08.28.02.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 02:21:08 -0700 (PDT)
Date: Wed, 28 Aug 2019 10:21:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Message-ID: <20190828092106.GC5573@stefanha-x1.localdomain>
References: <20190823194927.23278-1-dmitry.fomichev@wdc.com>
 <20190823194927.23278-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20190823194927.23278-2-dmitry.fomichev@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 1/4] block: Add zoned
 device model property
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


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2019 at 03:49:24PM -0400, Dmitry Fomichev wrote:
> +uint8_t bdrv_is_zoned(BlockDriverState *bs)
> +{
> +    /*
> +     * Host Aware zone devices are supposed to be able to work
> +     * just like regular block devices. Thus, we only consider
> +     * Host Managed devices to be zoned here.
> +     */
> +    return bdrv_get_zoned_model(bs) =3D=3D BLK_ZONED_MODEL_HM;

This function doesn't say whether bs is a zoned device in general, it
says whether it's Host Managed.  Please rename to
bdrv_is_host_managed_zoned(), bdrv_is_zoned_hm(), or similar.

> +}
> +
>  bool bdrv_is_sg(BlockDriverState *bs)
>  {
>      return bs->sg;
> diff --git a/include/block/block.h b/include/block/block.h
> index 124ad40809..238c0f5ed7 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -271,18 +271,35 @@ enum {
>       */
>      BLK_PERM_GRAPH_MOD          =3D 0x10,
> =20
> +    /** This permission is required to open zoned block devices. */
> +    BLK_PERM_SUPPORT_ZONED      =3D 0x20,

Maybe BLK_PERM_SUPPORT_ZONED_HM is clearer?  Let's keep the distinction
between general zoned devices and host-managed zoned devices clear,
otherwise the code will get confusing if we ever want to treat
host-aware specially.

> +
>      BLK_PERM_ALL                =3D 0x1f,
> =20
>      DEFAULT_PERM_PASSTHROUGH    =3D BLK_PERM_CONSISTENT_READ
>                                   | BLK_PERM_WRITE
>                                   | BLK_PERM_WRITE_UNCHANGED
> -                                 | BLK_PERM_RESIZE,
> +                                 | BLK_PERM_RESIZE
> +                                 | BLK_PERM_SUPPORT_ZONED,
> =20
>      DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTHR=
OUGH,
>  };
> =20
>  char *bdrv_perm_names(uint64_t perm);
> =20
> +/*
> + * Known zoned device models.
> + *
> + * TODO For a Linux host, it could be preferrable to include
> + * /usr/include/linux/blkzoned.h instead of defining ZBD-specific
> + * values here.

It depends.  If it's necessary to convert back to the Linux enum often
then I agree.  Otherwise the code is cleaner a QEMU enum is defined here
and we can avoid #ifdef __linux__.

> + */
> +enum blk_zoned_model {
> +    BLK_ZONED_MODEL_NONE, /* Regular block device */
> +    BLK_ZONED_MODEL_HA,   /* Host-aware zoned block device */
> +    BLK_ZONED_MODEL_HM,   /* Host-managed zoned block device */
> +};

Please use the same typedef enum approach as the rest of block.h:

  typedef enum {
      BDRV_ZONED_MODEL_NONE, /* Regular block device */
      BDRV_ZONED_MODEL_HA,   /* Host-aware zoned block device */
      BDRV_ZONED_MODEL_HM,   /* Host-managed zoned block device */
  } BdrvZonedModel;

> +
>  /* disk I/O throttling */
>  void bdrv_init(void);
>  void bdrv_init_with_whitelist(void);
> @@ -359,6 +376,8 @@ int64_t bdrv_get_allocated_file_size(BlockDriverState=
 *bs);
>  BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
>                                 BlockDriverState *in_bs, Error **errp);
>  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
> +uint8_t bdrv_get_zoned_model(BlockDriverState *bs);

Please use the enum:

  BdrvZonedModel bdrv_get_zoned_model(BlockDriverState *bs)

> +uint8_t bdrv_is_zoned(BlockDriverState *bs);

Please use bool instead of uint8_t.

>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>  int bdrv_commit(BlockDriverState *bs);
>  int bdrv_change_backing_file(BlockDriverState *bs,
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index ceec8c2f56..91496e8149 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -415,6 +415,7 @@ struct BlockDriver {
>      bool (*bdrv_debug_is_suspended)(BlockDriverState *bs, const char *ta=
g);
> =20
>      void (*bdrv_refresh_limits)(BlockDriverState *bs, Error **errp);
> +    void (*bdrv_get_zoned_info)(BlockDriverState *bs);

"get" is strange since this function returns void.  What is it supposed
to do, refresh just the BlockLimits::zoned_model field?  Should this be
called bdrv_refresh_zoned_model() instead?

> =20
>      /*
>       * Returns 1 if newly created images are guaranteed to contain only
> @@ -620,6 +621,9 @@ typedef struct BlockLimits {
> =20
>      /* maximum number of iovec elements */
>      int max_iov;
> +
> +    /* Zoned device model. Zero value indicates a regular block device */
> +    uint8_t zoned_model;

Please use the enum.

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1mR4IACgkQnKSrs4Gr
c8iF2ggAytgrltUptOROC8NnHcF7a/68HH5nHlhvd50AG05sqe8OOQTyY2w+TZhd
o2Ck/rttHDE6TKfGoeGs0/hdnXgqNTN94yCzE6FUffmHrlZJ9C3MT9vEcRNqBBIm
kTugvr9UGTH/ggq0UdshYBcIWjFxCnSD73hteCEuVJvFww7mnX+FrHnsNxnkXVgV
xJ0+XnG7njCdMItpOoq4qX+zHDF/RdDQNnrEa01exRBqA1KFzEddaatLu5TcRipO
eMy063m7hheGIB3zw7H+RmgZdBj3Wfj4MLkq+p7bDvBugnYMc874OjYTaWwk/1eu
HaFLMDEkeCBGdTUQ9LfeSL1kz7Iqbw==
=9AqP
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

