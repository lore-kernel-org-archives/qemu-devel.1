Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F41EC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CC72076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/B+8XYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CC72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlYO-0001cB-Ml
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlXq-0001Ab-S3
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:17:10 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlXp-0007h3-9O
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:17:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id z1so18071835wrt.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=kuNaYyzbN7QXKzEuw88cXjksdnL764Z4J4EXAD1g98g=;
 b=m/B+8XYIzg/HTluRRgF3LpDsFdtMJ0PNIV2WIuYOD+jNGBVkpupnv/pMgZm9cD4tpq
 62I0eZSf8a7ADji3IWPty/Qwr7WSlyHRjSJuhX59Cbgwj/hbhgx2P3FBX7bmQ56w7QJ9
 uPiknAqVZDjcaaXYxwy0908BegJKJ6/2mvIx1tVTgQbqxASErMTIxjNeWM3+IppHY7wk
 f/LTPF/P2lQIgeomm9F+3LsPmq8jJ93xDG5FzcZDGQX+PKV7SmoAx3LwjkNn7IMR6sQa
 azGiFeMXE/pFN7hkaK8YnGrIM++nVIGYGf8kKXuB9RFmbZyWUvPgQ6PMqSFF+KWX6b5k
 PEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kuNaYyzbN7QXKzEuw88cXjksdnL764Z4J4EXAD1g98g=;
 b=bRt5oECXJ0M6DeW+PGc/2shgpebjdCrGzWQafdjBah+kE8gyxzegr3c2y0zHUXPbnz
 knIkpAR/nppqsaHCRi7uv2GGzuGU9W+fqTrLl4gmU4vRJuv880JFppK+fp1uT93QB58q
 KmthIzePqjSN6V6K60QyFrKmKjD/iWs48yewTjcFj4tOwQQu/y3x9uf94z8syx+YGX17
 kiyzgnQ854h9XzLAtI7Sf8UtYsnY1Qo32eIXD5/LzkDFl4aEfq6EQZVmGX+p/utPHU0Z
 4rhR20Y/PGCydyOz0JKbxnDuu07WAjX+VKFgCnPVxYKxFoYW4QSJcGdLv0JvttF0SpxP
 M6mw==
X-Gm-Message-State: AOAM531b5mz6a2KSBuUaCRBKkCQycCh0huZof84lFtPhXmuITsoPVWab
 Pa04klaG50bpn4u/Apkc7/o=
X-Google-Smtp-Source: ABdhPJzwIglKa9GM6KcLMwg+zVws9Vg/JHB67IWXo64f9Bi3UevFBC5HTqkwOoSOqJKcKqYoYp1dGA==
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr15146660wrw.34.1600078627297; 
 Mon, 14 Sep 2020 03:17:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q192sm20467657wme.13.2020.09.14.03.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 03:17:06 -0700 (PDT)
Date: Mon, 14 Sep 2020 11:17:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: About 'qemu-security' mailing list
Message-ID: <20200914101705.GE579094@stefanha-x1.localdomain>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <25dc926b-7bc0-930e-109a-1cb3c03565c7@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
In-Reply-To: <25dc926b-7bc0-930e-109a-1cb3c03565c7@amsat.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x431.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 09:38:07AM +0200, Philippe Mathieu-Daud=E9 wrote:
> I don't think so, as I took care to encrypt a bug report and
> received the reply unencrypted =3D) Not sure this is the default
> although, as this was my unique experience following the security
> process.

Hopefully a one-time mistake. Confidentiality is necessary for the
disclosure of security bugs, otherwise users are put at risk.

Stefan

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fQyAACgkQnKSrs4Gr
c8iJHgf+JlOXn5sWuc7YMykVY3uuH26tj8//eSZlCxaY0DGkbsWhTPkVYg4lELZi
l9pXOWhhDLhCxV6UHFc7Y0KuG2jEuwCRBIWTR0OUViaaheMcvZULvJUroBA/0mQN
iXgFM/CGWuQiDDw09BQynhbK9du52tCkWcpz9SmjEQyZWnUSGtSlTVafGyyuDtnS
hyqUeoFJe2IDOZRMIRVcwfZmt2mUCwzxnLhCRiv0jAF0YGzpv6gMIiJ0I3UzX6rf
vcxNWCy4zwG6t89u2DMhmTb88LOgOiewPuC3VFS5ZrX5w8ZZshGR3ebtcQnjnfUZ
MKXbnQE+VsGkUWCRwUsQMf6UQ5zZaw==
=CFlV
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--

