Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C967DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91EF020735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL35UxJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EF020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNF9-0003GH-PV
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGNCD-00075V-Ci
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGNCC-0004UM-5d
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:32:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jGNCB-0004Ts-Tg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:32:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id 31so11070879wrs.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=mHsnQRz3LMbpYVZDpWDu0mqozYVRPCHGwQl6OjHiHO0=;
 b=kL35UxJzOzZIKNojXQmwtbrRV4m9t0jTDeZKo6ozXpIesbptE9B1UYeuGStrxpscjc
 KzfIL4LkDyRD3wgYrw+QsUHohAR9WU4bXT5wi08xqPMMUQUvoEJ4aucaPn626OMgN54R
 trqzKo2AQ+8n5ZbwlIvyAW5oYHGspt5lktpgDc1uiJ6Tvh/ZNaPkR1bxgp3P7ZKG+NXN
 zVvua2n1pGoZ3H81mXrIRRQaJZW2k/wVafK10XloJwIXnEBFHOBLfBboD+9vzrQ5IXkv
 0OUljKInfFPg5JuLrSHlyMCQPLzxe5CKO7CKcugHG/c31XSSkZqls6Nml+Dh3GRfaXVO
 uJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mHsnQRz3LMbpYVZDpWDu0mqozYVRPCHGwQl6OjHiHO0=;
 b=l1PsjiBQOddCJgdPNPuhx2n4Hf6mG43c8J+2+YbluLuXK4pBcBmsdkwT0y80X2El3L
 4wWxI6de+UTbT283DPKYTR6axX94tBDSIFgk8A3KWHMf0Cpjr0Ti2aaRKSZ+XBSc0d+7
 /XhkwhNcg/rStMNIbd43YzRdFOf2D9sK4Mq0Tx2nshDNjluPnXa2b0YvhdNwQw+nbcVL
 OtG84ndmk19nJPxtmd25qr0nIVVcDce+QwGEB/Z4y93h0RsdqDVW7gjPL4tRK6SKG7WA
 ltDrle/HszxTd/+cCXiRYhuV/ACqJexiV5XaOeQCP3IDeJaNqcat4SP/RPPJxwLnPeZZ
 lqlg==
X-Gm-Message-State: ANhLgQ1e5jFLxjTH2BTo4EbcuaPrrecYBGqwhQdWML0A2XZO8uWJDiwb
 8O8ZclupWBdW8WVosPwH8dI=
X-Google-Smtp-Source: ADFU+vtxRlV+360PLUuoqs/OW2ozBYfv7a/ogfc2mh/WWYXjpfiHn0HQYYHTWd6r1IwZjzBfT49Q6Q==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr11453484wrw.196.1584970366641; 
 Mon, 23 Mar 2020 06:32:46 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 71sm8197989wrc.53.2020.03.23.06.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:32:45 -0700 (PDT)
Date: Mon, 23 Mar 2020 13:32:44 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200323133244.GK261260@stefanha-x1.localdomain>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6K2R/cS9K4qvcBNq"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--6K2R/cS9K4qvcBNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 11:50:23PM +0100, BALATON Zoltan wrote:
> On Sat, 21 Mar 2020, Peter Maydell wrote:
> > AIUI from Paolo, the intention is to deprecate and eventually
> > stop supporting "in-tree" builds, so that the only option is
> > building in a separate build directory. I thought we should
> > probably mention that in the 5.0 changelog, so I wrote up some
> > text:
> >=20
> > https://wiki.qemu.org/ChangeLog/5.0#Build_Information
> >=20
> > Suggestions for changes/comments etc welcome.
> >=20
> > (One thing we will need to fix before we can do separate build
> > tree is the Coverity Scan build process, which (a) does an
> > in-tree build (b) can't be easily switched to a builddir because
> > all the source paths get baked into the scan results and moving
> > to a builddir changes them all...)
> >=20
> > We could also make configure actively warn if used in
> > the source tree.
>=20
> This was discussed before. I think instead of annoying people with a
> warning, rather configure should be changed to create a build dir if run
> from source and have a Makefile in top dir that runs make -C builddir so
> people don't have to care about this or change their ways and can continue
> to run configure && make from source dir but you don't have to support
> in-tree build. Then you can deprecate in-tree builds but supporting only
> out-of-tree without this convenience would not just unnecessarily annoy
> those who prefer working in a single tree but people (and apparently some
> tools) expect sources to build with usual configure; make; make install so
> that should be the minimum to support.

Yes, please!  I use in-tree builds and find it tedious to cd into a
build dir manually.

Also, many build scripts (packaging, etc) we'll break if we simply
remove in-tree builds.  I think make && make install should continue to
work.

Stefan

--6K2R/cS9K4qvcBNq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54unwACgkQnKSrs4Gr
c8g+bgf+MA7k4g2GRpZ5d/oKJ0yon3OW6MawALyFawsagDlKyECtvBQO2fD2z9o6
CnYkz4OwUxJ+8pKZ02YawyUAyisksbJim/7lVW/hkq63f4d19qOrphpmCmoBIKq8
NSj2/sUoycdz6Ou7RWlm2ljiYcFeLLKY7EWvR5R8VksmFFvRLZLJrOjlq20rc+st
guSZnL3JWOPj6LXZKWy575Ks0/9Y8frzvFXtMi0HSSXqY6P/Jn2eu1tQIEiBlirg
XwtE12vtTh/afp5hB3gN5iwhDBpWIO++oqgn1xoUsTUHi3Z2U7Rxc1Z0W3VQ3D/o
yEqr+2kNG4MfhBPdk93mzU0pDynY9w==
=Al1e
-----END PGP SIGNATURE-----

--6K2R/cS9K4qvcBNq--

