Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C57C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CF12087E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 04:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="b6ecA95q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CF12087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXd8f-0007r9-7n
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 00:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6O-00067q-Tn; Wed, 28 Oct 2020 00:30:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:46829)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXd6K-0002aT-Tl; Wed, 28 Oct 2020 00:30:24 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLbGH2BJjz9sWF; Wed, 28 Oct 2020 15:30:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603859415;
 bh=YEK+OIuUCuCqCeM5hVVFu0/MG7lO3tkM0JLhdsC4ENQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b6ecA95qxjpKKGdAs5mpgR8ZY03dDyndUy/5UNbNMUa5bg7yQExBu6dEqvKgmbEFG
 BDEY4PhMLkRQ9Cua+0dsGMmjGugQcKneFUWS9LQdS7Ob4z0x/n/jANza3VwyB9Cw7P
 uGKKjtF/HyZOuontlixyhY5UjUETU/NscBbWx0+4=
Date: Wed, 28 Oct 2020 15:29:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen Qun <kuhn.chenqun@huawei.com>
Subject: Re: [PATCH 7/9] ppc: silence the compiler warnings
Message-ID: <20201028042900.GC5604@yekko.fritz.box>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-8-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <20201028041819.2169003-8-kuhn.chenqun@huawei.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 qemu-devel@nongnu.org, ganqixin@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 12:18:17PM +0800, Chen Qun wrote:
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warn=
ing:
> hw/ppc/ppc.c: In function =E2=80=98ppc6xx_set_irq=E2=80=99:
> hw/ppc/ppc.c:118:16: warning: this statement may fall through [-Wimplicit=
-fallthrough=3D]
>   118 |             if (level) {
>       |                ^
> hw/ppc/ppc.c:123:9: note: here
>   123 |         case PPC6xx_INPUT_INT:
>       |         ^~~~
>=20
> Add the corresponding "fall through" comment to fix it.
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/ppc.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4a11fb1640..f9eb8f21b4 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -120,6 +120,7 @@ static void ppc6xx_set_irq(void *opaque, int pin, int=
 level)
>              } else {
>                  cpu_ppc_tb_stop(env);
>              }
> +            /* fall through */
>          case PPC6xx_INPUT_INT:
>              /* Level sensitive - active high */
>              LOG_IRQ("%s: set the external IRQ state to %d\n",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+Y84wACgkQbDjKyiDZ
s5KCmg//Xw+dYi7q/5oUJq/i75cK1O3nI3waMTrHt5zU4OelZwAQUb/7fB1pdBQP
mC7VEoQLNMt73BpalW0BZFk5nZTmE8N2Vi7rwTdNZ2RP0Y+drQs6Now9xF3pTXpR
rToN/5vvmfQDABR3QFZVckuXvOatJUHu80bgfMvZCZOB2in3hF4g3v7VHppgSuy+
LqkLhkVk8n4Biy0zUVKNGbYpDiSSRT8qiED4QZoVmKpWbAERN/ZnddxUXHa5SqBD
ZNM20Z4N/88mcKLDld4iKbnbaXSQ5GsMglW7f08fGnWKmz60qQqDgzfhZul6E5vP
qfx8AA7oSdZY8m/Zpm0sUMfMP8PzwesgGR175/+l0nAVTzfn+wX3wnkgkHkAwHCM
JKAPrnsXQqPKPychCpI54L9lDmLfS9vs7ItoSkzPHXfTc/E5AROouIQXwdW4cipw
vqNBxI2UvMFVAP8XZ6UrQu/R96N+DUqZe/x1ViZEtCZh+ZGL8cDZK54Dh/dZdz2B
gfBZReJBMQMIouk2KqsXqA+DYqJWRvfIgL5Pbk2RaXNptNvCSzyijaMAJs1F3Elp
uHNwQd62ieoblzH/DSLyU+iBSnYj8wl7Dy85SePOkBEjtklmrGVAsa8AUndHHsZ1
6lX/N3V3NNlrxMTDbeqALzm6+Ec3u/d1FDpzOCfidPQpdxO3UnE=
=8AAK
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

