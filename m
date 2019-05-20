Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486E0C072A4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1719320657
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 06:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="RqxMp0u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1719320657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSbSJ-0003Av-AV
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 02:07:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbR0-0002UI-Ce
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSbQz-0006ue-AD
	for qemu-devel@nongnu.org; Mon, 20 May 2019 02:06:06 -0400
Received: from ozlabs.org ([203.11.71.1]:47891)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSbQy-0006sU-Mg; Mon, 20 May 2019 02:06:05 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 456pKt0rXMz9s55; Mon, 20 May 2019 16:05:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558332354;
	bh=9r1zGHJiVLpWj+TD4N6+mrGb75sB6qRylVLGTJPV4mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqxMp0u0Wk9Zw48qZIBZm0YXSCCVjU7gdHa6X0t1/fUqgKhOwnUtcWfJnhP58ZUbl
	FgG8LTcvKpnghbTGGKONqcAjgkTgxD/XaGcmqEJ7VAbo749Q6pmI48Fu3FzF/AOlYJ
	t/gdFzPTDZ1a/szgTl3IHQwccrZBF+p/Z1c5Wudo=
Date: Mon, 20 May 2019 15:56:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190520055630.GA20828@umbus.fritz.box>
References: <20190518191430.21686-1-richard.henderson@linaro.org>
	<20190520040142.GA27407@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20190520040142.GA27407@umbus.fritz.box>
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


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2019 at 02:01:42PM +1000, David Gibson wrote:
> On Sat, May 18, 2019 at 12:14:28PM -0700, Richard Henderson wrote:
> > Based-on: <20190518190157.21255-1-richard.henderson@linaro.org>
> > Aka "tcg: misc gvec improvements".
> >=20
> > Since Mark's initial patches, we've added (or are adding)
> > generic support for variable vector shifts and bitsel.
>=20
> Applied, thanks.

Urgh.. actually, I've removed 2/2 again.  I get this error:

In file included from /home/dwg/src/qemu/target/ppc/translate.c:6819:
/home/dwg/src/qemu/target/ppc/translate/vsx-impl.inc.c: In function =E2=80=
=98gen_xxsel=E2=80=99:
/home/dwg/src/qemu/target/ppc/translate/vsx-impl.inc.c:1352:5: error: impli=
cit declaration of function =E2=80=98tcg_gen_gvec_bitsel=E2=80=99; did you =
mean =E2=80=98tcg_gen_gvec_2i_ool=E2=80=99? [-Werror=3Dimplicit-function-de=
claration]
 1352 |     tcg_gen_gvec_bitsel(MO_64, vsr_full_offset(rt), vsr_full_offset=
(rc),
      |     ^~~~~~~~~~~~~~~~~~~
      |     tcg_gen_gvec_2i_ool
/home/dwg/src/qemu/target/ppc/translate/vsx-impl.inc.c:1352:5: error: neste=
d extern declaration of =E2=80=98tcg_gen_gvec_bitsel=E2=80=99 [-Werror=3Dne=
sted-externs]
cc1: all warnings being treated as errors


>=20
> >=20
> >=20
> > r~
> >=20
> >=20
> > Richard Henderson (2):
> >   target/ppc: Use vector variable shifts for VSL, VSR, VSRA
> >   target/ppc: Use tcg_gen_gvec_bitsel
> >=20
> >  target/ppc/helper.h                 | 12 ----------
> >  target/ppc/int_helper.c             | 37 -----------------------------
> >  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++----------
> >  target/ppc/translate/vsx-impl.inc.c | 24 ++-----------------
> >  4 files changed, 14 insertions(+), 83 deletions(-)
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlziQYwACgkQbDjKyiDZ
s5LZERAAp+6UCZSVRQ4sOqhwh36WoUMizk4/rAganyl8naAjhF+m4rYOq8R2sEtu
L84xwQYDzBJ1pgmpAPOt7ruQKO5w7lHYSbs5Uq0cu6MSWrK+gNnxByzQVvx6BY9Y
1PSvVNUyjN1H3JOjlHrL3qty29NYk3T3dh10wcewDE1j42ORFvb21HdfW2ETsYcr
tB+U9miq+q95BweIpVUPfbnMAZlpFfLXlzaYicKYaYWbj6zqEsmtppNy+8qgpPzp
bs94/tmW+APCyp6Usmu+qWvyn3+iVuWRGxcOD/xyW76r+4EzGtf5jvaGiPxFk8Ew
dDBmK5GPm4f1kEmvDQsQD6sYB0oa+2rJK8Ge8+2b1MLS8y++ZoFm6B1LNcHVDb9J
JLWaLBCbTJHI/JETMJyFUPTWiVEpWwJeoHYkjYN5r2OoPzqKFjg0rLBz2Ay5H4YF
IQoQnLPF/KoGpgr0BMirlkWudRWSXgK1FwPICBzzftOfvmAEIRfTAQmaMwlmyqyF
3e3H+eawU4/8ZQznwu0LyFRcMwf2vgRiuP3Q4V8sWcT7bSrQJnltlqDo1G7kfQsx
q392BPL7bgL9uNam3DtESf9lmKGY4Nhu7Zo7Cpjjz3JgtqyUakDxXrueDIHYLQ/8
5R7l1XaLa91jovyxropA9fhq1/OYgkw3nn4vn63lyJIr8GnzzjU=
=FQ3K
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--

