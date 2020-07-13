Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 23:59:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998BE2184D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 23:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ncF7eSkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998BE2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv8Lq-0002xB-Up
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 19:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jv8L4-0002Wk-II; Mon, 13 Jul 2020 19:58:26 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36055 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jv8L0-0001Ir-Qq; Mon, 13 Jul 2020 19:58:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4B5LFM5n3kz9sRR; Tue, 14 Jul 2020 09:58:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1594684695;
 bh=vzMs5Ty1L4T8zt3kKDg3utWeNhy+zgJc80fa1hEzfRo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ncF7eSkzgv7Ihpf1i0I8WNrp2yFiIj8R9Ntl5LYdDkR1AG43hCu9g97AAjRmWjLOI
 oRaNqL0g9ks5C56G2gghJJXZ/9zC6TZDmDN9lstZjAtxsicyWKGPf6rXQ07UFgL1F9
 0TP8tXk1DgVLzVlAvG+oFNIltZVAzG6dwYJ6pwto=
Date: Tue, 14 Jul 2020 09:47:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Lijun Pan <ljp@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 06/11] Update PowerPC AT_HWCAP2 definition
Message-ID: <20200713234720.GF93134@umbus.fritz.box>
References: <20200701234344.91843-1-ljp@linux.ibm.com>
 <20200701234344.91843-7-ljp@linux.ibm.com>
 <20200713051400.GA93134@umbus.fritz.box>
 <BDB7FF22-BF16-45B7-B67E-94DD415A5E5C@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <BDB7FF22-BF16-45B7-B67E-94DD415A5E5C@linux.vnet.ibm.com>
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
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Lijun Pan <ljp@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 02:20:20PM -0500, Lijun Pan wrote:
>=20
>=20
> > On Jul 13, 2020, at 12:14 AM, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> >=20
> > On Wed, Jul 01, 2020 at 06:43:41PM -0500, Lijun Pan wrote:
> >> Add PPC2_FEATURE2_ARCH_3_10 to the PowerPC AT_HWCAP2 definitions.
> >>=20
> >> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> >> ---
> >> v4: add missing changes, and split to 5/11, 6/11, 7/11
> >> v3: use tcg_gen_gvec_mul()
> >> v2: fix coding style
> >>    use Power ISA 3.1 flag
> >>=20
> >> include/elf.h | 1 +
> >> 1 file changed, 1 insertion(+)
> >>=20
> >> diff --git a/include/elf.h b/include/elf.h
> >> index 8fbfe60e09..1858b95acf 100644
> >> --- a/include/elf.h
> >> +++ b/include/elf.h
> >> @@ -554,6 +554,7 @@ typedef struct {
> >> #define PPC_FEATURE2_HTM_NOSC           0x01000000
> >> #define PPC_FEATURE2_ARCH_3_00          0x00800000
> >> #define PPC_FEATURE2_HAS_IEEE128        0x00400000
> >> +#define PPC_FEATURE2_ARCH_3_10          0x00200000
> >>=20
> >> /* Bits present in AT_HWCAP for Sparc.  */
> >=20
> >=20
> > Um.. in the corresponding #defines in the kernel 0x00200000 is given
> > to PPC_FEATURE2_DARN, and several more bits are allocated past that
> > point.
>=20
> Then what do you recommend to use?

This is part of exposed userland ABI, so it needs to be standardized
at least semi-formally.  I'm not actually sure who allocates these in
general.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8M8oMACgkQbDjKyiDZ
s5JfkxAAlAwDp989axQA78HW7C/l6z7SlYy2L/jtwQnKXN+xUp3JmJJbVnNOl2N/
ZsqKEkW0TU1NUbgmaBicg/5Ej9o3GSQVO926LBjaVlRrxWa2SY7tF9r9HRrDUGph
ddLXV/w6xeVYV3ciUQDK7pRHYfXwKDy7p1Mz0aiwNLmhaeND0xAiTv1VLHtjHHYi
zVCQ19+kiXzWCpRAJgUJ3u8InwcsxLwiCV0ghYrgveFx5Byf+4Rxob5RFTvagjNJ
SFOmdHSprU7h11/DKZHKWpYQUJCkPfT8ksNooVr1Sgk3luQW23ZC8Q66bPh9FbVj
FhyO2MvA1Gm6Wq5TndfMHT/+PIeZzIHVaTzvo08ig5zmvDF+p7Pp0+Y40mkLp3W2
QS8ZSwjpa95OgiFEORVL4t012CcE6hIWRlaMulEVClopohH5p+Fal7XbukV/UTbN
/YsgCUL2Du8mLWfN3F+31y0fkMxjCImSyuPImjN6hVryYP3tY3hrrBxv8s/U7hXl
y/nRVxu0CiuaOT+l+gfTjMkFAwCg+zhH+f8BtnjHO+NdKGAbxCVwyXMWdmXuQG/6
kLXsHrBVEzuGk2xXj8wf8RS8isKP23EB57m9RSj/3544iSwRirVsoyMk1iKhE9yV
wIc2E5ImRzro7EsohTvzWVgrxebWG+QPCUac5PD8Efu7QfipbIo=
=vWCe
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--

