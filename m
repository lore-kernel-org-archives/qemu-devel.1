Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACED206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju2YD/SM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACED206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblao-0004nG-26
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jblZM-00031G-LV; Thu, 21 May 2020 09:49:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jblZL-0008TZ-OO; Thu, 21 May 2020 09:49:08 -0400
Received: by mail-wm1-x343.google.com with SMTP id u12so1634782wmd.3;
 Thu, 21 May 2020 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CswiY0vKiN2C0BFtjhgvFRnm/Dywj2zH0Heipijb7uM=;
 b=Ju2YD/SMO80B+cgVI+jS7DgAT8PWeSzCVrzVnsNqUJvJ9H9oyslZjLsWUYuTfCbqlm
 N+VF3MuKlOwRIIpvdyTw4PN4wYaAteG4SiM15EJk7gkkkeMuYxlmjXDmYLYpZZEeq5qE
 pltoc7VBmaepqySDW2XDq/2Mt0M0QejbpJLQ6aJPkYUwtY9bNLQ8DuvE1HlgduncLv7M
 ZBWE4dW/x8SbPQV31ewfpZcbKGgMyIT3wuy1wRUvNIbviUTk8Y8mSLW67VBE3yDbzTEl
 Cl5XoXoqIQ3llmp3FrOGNuR5ywqIxm3Img9equ7U9G3VHOw/TfmziNR3q13cbBg6O9tw
 IkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CswiY0vKiN2C0BFtjhgvFRnm/Dywj2zH0Heipijb7uM=;
 b=umJ1WNBSRflVOgoct9Nd6z4MiPbsDDjFeFiY3tjbjP2xocxRavtWg9tcDYSo6iIVHT
 bUEvJ+PA1aTcGjtqR+gFQTuYPrqzDQIAFewxM2s5lIn+kEEmr7kBLk0mdkKK9+JvM1df
 2enhZwKdXIdQro8+Pj+dPC8ds3sIEyb5KbX5k79p6AY0CtkXGOPwumN65NY062XRvv8x
 YEUsq4ArUWjUoOGnw/TYAreib0g/yTZX0PNa3oyu0bgapr0y9X9H3XUeo3MIseSSij3h
 FsbqtyNSj7KL54GjQTCjShsdhxGc1JUGnSVnQ9X5rScCXOf0wQfr57ceQ4ckWBicC2Mi
 J+HA==
X-Gm-Message-State: AOAM533qdvaEfdYuTpS6l+viGFHUtapAGADSiSyXcqi/ZWzzjjM8Bf1+
 5/hf3QzGwNFkLRVUI58N72BPHKnG
X-Google-Smtp-Source: ABdhPJwmCrU/b31bCVkDrM/w+LKyLZVsDz02jxn0w8Mnz57N8GkngpjRzGSscFXP90UNssE8v4GaHA==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr9433402wmc.102.1590068945718; 
 Thu, 21 May 2020 06:49:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 128sm7133209wme.39.2020.05.21.06.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 06:49:04 -0700 (PDT)
Date: Thu, 21 May 2020 14:49:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 0/2] aio-posix: fix fdmon-io_uring memory leak
Message-ID: <20200521134903.GK251811@stefanha-x1.localdomain>
References: <20200511183630.279750-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRokNccIwvMzawGl"
Content-Disposition: inline
In-Reply-To: <20200511183630.279750-1-stefanha@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wRokNccIwvMzawGl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 07:36:28PM +0100, Stefan Hajnoczi wrote:
> This bug was introduced in QEMU 5.0 and causes guests to slow down because
> AioHandlers are not freed when the fdmon-io_uring file descriptor monitor=
ing
> implementation is used by the main loop thread's glib event loop. This is=
sue
> does not apply to IOThread usage of fdmon-io_uring.
>=20
> In practice few distros build with io_uring support enabled at the moment=
, so
> the number of affected users is likely to be small. The fix is still suit=
able
> for a stable release though.
>=20
> https://bugs.launchpad.net/qemu/+bug/1877716
> https://bugs.launchpad.net/qemu/+bug/1873032
>=20
> Stefan Hajnoczi (2):
>   aio-posix: don't duplicate fd handler deletion in
>     fdmon_io_uring_destroy()
>   aio-posix: disable fdmon-io_uring when GSource is used
>=20
>  include/block/aio.h   |  3 +++
>  util/aio-posix.c      | 13 +++++++++++++
>  util/aio-win32.c      |  4 ++++
>  util/async.c          |  1 +
>  util/fdmon-io_uring.c | 13 ++++++++++---
>  5 files changed, 31 insertions(+), 3 deletions(-)

This has been merged into qemu.git/master.

Stefan

--wRokNccIwvMzawGl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7Ghs8ACgkQnKSrs4Gr
c8i4WQgAkKKFt3GS5zuAd+k5LqyG0xJZ2S4Uaqv2/GspI8mcj5KE4f7gGS+vLiSr
6t4f0rXUuV2JGRM8LaYjTYHQn1C2wx+aZmI9A0A7HRq9MMwjqLUMY7LVokVxRFy3
UJ+gDHhuNadcsOXA0HqjWTjXOB3KJQIybD4OrMotWyLxemns5UWHBFj6N8A8tsic
qcy2K9ORMhzyNZ1o66hXETbCSyOGTpSxyRA71rSPqp7PFnHn0XCqaftWIpIC4E6o
LNgOki6G8sqbytxYcuDDwo5EPS2AS4T546g8HGgfljT/EQLT1miXlQTrrYnaBXlD
gAcxr0d4N8aOvdw/IlQeLM/ePdxkOg==
=bGqG
-----END PGP SIGNATURE-----

--wRokNccIwvMzawGl--

