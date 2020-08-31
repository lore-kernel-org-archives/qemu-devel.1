Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B93C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D61A20780
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hhMF5Hpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D61A20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCtcA-0000yJ-Ce
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 19:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kCtaz-0007wb-6k; Mon, 31 Aug 2020 19:52:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60297 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kCtaw-0001no-LS; Mon, 31 Aug 2020 19:52:16 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BgRnl0wCnz9sVd; Tue,  1 Sep 2020 09:52:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1598917931;
 bh=XNqVpdqx+U8CPZ5jmb0Qt5SqTlEC+u9Tgj07OwTdsdQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hhMF5HpdPom6dPaRVxQibnklHqezr3xhEnwjIbj0Q50g4U/CURP6UF1VOcwSm7odx
 aGjRnjoZ77L60L7D+gx2FAKr/YScQYJUdpjdGoYbq7U0GNh2YHH6NTRwQ4V83SXljz
 HmcAtkyQwiOAqiquyyfU2Ka7PuLF/m3KbToz5Nxk=
Date: Tue, 1 Sep 2020 09:52:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 3/3] spapr: Correct type for SPAPR_DRC_PCI
Message-ID: <20200831235204.GA33713@yekko.fritz.box>
References: <20200825111627.2007820-1-david@gibson.dropbear.id.au>
 <20200825111627.2007820-4-david@gibson.dropbear.id.au>
 <20200826162137.GE642093@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200826162137.GE642093@habkost.net>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 19:51:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 12:21:37PM -0400, Eduardo Habkost wrote:
> On Tue, Aug 25, 2020 at 09:16:27PM +1000, David Gibson wrote:
> > TYPE_SPAPR_DRC_PCI inherits from TYPE_SPAPR_DRC_PHYSICAL, so its checker
> > macro should use the corresponding instance type.  We got away with it
> > because we never actually used that checker macro.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  include/hw/ppc/spapr_drc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > index 21af8deac1..baaaba3c1f 100644
> > --- a/include/hw/ppc/spapr_drc.h
> > +++ b/include/hw/ppc/spapr_drc.h
> > @@ -59,7 +59,7 @@
> >          OBJECT_GET_CLASS(SpaprDrcClass, obj, TYPE_SPAPR_DRC_PCI)
> >  #define SPAPR_DRC_PCI_CLASS(klass) \
> >          OBJECT_CLASS_CHECK(SpaprDrcClass, klass, TYPE_SPAPR_DRC_PCI)
> > -#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrc, (obj), \
> > +#define SPAPR_DRC_PCI(obj) OBJECT_CHECK(SpaprDrcPhysical, (obj), \
> >                                          TYPE_SPAPR_DRC_PCI)
>=20
> I'm not sure this is really what we want to do.  This is what
> triggered the warning in my script, but it doesn't mean we want
> to use SpaprDrcPhysical here.
>=20
> Code that needs a SpaprDrc* can use SPAPR_DR_CONNECTOR();
> code that needs a SpaprDrcPhysical* can use SPAPR_DRC_PHYSICAL().
> All the other OBJECT_CHECK(SpaprDrc, ...) and
> OBJECT_CHECK(SpaprDrcPhysical, ...) macros seem unnecessary.

Good point.  I've rewritten and am resending.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9NjSIACgkQbDjKyiDZ
s5JFfQ/+Jrhk86ScH7OJvTWlad77fSklyopNZhvY30+KvcxG+5qYpG3yprcCc3q0
VR/CkZNG8wAEpTsQ7jSpR75a85GcYVUqC/x9t7j3MRpB4eLBzlv6D8bcqh3iikNZ
6Y+7KfLlbzVemzN4LRy8fC40h+d5xSb+NrehLUwNBHYBXM02lg6jYXVbYLVHVYo7
dsSCMRz1Bg1G5gy9YlGh6+x2lPtKIN7C+eLCTqoxfL+DPyGjMcmtpL/d1Lgx9LIl
puFZ8dxOU1jYhAJnpJVvpwXntjWnxJpZk4XMfnjL/LeQ8DdbC7VTJVjrf4P6Jtmv
Z6dTIO2V4uOX+E5wPtG/D89RUxXaDHOKDc2F+EKRq9qVS2xSAswv4wN3xL4lDkeX
BoVCvAPYj6DMn5tAhdgXr3tsCf7qTrnYLzLscZ4UuFKbxl/JfQYFB7oLQbkM6qPD
uAmqO3dS7hhl7n9h7Y2iVzoClB3+yOllHcBoA3WDKvqTgXFuqG2fZT2V5RHGVfH/
d8eUe7pJrgVv7SB8/zqAh1u6zJd7Vc+uhy+ZwteHuPGLpsZon/9mgMwCj5MPi5GW
ToRGO+iPF99L7vr0iAH0HmrXEZr0P/J+iYOeUWwjT/Vh2DoKPE7A0a8ATRP1NP21
0qitWeYy218WtGRSwLJZJ0G9senEQCN8IbF4Cmlm+oIfd00K35g=
=i8Ec
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

