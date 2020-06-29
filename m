Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D67FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0351A23D97
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6U6HYBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0351A23D97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptor-0002R6-AB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jpto5-0001fp-RT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:26:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38605)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jpto4-0006Ts-9G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:26:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so16125378wml.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=YBXe4WfSuS0RJiRXOvoM2LyZprO6DdffSs9qkk8Tjes=;
 b=T6U6HYBtvb+LLvwW6U6rNlY6eDVZ5yxcQolBD0IutFDooNdvnHNu66b77QCwlcHGp5
 oW9/dBnpI0iKCUVPlvqKsT7MRfGpPqGuVo7C6DKlS4zHNe79kRqLjSk3wTU2hD9M7mPa
 bFKoyl/kBIZwySGR/AcSq6pXRfOO+POXj6gZpQ/JJHQQVMfrwXfdSFH6uswxgcqyK/Et
 9T1EWOw77evA5cQh9u8XbPb9TtT9Ib832Ab2xyHtj4NCgYaFf/ajLPjVAkOg6FEIWToK
 nqE7L5lE8UMabMTnJBlvgclmeYuYZtYUDHGhzXYA1nr79Skog5Xf1cAIV5Cnjmv7y6oS
 uaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YBXe4WfSuS0RJiRXOvoM2LyZprO6DdffSs9qkk8Tjes=;
 b=G58XZ1BLBrZ2Q9CoCYC+qpbPIzOCmc5vEPMzSnzuoacD7tsc+Xk11HS2/LxbjK9gWe
 KteN2K//EtPyBVyJPApgdKME/yaGu229DMVitaBNsTnlHioCz8dd1zIYelivBs50HClY
 O1NJvhCfKcWBneOZXK02eJAD6wLr1JZNHeYc9bIignLFRhHoOUw2j3ho6jN6e+wqMboq
 Ujiq2oMtmxNvd+eaAf3iIDylxy0sx28U93vaVMPeqwZ8mdszgbYn4RUjBV59FQXIZ9cd
 v1YCPxNnO46EVBBVm2c5S76d7EnfqUwz6XMKNhaSZMwCmWM0pWY8x8UXsvQhg/RtRw7E
 +fyA==
X-Gm-Message-State: AOAM532u/DsYkJ2uOxb0we/XgzDIO03rAzX4uzTB1wlHZHFe9dyd/bFs
 slYZfQmWOnparMsF5QHhNR0=
X-Google-Smtp-Source: ABdhPJzmc4Z5nR4kYBG2fEZ1eI4A6uuytr86PR7Mes2MgGqYnliPCShxW9BdIn7Sz9nSPKBy5zvh4g==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr17786954wmj.161.1593437202583; 
 Mon, 29 Jun 2020 06:26:42 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 33sm42617235wri.16.2020.06.29.06.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 06:26:41 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:26:40 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH] util/coroutine: Cleanup start_switch_fiber_ for TSAN.
Message-ID: <20200629132640.GN31392@stefanha-x1.localdomain>
References: <20200626170001.27017-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CaPKgh3XHpq3rEUV"
Content-Disposition: inline
In-Reply-To: <20200626170001.27017-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, peter.puhov@linaro.org,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--CaPKgh3XHpq3rEUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 01:00:01PM -0400, Robert Foley wrote:
> This is a cleanup patch to follow-up the patch which introduced TSAN.
> This patch makes separate start_switch_fiber_ functions for TSAN and ASAN.
>=20
> This does two things:
> 1. Unrelated ASAN and TSAN code is separate and each function only
>    has arguments that are actually needed.
> 2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
>    access from within #ifdef CONFIG_TSAN.
>=20
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  util/coroutine-ucontext.c | 52 +++++++++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 18 deletions(-)

Thank you for revisiting this patch after it was applied!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CaPKgh3XHpq3rEUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl757BAACgkQnKSrs4Gr
c8hl9wgAk2WQl/yUtrH3Ou0dwG3R5/ARKYf3JllORU1zbjKLze+F/dEcdtorBATP
P146cBj9Gtnro2Cvm62d3L1HnP4cY1+4Qcj/Z/NZIJKNVmyiRrh1JJYFed2imPd9
91LRhbF5YEWxRjaDmP13IwJTO8jbXGv/gzWmmGjzsuy3y5RpOYlQDvlvd3GCotuQ
FiXJj7hvLsdjCMcZ5H+JidBjmGrl0rWTFPX7/gOXsZjuz81yRie1EzE3fweGcuho
uzwjXm/e9p6iPlB9WFA9j3etQ1PEvoFhR/YQxmQlFq9H+VEmB59LZIUGqaM5wYCz
mTj+njYDEVsXWEuH6KjaObhxao5a6A==
=aTbR
-----END PGP SIGNATURE-----

--CaPKgh3XHpq3rEUV--

