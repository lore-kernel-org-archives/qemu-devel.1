Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0929C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767BE20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGMA5FEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767BE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHgF-00079f-MY
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHdd-0004b9-Qz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHdc-0001Hw-DP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:50:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHdY-00017K-FK; Wed, 22 Apr 2020 11:50:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id x25so2938911wmc.0;
 Wed, 22 Apr 2020 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=OZPDZ29mXi6pauLhMtgof1NqJ0ePEOUpfrO+oE6DYMs=;
 b=YGMA5FElMa2rA1AMKt2BWjVyE8b2+D1CHxShxYUmNoGbICTB1pSnI9/+gXsZGXk4V+
 oIQFuEE3d0jWwg33XNsBln17ecPCIO9QtpgwCGpJ2B8K1+FEb9ACPtFLvb48x9qydhE0
 RG6hqgO15vYa1PjC6yeTkovcGGTywI2FAkrIeyJamkGq0hdALDcrttx3JNE9Wo04jIxm
 Ud42SG40ryfs8YbABhnjNU3hKWNWSBezGj/t7HKPHTap1tK2EZQwxpY28KPWwX1rzqe7
 Y6RKq4W4zdHUZ8jF/LNUmzYnng2sMwBFhi0OrPc86wABf9FgqTuDVdVDU+aB8c/7PiFk
 4Zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OZPDZ29mXi6pauLhMtgof1NqJ0ePEOUpfrO+oE6DYMs=;
 b=XClV7zjSiDlAmYL73d8wkfNq7y/WMrGkzKCyhcTw7tDJyM9qbTRfo27UOqnqMjjbes
 q23OTDnm//yFEH08JNCCEs5U21sV0yIvDYqe97DGOUJ/c5UlRGxp0KYE8ZSDUHrht96r
 KpoRGj9+PcZ0oH+xJl+Vv3Tq9nLXNudyW+8sPNeS0JimOVulXNXINEHvOjp6mbSIzH+m
 dzKwfoQX445swi/4IpQotbaXHJMBRvB4OShBTUInb1UCfRNVTBXRAOwJM2ksjAsd2VXA
 MAbUfC1cX8sjKM2O1muxBYSwJA8S58GF2anBuKEF8/EsVjpauippsJJxSu9AvjnBX9FZ
 le3w==
X-Gm-Message-State: AGi0Pua/WtHPa+0Um/a166InXCvMuFgH6TqVhk6hZHCyfxya7WwsZm6r
 qdL2ZzgBJBnAWt3JaqYI8xs=
X-Google-Smtp-Source: APiQypLLxnxeaI5q34/i6LNb1YM8lh8HiSMX1mAR0CqrL9hUvnY5Av8DD3hy10DnPlbPRiPeFQVs6A==
X-Received: by 2002:a05:600c:c5:: with SMTP id
 u5mr11825678wmm.134.1587570605927; 
 Wed, 22 Apr 2020 08:50:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w18sm8443618wrn.55.2020.04.22.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:50:04 -0700 (PDT)
Date: Wed, 22 Apr 2020 16:50:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/3] block/io: convert generic io path to use int64_t
 parameters
Message-ID: <20200422155003.GE47385@stefanha-x1.localdomain>
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
 <20200330141818.31294-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <20200330141818.31294-3-vsementsov@virtuozzo.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com,
 pavel.dovgaluk@ispras.ru, qemu-block@nongnu.org, dillaman@redhat.com,
 sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org, mreitz@redhat.com,
 ari@tuxera.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org,
 jsnow@redhat.com, ronniesahlberg@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 05:18:17PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> @@ -875,9 +875,9 @@ static bool coroutine_fn bdrv_wait_serialising_reques=
ts(BdrvTrackedRequest *self
>  }
> =20
>  static int bdrv_check_byte_request(BlockDriverState *bs, int64_t offset,
> -                                   size_t size)
> +                                   int64_t bytes)
>  {
> -    if (size > BDRV_REQUEST_MAX_BYTES) {
> +    if (offset < 0 || bytes < 0 || bytes > BDRV_REQUEST_MAX_BYTES) {
>          return -EIO;
>      }
> =20
> @@ -885,10 +885,6 @@ static int bdrv_check_byte_request(BlockDriverState =
*bs, int64_t offset,
>          return -ENOMEDIUM;
>      }
> =20
> -    if (offset < 0) {
> -        return -EIO;
> -    }
> -
>      return 0;
>  }

Moving this if statement was unnecessary.  I'm not sure if there are
cases where callers will now see EIO instead of ENOMEDIUM and change
their behavior :(.

More conservative code changes are easier to review and merge because
they are less risky.

> @@ -1743,7 +1740,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *chi=
ld,
>  }
> =20
>  static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
> -    int64_t offset, int bytes, BdrvRequestFlags flags)
> +    int64_t offset, int64_t bytes, BdrvRequestFlags flags)
>  {
>      BlockDriver *drv =3D bs->drv;
>      QEMUIOVector qiov;
> @@ -1773,7 +1770,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
>      assert(max_write_zeroes >=3D bs->bl.request_alignment);
> =20
>      while (bytes > 0 && !ret) {
> -        int num =3D bytes;
> +        int64_t num =3D bytes;
> =20
>          /* Align request.  Block drivers can expect the "bulk" of the re=
quest
>           * to be aligned, and that unaligned requests do not cross clust=
er
> @@ -1799,6 +1796,7 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(Bl=
ockDriverState *bs,
>          ret =3D -ENOTSUP;
>          /* First try the efficient write zeroes operation */
>          if (drv->bdrv_co_pwrite_zeroes) {
> +            assert(num <=3D INT_MAX);

max_write_zeroes already enforces this, so the assertion is always
false:

  int max_write_zeroes =3D MIN_NON_ZERO(bs->bl.max_pwrite_zeroes, INT_MAX);
  ...
        /* limit request size */
        if (num > max_write_zeroes) {
            num =3D max_write_zeroes;
        }

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gZ6sACgkQnKSrs4Gr
c8i8bgf/QeP6bM5X97t1aRWosIJaa6JhbKVX2/3n7bdf5bzTXkOtNzVoD4n6FAH5
mm8haDm+/CtCWcfh75C9BDNHmvOs/j5FiBbvlO4KHFv+zcCTcoykDF9IBqg16b3F
7fE29CAfl1PsF5FjFNo68oEQQXdNtjsw6aLBMAuyXz8K0Fl1z0aOz5+6wEsvBUr1
Gn77f3x/qf7/BBLSN0yrtSitj1rXV1Aa5XVZ7s1fYBkO3nORkP3IsWK4LNPBl1L/
/PSiCIHtpjDlHKdXBBLf2SCTU0gItoEIVZJ/Rt2VhSFkX6622pa0j+QHIzxtCaDS
rozNYCd7WuKofKYdlkz0h3FHi7wL3w==
=9ZWz
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--

