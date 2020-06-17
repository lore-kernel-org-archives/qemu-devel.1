Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061F9206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgSMxs9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061F9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZ7o-0007hD-Ad
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZ4i-0004nG-Iy
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:30:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlZ4g-0006a2-MU
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:30:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id c3so2542912wru.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9BeFTxtyvUHiP/foG8WuGHqMNLmBo2SS3Hn31dxcmTc=;
 b=kgSMxs9G89UHxVqlNljaF/VdQFyE+fMj+KaG3U++ZfyQXI7skJEXoP4VtE95ZLB+jM
 5RRptvA90yV/XKJSfUg+3v7R+BYZM26VeaOBPdL73Dlr57WFzobCq0Ge/aUKQnZzyxpe
 ltb8y0kc0H2TkzkutoIhOKvg9Rvd2itiDNYg/1yB8lCeOwl9boPOoCgVEtLsmBhhiYMy
 nIZ/+2bNwCpnwlWTQ9Irwttu8NcqrqnJSXxAPun4rU49giQW+dX7pkzxxGCULUHlYera
 I/NpSgfE89w/zKswpljIaaAHwprhGlMIPknUpk3YO4unMunJoZriyV1o1IJ6PxfR16sl
 CK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9BeFTxtyvUHiP/foG8WuGHqMNLmBo2SS3Hn31dxcmTc=;
 b=j5QLqdDGxsb9zKVpLsybHEbovO3Mwa0F4IJ7tp+wWpqLIoZTPoS6FYOlMLQHcHwscA
 HmWOBumsyW2nv60fAMNSpSgQ+XHCnxABAChV0J+hzb4OybigE87vg4p/Lnyu3fCB0HGf
 /BEm1O1uHxfU8Zs3olKExbm0r/rlu4RCFXDVc3remSOYhsudZD6f+B9ytOpEAXlxVs+C
 MmrDnCIaeos2rSnWNW/fbgBvfG7YWphsGqEfqMMAbItL8rYG25Ne2FlDcabmZYUiU5Ga
 pIvxD5cRhyNcQOycbXcw7dG0W9L9LFOGz7xrT4btcAS2x5rNy+DDgsr8rjzQMXl1Ff63
 hSxQ==
X-Gm-Message-State: AOAM5324QmDUxLjPllAHR+Ns27qQAxwiYnbpjqeBc0bPHGPzrlW5kMpP
 h9ewh1Ee5VeI65YTXTopz06Z0cUxh8k=
X-Google-Smtp-Source: ABdhPJxLenhde5zGCFmU9flfrSE3KgLbume1WA6Ukf3a9520iqwxuAB6BRTu55xuexcN4vAaaEck7g==
X-Received: by 2002:adf:f845:: with SMTP id d5mr8695137wrq.197.1592404196851; 
 Wed, 17 Jun 2020 07:29:56 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id g187sm615828wma.17.2020.06.17.07.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:29:55 -0700 (PDT)
Date: Wed, 17 Jun 2020 15:29:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1880507 <1880507@bugs.launchpad.net>
Subject: Re: [Bug 1880507] [NEW] VMM from Ubuntu 20.04 does not show the
 memory consumption
Message-ID: <20200617142953.GI1728005@stefanha-x1.localdomain>
References: <159038615546.7053.4830753292873479822.malonedeb@gac.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/8E7gjuj425jZz9t"
Content-Disposition: inline
In-Reply-To: <159038615546.7053.4830753292873479822.malonedeb@gac.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x436.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/8E7gjuj425jZz9t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Does "vmm" mean Virtual Machine Manager (aka virt-manager)? If yes,
please file this bug against the virt-manager package instead of qemu.

Thanks!

--/8E7gjuj425jZz9t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qKOEACgkQnKSrs4Gr
c8he/Af/Zki2oZ92uDkkIsO2y3qoY1sQPo41lpsAbSr/6TWlci/ScWDvKcjJpRSb
TkRzcMd7cKQK/DG8KC2i6PgWYrsActqGdAU8wdpef9qrzmPXFYevcvdFgxxsJ9zl
XjBVDOSgDy1XcyXBKO9/NNm1KhfL807SJzlP1aJhy7uDbnoGUYx6Jf2Nd0mi6XzA
Wrwfk22K8yBqHUxj6yM1fZu4Os0I/PNPXtZ1X45vRUbvXRinOYxX8byE87BOQGO4
BS5B1LhTzCgL3neCZZPs+7gjp6VUrp3ZU4tOisYql+9fmgmVYkjxGiXnSYNXwQtG
Zcgj3uYRNjHvdIkVnQmpasICgPQ8GQ==
=I9mN
-----END PGP SIGNATURE-----

--/8E7gjuj425jZz9t--

