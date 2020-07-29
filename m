Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B605C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D358204EA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 10:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6EGqIgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D358204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0jTF-0007fg-DU
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 06:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jSf-0007Gt-Db
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:37:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k0jSd-0003Qu-Ir
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 06:37:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so21158157wrw.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wazj3mYkT7ma3SNC4PocHKj5JPjGVzTplmbf47SZxaE=;
 b=b6EGqIgMpUm5LUXIRRtuthBgdRyaFF57K1UUYBtaYD57pSd7pN2yQQceLDsG2gpn+L
 aFfcxCStFv4QlS1qJbX5UY1EYkHiIgRwU69xMvESi1TCIemgsWi79KVPjAnASXEisYjG
 pLD+LTFZGkOMSFXH/xk+3UgjT+L277FK+zk7+IaiJakP7VKf8Afg1SvJz+LzaoPc6R9u
 Dne+3/LVA0tE4kYbiRcd9yDvnSyA/zjaOn83UvqgsAcYaDJOnxNvHWNj80zG7fcKym9u
 ycTsnsN7u9z/cc5nH/+9dfW7ETstyhwWWAxHLqddlrhuLSqUr7iMbvCTL51yR5TgkzPI
 tH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wazj3mYkT7ma3SNC4PocHKj5JPjGVzTplmbf47SZxaE=;
 b=SMPeWlQyVm1rVPloU7+X1i7+VmubYJz8NRF8sCpF6+A3UExRVnFp/zHeGoJIiMkBG9
 EQIjgpRlhp089kIld/pSYj4pyqldl8lZUg14IK9Q1OAnkR23uQH4jglsON+2PYUeGn4A
 3KZIh/gdPdPYSdewh46H7FxBFbpna1FzVkkI/jCHS61ucHqhBUDHsZvytmQ7tE2CDCk1
 vvHBQfRdCZAWP6ZZggB5uLGH7B5cXLzZxyALkXYZUGQTvSTtyEyYObyCiOWK6uHHvZAp
 f5qZl+e/otcyotfMsuXbw7ZRmcQ/HJZfNh3f5M7Z5ADi7EDw6gzmoI/y/D38Qe+lvS8p
 GV2w==
X-Gm-Message-State: AOAM530p3hGYN+N8m0OPpYzOZKmoj41XK9nsKs0qYHfXpfkflQgwxDFf
 sCbB+IgGUpqskXJu7aEdTW4=
X-Google-Smtp-Source: ABdhPJwt6EEfOX9Q5R8zUMtzExtMfXSwjSNbuntytcYRCebCTIYATSUKH6M72yfmmI/7d8Jsgdrohw==
X-Received: by 2002:a5d:4604:: with SMTP id t4mr28560247wrq.417.1596019041793; 
 Wed, 29 Jul 2020 03:37:21 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b129sm4240500wmb.29.2020.07.29.03.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 03:37:20 -0700 (PDT)
Date: Wed, 29 Jul 2020 11:37:19 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
Message-ID: <20200729103719.GD37763@stefanha-x1.localdomain>
References: <20200714162659.1017432-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <20200714162659.1017432-1-berrange@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 05:26:59PM +0100, Daniel P. Berrang=E9 wrote:
> In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
> to previous 2.2.2. This new version generates a warning on
> the source:
>=20
> docs/qemu-option-trace.rst.inc:4:Malformed option description
>   '[enable=3D]PATTERN', should look like "opt", "-opt args",
>   "--opt args", "/opt args" or "+opt args"
>=20
> This turns into an error when QEMU passes -W to sphinx-build
>=20
> Strangely the previous 2.2.2 code has the exact same logic
> for checking the syntax, but it is not being triggered. While
> it is only complaining about the first option, I changed all
> the options to give consistency.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> ---
>  docs/qemu-option-trace.rst.inc | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8hUV8ACgkQnKSrs4Gr
c8gm5QgAnn5GZUSgc8PB4QlAeFKWPMXS4yJRl9sqEynQUb+GmNKcD8rdRjA1vEgj
NPnlyXWhHpVR8F34iHtWEtntKS41Lodzkyz5puRQL9Qiro8EKotw8Eg/tQBaeR7r
jJ58nVUzZ7Ye3UxMxHgtJO4e5j4u74dVY9DPNn/NfKnzULI6b6cHexP5FTW5wZDE
uRSHXbnzFVSEHhwal0kC60psRuqH32ACWsZmEf8vMvRkkke7CTnKSSBTmJWSTn/p
7nHw3Sw7AK1/guJpa6QiHH4gsNLE/U6lCMQ3xd5wwdHo4gqSvttx6zWNYEDsZWmy
fQj9V63vlMugZIhUlFg0w4aFjo3Skw==
=Zq4b
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

