Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD4C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:27:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4459820735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVdnIt7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4459820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGN6t-0002Yc-5g
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59083)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGN66-0001Wy-SF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGN65-0002Dt-Tr
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jGN65-0002Di-N9
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:29 -0400
Received: by mail-wm1-x344.google.com with SMTP id c81so4212931wmd.4
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5QE2+iCQw5Y6IXUWc37innqYLAmILnR3E+ex14S/YJ0=;
 b=eVdnIt7POfl5YauGyYwoX61ifQSVGjYDO0WDtS+OGkAjj10QChGPiHhiIdADCrjIfQ
 gynXoV1CDX/9BkX0lDBndSFXHtT3J/3tUH/foRMsE3XuQbvO8yNno3U/dLxAG0tPyEso
 B/EuFfAHSVUSTkR9qdm0g8SYJyhT8MVgtlt1gY8oB918C19vtYMo9Xl64hKsW9zUnOxz
 o38qDl7GwFhskIorpzXqX33zZTVIg6PjXvXje3GCntRYMUkkkZfX8O698Pk50mNWIED/
 nWJYJRfZ1HsDRWmJuBtKLBLesf18k3Wy/gVy1JYRERrguB3jRkff1cdpPFw6dtjWwtVa
 bR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5QE2+iCQw5Y6IXUWc37innqYLAmILnR3E+ex14S/YJ0=;
 b=NIhxIqW272o0VZZPKSQb5KnMkf064YJnkCzvAjaY6dxw3Di6mNOmTeTRzD2MAuvbXj
 vdYkGQNdAsOgsXIEx/gVlF3oYre/+uB0QPgOam4AHv0/J+BwzOFwG+KWwYrdE13u3Mwy
 cfNm0r7NhKruo+LeZfQPnOWfO9jdcrW0xz5s3U4dt+tmqy46PT29wdi8zXLSQGpZLLn7
 HTAsueKnKJtDXAKZa20P5b94OuE2V/4fy6+HeUKGGnI3wlLSnjFNbez/+GB5YAMPiUYe
 z1JkDoiubraOo8C+QGN3vfQVHL8bOPStZN2WeaoTUwsoUxidIIolVkQWfirnE/mIiyFb
 AUkA==
X-Gm-Message-State: ANhLgQ1tCSSd49cQmFUxbGr92AWIbap0vZZIfvvwFFawS9l8e4vJdXLQ
 86cuWg6HfCAgTj7POYYSv4M=
X-Google-Smtp-Source: ADFU+vtHE2y/TNcFgeIfFm77VV8c0Vs8CJARRTVi0va6qlLXRhMnAyXEBOx7WidBjMF5BTOaO+lu4g==
X-Received: by 2002:a1c:f213:: with SMTP id s19mr27086463wmc.116.1584969987451; 
 Mon, 23 Mar 2020 06:26:27 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s2sm5500833wru.68.2020.03.23.06.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:26:26 -0700 (PDT)
Date: Mon, 23 Mar 2020 13:26:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: dnbrdsky@gmail.com
Subject: Re: [PATCH v4 1/2] lockable: fix __COUNTER__ macro to be referenced
 properly
Message-ID: <20200323132625.GI261260@stefanha-x1.localdomain>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <20200320123137.1937091-2-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Content-Disposition: inline
In-Reply-To: <20200320123137.1937091-2-dnbrdsky@gmail.com>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 05:31:36AM -0700, dnbrdsky@gmail.com wrote:
> From: Daniel Brodsky <dnbrdsky@gmail.com>
>=20
> - __COUNTER__ doesn't work with ## concat
> - replaced ## with glue() macro so __COUNTER__ is evaluated
>=20
> Fixes: 3284c3ddc4
>=20
> Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
> ---
>  include/qemu/lockable.h | 4 ++--
>  include/qemu/rcu.h      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Please see my comment on the Patchew CI error message in this email
thread.

Stefan

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54uQEACgkQnKSrs4Gr
c8jH7gf/XTZiNLdk7aDQTq0+mGXW6NFyPCdyjn5LS98I7VA5yotqrXYZ/oWJtCHm
d24RelL8BowArCECyh78NNjByhqb3LZNaCw0P5fz7bIgygzNfaEGJyDJmI+375fb
KbOQV4sQANjsd/OT5eb8LVAgRezjmLU1KVHlwFjNlCwFrRVYOx1mLrKdDm6lj+b7
TGk7RFozYWw0EQLyleVxUi77H0S/wJ2ussibysf+75Q6tXLz22uReBT2wcCGu5vc
f3KVuzjJfth0ctg1VhoRQhTziJqthUkC1NeuXe+k+qYpQnQY4xB12X4YV65AZXmp
X4ZrElCdH4AqbsgiM144AHkl+OuFuQ==
=ccV2
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--

