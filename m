Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930CDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCCC2070A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiC8snde"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCCC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAc7-0005Be-JL
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jAAbS-0004ka-5O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jAAbR-0001n5-61
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:53:14 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jAAbQ-0001hy-Rx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:53:13 -0500
Received: by mail-wr1-x443.google.com with SMTP id n15so1764270wrw.13
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=b1BR7hsm4MzOuokGZvWG7X5kX4Ya7y+fcRyo8lPmRO8=;
 b=QiC8sndeXGKq5Y+67u+FSQD3kw0n9CvT1ZUU6HL87Gja7rubOTheDGXf0nyhLDwgx5
 V4bQYF2JpeKDnH7sp1HoTAzq5HlGaeiWdgZM1tmWZFyiIYnL1VtkdNYxErIPhX/gaLJ9
 SF6uFrUQse300v1OKlxDQy8S2/9BAUKUK8f6a/QI/Vn0amAvEp3z/ihHeDk2j2gMYicp
 pcXxabsUPI+wuNXh+a+T15o5UK7AswoGc8IqDkyL4buWKGH6okcyZf2ZH73URJBzExD6
 36xoapp0b2UlmOsdMQgsUDINgSYEaTLtOdDE90OvHokaz9pJRoFiPlevoVpIHZQ7Dphl
 yIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=b1BR7hsm4MzOuokGZvWG7X5kX4Ya7y+fcRyo8lPmRO8=;
 b=dMUpUK9NoDVgxkJcWLbDrphwa5FdyfPsSB8BWxpM80bMYQwIi/AY5BsM15w6tUkt7q
 gptvudZ0EoeAislF4qBoYsIR7pcj330MXtGSep9weiixIAYBUjquDQJ0idjALjDWFLgL
 nI9+9XpnpVTUwUu0CC99pftRNMhXplxANUkqZft6x0IuMqmfyCrnfgEXGi15LsBT41Vz
 b87J8Sz+peFlnu6dPgP1Q3kqK5FtcczI2SCvT/FcuRXSrIWJuGRsWS6KkvOGeSwqKcvH
 L6CZn8vX1X23mO19iBHS3+ap81SxdwowYe1Ccx5cJte3Z+Ynvuzu1K9TJMN9vxCoshd7
 e+WA==
X-Gm-Message-State: ANhLgQ2ZcJwAXw8eKhshT/R78isXF3Ok2juOgDoMo03UIFy4K/d+z5nL
 MZgLNlP6d3nbEV8wMWmCEEU=
X-Google-Smtp-Source: ADFU+vvUhDSPFO24COXNZCX1mylZS5MB8rynTMyHNIqFGuzCValDI+dSC8G1UGjMqUhXyMOR0mditw==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr3500679wrq.80.1583491991298;
 Fri, 06 Mar 2020 02:53:11 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id e1sm35902420wrx.90.2020.03.06.02.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 02:53:10 -0800 (PST)
Date: Fri, 6 Mar 2020 10:53:09 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] tests: Fix a bug with count variables
Message-ID: <20200306105309.GA1365924@stefanha-x1.localdomain>
References: <20200207115433.118254-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20200207115433.118254-1-tianjia.zhang@linux.alibaba.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 07:54:33PM +0800, Tianjia Zhang wrote:
> The counting code here should use the local variable n_nodes_local.
> Otherwise, the variable n_nodes is counting incorrectly, causing the
> counting logic of the code to be wrong.
>=20
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  tests/test-rcu-list.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry for the delay!  Normally this would not go through my tree, but
the tests/ maintainer is away on leave so I'll merge the patch.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5iK5UACgkQnKSrs4Gr
c8jjNgf+KF78DE4jNxi5TGoGdrG/Z1mCY/fz1s0eSLc8cqnIIKzdDB3gJVlZ6U3J
2UpZThba6dPXXmsfV6j7wrVj+cUajV1CH3h1KEJ5lNOQBa9RX1i/bz9zBfwE75FI
BzibVbKsEPMwVJUFj2tBPn5khI09lm10/RddpWck3OPVia1yJSeDTTHTZFIL7oD2
frqU8S3blfK/LvV91n3DD7U3oFIgErlRHBxtVbB0JiKsHYUEXPFZJlaHnd/xhq5n
5LJT/Gopfgcz8vy6McLQxvcjEjO1FcbO/Bq+Sbu4zqx6s3a3vbs1UlhaIuYuOryG
lYBI2Qg7pTJ8WaB2MCEFoIY84gIaLw==
=U8Zn
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

