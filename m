Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C609C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BB52070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqQLqzNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BB52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmlG-0005u3-8y
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:44:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXmkX-0005Cj-Ky
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXmkW-0007lW-NT
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:43:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXmkW-0007jk-GP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:43:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id u18so3772962wmc.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 05:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=7Mdlj/m0wAidu8wbBTgtlWZywovb0IgKfmWD9Wybjjg=;
 b=nqQLqzNbYQqjSA62U1iEVS0IKVevNWoZYGO8dknt33yXTeHzlq17oDDJ2VX+9GjNzy
 Oes7Ok9CYCaJN5oeXv5jQQ6vvUs6ral6J084G8Jgvaa0Xk3Qh8z8CaYaZfZeQwemSbKL
 UjeMpd1XkyRNoojRITfIty0cHRWknhKqJ040ShPypeAMWiT8L+nzzgqRko8OlG0F2vnc
 oVmCsQRnxbmOZqXXAQ/E1oGngTwqJ67b+zFq1TLhjvTwQwi1zD1v525i7xEXKMAUi5YT
 B+AxeFx7gu1K6ZVkKVlVmAGDIuKfIOYcgCJDyeEH/Vzkx8y8ltIjtreebmBhby88HHEZ
 ljuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=7Mdlj/m0wAidu8wbBTgtlWZywovb0IgKfmWD9Wybjjg=;
 b=dGSPXgNblM99i8uG0kud09tpdHl4Gc1O7G4Hkln/eq01o/zyFlY4m8Clkp31G1pLgt
 v48CFz1jhDBZ97WRHMtlcUn1RkBFG0kKcoqSvlJ++jogeVE+gVtEo64ALpWEfgiq8S/v
 a9z80QSsCkc7GNyruVebSFyhhr3c4YQMHIKPIZrCt6x6zu/aJ4BpAXQv76friV7pt2Co
 XbUrZCIHpJUoQe1/6rcDw9Sw7/vRxbp066ArvlMeFitscLVXcCeW5Tk0mMYwuH2U14vy
 BfLhUleczUrn69Q3C9w6W9YjOLdt6/1ipSnEtJzpYSUri3KNil/KejFI6dX/HMkGjUyZ
 rpvg==
X-Gm-Message-State: APjAAAWxjcBvcpSCxYZ7H9F6gtoOFVlkmhjv50M7dMZbI4kVdnM9p/f2
 Vx2d2I5lQl3RsLg38SclwBc=
X-Google-Smtp-Source: APXvYqzXzHjH7e0yJ88yHeHlGwjgZA3jBHmbWkBRuT1B4tI+7dVNPdPJBPy6iEdwKkjfxpEGBRENSw==
X-Received: by 2002:a7b:cd0b:: with SMTP id f11mr10525173wmj.26.1574343834707; 
 Thu, 21 Nov 2019 05:43:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w7sm3329806wru.62.2019.11.21.05.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 05:43:53 -0800 (PST)
Date: Thu, 21 Nov 2019 13:43:52 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] vhost-user-fs: remove "vhostfd" property
Message-ID: <20191121134352.GV439743@stefanha-x1.localdomain>
References: <20191116112016.14872-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XDqeUMnLaDfDQgU1"
Content-Disposition: inline
In-Reply-To: <20191116112016.14872-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--XDqeUMnLaDfDQgU1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2019 at 03:20:16PM +0400, Marc-Andr=E9 Lureau wrote:
> The property doesn't make much sense for a vhost-user device.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/vhost-user-fs.c         | 1 -
>  include/hw/virtio/vhost-user-fs.h | 1 -
>  2 files changed, 2 deletions(-)

It was never implemented either :).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--XDqeUMnLaDfDQgU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WlJgACgkQnKSrs4Gr
c8jGhAf/Tcjh2/cQp4KVUL4dhyk8BTj8fvgeoqvmMVdLZMqAJhSsKr6FutxYMClx
q0k3YmZ/skbZmr5Jgj/KDHRsA7Kiwp/zRDA++mhBBJp/Shf6elpMwnQCQkpIWw0N
Idl3H+QLrfDZNtFeXq5aXuRd2qKKsmeS7vvYgbGSwu74/E7/9jhZ115XsD3rNZpm
4Q/H4IWrCPB5eQRf+Ovjh9ciHLs1PXYNM/fNuHrQxnzNVHP5YQjVKbjwdgAG+1ZB
gbGLiR3nqvMHS6+26sYZsAWU2dsE1N9s5DPXnQcb9sVF2zt8C1ES3asl7YljXeTZ
No9nyHuGwxQOTJBzJQtdhlOnqVkQOw==
=+jev
-----END PGP SIGNATURE-----

--XDqeUMnLaDfDQgU1--

