Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9044C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E372073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWk4oaDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E372073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkdq-0006MK-UD
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkHi-0005Ia-DW
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:52:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnkHg-0000z0-J8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:52:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id t194so3526678wmt.4
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=dv5krdPi5QPpwymN3LEesqLpWMN5StpM+D7F384XbNM=;
 b=dWk4oaDlubeLDEuwMns6/4YTWcmQeBrs/VXKwaXo3dsNGd6CFBSjuzDfhtkd7NYWTm
 6rtivLFyRw1GUcsi2mhz+FXBdBeEzvsLDnnHaxrmAhi+J4/KeIPphxe7nErSuhMQ6R9D
 PPt2h87aYZ/N+shPWFuy6UOtNHTYnbCwf4np1dVQCEh0EQxL1q2qKRWFGQLqEaQpJtFF
 JKyMDl7u4/yZIFDt0I5D26CH9UPG8sagEKrroae5oUMkcvFrpPsl8vJBsi9KrjaqDT03
 SEqaQsI7px+XHPt/Kpr7xY2m8A6bGwU+mnNAchWvvMR3/+Hj7zxr6Hl2hvDGhmE54yRO
 CZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dv5krdPi5QPpwymN3LEesqLpWMN5StpM+D7F384XbNM=;
 b=tK9OCGKaTafiNinJoHhE9w4A6zAzpcoO11DpIh8jCZ/ejskAn9MW5NKhgcBE4sdlOc
 HXZ1zOtJRh8z3dl3B5r9y6TnWqRgIuo1GP4lt58pJmhuQwFBpeVQE8slteJWB1LI+F/J
 /JSoROe0cxV3PfdSY+SMJd521hvf5Ue0Xqf6H2Rmm9Odn2dUHwS0Ffat3AmfA35v9OYZ
 JU0M1nKgSTkRgmy92IX6YGMrETn7n2wY7pvnoivO8Se5ZCA9QdiDqNDYMyauwEbrYpuO
 hBTpIKOpWTlR+5pIBOu2ksOE1KRXt2v4brRX4NYLgh+jCUdnMCMaog0jl51nKzwEerzh
 Pe5w==
X-Gm-Message-State: AOAM530bFhnyteru5qpTCVcjdxohz/1FmyNZM2oJHBkSEUZC8SsX49K8
 bG4OH6FdVkjoBuSzWJ9mpII=
X-Google-Smtp-Source: ABdhPJw9ONLpIjtxKUXPwq6kntCfUeobjtRvoaJn7g/Soq93VH661OGxRU7wN2H+025YRag4Iq/lXg==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr24804890wmk.16.1592923942997; 
 Tue, 23 Jun 2020 07:52:22 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u65sm4291883wmg.5.2020.06.23.07.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:52:22 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:52:20 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3] docs: vhost-user: add Virtio status protocol feature
Message-ID: <20200623145220.GS36568@stefanha-x1.localdomain>
References: <20200618134501.145747-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fqIB0bRxfTYxTb/F"
Content-Disposition: inline
In-Reply-To: <20200618134501.145747-1-maxime.coquelin@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: jasowang@redhat.com, amorenoz@redhat.com, qemu-devel@nongnu.org,
 lulu@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fqIB0bRxfTYxTb/F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2020 at 03:45:01PM +0200, Maxime Coquelin wrote:
> This patch specifies the VHOST_USER_SET_STATUS and
> VHOST_USER_GET_STATUS requests, which are sent by
> the master to update and query the Virtio status
> in the backend.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> Changes since v2:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Typo: fix missing # (Jason)
>=20
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - Only keep the spec part in this patch, the implementation will
>   be part of Cindy's Vhost vDPA series it depends on. The goal is
>   to be able to implement it in next DPDK release even if Qemu part
>   is not merged.
> - Add GET_STATUS after discussions with Michael and Jason. It can
>   be used by the master to ensure FEATURES_OK bit set is
>   acknowledged by the backend.
>=20
>  docs/interop/vhost-user.rst | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fqIB0bRxfTYxTb/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yFyQACgkQnKSrs4Gr
c8gE5AgAyI2l3JYA15whXcjnSrWuPf4eXgwPqQvp+zhF1pNxM6N3vViBvpHRW3MK
wDgDq+77R07alffG3tsx5++eYtkvi7NDtNF+vSKTlSjunmaVOdUSHKSIM1elsL+d
OzbSkx9+35TXJbGoGTtMUbJEBtAje5IPU3E6ZdfEzk3unJ2pw0T8sAbpAdLiIczR
5T9h/ULEMZjcTHOICFLOLKGg6X5XFhAm86eywjLfLB4bnUhmNxasuyu4gcGqjNW9
q/a/u1ZaYIs4KKz2QAbfrKdR/g9nYFxuMpYVaCLFfJYsFP4mGkVvlYq7o7ve0C+Q
m1pZNCeTAOeYLxZKwMtJTAosJoxBSQ==
=fyBF
-----END PGP SIGNATURE-----

--fqIB0bRxfTYxTb/F--

