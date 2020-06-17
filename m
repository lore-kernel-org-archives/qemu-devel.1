Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D675206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u11tRlo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D675206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZrI-0004uO-A4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZgk-0005Z4-AS; Wed, 17 Jun 2020 11:09:19 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZgh-0006Ho-H5; Wed, 17 Jun 2020 11:09:18 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so2384772wmi.2;
 Wed, 17 Jun 2020 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=bCI6yhoIE4Uci4af37ie4yuhah42WPPGjoxXGR358i0=;
 b=u11tRlo0pUYPJFAlbvGErIRwHlBfMvx1xewEooUWl2F1e+x2G2L4Jo5CvJ4dMHPzoU
 QvvqRUIYpU6LUIFUsPxBACINT0gPy32kESq2yrIzkgwyfSpVO1H6xDoZaRgZbueF+wr5
 tRCMtUiag2s1f7nnKRdXd+TeR9ys0L6iVtts9VT5qfwaM02PMjXiOaXRNOTaeRrbJXji
 MzBGmPwn2STIrYNk8xmObdsbE+8ES5QQKGdTObTAnIVBZgL2sEn6FROhroXlJKGU0dWC
 4CPXOAyRAx0CtizeX1teP1qdlGSZeScF1L2nmMuggYDvCtE5Ucf/wHwv22iblaE3cUgp
 4vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bCI6yhoIE4Uci4af37ie4yuhah42WPPGjoxXGR358i0=;
 b=qBvymjEYcld0NJh2efIEpePvP15nwDiKmmYNCimodla5djRIkmDEwXCmmO0rCnFdMc
 0C1Wpu93tYE70N+dWH8Uf/vJXzk98Tqj93HSA+RvHSVzMTatqM/QVUvlUFkirruT9U0T
 LuZJyZNWXCPYWRj/4sFPfWmNN6c6eHziyQ4nXzh/axX2eP3FZKJg8Zw514+Jz2WJ4F3n
 vmgAY13GPAnsrxKDhgSaWeQ6XjvptVS9uripq3TdgXYEH0RQdzzH2cpXzk2RSPE7dttH
 nWATwb1shlQ/PG0vVyEqkHY2CBOLS3qDVVPpCUtaJ2/9JvLAqK48Xw0y2a1E6HxD/YbP
 JByg==
X-Gm-Message-State: AOAM533R8aUhv9Tc8qikVZIY7rvIH5z2qOYEPaxEUMUXUE4rXxdQsoGz
 k8ektBfQywA9VdpV5vE1MYY=
X-Google-Smtp-Source: ABdhPJzoY8D3sKnqarq+2be6gNIwdhc4IFZVZRzrK1+nreOYjg0CgMJ+kNenIsGL3K5FRd3Y6eH/nQ==
X-Received: by 2002:a1c:790a:: with SMTP id l10mr8498621wme.80.1592406552127; 
 Wed, 17 Jun 2020 08:09:12 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v28sm37797074wra.77.2020.06.17.08.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 08:09:10 -0700 (PDT)
Date: Wed, 17 Jun 2020 16:09:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v4 2/4] block/nbd.c: Add yank feature
Message-ID: <20200617150909.GL1728005@stefanha-x1.localdomain>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 05:44:26PM +0200, Lukas Straub wrote:
> @@ -1395,6 +1407,15 @@ static int nbd_client_reopen_prepare(BDRVReopenSta=
te *state,
>      return 0;
>  }
>=20
> +static void nbd_yank(void *opaque)
> +{
> +    BlockDriverState *bs =3D opaque;
> +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> +
> +    qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BOTH=
, NULL);

qio_channel_shutdown() is not guaranteed to be thread-safe. Please
document new assumptions that are being introduced.

Today we can more or less get away with it (although TLS sockets are a
little iffy) because it boils down the a shutdown(2) system call. I
think it would be okay to update the qio_channel_shutdown() and
=2Eio_shutdown() documentation to clarify that this is thread-safe.

> +    atomic_set(&s->state, NBD_CLIENT_QUIT);

docs/devel/atomics.rst says:

  No barriers are implied by ``atomic_read`` and ``atomic_set`` in either L=
inux
  or QEMU.

Other threads might not see the latest value of s->state because this is
a weakly ordered memory access.

I haven't audited the NBD code in detail, but if you want the other
threads to always see NBD_CLIENT_QUIT then s->state should be set before
calling qio_channel_shutdown() using a stronger atomics API like
atomic_load_acquire()/atomic_store_release().

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qMhUACgkQnKSrs4Gr
c8iwMgf5AQQSxP1QCfXZ/f0RJDup2gTCA9MKKCi3BIX3nwtBaeTxIy6WcAlfa3dp
pz8zgFBOE5ov8UH4YvEX6bivWhl81OwUKiuTrFbtD4MOKsNwbpMdafcMBf3IjaMS
clwdo0wkyUqNuiADjKBBHON8SwGchRmrNYRiFANkrjks1h9OBRkSu4FOZuMqbqP9
pWvOOPl6c46ql8LjSTYZ1XQfjzP5akztXPHss+ql/odDZbR180RITVqabvnmIMmH
72YgUB3tdk4xLFhtZlJDVRXyx1mz33A9LtT3e3iR9CfD8lRsUfIUyOo/gxaUeoSz
FcG10+MGGmhjs9CrOJAMmDe193wBTA==
=UHrX
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--

