Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D72C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA34E206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA34E206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keithp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJ6a-0004L1-18
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iVJ5p-0003s9-Qo
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iVJ5o-0006n7-Qy
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:39:41 -0500
Received: from home.keithp.com ([63.227.221.253]:37702 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>) id 1iVJ5o-0006kh-Kj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:39:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 6EA913F29ADC;
 Thu, 14 Nov 2019 09:39:37 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id DgqACPdh-RiR; Thu, 14 Nov 2019 09:39:37 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 2D0433F29ADB;
 Thu, 14 Nov 2019 09:39:37 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id C7432158212B; Thu, 14 Nov 2019 09:39:36 -0800 (PST)
From: "Keith Packard" <keithp@keithp.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
In-Reply-To: <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
 <87eeymx603.fsf@keithp.com>
 <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
Date: Thu, 14 Nov 2019 09:39:36 -0800
Message-ID: <875zjmuzl3.fsf@keithp.com>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> That defines the instruction sequence used to make a semihosting
> call, but not the specification of what the calls are:
>  * what call numbers perform which functions
>  * how arguments are passed to the call (registers? parameter
>    blocks in memory? other?)
>  * the semantics of each function supported (number of arguments,
>    behaviour, error handling)
>
> That's really what I had in mind by the overall semihosting spec.

There isn't anything more provided by the RISC-V foundation at this
point. I'm not sure what else they *should* provide as the goal is to
match the ARM design, which does specify all of the above.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl3NkVgACgkQ2yIaaQAA
ABH93Q/+IWPQsKBCVY7ALbsl1yPHshI7Elocap5L+rxsXWIqs+G72ExObaSezUu7
21xBm6epfmjDQCVyIdizRf3gBhovdM8A3hCjAWQzLAkYt1+dRXpFYsKC1YMYAfmg
YcQq1NLnfIyyemWz93uo22ovJ46bPi17golQuv1yYOMjKdIxxEXGUWhHke/wzsk4
83ZS1vTb+URRL3zqd0DiBMuyVdjQlWsQERjoF9KIMRyKfXssK4MSNI86qGi+eU3Z
gvTaQ6D/1mfk0jXb/vACTM+oqjmAbdM6uF0kqtfzyRVu1ia6gcoBDZkw9wLd77u2
9DpzV9F/rvf4DAbH/v45xgp+PTQ/pWeqtulq3u6n8snZLiqFKblgtqop9Gv9DxZP
x9c/Ec5kshQMBFrVMwrhbOdDmnDbdx6RFFzh4uVfIQ7pJhVtrqRm6TXSR8svw6y5
eAk9TAWhLh0chE5UT00ddSdNd0wRtyZ4EjmKC7QiDugpuATkXEvkOsuw41/WU7P2
1nVwhS390B+X9qxUVZhpU30Hso0n95YroEi+85OSIZ0d/oL20+6aUF7Hs+RRiVP+
lEgWUb3vsfHfdPRAr1QSy1ZLmXyhEdxMZWflJ8dVlRhhywy8D7Z1g9zm9bwccSn5
+8KIbzqM2PQ3dMV93qyKvoEaexwTP5eysY7aBmgxvDwqWT2sb1I=
=NwD9
-----END PGP SIGNATURE-----
--=-=-=--

