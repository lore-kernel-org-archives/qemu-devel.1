Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79416C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4863420657
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TfDUHdIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4863420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58494 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbSI-0003A9-J9
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:07:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbR0-0002UH-By
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbQz-0006uk-DH
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44221 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSbQy-0006sT-J7; Mon, 20 May 2019 02:06:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 456pKs6cGKz9s6w; Mon, 20 May 2019 16:05:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558332353;
	bh=Vqsk7ajOTefTOTd0aX+DF04fPOYqiCJ3cdpVKK5RWHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfDUHdIRlEmwRyHpKeBykjjw4R/F16x84ksvnEc1fqg8Ahoyxv8yC02cKKGlVXyZ/
	0qapk/I4uDMgDvwdi9ZRI0W4omWLiwizrj3XsEtsauO/4Dt5YWxD+2DTY2IcjdyMPS
	oqeLGwcMnBMLSGmv1VDvAfnYuvJ+925vbG8bA46E=
Date: Mon, 20 May 2019 14:01:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190520040142.GA27407@umbus.fritz.box>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190518191430.21686-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 0/2] target/ppc: make use of new gvec
 expanders
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2019 at 12:14:28PM -0700, Richard Henderson wrote:
> Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
> Aka "tcg: misc gvec improvements".
>=20
> Since Mark's initial patches, we've added (or are adding)
> generic support for variable vector shifts and bitsel.

Applied, thanks.

>=20
>=20
> r~
>=20
>=20
> Richard Henderson (2):
>   target/ppc: Use vector variable shifts for VSL, VSR, VSRA
>   target/ppc: Use tcg_gen_gvec_bitsel
>=20
>  target/ppc/helper.h                 | 12 ----------
>  target/ppc/int_helper.c             | 37 -----------------------------
>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
>  target/ppc/translate/vsx-impl.inc.c | 24 ++-----------------
>  4 files changed, 14 insertions(+), 83 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlziJqQACgkQbDjKyiDZ
s5JYxw/+OiRFdPzZIjLkt+lovJpB5Vzahvzfh6fwkpBzn00XWILUGpBmWodBjQTh
/bvno8wx/+D3cYZvRX5nlC/32HpBc5mXyyW41KIvkj73fo4ouMqH94mdOZ7EnMmH
OWcdsb+z0Yjz14iRaV6V4HYEuyZP9KjEDjvEGNe+dIy6r5Ba8gCeeEmA5GIzRxFt
9rFLFO8/dVhcrzobZw21modfMLgWNlmjOtqg7fVJi1JDnrk1tS1LwnpBAQ04SJZv
u4w3h5ta8yM/Tz7Ufm0MHlg8my8xYPJeCkA1B7m1uaCAj21ala45EmfSixTF6MyM
lpiiqkUSQ48m7DfevtizjmdPIyTRsTtghcldb1c0dGME01i0JuakhiJeCIa1jhgP
/qkKn539pq/69RinGjzlpvf0uBx8bNDifopU9Oz2xQcDJgcnG+59tosdUVklbqCv
8cJhHYSqVtdq2YzguVvEK6FIu1DgbB8SK7hjMZ96YKHPTcO9oLlZHhctW38IaeHo
I5FAA3K5EtEToOnCt71ib7zN1coLf5ZXWBb+JvnKjgAs05KnD6cv9DulhBXm1YJe
yUnZ4DVLV7cB/NhcSRGfEwyMwhjZApcu3WUbBVsdjGPDOMgM5PbO5W+7fkf9Q4Ad
tWlPrwh/U7pVA/CT1Djbo9vS9Z1OOeRSG7+BcstO3mdQMVzaIfM=
=/EK/
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

