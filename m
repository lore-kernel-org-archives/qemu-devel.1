Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C52C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C1B208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkvTnm39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C1B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYU5-0005H9-Qp
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYTA-00043r-6w; Wed, 17 Jun 2020 09:51:12 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jlYT6-00087Q-0T; Wed, 17 Jun 2020 09:51:11 -0400
Received: by mail-wm1-x341.google.com with SMTP id t194so2075056wmt.4;
 Wed, 17 Jun 2020 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=oszAfgQLcuqhw96CpCXHIlMh5eU8XN9EGCuIB+dl8T0=;
 b=kkvTnm39KAIdWfEhGWx3gXtqe37j0szQkOB/GQGFMIJblxtAefjYkvzPP5Mdk9p3eh
 37ZO0UYOPwCTnOp+Vp+gUcdEVSR0J90xiAMvNmMteRx2x+JbVyX8EzSHTWDFc2Xkw+qI
 Bk9X5uuRoAHdslzH4YOJgddZMPgoxhifHb/jv25pMJuSnEmtmC+R786BC4UEK/LVp/9s
 WF6AHHfIexR8NQTi8G3DBZhd5Y/wZ5eVMg2Nr5x3eoyiNd1Z0rXzkOTLvA+6OYuZnvug
 LJU7yecpSjcNxH38V1fmPMN9Xzi6MtUAwmwk+Q37yYBLDYcAT2xpUmFFsu3Sgrd2cck8
 plBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oszAfgQLcuqhw96CpCXHIlMh5eU8XN9EGCuIB+dl8T0=;
 b=m6h6sql1QvkZVJhv437jfcGt8Yp8H9bKSFHwSwtgiVmsiDUczIvDl/yYKQ6Sh8tF29
 tNTml7nvC0li8St86LMRRJ0ll8PpWeVNAKFg7gs1aV8ZQw414cmtn+52oRDUhLHqBhwC
 rMWWmUUhrSL9BspTaxUc8A+5mIoUEIcSV9bdR2HC+XDjVUZE+ycNEsspt79nzNx2xyCA
 nlmCG72nnE+0yKPH4xkp+tTXGawT2VpF5ljNeAt0KhAqeqwA1OmhB3gv+1y9ybVkjgJa
 jjWGONBJKv/nEHpK3JpnroLaKuQO3Zt51pABDFz4fUNafFwTnf65Ghwxk5Y9jaN8Qq8v
 eV4w==
X-Gm-Message-State: AOAM5301hWwXfQF9YO8N6T2drBmYp6eHSWrTDm7fNmnr+9CJl3Bdb51U
 wLav2hserN7snij/GhU7OXE=
X-Google-Smtp-Source: ABdhPJyqj18xoL/BMRiq81y/4dVUJzqEEk9W0yyA1V+zG4J/yV/RzOZjpd91BpTLbu/7u7qP/ayZXw==
X-Received: by 2002:a1c:8048:: with SMTP id b69mr8460386wmd.169.1592401863081; 
 Wed, 17 Jun 2020 06:51:03 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id u3sm464761wmg.38.2020.06.17.06.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 06:51:01 -0700 (PDT)
Date: Wed, 17 Jun 2020 14:51:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 04/11] accel/tcg: Add stub for probe_access()
Message-ID: <20200617135100.GG1728005@stefanha-x1.localdomain>
References: <20200521195911.19685-1-philmd@redhat.com>
 <20200521195911.19685-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TmwHKJoIRFM7Mu/A"
Content-Disposition: inline
In-Reply-To: <20200521195911.19685-5-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TmwHKJoIRFM7Mu/A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 09:59:04PM +0200, Philippe Mathieu-Daud=E9 wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> The TCG helpers where added in b92e5a22ec3 in softmmu_template.h.

s/where/were/

--TmwHKJoIRFM7Mu/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7qH8QACgkQnKSrs4Gr
c8h8sAf/YcnoLncBCaFhEPr9E4CrtTUYIuLHjpMYLgtyGMSmbPkx4NIzieUBOToh
jLf3y47bKlPFsqC09GBLuMHfhg1ucjCUuJyhd5x+APO63VgR7T+AgTFO6nFClt8O
NXzgvBOjJ/OYVWccc+tIOgxbIGDXzefZT6nGrtBx23AhIps5Ob1CskpOj7a077Dk
KJAcJ36zJ7QbRjKNw+U89kQkn8ogUm5XtiPN8eCP6SQQV4CcvXPTj+lbXDWJ4AIr
WEVcSf1/4ny2g5MFJmIoqbOCMzoV1+aZ4alZL0SFxaLeviRklInNVoWnMA0fX9UH
EXbzEXlSwv3omAnjea42v4NiEe7krA==
=YOPi
-----END PGP SIGNATURE-----

--TmwHKJoIRFM7Mu/A--

