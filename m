Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A5C282CE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3F120880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 04:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MpY2zgsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3F120880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47147 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDLwO-0005jm-9k
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 00:31:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuP-0004QZ-Uz
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hDLuO-0007ba-6d
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 00:29:25 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57085 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hDLuM-0007WR-51; Mon, 08 Apr 2019 00:29:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44cy9f6ZwBz9sRR; Mon,  8 Apr 2019 14:29:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1554697750;
	bh=GpwQvXQB+37gRuoDux03zeLmnZfsr2/3n0UrJHoqvGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpY2zgshiTqgkxacGhsLTC6WEajLzKtk0fv016tzGmJZtPzfgtYwqbaeY4hg115q8
	9FxFjRzZVUJflqNVun2+1CDU6AhbdOaLaNTUM3edJBLGbVrOGkm+CojM5BlkHrIyIc
	Mjiqpp12hwLshnaR7bbDr/ssRuTT3ZhD0/KfmTuo=
Date: Mon, 8 Apr 2019 13:41:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190408034157.GC16627@umbus.fritz.box>
References: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline
In-Reply-To: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 1/2] target/ppc/trace-events: Fix trivial
 typo
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
	Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
	qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408034157.ATimeLxjB3Fp8mF3LcrqqwxZlevIANBu1s1fbNbqgYU@z>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 10:05:19AM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.1, thanks.

> ---
>  target/ppc/trace-events |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/trace-events b/target/ppc/trace-events
> index 3858f97dff54..ed4d57c6d9c1 100644
> --- a/target/ppc/trace-events
> +++ b/target/ppc/trace-events
> @@ -1,5 +1,5 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> =20
>  # kvm.c
> -kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
> -kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
> +kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
> +kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyqwwUACgkQbDjKyiDZ
s5KSPBAAqDPTwUuW/jbSkTOnjfi9vv579K81ZssBflAx/v8SrffdaBSeI7Dm4A3G
C24MzGsJN1fqcqYcfTKkas5diKK2DRivPelFacKE9Uby8dgfjifuzW2ESWJJjMve
Hm8SpVI2xV6DMhkw3bMqBAP93zsCH49c6Ig1AMYKF28fCNJnEgwe4Tid1Pv45Oz3
IpHATTJOzoK3qBOg04Ubjmgxk/ZvpxeLbbx7IU8sjbu43lauskTyTSkx6qPnCWKc
eIi2V5vwP84QWBbXpX+Y8YTenugXcwV7q1BRi+U3iWiKOweN5IpAQ54Hpjp3h/+y
JbjnrwPPKxy3oaSXwoGk/uXHKx3lyOd7x1qbcj6v9GTeyEmpjtTWWr+uwe6TNxV6
pSVWIAqWgHeLtOQvspNeEVMnMmBYS2GkmRWV6g3O3a5H1C+xtkUckOi+EecNz4Qe
iosSpGo8h0RxIUxAli/L/+1TTGyJvJOkANBXCHaX90RookjkiH1WJZPU+EyP7asb
sxWfN7KBmq67icNkBC7ckKg0HTpEQstAZ663cZ2YtmJcWZftT+tu1+irTEljWw4w
kDv2JKH9DlC/ME5krzqMuxnhJ97TjQHJlFFPP5e2LGa89krvZEfDn1L9urNt/qMw
PQXnDXm42iXhd6TMZbubqb6kUYvS5CYZGowqh8hys8vrRADUL14=
=CdCR
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--

