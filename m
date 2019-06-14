Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA64C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B195920851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 09:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udpxfvTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B195920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbiFs-0002Kc-2G
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 05:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hbiEW-000133-SM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hbiEV-0005Su-NZ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:10:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35232)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hbiEV-0005S3-D0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 05:10:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id c6so1526667wml.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eTjij9PRA2vnk79HCH4iSIJNY3y1U4TmaCtGpS4t4D8=;
 b=udpxfvTO5aQLshB8YLXzTdQkVnockJYxxZUOWHZXp8MNzkSrtwUKHVheW37daGyAZ4
 5hWibp976f069MVvRsRPfhAkq0cmEkxPWCTSxctdwpPMO/mdci1q5QbiXuBek1ChmIBQ
 1H+/Am0X9YqL24TOTxlFpyQ7e9bT5QlnVQ8r6NPzQfT4obPDMkIfH3y9h7KnCSDQYM5V
 ulqWLmzXBQXQ4OXqE/XucoPmjY13mK1SIU1pJnDljKxccUiFzEj4zQsNduKdTkSvPSZA
 uaMVMkWs5EyvLwhBvfAjA7HiG9BXmp8Mld1Dv4iBuC3lqDY1xzLezibkAAIExYVX4FUX
 eeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eTjij9PRA2vnk79HCH4iSIJNY3y1U4TmaCtGpS4t4D8=;
 b=sIxqQyAT3sc8nwBr1eTS768WLvCxNWDS26Z0NgI56rDNnvSYu4vTW7UVg8GWSC1GZR
 rO9xaroIgi0SSS+r5CVPd6jjaZEDIH+13ti9oUJOO5S0mmK5IjJLBXbYShQUxyFe9Wj7
 8rxlfc4KEYSAoDuETn6Iw6/lSic8vA8gqJ6FP/7shbVWB/48gBQvKxYEd2OJir04m9ka
 oUdrMNfWRupJCgwb3sPy8k4QI9GF7dFi697mfK0NYePcKtIBaphECHAgfPjOiEagx1z9
 5JEeBXC/6tTe3X1oiLz57Ouf466bxuCTo3WMzDm9gFh6pozYOuK69rSA4I7g++Nx3CF6
 5ymQ==
X-Gm-Message-State: APjAAAXlU4eLB6bP6LqKrXubgEmyqqc76e0d5PHJxKdjK+ozLxzk2EkY
 ze4TD95MY5LIoHc9p9ar118=
X-Google-Smtp-Source: APXvYqySN1LpoG/mLjb+RWdCj3FBmsIyGlBy82xkr0fv27O0e+wZPZxVh5RgZ/c2t03VTMM+ZFhCRA==
X-Received: by 2002:a1c:c912:: with SMTP id f18mr6799970wmb.118.1560503450114; 
 Fri, 14 Jun 2019 02:10:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n10sm2309974wrw.83.2019.06.14.02.10.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 02:10:49 -0700 (PDT)
Date: Fri, 14 Jun 2019 10:10:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190614091045.GD10957@stefanha-x1.localdomain>
References: <20190607152827.18003-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <20190607152827.18003-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-tech: move part to docs/devel,
 delete part
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


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2019 at 04:28:25PM +0100, Peter Maydell wrote:
> This patchset makes some of the cleanups to qemu-tech.texi which
> I suggested in my Sphinx transition plan:
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04932.html
>=20
> (1) the "translator internals" docs move to the devel/ manual
> (and are given a simple by-hand texi-to-rst conversion)
> (2) the "compared to other emulators" section is simply deleted:
> since we haven't updated it since 2015 we obviously don't
> care enough about it to keep it useful for users, and the wiki
> or website would be a better place for that kind of "you might
> want to know this before you install" information if we did
> have anybody interested in keeping it current.
>=20
> I suspect the TCG docs may have some stale info in them too,
> but the devel/ manual isn't user-facing so not a very big deal.
> Followup patches correcting any inaccuracies welcome :-)
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (2):
>   Convert "translator internals" docs to RST, move to devel manual
>   qemu-tech.texi: Remove "QEMU compared to other emulators" section
>=20
>  docs/devel/index.rst |   1 +
>  docs/devel/tcg.rst   | 111 +++++++++++++++++++++++
>  qemu-tech.texi       | 210 -------------------------------------------
>  3 files changed, 112 insertions(+), 210 deletions(-)
>  create mode 100644 docs/devel/tcg.rst
>=20
> --=20
> 2.20.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0DZJUACgkQnKSrs4Gr
c8h5CAf/c3oonKF6xhnnxdpAW4k2pb/xX/6UOybD98h+fvC7hP5J1WaGT1FcKo7/
msVgNwU2LmdpnYUVeQqEW+Lqn4XWpOH0mmrz0wB6J7prCVzfUKmI6vDHOHApF/og
J58A/DXAg0MZ5obshyEsCyA7wSjwb/QAnDuJf9VG+Amx5oqF0XfXjEyBBoDvM+kh
oxHTDQY+JsGCSRm/BcXb3/hbT2yAgO4wVRr+nalGA4iuDP46NLYWefsZp1ScKL38
LXmiHnbPfGZ8+IKfeOIz+2zhHZATejYjVom+lk5+uRfwaVmDcVSiapPsuMgsPI8Z
YBWAsgGWKHJmVR/bdXzqTPrxjAnkYA==
=rThW
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

