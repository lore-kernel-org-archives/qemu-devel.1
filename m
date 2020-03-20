Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114A4C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0642072D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5CauCMO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0642072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFIIy-000230-Vs
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jFII3-0001cK-At
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jFII2-0001XA-9H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:06:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jFII2-0001Uo-2H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:06:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id t7so2933295wrw.12
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UOnRalCV7oYEuB5tNNyiR1Q2uzvmbnsvlld1OCGv3tE=;
 b=A5CauCMO4EL23g+VH0e3wfvwPb1pWLVR4y5ADCghb8eErZLb9W7Xllc49h5PreSsRb
 MYV5yGhvT/ij/uSrgqmjz2HBNv+Vfz9DZmYoyfc8WVSFB7P/zKCb3LKjQb/aoj3GkICA
 PtpGgfasG7qx8l/j7KMlVEFUb5GIpv/jPtg2Qx1qGKeH7I9K3GVqAyIin96p7TpQWPtJ
 fzs0pLko4nzg7uaOGAHzlWGHiehzQwQf5SsCtTNotey+babb/EtWdcclaQHFrB+iU/gX
 Mv8c9bA8HDIhnKKGchlQPqvTLE25rHS/qFBxiqiv1kdl3VsLeiv4x8VEhckdIiw0noOB
 iXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UOnRalCV7oYEuB5tNNyiR1Q2uzvmbnsvlld1OCGv3tE=;
 b=DlHecqr/c05XSEjjEHOb5xAIjRSipIWLTogRmYMfgCsIJne7FN1V3wgR+p+IldT76I
 6EszTMzPJCDNnVQ6puii4oZf121flyW/nSSSvhT59f2euoZpaEKuQozogqWkC/FLYlls
 t3IcmYxlK9o1+hkQ05gY/ij4geKRUerqZN3Sol3N7ukrEy7puR5DN0/HTwUNS2WTDeQp
 50guZe56nl0oQsP9f1AX04ph0Y05GNuiN4iekElqy6y2iGjjBjEIPwvyirFLGHPWmQOC
 GnoGafGY8dwJ+fqhcbsrTJlIOlsf3DD6nOVVEHKZbo8qtNrRTTOMFHJ583JD/iBiUDOE
 S14A==
X-Gm-Message-State: ANhLgQ2SGDe3mggPm9wsFYD2vc5P5Rk4i2ipLSBa00j/LltC53ryA2PU
 ZBbNUYmcnvT3yUHMAf3S63E=
X-Google-Smtp-Source: ADFU+vvEx5028bKBhW9qNQce2Cbdf9UPvjDb0NUeVglV+FjGiC1h6ggFeMrCFy7Yo3aOB9cKe67oSQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr5019714wrq.62.1584713180845;
 Fri, 20 Mar 2020 07:06:20 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b15sm8302702wru.70.2020.03.20.07.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 07:06:20 -0700 (PDT)
Date: Fri, 20 Mar 2020 14:06:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Update copyright date for user-facing copyright strings
Message-ID: <20200320140619.GB138042@stefanha-x1.localdomain>
References: <20200316112006.19107-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20200316112006.19107-1-peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: John Arbuckle <programmingkidx@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2020 at 11:20:06AM +0000, Peter Maydell wrote:
> Update the copyright date to 2020 for the copyright strings which are
> user-facing and represent overall copyright info for all of QEMU.
>=20
> Reported-by: John Arbuckle <programmingkidx@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/qemu-common.h | 2 +-
>  docs/conf.py          | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl50zdoACgkQnKSrs4Gr
c8gajggAoBqLZeopdi+rmn1xCOgTkb8I09P++4x66prbqQrdSk8C7i7X34n3yzN/
YRQ0+e8RepN0rynW9wnpFohvgOQMLfsAaG7cA4KohzY6KhK2QaLuttbWUNPaSdqt
u7ra59uH/AScMoCNazhMe7c54sg/lRSxmo/BNbMRQJbxnI0vyZQPt/lIZNnJr2HV
lGK55Hoi6qS3kW/Bo6BsKVonupF4Ff0tta6Nwd8tHn2fiLHGrvBZRdPii7thVUwt
4ByTCHOzfUM4f42vH2BuMKarZVXm7KkmTNDwrbN+WsF61bQVUHri1Iam3yJpV159
uGsc+nEXmlX76IA2DQxtPkh0EdoMGQ==
=MmkX
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--

