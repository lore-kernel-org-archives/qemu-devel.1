Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF61AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF2220678
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="O6C1nGLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF2220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSCp-0000BK-Qm
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgSBd-0006o1-ND; Wed, 03 Jun 2020 08:08:01 -0400
Received: from ozlabs.org ([203.11.71.1]:49863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgSBc-0007yw-09; Wed, 03 Jun 2020 08:08:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cSN44kFLz9sRW; Wed,  3 Jun 2020 22:07:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591186068;
 bh=sWOqdQiTvVrA52FGlNQ09smhuyYbRnbpUOcmb9tq01I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O6C1nGLfceWXHb/W6iKaDeojmlFpvcJWyq7DTmCDeOAjbgrTincTDxC4hCxaQ5saa
 cRIpkXU/FG9pANqzg0WwH1ARi8YdEzcrWaOhGXdbIM1u4l7adN2F6tKUFdDiR5/jDj
 zhuo5TBI+iG0BEq1VAIEXibRJjx9j5TUKHyOSchQ=
Date: Wed, 3 Jun 2020 20:09:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC v2 10/18] guest memory protection: Add guest memory
 protection interface
Message-ID: <20200603100930.GB11091@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-11-david@gibson.dropbear.id.au>
 <75221e39-837e-7cd0-6ed8-42610b539370@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <75221e39-837e-7cd0-6ed8-42610b539370@linaro.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 08:07:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 06:44:50PM -0700, Richard Henderson wrote:
> On 5/20/20 8:42 PM, David Gibson wrote:
> > @@ -0,0 +1,29 @@
> > +#/*
>=20
> Two extraneous # at the beginning of the new files.

Huh, weird.  Fixed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7XdtoACgkQbDjKyiDZ
s5LP2w//cVaecXbxrQlZSuEdEz7dUteRJqPDww5olxL0dz61E29mF59djvhId9Bq
H7adPUalIvRCr1cZ9pR1kDbjiBS8DUcqvhaF5e6sSVm2kmJYkxyflK4aMj2XOnrb
CIYWNTadTEx1GJ4t+/kfsgVzRzuwN0dw/i0xSF3TlVCgRNlFHaFxhTNQbT7N+T58
s/ivATJc/epebCK9zRLB3fJOVB+9UtBjary0BMfD+u1DL+NM4nlVBzqF8sKzbKNH
+vf90Ts83V2JV1se7t1lrzJj/jnoae0XyphiWpvf2zoaYUh51pjqGTeRVCJ4xEdy
uFXmkE43zEWArDCaqhY0B7Q9gbecGSvxgaQ/oKAa2g7DnHYjrHCBVB3tOO6Wk4Ej
GpB6hMM8Ykpd63Cb1F96m1exGCbkhE/WBivw+itFXNyMPjBpQBb2V7V8zrAonMrb
m9TaQoi6Hw0JEOGJxzeOYc5Z08Zx7tDY27+3oG2xLWIzO0sBFVRM8Nq54g7BMSWX
UazOTABS9tJYGd8n+A+C9RAjAzJHAKLfG3L5YAhz15fh/ZrMyCgiOiEDhwnq1mte
FfjPkoLfgh2l0NMpPG8mADOQAVDPNroJ4fhx72hGQPI79dCeKU5ivpdmFDPLZUqO
Tvwk/YG99Hw27mZdbdWsnAtyiWiRKGaShWJROAHwoiL5D5kSXAw=
=WUE/
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

