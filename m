Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE6C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56052076B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 00:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gCBaI9Kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56052076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXvzb-0001sx-MK
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 20:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXvwy-0000Cv-Fq; Wed, 28 Oct 2020 20:37:56 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:60413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXvwu-0000ye-NO; Wed, 28 Oct 2020 20:37:55 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CM63R1VD1z9sTq; Thu, 29 Oct 2020 11:37:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603931859;
 bh=QoaRcCy7Nhh4pgDVKXYYG6RiNuQyYN25m0w6Hf9XN9g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gCBaI9Kn60zDvXgI5AcGMMRLxA9WbBhqq4HK3Z3kozPi+uwt2zM52IRZcSzd9Zm6B
 QGvcqgeaoX6X0bv4ySjDlaC69NFIUV7foQbdjEMSOmp+D+Tkb1qH0R3fzj/NAKanK4
 biC6OVbgy3PYVFQAHySx/nXwOCpJ6ZhjGDDy4NdE=
Date: Thu, 29 Oct 2020 10:39:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 8/9] target/ppc: silence the compiler warnings
Message-ID: <20201028233910.GH5604@yekko.fritz.box>
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-9-kuhn.chenqun@huawei.com>
 <77fb89c5-daa2-0039-bdba-cce0f9895195@redhat.com>
 <c8255814-80ff-8937-938f-158ff924bb91@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YrlhzR9YrZtruaFS"
Content-Disposition: inline
In-Reply-To: <c8255814-80ff-8937-938f-158ff924bb91@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--YrlhzR9YrZtruaFS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 04:06:03PM +0100, Thomas Huth wrote:
> On 28/10/2020 10.56, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/28/20 5:18 AM, Chen Qun wrote:
> >> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed w=
arning:
> >> target/ppc/mmu_helper.c: In function =E2=80=98dump_mmu=E2=80=99:
> >> target/ppc/mmu_helper.c:1351:12: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
> >>  1351 |         if (ppc64_v3_radix(env_archcpu(env))) {
> >>       |            ^
> >> target/ppc/mmu_helper.c:1358:5: note: here
> >>  1358 |     default:
> >>       |     ^~~~~~~
> >>
> >> Add the corresponding "fall through" comment to fix it.
> >>
> >> Reported-by: Euler Robot <euler.robot@huawei.com>
> >> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> >> ---
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >>  target/ppc/mmu_helper.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> >> index 8972714775..51749b62df 100644
> >> --- a/target/ppc/mmu_helper.c
> >> +++ b/target/ppc/mmu_helper.c
> >> @@ -1355,6 +1355,7 @@ void dump_mmu(CPUPPCState *env)
> >>              break;
> >>          }
> >>  #endif
> >> +        /* fall through */
> >=20
> > I'm surprise the compiler emit a warning for missing comment,
> > but don't emit one for superfluous and confusing ones (when
> > building a ppc32-only target). You'd need to put this before
> > the #endif.
> >=20
> > But instead of this band-aid to silent warning, replace the
> > TODO by a LOG_UNIMP call, and add a break before the #endif.
>=20
> +1 for replacing the TODO with a LOG_UNIMP call and adding a break instea=
d,
> that would look way less messy than the current code.

True, that would be a better approach.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YrlhzR9YrZtruaFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+aAR0ACgkQbDjKyiDZ
s5LCeQ//aVNlIvG4AKUL0rgLA/GUnfHxNQp7LeMjUq1xT25Y3Vjm2Gjck3igWXqX
Mlz+P7bLQ/yVhN0g0LuHl8efjlyoDdDOOyqQ68hlZj/mYnNlJ3VBz4nE6buOqXkC
aU0cl/3b3HMdZlHT/4z3tLCmVXd0PpVCXGsH+mAJO4cnrN0hjNj97zDKTM19Uhwa
mEIvepeNcF/viNiRz0uSy0tK1ve4eVdOvzB4rcoy1mhnM9NRWuGsfwIyxKNrgAPU
Lk+nAnUyUTcid2pUcME64DA5iovPDXar8IsyLLShsfsdMi5g6LN7Svp04ZWz6Ag0
mMzKam7IywS2ldYmCmnTVjg3maagPohh5P3PySvJDa8V8BtKYOdcpbdvE7Ijv+1O
tnGWXVSwAwrmt0o93zc6CWvAbJxXbf6ThTqlXdET/jDLMa/JCQ6k9qAT690LWllr
Nb7G9M8425jzIhhbu9P1WPztpmT0ksVqSMAcN9iJ9xOXUZs7IcxWACzMYYA7nzPX
qcxYnxfZwhPOTNckBnas4KB/QdX8qZxk6RyrcvJdsotsTZflYjVnzn9qT77n+BEF
L7/C20AFi9pzHSJOmBrnRSTDKwc4iA0JL5geB9Ccpn/zekCCFKr3h0uLXTrweEgi
y5EtCXu2JhZViZtR3WE9ZIG/UMv2nb/zZnUz3OfPSxLy2NYsfKs=
=oLrI
-----END PGP SIGNATURE-----

--YrlhzR9YrZtruaFS--

