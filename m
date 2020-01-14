Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD313C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9259A24672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itef3uUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9259A24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKC7-0002iU-Ge
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irK07-0004Jn-6S
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irK06-0008D6-7A
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:04:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1irK05-0008CZ-8c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:04:45 -0500
Received: by mail-wm1-x343.google.com with SMTP id u2so13167463wmc.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=poI9+O4rWtN9dout6QdkM+i8vBow/GMm4TrdNefzrXI=;
 b=itef3uUEk3ASB3Our9ijcrb+ghMNTnmgzI19h7VC9JHRpC1w5gR9OO1VsZUlqu6H3L
 Gbmfv5ZQqI2y/jmHmVj7k4qlDMUS6pzqnjXk9i8Ok5SsLdmxlSLfiHE6Lv2HE4ujR+6a
 7U1Yobh5cm++96BbsVYSinI1VOJorwJ/G41mJ6NHLmNNr1jnKvzVRAZSxP+f8gupbtkc
 swK8fWLRKRYmSXZweOEZiLr5UZclYxb8I29GJ1541JinvLn8Q9V4QsAs2w4NwW7xG5D5
 ptMp9TxNml6PzS+293DGPslO/CS06WALB0aRHNnu7D5Wh9g8+7db6fKuvJXZ7rdXQZS0
 BDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=poI9+O4rWtN9dout6QdkM+i8vBow/GMm4TrdNefzrXI=;
 b=AVlgKDlSBt0KUuIyGi2STodGL/2fg1wZWZJRh+B5nbeRyJIuY1r3xDkbVDjSxhCX+A
 1qRzdxfXZ7tYOr8EggUd6xgGOURw42od4vV+gnLbVgzUnof0a0RiLmUzFV83iR/b8iDq
 lvdP5F/Z038da19FqJ04MkULRHyAXVb8j9OWPzYj7YaFLMxHTImejiZ43zvqr9SPBYyE
 27A/pJpfKwFD2el4c9bEJNvXLte6BT7m5xC5qvPE9AQUS89yvacn8lc13GmONUkRY/kT
 DCHKa+SvXu5gC+73yWg3DFy9mLhs0SoUBhlu4usVwi9RYCByjWNO81hqpIQp3hMNFs+M
 94Jg==
X-Gm-Message-State: APjAAAVTLMaY/ynrgZ+maJV9jmScz5lr1gKU23+PiQEYpLCz7wWZgWs1
 0vHodFg89gDutJKJKYfB2LI=
X-Google-Smtp-Source: APXvYqwoPpTQTK/+Lss7T2SlADtv2NOAn3uf2RmA7tGzbhcOZTlXL+nDoOYM412J5HPe5l1qltIq9w==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr27420630wma.89.1578999884032; 
 Tue, 14 Jan 2020 03:04:44 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id z187sm18789152wme.16.2020.01.14.03.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 03:04:42 -0800 (PST)
Date: Tue, 14 Jan 2020 11:04:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
Message-ID: <20200114110441.GE118882@stefanha-x1.localdomain>
References: <20200113103550.1133-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <20200113103550.1133-1-alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: pbonzini@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 10:35:50AM +0000, Alex Benn=E9e wrote:
> ..and extemporise a little about their state.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  documentation.md | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4doEkACgkQnKSrs4Gr
c8ijRAf8Clw4fiQZAjfY8/tYIoVT4kv9V0zHiwkMJmIVHYPfLF5HOmJqTMIsj3BF
52fDRy+9ADX41L9HR0UVBCo35uCBgHNXcBdg4zJXhsdT8sQ9o7RAWsTGe98FX7J/
UeFXybsiny9WlK24+LrJfZKh8iN4dTCzuTAD23xUD/uTFI7y6iF3yVp/PBmEfqkx
o53Vg0sR3o+fi1W8fs1KYK8CgKatd5/nYkPF58Pp2oirS0H/gOf1nBFqHLxgzmMj
60606H/Rm3aD9ul7vFpjJBiKHXZi/eHGnfPFJjpuNbgVt3tYGXzXT9SI2MDdaKI4
I81KT/eDPuOsAr09fdkK5948t6i/Bw==
=gGO1
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--

