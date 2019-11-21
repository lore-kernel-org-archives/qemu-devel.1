Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66DDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A126A208CE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEEU3CEH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A126A208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlwb-0000BE-Qh
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlvp-0007hR-2t
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlvn-0005dR-TB
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlvn-0005ca-MI
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so4281373wru.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fM2o1UAzPpMIcNpWuAd9Db7vQRJXaX6m94cR7/zEG8M=;
 b=SEEU3CEH/L7GDZIJJpm8p7RcXSfxssCHUuHpmGTA/jExcDoFbVXGQjyOdp1b2PL8j7
 du51m5hARQB82eLg5hCEHfPovnlJ+iAjB0rKxDmYjyohKBRjshDdNSbud1VXAuZWbfUH
 TxNWQuu9lMlT8xlQ0eoZ3IDG5py0hu6iYwsHmG1U/TqiswOZaovK+cdXuwhGKxoWp9yI
 qt6kQM/aK29tDXgKrwFRfSCT00kIyuk8q6oJDxvMTgPhx4BOJsYCC+1TFnef4GV7KqJb
 bt4Mt5vlRtsykOvGFQyFd3XOdoNWNxtpz8ywcnOHevjA65ivtydiuqrQ1mahT4uCD8Pc
 cqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fM2o1UAzPpMIcNpWuAd9Db7vQRJXaX6m94cR7/zEG8M=;
 b=JBNh1+dKw9rkHWAetIH1BgYuJWbh3LmpyVqn7nP0QDcl6mMC/Pee/bqe1ANVJys/Fw
 27OqTM2AVPTf4cZR6LEcU19gA+CZTEGJzWlDGDeRMoQFv8/vjYHrfcnkOfKdzzDC7vVJ
 60IWfKNS3Kw5WhxDN5pF3XFEiVkDPF8RO4KXgcCR6jz5pIkgMOTTHiUry75WX+X3Qooa
 on9kDrSa5l85w2UWQOH98/EScbVLCHwtFr4TQqkVPRLwS+j5ilcYlRvGrVtG0HbWgc8C
 Oo5wtA2svrWpBRvNin1E5xLm8pu0JU7rZXQAVDB4KjQXZx1bP9E+9tUExC3rn1pXC5VA
 u1MA==
X-Gm-Message-State: APjAAAWCh74N/OVD6NG9UzSq/1f6G7pYoQ/oW3gCuqLir93csRdX5kKR
 5P3aZjQ1nlN2XucvV4cA0Fx4uZLIxF0=
X-Google-Smtp-Source: APXvYqz7YUBYxV352LCOcJlOw9osVIyFi1Th8qYFA0T6GIA7he3eT6xQAoWu+xaK7r9G2KoGLB5K0w==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr9536993wrc.175.1574340690622; 
 Thu, 21 Nov 2019 04:51:30 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 76sm2949975wma.0.2019.11.21.04.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:51:29 -0800 (PST)
Date: Thu, 21 Nov 2019 12:51:28 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] Add device fuzzing blog post
Message-ID: <20191121125128.GT439743@stefanha-x1.localdomain>
References: <20191107091136.359965-1-stefanha@redhat.com>
 <1233611027.10012683.1573119684999.JavaMail.zimbra@redhat.com>
 <CAJSP0QVMCyYND7GrhUUCF_c9XOd=2ODRdV_s_K=afJ96XMz=pA@mail.gmail.com>
 <9313c9d8-440c-03d9-4050-064c0a2b7ced@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7Rldj+JZnTQmDdGi"
Content-Disposition: inline
In-Reply-To: <9313c9d8-440c-03d9-4050-064c0a2b7ced@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: Manuel Egele <megele@bu.edu>, qemu-devel <qemu-devel@nongnu.org>,
 Alexander Oleinik <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7Rldj+JZnTQmDdGi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2019 at 12:39:49PM +0100, Thomas Huth wrote:
> On 07/11/2019 16.48, Stefan Hajnoczi wrote:
> > On Thu, Nov 7, 2019 at 10:43 AM Thomas Huth <thuth@redhat.com> wrote:
> >>
> >> ----- Original Message -----
> >>> From: "Stefan Hajnoczi" <stefanha@redhat.com>
> >>> Sent: Thursday, November 7, 2019 10:11:36 AM
> >>>
> >>> This blog post covers the device fuzzing GSoC project that Alexander
> >>> Olenik did in 2019.
> [...]
> >> Seems like the images are missing ... can you please attach them?
> >=20
> > The commit is available with .png files here:
> > https://github.com/stefanha/qemu-web/commit/49efe1b254460a92c6348e1981c=
af3e1320782f8
> >=20
> > I moved the authorship information into the author: field.
>=20
> The article is online now:
>=20
>  https://www.qemu.org/2019/11/07/device-fuzzing/

Thank you!

Stefan

--7Rldj+JZnTQmDdGi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WiFAACgkQnKSrs4Gr
c8i+Zwf/TeIUQM5ZtZi6B4s3/MgZJQUCqizZoSRBoiccpz2uSaIJW0Myuv/yvcsz
I/BfKYRazICDWrwma+5+EIeQ29/oae+tm3ikjtIq5ByXYeeoUVshdAJnw455a4oJ
ftS+pJ93lJ0lin62vmPfuY1QuA6fYrM6S1g6EOc+jy35b/J6lnqE+LHN/42B5/lC
f5rbiQ5EnE+7zvukuyBvYPtaJK6zbY0HaENUTRMaUTX55ki01M6m/6h84an1YW14
UMscqZuK+fhln0nLndqTuvvWyIACyYGUlaS+T/6+UZLjOxfsZPCawu8pBKyXQVHJ
qN9qblHnevU1aheUT3hM3VoNAlU1NA==
=O4f5
-----END PGP SIGNATURE-----

--7Rldj+JZnTQmDdGi--

