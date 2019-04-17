Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9303EC10F12
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB7820675
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 06:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="iirECQs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB7820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47624 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGdpP-0000iX-Dz
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 02:13:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnR-0007vd-P9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XB-Lu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:49 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39015 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hGdnO-0002To-QF; Wed, 17 Apr 2019 02:11:48 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44kX1m3Jwbz9s7T; Wed, 17 Apr 2019 16:11:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1555481500;
	bh=5QywlsAdJ6Diou3EiqkEJQj3h4cjSO8gLPO94KHNVRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iirECQs6WnTn6JrBbopNv1+s3traioduMshUNikJGqRdvJI2iwUJeg3YKPwfDL8ha
	ZVfXyqbG/SeqO3GvD1Kv/OXDqyKGNAkzAgNWz8tSRMYvGIVEUcfHx96nRNfescjwzc
	pj2sw2RMwDKVjhtHKKz5GDptCeFOniJD18mcFrJk=
Date: Wed, 17 Apr 2019 15:23:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190417052338.GO32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-4-ehabkost@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
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
Message-ID: <20190417052338.4Gg-HkjTuzsgHM6oEvKFYPtyMpd710dplQDkZURwIHc@z>


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:42PM -0300, Eduardo Habkost wrote:
> The return value of cpu_get_model() is just a CPU model name and
> never includes extra options.  We don't need to call
> parse_cpu_option().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  linux-user/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 20e0f51cfa..d74108e05c 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -592,6 +592,7 @@ int main(int argc, char **argv, char **envp)
>      TaskState *ts;
>      CPUArchState *env;
>      CPUState *cpu;
> +    CPUClass *cc;
>      int optind;
>      char **target_environ, **wrk;
>      char **target_argv;
> @@ -660,7 +661,8 @@ int main(int argc, char **argv, char **envp)
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D cpu_get_model(get_elf_eflags(execfd));
>      }
> -    cpu_type =3D parse_cpu_option(cpu_model);
> +    cc =3D lookup_cpu_class(cpu_model, &error_fatal);
> +    cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
> =20
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uFoACgkQbDjKyiDZ
s5JyeQ//Ya0MRbINQEKGC/4E0UfDqIQxlDjrC0rdkNPR+Iq2IBmRl2MfxLa3IQXc
lDbbCM6qCd7EPw6SY8LolqHEoG1a6CLazxsH3hXOeBIFLXUSCd2S7ky7YJSTcg/Z
sXy6LkM0Fi2pMuq8CntH8vsVVL9MHauVfCNla5U2Suy45PGpB+V3aaexXqJ7Dpru
T3iLx52GAwRe0I8Z2wxDJfbzCufafVcKfn1D1fCRI0P38g+vusKXGJOuC777Mhbt
/5t+t1YD8nbi3kgTQV3nvPldXP8LRc+AJ/mOrc6YfwUV2aA+B60WRyryZhbpBJ0O
jKrZsPY58E++IBe2rVzEp9Cjw/FtBuumwa6EHEfXxCZQblS0pFYDQb6SsZwEEPBK
tSEOneSc6vg7nkDGtFER2mzvg9u8b7Zh63djd8HjEOpagItNvPXFbcU+o87eGJkk
NfTO3N6u2aH1uBFjnQPLhROrbgIVNU/qgZXB5ye3oH6xjh1Hh6gWWqLwijSgyc6N
ur93GCgccPK/tNA3Qae7GsUnJ/yl8Po8N+1Ya6q2kssxpMJzy7i8VWiKT536NQV7
gD0eEVMl+y8jHSsrAzSmGoMLKjICXQ8xyUMni3koHimqW2cpO/WWZLCalTgHJhYi
pSf3MRAznJ0q3tJCMoT48176nnECtjer0EajkkCOrvbYLWeCzl8=
=94jm
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--

