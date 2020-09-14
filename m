Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA20C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:58:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B346D20731
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 09:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7JvBDiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B346D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlFu-0000TE-MQ
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 05:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlFG-0008Ry-Ef
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:57:58 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38103)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kHlFE-0005Mt-UJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 05:57:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id l9so10586975wme.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 02:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+uUej+S9XoYDJf27Q8EYRfsQJ21GIwuHtO15A3c7igQ=;
 b=u7JvBDiKc6sh9DoyvMU9lDO3lpTGFoHsd+h6GIEQfeUKXrIAJw85x41HML+Ie46Bpj
 JfE+RVL0I0roajgrEZ0ydLrTPYfJaGN0mKkAPfFmQvg/tAHvWAyDyaJQk7Ehek/TBcSc
 eZLSAwRAxvubRDF0/Rkll/L1Aufu5YcfacAXuEEc7s7bko246s9D3V/gORjLJoh8t6Ad
 elufJQ898RyNzPTnYSXLjPg5/GRMbUECKQf8vB1lKRWVQEXqtmoC5f+JFxjybKmL6eis
 2t5swob9juWdco2xyQhYZcu3zFevSMV0PJjeIdHxuWTyaVX4yQ3n6OVJgQltvO8YEUeO
 8fGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+uUej+S9XoYDJf27Q8EYRfsQJ21GIwuHtO15A3c7igQ=;
 b=Du58BMVy15dDdq6la6mmwaXphKe+YdyeFg/FeC4A3kZ7Jh43Rbra3NDVb/fdtG1Xdh
 5VofndiYBq3l1PzuQ4KQjShr/y03dMPoNZG4NnbB/4sYZ9NpkLFkr3T0L7/FTJcZG/JV
 zLvZIpyKRjXmq0Dm/lsabzaje6bKXkadtQM+mH7vP4zBTzAgYNeARloSc9nBJSWdduIA
 4fSdSnAfzn1ftHcNHivXIvgfdXRSmDwUBVW1R8sP0q4HH9Bantx/71CPh9/1UV7jeCOi
 +cwm8I9rIqWI3jK1Lm4xfipulQL++OKFS+ZFAJBKaZG2kv281ioLewpk2TwvtCuXr8y5
 6oBA==
X-Gm-Message-State: AOAM533nJxgYxrE9k55S+82S/WSmwnztRPQbj4T4BGlmTxNBXntYc2ar
 gIQGDAisAhhidwZRX5UPK4g=
X-Google-Smtp-Source: ABdhPJx3hN1j80y3Dy8bwhAKKuYgFyvGkXSevNACqWNuaYwVvKVEmHeukncEs+N13ivVMpQkNfIZkw==
X-Received: by 2002:a1c:6607:: with SMTP id a7mr13966701wmc.142.1600077475490; 
 Mon, 14 Sep 2020 02:57:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h2sm20399883wrp.69.2020.09.14.02.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 02:57:54 -0700 (PDT)
Date: Mon, 14 Sep 2020 10:57:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/3] Automatically convert configure options to meson
 build options
Message-ID: <20200914095753.GB579094@stefanha-x1.localdomain>
References: <20200913100534.22084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
In-Reply-To: <20200913100534.22084-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 13, 2020 at 12:05:31PM +0200, Paolo Bonzini wrote:
> - because we parse command-line options before meson is available,
> the introspection output is stored in the source tree.  The output
> is slightly modified using the "jq" tool in order to ensure that it's
> stable and that modifications to meson_buildoptions.txt do not cause
> horrible conflicts.  This is the main reason for the unattractive
> diffstat (the number of JSON lines added is higher than the number
> of configure lines removed, though of course the latter are code
> that must be maintained manually and the former is not).

Does this add a build dependency on jq? Is it possible to use a Python
script or even a command-line one-liner instead?

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fPqEACgkQnKSrs4Gr
c8jDowf/bO//FhVy4ylu0OHAPuZwZ9J0Ec1Y4Va4eTku/tIW3+bBo1WJQoEWA/0H
Oq3QOIejdXuWV757lXs78nS6zcYYzKZFgkpKJ0LJOvdsOVPD+WOlzMie1UHCd+TL
oQdoLHR8bsCEewOeC6IbM+l04m2pJmMupuBArq8UcLfTgnfh0CBxKPzhilO1k0s3
gDuhAfI+1+VqmvNxinbzircziEhvy98ZkOxJSPL9vZTqtlxJI2U48bmparSyY7Jg
SWtQGsXPWA7/NogyS0w/XFeUNfX431hx7enGBw1Uxtmgm1L7hv7pYl5LZX+014Ve
FF5DTAquGETEIAS65zm1Slzqos/19g==
=5czt
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--

