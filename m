Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C46C10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16A82177B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dF5xNtTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16A82177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdrW-0002bF-1B
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 02:16:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnR-0007ve-Sb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XW-N2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:49 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:42093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGdnO-0002UR-VG; Wed, 17 Apr 2019 02:11:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kX1m43sbz9s8m; Wed, 17 Apr 2019 16:11:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555481500;
	bh=F3YzYoCgC/xQPsAxdnKKWMUZtFtf15MXvwX/ov/V5wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dF5xNtTFoKejmJg5Ueh0TvBv9g7/zEEXnIyCoSKPKbnSfAT05h2E+hNzdGdu204xn
	4Rtdwr1sWj3dxwP2zeW22L3oLPpyE5MfRA4fQYJW+YXKe8aPWQXA9oBWV+YNJjFerm
	h1MK6mPUWT+C4olfLKwDVik2gcHE9H4I4RBCQQRY=
Date: Wed, 17 Apr 2019 15:23:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190417052356.GP32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-5-ehabkost@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 4/5] bsd-user: Use lookup_cpu_class()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Like Xu <like.xu@linux.intel.com>, Markus Armbruster <armbru@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
	qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417052356.sIAZDegOCyEAq3DTT76sfaAv2pc8_D4QcvaoSx6tgGA@z>


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:43PM -0300, Eduardo Habkost wrote:
> The hardcoded CPU models in the code are just CPU models and
> don't include any extra options.  We don't need to call
> parse_cpu_options().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  bsd-user/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index a6c055f5fb..d2915a9951 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -732,6 +732,7 @@ int main(int argc, char **argv)
>      TaskState ts1, *ts =3D &ts1;
>      CPUArchState *env;
>      CPUState *cpu;
> +    CPUClass *cc;
>      int optind;
>      const char *r;
>      int gdbstub_port =3D 0;
> @@ -903,7 +904,8 @@ int main(int argc, char **argv)
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
> =20
> -    cpu_type =3D parse_cpu_option(cpu_model);
> +    cc =3D lookup_cpu_class(cpu_model, &error_fatal);
> +    cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
>      cpu =3D cpu_create(cpu_type);
>      env =3D cpu->env_ptr;
>  #if defined(TARGET_SPARC) || defined(TARGET_PPC)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uGwACgkQbDjKyiDZ
s5I4qA//Un3ylIUuBSAN/ZuCQ53tYfLroprqFxMK1jmlJsK+SUxAi1o/smZb9Egq
I92aeWiimbB14XLNtf+Y/zDoB5h6vlLZi8XtW9t9R+9/rhY5MeezZZPKdrDVQVa3
3fODXYCdlUNBg/IB+2EZUTE5cn8fsbasNx0Q8TsR8UA+Xx74DuY7ehalzLnf6rWc
+dJmQr8rinjJGhWnRXA9Z9OI0gI5xku/GMh6flTvVnKCwkIIVPPlV4C4sA1m2ekI
R+TlIzVQJpFEDIf+lx7Rb4YwqGDE/RTgT7IiZFoSdBbbkzlyq1mjUZiVoYJKormV
pKKnZAFosRW3N+rhm3AONcReo3QaRvNWVZAeCQbweRxWYxw5bP8oClQdiDJyuTrn
pkn/kiiTkbTR9SZn5UArCeljXYTEgK+FHnEQOd4siz+G1J8sTvouOSp8wOGGdReF
o5uv0A1h8MUCQnrl+26WcnYMwWCk76EsTjojtLSHNe4PPKzPjGuy1nb69p1bUJnj
SdcLXatqPt8+3644eLNTWadHsUdtzcLlh908eXoHdGbDdLihOq0Em5v8O0asKML5
sRQtuBLv0TpiMzGLeH0En74GJ0YEwoVvSlJGp+LIdI8rvopHPavdVAPWQS8svBqm
jM01e1hqtuYuMmDldtMUXl16QCXojIk46n4kL9ldYL8PHS+qG6Q=
=gTSH
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--

