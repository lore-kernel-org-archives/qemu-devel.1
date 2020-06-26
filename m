Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89F72075D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 04:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ceCqz9+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89F72075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jog2G-0004l9-4R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 00:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jog1Y-0004EK-LO; Fri, 26 Jun 2020 00:31:36 -0400
Received: from ozlabs.org ([203.11.71.1]:52961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jog1U-0007JT-Tz; Fri, 26 Jun 2020 00:31:36 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49tP8k40xLz9sSS; Fri, 26 Jun 2020 14:31:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1593145878;
 bh=I9LD+s0nEwihV+621It8tdgyuBKbDfmSwocjNwQHrUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ceCqz9+kvtf4HBSR3A6EVOLtF9F6g5rzuK7xLRE+7VTSl779wkIoYHnzCeHgxAWTu
 M5L12EoyownE6EID1luU51dS5AZvXIuFpBGGAujo4/a6RKaU/jU8SStN+YyVTF0X/K
 UK5Q7xRcr+O0xa71NSFiy1K/mGMV+6jzB23xw4vs=
Date: Fri, 26 Jun 2020 14:31:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 8/8] target/ppc: add vdiv{su}{wd} vmod{su}{wd}
 instructions
Message-ID: <20200626043114.GJ172395@umbus.fritz.box>
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-9-ljp@linux.ibm.com>
 <4561adf0-2be1-e9c3-49d8-9de8c414ec40@linaro.org>
 <233C7E06-CCB3-4164-82D5-7BC765CC8E01@linux.vnet.ibm.com>
 <0095b0c7-ae6d-7a09-98b2-bf830b566186@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MzdA25v054BPvyZa"
Content-Disposition: inline
In-Reply-To: <0095b0c7-ae6d-7a09-98b2-bf830b566186@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 00:31:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, Lijun Pan <ljp@linux.vnet.ibm.com>,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--MzdA25v054BPvyZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:53:54PM -0700, Richard Henderson wrote:
> On 6/25/20 2:15 PM, Lijun Pan wrote:
> >=20
> >=20
> >> On Jun 25, 2020, at 1:37 PM, Richard Henderson <richard.henderson@lina=
ro.org> wrote:
> >>
> >> On 6/25/20 10:00 AM, Lijun Pan wrote:
> >>> +#define VDIV_MOD_DO(name, op, element, sign, bit)                   =
    \
> >>> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   =
    \
> >>> +    {                                                               =
    \
> >>> +        int i;                                                      =
    \
> >>> +                                                                    =
    \
> >>> +                                                                    =
    \
> >>> +        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {            =
      \
> >>> +            if (unlikely((b->element[i] =3D=3D 0) ||                =
        \
> >>> +                (sign &&                                            =
    \
> >>> +                (b->element[i] =3D=3D UINT##bit##_MAX) &&           =
        \
> >>> +                (a->element[i] =3D=3D INT##bit##_MIN))))            =
        \
> >>> +                continue;                                           =
    \
> >>> +            r->element[i] =3D a->element[i] op b->element[i];       =
      \
> >>> +        }                                                           =
    \
> >>> +    }
> >>
> >> Missing braces for the if.  Extra blank line before the for.
> >=20
> > No, the braces are enough.
>=20
> No they are not.  See CODING_STYLE.rst.

I suspect there is some confusion in terms here.

Lijun, what Richard is saying is that the qemu coding style requires
braces { } around if blocks, even if they're a single statement.  Your
response seemed to be discussing the brackets ( ) which are fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MzdA25v054BPvyZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl71ehAACgkQbDjKyiDZ
s5KNVw/9Ez6dikH3mAqYAxn5Yok3UBodHImRcsq4hSwUhEYue8hIV/7clvk85lmR
KkU4Ltwxdp1L528NRQkuH4MQzgQ7W3eaIkuLn5PriCyhWStG/0Y6t2+l+jML5673
FKwU6Su6ecDiOWW2Dc2duyQQrtrPCH6atEJCD3zHCBCnOP9fw2H3ePPH1XPzATTz
5qcBCKZ/YSLeYRQfgtLoXXpAzeq0fMVrQ+rBqk2XE7hK3Fr4Z0bNXpEshx6fty8X
fA9SMRhszGsmE5Tdliq1L4s2ej7Zg5zkdhDZli0va+yUOrtB6xgrfW9VdY/HgvvL
DlKWwHPigQ3xvIuCAAmp1yVMWHExQdHh1DFQvNKaBbEmXXKD3Uxtsjz1CiZZcmhQ
LqJWa7evZY0h78m+JuGOhz91L79BkffaIgOCDR6FslkgbvzOXdHJaox/tYuKkG7N
2fh3j75V2pC3iaNMi8XG1EhcITWkIlT3iJmk4XKtB3Qa2ZPsJUm3f0vSTvYt0xvE
GtILmo6MeKbYxe3fOsfBSmaZ3zU/ayZZEAeHGcTUPBIzAH4OVelqkn8wDDLhiGDe
VAqVGDC7/tbuRRWes+//Vay/A961d6jxlTTMfkOI06wKvA0ZviDxjdZOKdv7ta+d
ukw7CJSkfDuuZoCVpGCgbgx/PpoWKJS68Ta5HDTx0ExcV7lCJ3o=
=Ekgq
-----END PGP SIGNATURE-----

--MzdA25v054BPvyZa--

