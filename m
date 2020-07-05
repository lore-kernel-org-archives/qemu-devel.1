Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD34C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454920771
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZgCzr333"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js10P-0001zK-4U
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 05:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0zI-0000DH-11; Sun, 05 Jul 2020 05:31:04 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1js0zF-0007XK-H7; Sun, 05 Jul 2020 05:31:03 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B03NJ4HmBz9sRf; Sun,  5 Jul 2020 19:30:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593941456;
 bh=ofDVbJ9dXOzCbN6+/wG5GZvb6cMxj6jGba7KAmDIljw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZgCzr333sRurlm1kYBGyrAhe6qbvXowH54KzciPmnX9o4O5kU5ue5LUer9pljT/3K
 BbT5LMU9qlQMJX44YLFb1Ytk/aOlnSm7RerU3Ec+1Xg/00TFR2zTbGDx12y1cLRq1+
 UFdWh0sfd+g//9uvBXQHqNk0aqNOqApz8xGLh1BI=
Date: Sun, 5 Jul 2020 19:08:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.ibm.com>
Subject: Re: [PATCH v4 02/11] target/ppc: Enable Power ISA 3.1
Message-ID: <20200705090804.GD12576@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-3-ljp@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline
In-Reply-To: <20200701234344.91843-3-ljp@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2020 at 06:43:37PM -0500, Lijun Pan wrote:
> This patch enables the Power ISA 3.1 in QEMU.
>=20
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>

Applied to ppc-for-5.2.

> ---
> v4: split to 01/11 and 02/11
> v2: add Power ISA 3.1 flag
>=20
>  target/ppc/cpu.h                | 2 +-
>  target/ppc/translate_init.inc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a5e9c08dcc..ebb5a0811a 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2201,7 +2201,7 @@ enum {
>                          PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
> -                        PPC2_ISA300)
> +                        PPC2_ISA300 | PPC2_ISA310)
>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 38cb773ab4..3f72310e60 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -9206,7 +9206,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data)
>                          PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
>                          PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
> -                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL;
> +                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA31=
0;
>      pcc->msr_mask =3D (1ull << MSR_SF) |
>                      (1ull << MSR_HV) |
>                      (1ull << MSR_TM) |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8BmHQACgkQbDjKyiDZ
s5JN3A//ccug/CGQeoOOyHr+KSl4H8ksAwwGOZJp7V00uYLBBERCGN9DsuYV/I8i
C/luf3KH0GAIBXe3m+XsoDoBKUNaRzmRXj+avYhJsXizEq6IO0uLzvBS5mFUwhSZ
rj3iU9wRaZnu0YJwZV85qgYgaVngiYp5Itms1K+FjHAPZGTlC0zIdn6+Egqo8kFp
0qx5fvlbFb5Y5eJbsSS2XkCQYJ1i3OVC4M+64kONE8Bz0CgXmpp4u/uRWBcBrnst
JDbkx1qYT/HgdpRapjR8vQ2li7Fhq4FSE/FBlLflCcGVc0jv2Qo0A96h/QWDH2ha
HPjM+d9Sl8e+SX5BjuoOtINmb4u2K3SZt1tHtn1Kbipwx4FWeZxTwvs9NZllzpgT
UWK1Ml44fMJz4oSH7UOzU4R3JL/uEro8ORdpKPGk/QjAddPBol9YC5By1vJjfk/+
SMQBSQAkTCX7w0gj2mWezdHDoAtFxw1p+h4WDCWAUUQIxSk1khA5dE3tbbplWF4u
Jyi097zfTqL7KKq/2mp6YVUQPnMa0bG3QPyfA15GmqJIZeymnoxB2tgjjveiecVn
xQxgAYluQeMF2ap+rPeiVTMzs2IoshywiyWfcPyFihdRaXBW7GBIj5pRst4VMyHH
JuRHWvDd8GSfgqnseLWxhdaVkTuFLg4xS9NTtJOWOHrM0qR2mmg=
=B+Xr
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

