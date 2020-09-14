Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE5C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828D22078D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="togFS2dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828D22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlak-0002hr-Gg
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlaE-0002Hk-CN
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:19:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlaB-00085l-Jt
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:19:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id g4so18088257wrs.5
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XXEF47AHZOo/NHIHTyDX5f/3ARsG+naYnf/JUgnnZ9Q=;
 b=togFS2dZVNFfDo8kRXwGSmcGv9ojxNw8ZR3qefoPhF4TejK9rRyTgniD8H7UD5Tnlg
 OhnyeHOl1XEm/H0L1MPELBNQwgxaShxib/uPXPtcCmGHU2FIoaIFfM2ZZynRsu40Krrm
 rnWRexYmZbl8Fcr0APCshr4m7y8Qoke6Eaq4zNhAtioISqygInfUYGWhrZ1moPITKojt
 MKboztImlYo3j689PPHlEOEwqJ8ioVFiqkX/5xwV25oNwCbJBudJKLqjPbTdz++o/Qgw
 5ooaBpCgTKOdj7RPmJZprneGMLibeYdkTVDvxeaWaozyMEwWqFKYcV7YkP3GzJU/PTLA
 8fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XXEF47AHZOo/NHIHTyDX5f/3ARsG+naYnf/JUgnnZ9Q=;
 b=Ye4B2nV9wouH5UP4sGmdYyk6VzbspNtee3WJXLXkxfeT46Fn5wbVfq/m4My5Kpc3fQ
 n3qYkvi4vT/ybB9TKuk29cSq9vwzEI2rKwyUJdZ8C91Z79+w2MBa3X+JMW6lHZJyKMdQ
 GpQw8SRbcx/T0+mbVLcH0UDF+7yZEp3Ab00sX9gBNKT3oh189Or0fBxhkQUpkO0N/YoQ
 YYLZ8jRZBKywUyiR7pOmH3vQB/iSgex/91CA3FozEmzc91jyEU/gYyhRaRDcT32DMuxz
 6pR/9YdWq2hdCp7roM5uMFI/Y+xlxbAtNIVymTSb0fvyCy9umQFYIPDGKeKBVH96w8I4
 3aAA==
X-Gm-Message-State: AOAM531mxz8FktQpijSzRtHkoFLJiq9KGPQxiPw8GNWbi725Ya/sukTk
 ZotmPMTwjg0F/QDVl6XKuwc=
X-Google-Smtp-Source: ABdhPJx6RUYpecBBi36ZqiK84tFxOl1XGPwjyIo91hk9XTWPYE/RmP2meQ2ll6lYyq2bpOz5oFWvTg==
X-Received: by 2002:a5d:40c4:: with SMTP id b4mr12018507wrq.151.1600078773843; 
 Mon, 14 Sep 2020 03:19:33 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k6sm18194492wmf.30.2020.09.14.03.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:19:32 -0700 (PDT)
Date: Mon, 14 Sep 2020 11:19:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] seccomp: fix killing of whole process instead of thread
Message-ID: <20200914101931.GF579094@stefanha-x1.localdomain>
References: <20200911141832.1238636-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20200911141832.1238636-1-berrange@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 03:18:32PM +0100, Daniel P. Berrang=E9 wrote:
> Back in 2018 we introduced support for killing the whole QEMU process
> instead of just one thread, when a seccomp rule is violated:
>=20
>   commit bda08a5764d470f101fa38635d30b41179a313e1
>   Author: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Wed Aug 22 19:02:48 2018 +0200
>=20
>     seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>=20
> Fast forward a year and we introduced a patch to avoid killing the
> process for resource control syscalls tickled by Mesa.
>=20
>   commit 9a1565a03b79d80b236bc7cc2dbce52a2ef3a1b8
>   Author: Daniel P. Berrang=E9 <berrange@redhat.com>
>   Date:   Wed Mar 13 09:49:03 2019 +0000
>=20
>     seccomp: don't kill process for resource control syscalls
>=20
> Unfortunately a logic bug effectively reverted the first commit
> mentioned so that we go back to only killing the thread, not the whole
> process.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  qemu-seccomp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fQ7MACgkQnKSrs4Gr
c8g7Owf/aoahXDwIomgUobCdGUd69ntPQ8EzpnGeafdaOtofc4i4TZvRcjkIv0Iu
6Oa15aS0vzi85kNTYG+ISdqdwlVrcECyPPSM57kFzy3NmD/rCls4Pbi6GzRvHbwU
BFcXF/K9PpMKNpAw1t4GH0npBVP9zgoeyVc4nCwCAKhmJiOuKB8sObStv86GA/YH
htaO1y0gtFj5q9xa661TsVFK0Bp8bwzt11GA0WCLKV2QdcDbgh/QmzPxGLwPLuQf
LrokkTrg/pJUVVN7Nzsi2SVCeg+riGhlyTPxI9UFMwJ6Nft5E5AYO6iPb3EOSe7Q
HJL1om/U450uLT0Vu39PrCinCPuidQ==
=1yBG
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--

