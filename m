Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E3FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBEF23D4D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjJtuD9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBEF23D4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptbO-0006Go-8j
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptaP-0005Po-IJ; Mon, 29 Jun 2020 09:12:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jptaL-0004KD-Ln; Mon, 29 Jun 2020 09:12:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id g18so16534150wrm.2;
 Mon, 29 Jun 2020 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fGgL79MyZGaqgLG+bNfpXx7msHKeI8CD8GrITmN73+M=;
 b=pjJtuD9YEaCQEehDiMay0SkIOnQEW6KEmY+WPk//SG0osJPo57zHxbAQifaOq1Ye33
 XX3ZowvvfDzuN2RXU3eF4hUi0qhuESxp39Zq6h5E6XiKhluWxTIQxPhONpr8Mkzgs6GT
 osUpmFKI6F2kEodKWWTSCirQUV3wb8PD9RT8JHpPlz3Nx9P2wo2eYWNsRnBYCdEdo3Ba
 NR3iO7hWvbehkY+UElYzHhoca2DRzO4e8SFk0ROrIMo84qrsz7N6CU5021SFWWUBB1BU
 IgZ4/7PIqGjO2QA5s9wIkDYFTwdOjWg/H6Nj1TxwN+2HVQ609BTsGnKE/xb7CRz0fi5J
 38kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fGgL79MyZGaqgLG+bNfpXx7msHKeI8CD8GrITmN73+M=;
 b=SCFP5+YM4xCNbO/hxITH3U/vR62/H3Hu39D4zwx7Vzjx1yelpZyvfB4Mg32BgG3FvA
 /Q38b24Ykrk5ftlpBoqDVrqTAZcNdgzhXrWlEuoLx9Hi7YYof51U2xaSuirHpz1vH/gj
 KN9kcRYjx5w1zOno6YPVkhJC1BClm/wOzYzfXLIUWLFTjddWi9OrdjZxYY5nmJjybT5H
 G27CqPh13MaaW8/TmZi8EwcGRVxqh0MTmASN0lBaf3Ggc67fsLJteNNA/IJltEHBg9CH
 uglNe7T9SqwNSmlYuNQJz3xL21ZdE6jQWdLh9x/QISq5yF8M3sF1KujHtP1D00ru7g0I
 2eRA==
X-Gm-Message-State: AOAM532rlh456oVkwMRThTfpYoaTf7W0PxJKN2VzcoCh8UuouSAHM7Dl
 oehVrziaK3TVa/nBeJ4hPWY=
X-Google-Smtp-Source: ABdhPJz/WJ6nQRrB/gq4vcIVuvUwRa14eUMmAUihewUD1nigMGamG+aWJJLSF/kZufBBPCDhT9rjCw==
X-Received: by 2002:adf:f04c:: with SMTP id t12mr15475502wro.382.1593436350547; 
 Mon, 29 Jun 2020 06:12:30 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b18sm19331470wmb.18.2020.06.29.06.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:12:29 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:12:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Asmita Jha <asmita.jha82@gmail.com>
Subject: Re: Qemu installation error from source
Message-ID: <20200629131227.GL31392@stefanha-x1.localdomain>
References: <CAKKBCQoBmk3rA=Ht=AVZkOUc0zDVJCVyX1GLbEWK97hodOfqDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bPg9NdpM9EETxvqt"
Content-Disposition: inline
In-Reply-To: <CAKKBCQoBmk3rA=Ht=AVZkOUc0zDVJCVyX1GLbEWK97hodOfqDA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x42e.google.com
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
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bPg9NdpM9EETxvqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 06:17:06AM +0530, Asmita Jha wrote:
> Greetings,
> I had been trying to install qemu from the source. I tried both the metho=
ds
> given on https://www.qemu.org/downloads/#source
> And also as given on https://wiki.qemu.org/Hosts/Linux
>=20
> But in all cases ,I am getting same error every time. Screenshot attached.
> Request you all to kindly look into this.

Could it be that you have a statically compiled libbz2 but are building
a dynamically linked QEMU?

Does QEMU ./configure --static ... help?

Stefan

--bPg9NdpM9EETxvqt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl756LsACgkQnKSrs4Gr
c8jEuQgAhzS9SX90zFyNSqeyNmN39+nOvfh8ErrkPvITUsHo5V1po6OBTc7Zgb6E
lqjp56tqo94IBEAgY/SFXdto0AXRVNlU8052SqlS5S9OqzB09tR1GzT6m+Xg5YCN
+WholQxxB0I7XIbk33GjprNJLGucZeQiQ4I0pZNkzDWA3QYs59henTn0orv6rfB5
9Ca5/L81oEYXiLl5jN6Rf64j83uQmnGkFVmL6/aV1LwoFLwc5Alwv0xyCyG34Y54
HQS70d8yznDciN4pCnD3BmEHzdGP0AdNWymifG4ukHogaw0y6pue9CMIF12eXEpK
cPaOn6WpCItjmtoIu/Xx/mg2kmnotw==
=q0Y7
-----END PGP SIGNATURE-----

--bPg9NdpM9EETxvqt--

