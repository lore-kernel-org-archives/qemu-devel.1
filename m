Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADEC35671
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9F42072D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 11:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdh0b6iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9F42072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6C74-0002MF-At
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 06:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j6C4r-0000I9-GU
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j6C4q-0007DS-IV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 06:39:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j6C4p-0007BT-6f; Mon, 24 Feb 2020 06:39:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so8669361wmc.2;
 Mon, 24 Feb 2020 03:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XvLlnINkR4GetBSg1b0UzjnnrDmjsxkOG0qN8Hr7AME=;
 b=hdh0b6iGB6MJLJV/M9eMUeLqJqWtT10+uIlCPFkD/BLjEol5rplecquqeI+2mhe9dn
 BpzOlKU2ndJo9lILAEFK5C8D1CXoUpVCRAC+V76XfzcvLsIhCPL5rODRkqmWiJvOkFur
 AImT6NYDL7ZO4cVs7nk2V+6VmgjmR8RbrRQXOffL9GSxuM5ZcrhhT8Ix1lkMQRg9AuJD
 g15AK2ub7WYE9T5Cz6jDSykm/0h3fNX7PTX/yZwqbebarDLDAss+1aC9ppdMUQ7HhTs0
 fQaMif0ZZY5l0H7NeH/yfKZ9Mq11OHINf/Q9lm/jl9apuzlEjqRYN2tnx9TMERh5d/4l
 PDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XvLlnINkR4GetBSg1b0UzjnnrDmjsxkOG0qN8Hr7AME=;
 b=Rbv1TGtwy6lh2/fIdZuADSpgIDBC4985SMR+pi/GCjbLvGiGxAIkcyjzxflAfsiBYj
 W/devoA6rIgCF2whTH0DyVylsOSTcXUouRPWEX2dIH1rTLWJ4SLo1nTrQUglPw0hDAVw
 0I7uNnU9bmMEZTIzFbPbQc4sw7eaOX79EMnUre9l+xyCSRzRP+eDgb6VBLk/XHpAgKa0
 nKtG+03zNU+TniQCKubqWAVG6Rpqf2+WYvR5NTGE4u61PzVjl1Hn68T6o+ZgA6K/Cm4O
 invkI96FpFals5+tRN+RCjKuw0RR8baJEFNNFoEJAoBclqcKWxNoqfaacFaSA1fZ4Z5V
 98rw==
X-Gm-Message-State: APjAAAVmAWNBFvXBOErWDEdnreuSG9DV0vcgArZWrajOfX1MctO75HAQ
 y6UosafObrZouM/Ef9dPiSGVrLvH8orFpw==
X-Google-Smtp-Source: APXvYqz4AKvODxkOkTDpmR4p96fm+Psz017mNYZH8jGb0w/uct0gqLLF64putccrDOMxorjACFIp7w==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr21699803wmc.103.1582544345519; 
 Mon, 24 Feb 2020 03:39:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v16sm16928079wml.11.2020.02.24.03.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 03:39:04 -0800 (PST)
Date: Mon, 24 Feb 2020 11:39:03 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
Message-ID: <20200224113903.GD1896567@stefanha-x1.localdomain>
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <158254173238.10132.7761755657862330006@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <158254173238.10132.7761755657862330006@a1bbccc8075a>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 02:55:33AM -0800, no-reply@patchew.org wrote:
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/2 Checking commit f913b2430ad3 (qemu/queue.h: clear linked list pointer=
s on remove)
> ERROR: do not use assignment in if condition
> #65: FILE: include/qemu/queue.h:314:
> +    if (((head)->sqh_first =3D elm->field.sqe_next) =3D=3D NULL)        =
      \
>=20
> total: 1 errors, 0 warnings, 59 lines checked

The same pattern is used elsewhere in this file.  This code comes from
BSD and doesn't comply with QEMU's coding style.

Stefan

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5TtdcACgkQnKSrs4Gr
c8jkfgf9GcChzVTwI8bF8CRlM54LLHTRYKZrc0SG2dSasbl8kVSt3MnVTjzyzKW4
al2qyhkqgLxdyZqsGTi3dk5TRoLX88E3Nc0A6W0OUMuNhpGVVkoBDBZD0fbZSBME
PEjKq0y4Fafkoe0l2SCbSP6DfbBqsgoKFHDiD4VRaETS7mcb5gUztwW462rzxwbR
0FTO1NcZLh9TN+3RaBc4wsocdlvPrUn0NDPg5PGHkSMeU47xrEzm1RUuRAu7i14A
YIx8SGI+PFhQqLJGXYROCC7jfUbuTA13e9pnuGqzLgPnJ0ocRjZAFTgMoCgs8N9c
8uobaMrEvGPjvCyRBrLd8daZ/POLsg==
=v6ee
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--

