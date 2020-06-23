Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E334C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E292206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNyBmtsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E292206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnk2w-0004Uk-2k
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjvb-0002qF-5S
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:29:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jnjvZ-0003mC-Bv
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:29:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id s10so800246wrw.12
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Nfq4b7XRtmRJ0N2iBCFewwmIeXH6karw7NeyaEHuiTc=;
 b=TNyBmtsEs3Y+gyv2c/F8va50J61zC7VigTX9/DP4PNQjEx6ovPuTmrcEzbGiMmyZBo
 0RnLrlQ76peowezKem8STxEcqn6Xbd3AAevHNAXqw854cR67EfrSo2bv0umQFY3lpvRk
 Zwtl/PRGW6AexGguO18WM0FX6X+f3BXIV4ZNngfjrROMWLMgXjMhGm9wIX/96vxFUX2b
 dOHdP7FJOSp7sQaEyvx1e5VD24yUGAjKniLyrgJVT6VPYdatITswrKW4AlxLMsBMPx1Q
 HeY0MJdlpwMji5458/XItPdYnuQPlraiGmGcNDmacXSfjqfB2458jORJ4ZXtaRzelDp+
 XAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nfq4b7XRtmRJ0N2iBCFewwmIeXH6karw7NeyaEHuiTc=;
 b=uMbYjQPT90sQhxlvTzNkxfXx6hsmf6oMu6nTMv6gILjh6CpyJjUyCu5ddZMcXSrWGw
 uEU1rbDVLBvdIyHm58P0pU5awE07oPmgNAaPKfTNw9bQEYJhBnRcfcLb3rgHrabxsSvM
 tBeaU2aUEk4SXNe1Q1bnpqLAM/APTv8sYkIef5mzyQgrazTwKcNUeZvOTJ9IP0izkkyV
 BuEQEbd+a/2wuiD6Xm4ZUJizHpX3xS9OrgaFlEYTqu3/xR4pEPw1EZ0pB5X+949VlHbP
 cSG/Pd513n6rMKZT0i5BVA0ErDq22lLECBTfWvB8D2Zr1hlmjIEgptrp/Kc1dDLAsA13
 Gs8A==
X-Gm-Message-State: AOAM5317xAfWtUpYMgi4y1qgNTnb9atEwpQ6bUOTyx6z5XK1Q0hip9Jn
 mFC/5VVfq6iaquGjr0FqE3BYptTsDNM=
X-Google-Smtp-Source: ABdhPJxW4TPZymFI1waDsZS1N4zb5h8d14nh0Xa4Y51dQM6jIS9+rOxci1/5w9fgk31rlHP0+DKgrA==
X-Received: by 2002:adf:f311:: with SMTP id i17mr10931512wro.237.1592922571838; 
 Tue, 23 Jun 2020 07:29:31 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i17sm16748788wrc.34.2020.06.23.07.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 07:29:30 -0700 (PDT)
Date: Tue, 23 Jun 2020 15:29:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Bug 1883400 <1883400@bugs.launchpad.net>
Subject: Re: [Bug 1883400] [NEW] Windows 10 extremely slow and unresponsive
Message-ID: <20200623142929.GN36568@stefanha-x1.localdomain>
References: <159209820759.11242.7518482343283209679.malonedeb@soybean.canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3hAdtgBjtgL7p0NQ"
Content-Disposition: inline
In-Reply-To: <159209820759.11242.7518482343283209679.malonedeb@soybean.canonical.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=stefanha@gmail.com; helo=mail-wr1-x430.google.com
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


--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2020 at 01:30:07AM -0000, Toddandmargo-n wrote:
> Public bug reported:
>=20
> Hi,
>=20
> Fedora 32, x64
> qemu-5.0.0-2.fc32.x86_64
>=20
> https://www.microsoft.com/en-us/software-download/windows10ISO
> Win10_2004_English_x64.iso
>=20
> Windows 10 is excruciatingly slow since upgrading to 5.0.0-2.fc32.
> Disabling your repo and downgrading to 2:4.2.0-7.fc32 and corrects the
> issue (the package in the Fedora repo).
>=20
> You can duplicate this off of the Windows 10 ISO (see above) and do not
> even have to install Windows 10 itself.

Could this be a duplicate of
https://bugs.launchpad.net/qemu/+bug/1877716?

Stefan

--3hAdtgBjtgL7p0NQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7yEckACgkQnKSrs4Gr
c8jwNQgAoQfcerC6vnd1B++7Wlgw8BXim547qWbIWl5uZUxF9fdOP3GsmBEwm3N7
xe3wGTGYUPHRfL0nbUYEI1GoBvpsh7ynEPQr70aFnhEID9S6rlso0rB3JPBbOO6k
kJpZd3U0JrrhLJwOLdlyFKEyHHtuWZ+hP1qfrDyTZJjx3XuWg/6vJbbO5B0pYHg6
gNZisa3y9XmAIEpGqDBsAxI+MtfzVHmlDB2NYcxVFn/beIGTb2FWvN2xn0QYLJOY
1ZAbp8rsEp693DXgwY1sD1H4AT2RuLOKkO4SccKKbu3k22/bG/NTNf22xX7CAwhr
SIjaiUXprFhQDP97/c89PdAoz3iE5A==
=tcCE
-----END PGP SIGNATURE-----

--3hAdtgBjtgL7p0NQ--

