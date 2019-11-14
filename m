Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C4C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 22:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC6B02071B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 22:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC6B02071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVNai-0003Yz-VW
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 17:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58292)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iVNZx-00036Z-V4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 17:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iVNZw-0000K6-Ve
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 17:27:05 -0500
Received: from home.keithp.com ([63.227.221.253]:40382 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iVNZw-0000Jn-OB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 17:27:04 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 8BD3E3F29AE2;
 Thu, 14 Nov 2019 14:27:02 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id LZ4mzEtEqH_s; Thu, 14 Nov 2019 14:27:02 -0800 (PST)
Received: from keithp.com (97-120-143-1.ptld.qwest.net [97.120.143.1])
 by elaine.keithp.com (Postfix) with ESMTPSA id 1F0333F29A4A;
 Thu, 14 Nov 2019 14:27:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 59EFA158212B; Thu, 14 Nov 2019 14:27:00 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-MRtr9WUpqqwJiX9kc+ybGdgfv7ZB5Tc6_q9xwHwebsQ@mail.gmail.com>
 <d4baa0c3-694a-293a-385a-b3eba7d52d0d@linaro.org>
Date: Thu, 14 Nov 2019 14:26:59 -0800
Message-ID: <87r22at7po.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 63.227.221.253
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Richard Henderson <richard.henderson@linaro.org> writes:

> For semi-hosting, it seems even better if the semi-hosting syscall instru=
ction
> is not "real", because you're explicitly requesting services from "unreal"
> hardware.  It should be specified to generate a SIGILL type of exception
> anywhere semi-hosting is not enabled.

In the QEMU case, yes, it's virtual hardware. However, the other common case
for semihosting is when doing hardware bringup using JTAG or other
remote debugging link -- having an instruction which safely traps to the
debugger is required to make semihosting usable there. Reading through
the history of the current RISC-V semihosting mechanism, there were many
designs considered and rejected because they wouldn't work in the JTAG
environment.

> With that in mind, it may be simpler to handle all of this not in the
> translator, but in the function that delivers the ebreak exception.  At t=
hat
> point one can arrange to read memory without raising additional
> exceptions.

I'll go explore and see if I can figure any of this out.

I'd still like to get the non-RISC-V SYS_READC patch landed someday :-)

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3N1LQACgkQ2yIaaQAA
ABGVjQ//cmvC3RtxjCNm0SfBzXPK1adrMxjm/36PjTAtsUSdIuYZjU5URAjvvAS3
L3y6UIldSf/TVU/uzPUDaIfBoUDxKZOm1QOS0ITHigQV4DLZYswpdXgqzYt0u9j8
5S8JRw/lM5y0BG58cIUjY2fBRhZsSnEgu2Gzb2EFl2YDb0yWDEnwmVOeYh1YSCUf
xk+nGQcmBnLepzajqZzTbKelG4ZGfnrKW2hfht2WgIx9GeRbhcGZXUysbOPk7L4p
puXDAS30M07a4esOwDag0d0lZjuX3nVKutC3Ol2QMNdowpNq07YEZ9i+bRyoLUv5
W1lrv7odyfUMc5Kfdf1tOu9q/4dPAva7U7ImkpxvNrsG83wQnq8516vN0Vdz6MUT
Ivx9EkYJR7rRViRdZUN1/si+hWwXN2jqQSVi/Ef4xTPJsz75l+w1wJMbNrCqMoIA
l+G+kEuJZZhZJGGiv2HeAoWSCQ3t5Y4s3LV/NcM+6YJXKlehoVTBEhXRpY0C2sat
H6ezRdpDZDn9DcDvhnUHd54zQmToj5H1u6OjQJCQSHyAWVIATmQeTLYRBNY/P8Av
zkxg9ZoP7oJ3UNT50pdwQis82O5Hf2PfaEL6sfTlkUI3x+bYCYhgR3Lr1ZRvcWTs
tRgABc667Cz1JcjOYP2HgoPu8MlrGGgXbDW47/FjbBGlYCnG7mQ=
=Hj7q
-----END PGP SIGNATURE-----
--=-=-=--

