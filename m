Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6C7C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3882221655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbgNx+0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3882221655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imydf-0006lY-Ew
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:27:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1imycl-00061K-4L
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1imycg-000851-Vw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:26:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:44706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1imycg-00084e-N2
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:26:38 -0500
Received: by mail-wr1-x429.google.com with SMTP id q10so38904294wrm.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 03:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=joWqSNEt9J12EEczztgDrlb3VWirUpNCr70kTEsqT30=;
 b=VbgNx+0+LDiohtRv8pLna9giaPHjtzpuRmBSSweJSG+ZjBYDal3x15KGgfdQEMNKHS
 LZQ1MftOil6av1jA6zsILCfwsVTKwYDaQ2Ejkxka2fC+Wvhbwnpp9qPS495RWenWNnUS
 ODpYFIiL8zwrMtfS6Tq/bH0AvazQUN6NMdNsIhRLgkwx3V4qpLenH1fIWvKejUyX3I1R
 uomoe2gpYuJkZwqKI0dR9i7GM7ojdPF0fuus+ZbMkLtSTim47KtPMXXQO8gKjdeML8hm
 N/OMJatBvWeNXElh9YJIjn/NYzdPtuDLi11OtCFPBBcE+/k5AJlInzAXp5rJKlKwAoog
 gCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=joWqSNEt9J12EEczztgDrlb3VWirUpNCr70kTEsqT30=;
 b=Xh8ZGb/a+moXngKGNg+1mkVi30vx1I3TMrlVQjdK1hZ7V9GdidbAN0XZBnnisNhhsb
 rg3s+ewYqyUU9VPIkKUY+ojtYjzFVqnzmd5qKLNSvLWEuNSEs7hZFcEdMhqxQvxIkCgH
 ms7CYkoLzLywHGpzPGH6gSMeqTZlMNwDJzeb9NbtlaFOoPnuGOOmdAC0u4hNOQHEpT8A
 dT0z/ofZunI6CjVWRK4Jxt+UE6cK7vDelp7hWnTOq/VM/h35vf/R1ICditcbvzGAvZNG
 vWAoaajvOZyNNyMqT+IQ+527IqLzwtSdQkVuZFoZutLeI00S0X1M+LW4t3vKP89XXiFS
 IX2g==
X-Gm-Message-State: APjAAAUMPq1Ed5PqjBTWIuoQmQbJuu8wVPiSAT6k5GfCr3v6plJh2m2o
 en60i86hTXtlUnKEFOd/nUM=
X-Google-Smtp-Source: APXvYqxCycC6h3//SulCKaYIuX9YNgqdmyEM0dfZuooNWQJJyXVBJdEfuhIRSuS5WH0Zyk7TFaZo0Q==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr84759628wrq.72.1577964397570; 
 Thu, 02 Jan 2020 03:26:37 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c2sm55580591wrp.46.2020.01.02.03.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 03:26:36 -0800 (PST)
Date: Thu, 2 Jan 2020 11:26:35 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200102112635.GJ121208@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <20191220210750.GA29167@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7PTD44AewjTsiSV"
Content-Disposition: inline
In-Reply-To: <20191220210750.GA29167@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C7PTD44AewjTsiSV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2019 at 09:07:50PM +0000, Richard W.M. Jones wrote:
> On Fri, Dec 20, 2019 at 04:13:59PM +0000, Stefan Hajnoczi wrote:
> > 6. A configuration file format is sorely needed so that guest
> > configuration can be persisted and easily launched.=20
>=20
> Actually qemu already has that, but it's really half-assed, barely
> documented, and doesn't cover major features that qemu provides :-)

Yes, I mean a fully-working configuration file format :).

Stefan

--C7PTD44AewjTsiSV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4N02sACgkQnKSrs4Gr
c8ijbQf/YzNh3qnEzFXsxtwp/VLhHToWIPyBNza4LUGz9DQoCQHEedFRQ3tX5gKb
gKKRTchuKjaDqtWRXUTucF3gkb+QPtk10eFMneQsubWphJ96E/oxXp5xnKesMaZG
wUbF14KKwoxk2WZJnpG3DlPuZYErSHbpxa2J9ZPMVFbQS8N8KCVS2KnK36R7zqD6
YoZRBFZu2iIzR8h63DMrPnQhdxInD3ZNFeQYbKSXjqREXAJpzPXP324aGmY8yZV5
+DXZ+TxNFXCnPnD8rzODx++useQ/NDLlxOenzhFfnbY/9z441oz+ZtO+QvCy58Fg
t0KgHtsybvgJkQ5rTA7wsvNG2wEjAA==
=bnsa
-----END PGP SIGNATURE-----

--C7PTD44AewjTsiSV--

