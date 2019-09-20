Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E70C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0292070C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 09:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuzezCxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0292070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBFFE-00078X-4x
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 05:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iBF8X-0005j1-HI
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iBF09-0000Zx-QR
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 05:14:54 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iBF08-0000Yp-LC; Fri, 20 Sep 2019 05:14:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so9079607wmc.1;
 Fri, 20 Sep 2019 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/cqtzKqcWrCsVrZjWVxWwEKHDNeAGI8dMMmo4mDIy1s=;
 b=cuzezCxLCM7OGimJK69z3aNUaXArnZbN9z2nHUTDV6RRzWxj/J3oVvBm7nlDEecgWj
 +h1nnrCj5MZn1RyuTburoph88Fzfr01bxSfjbwYaxb77+Y7ibjJAiseFPYjPmkHNWue2
 JXwmoOMD48koVcM3U7Eph+C9yruuvFJdjC+s9eI9Tfr0DpfQQ/L0KoMn+BO2I/XNWfuV
 SjSfraFG4VR6rC5G+u/zPMRuFbx8kH4brRVtwX0KEvitB5ApnuKjbcAose0qMn9sdM+h
 r2eOb12nrfe6XZLpNCQau/iMyF2ak0cijAB3FrjdBDNtvBUkGzr8ZIQTEmEBY7PW9JPz
 vdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/cqtzKqcWrCsVrZjWVxWwEKHDNeAGI8dMMmo4mDIy1s=;
 b=G7hAvXXKKrsqOrWrBcD1EQHZHpY6CYU5/dYlI0xuHxQzzgRmSGDfruFIDOHF+vzIWB
 Iyrct8DwA12TBSwkSTK4tamF7dxsbZ+4sj9N0FF3wA7lX0DPJ4xoAi3Qznt0lswBcyYq
 KzN/7jOIfoewSkqY7LkdMNjlBluDj/c1Wc+vmx9wFPCQnLNiAfBlQJNMpTs8ZTFjVpLh
 05bX17uPXoR2He12elXXLd5VlfyigG+l4yWRe6++AflX/66U9vuGZt1jb25RrhSrVfPY
 DR+SXGoe6w8SOolsYUNkWLgNWZoaZt84FijekjNw+U+rTar0XUURpzsO50HT+rgSMf0F
 GhzQ==
X-Gm-Message-State: APjAAAWS2F3PAvTSpFlFJCpEgtGcJwlT8TY1una/N3N0ULfq+qyIvbVa
 FGVp8Mz7IYz4UqiDrrIXsrs=
X-Google-Smtp-Source: APXvYqyNT9s9NW5zDy0cdHEqCfz9rrFT67A8aiTvSIkdY5eddLkFpNIQWFEc3Be//ASopo6s12JUvg==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr2601479wme.41.1568970891010;
 Fri, 20 Sep 2019 02:14:51 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l18sm1630813wrc.18.2019.09.20.02.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 02:14:49 -0700 (PDT)
Date: Fri, 20 Sep 2019 10:14:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3] virtio-blk: schedule
 virtio_notify_config to run on main context
Message-ID: <20190920091448.GG14365@stefanha-x1.localdomain>
References: <20190916112411.21636-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20190916112411.21636-1-slp@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 01:24:12PM +0200, Sergio Lopez wrote:
> virtio_notify_config() needs to acquire the global mutex, which isn't
> allowed from an iothread, and may lead to a deadlock like this:
>=20
>  - main thead
>   * Has acquired: qemu_global_mutex.
>   * Is trying the acquire: iothread AioContext lock via
>     AIO_WAIT_WHILE (after aio_poll).
>=20
>  - iothread
>   * Has acquired: AioContext lock.
>   * Is trying to acquire: qemu_global_mutex (via
>     virtio_notify_config->prepare_mmio_access).
>=20
> If virtio_blk_resize() is called from an iothread, schedule
> virtio_notify_config() to be run in the main context BH.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
> Changelog
>=20
> v3:
>  - Unconditionally schedule the work to be done in the main context BH
>    (thanks John Snow and Kevin Wolf).
>=20
> v2:
>  - Use aio_bh_schedule_oneshot instead of scheduling a coroutine
>    (thanks Kevin Wolf).
>  - Switch from RFC to v2 patch.
> ---
>  hw/block/virtio-blk.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2EmIgACgkQnKSrs4Gr
c8gxbQgAn7WW3OCn/zEPV/rkVcKprjJFBPi/QPeRfOKToDJAtnYfbPPAdlilgxBe
0nVUypzio2N/G4ubqlxm36ZQyseRKrtCZ6j+XbBDt7QsvloxJKskv9NJMGlZ9DuF
Ij1n9BhrhgFyVDQQSwZy62WGdgN7cYMqt2w3XKHOfFx7zzj7Qw+2gTuaIKCgC/vX
FM/JUqtu7bI61NaQEsNlQ7x2b4DE9rqWHCzPymLGfFsKxf2TzklX53tGdfl576Wc
EJTU3V3fIgxJZrd6q61E38HwOjzWf57jMVNVrArQGrgRreHNJrj5R3RSWJNfo0fk
IPHua6ADG2Gg6JGZbMAmM6f/ZrSaZA==
=DWwK
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--

