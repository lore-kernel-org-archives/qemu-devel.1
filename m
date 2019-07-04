Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2697C5B578
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 00:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD55B218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 00:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TgBk48dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD55B218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hipwT-0003Bw-R2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 20:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hipul-0002BV-Hc
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 20:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hipuk-0007Ls-Ey
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 20:47:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:49177 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hipuj-0007KH-Rt; Wed, 03 Jul 2019 20:47:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45fK8308xRz9sPB; Thu,  4 Jul 2019 10:47:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562201267;
 bh=EBsd1xy6nyqr1bMunKIeFAXU90ssSW8SARCkgjm7cuE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TgBk48dW1lOLQCsXfUX7n/93WCw0/9bohXic/LOKygDlYzYHXkAgTkntzZEbgiOUp
 dyxktdEEODr6jELUHQyy1iXOA6glUawoId86QzhfBAzXhIKj0TLqsvW6DFV7bjpm3G
 +nnRhQ8oWwO98xa2RqaqKcHjIzD3eOiGY4ODdt7U=
Date: Thu, 4 Jul 2019 10:22:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190704002258.GQ9442@umbus.fritz.box>
References: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i/CQJCAqWP/GQJtX"
Content-Disposition: inline
In-Reply-To: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH for-4.1] xics/kvm: Always set the MASKED
 bit if interrupt is masked
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
Cc: qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i/CQJCAqWP/GQJtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 07:22:20PM +0200, Greg Kurz wrote:
> The ics_set_kvm_state_one() function is called either to restore the
> state of an interrupt source during migration or to set the interrupt
> source to a default state during reset.
>=20
> Since always, ie. 2013, the code only sets the MASKED bit if the 'current
> priority' and the 'saved priority' are different. This is likely true
> when restoring an interrupt that had been previously masked with the
> ibm,int-off RTAS call. However this is always false in the case of
> reset since both 'current priority' and 'saved priority' are equal to
> 0xff, and the MASKED bit is never set.
>=20
> The legacy KVM XICS device gets away with that because it ends updating
> its internal structure the same way, whether the MASKED bit is set or
> the priority is 0xff.
>=20
> The XICS-on-XIVE device for POWER9 is different. It sticks to the KVM
> documentation [1] and _really_ relies on the MASKED bit to correctly
> set. If not, it will configure the interrupt source in the XIVE HW, even
> though the guest hasn't configured the interrupt yet. This disturbs the
> complex logic implemented in XICS-on-XIVE and may result in the loss of
> subsequent queued events.
>=20
> Always set the MASKED bit if interrupt is masked as expected by the KVM
> XICS-on-XIVE device. This has no impact on the legacy KVM XICS.
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/virtual/kvm/devices/xics.txt
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-4.1, thanks.

> ---
>  hw/intc/xics_kvm.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 51433b19b076..2df1f3e92c7e 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -257,6 +257,9 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, E=
rror **errp)
>          << KVM_XICS_PRIORITY_SHIFT;
>      if (irq->priority !=3D irq->saved_priority) {
>          assert(irq->priority =3D=3D 0xff);
> +    }
> +
> +    if (irq->priority =3D=3D 0xff) {
>          state |=3D KVM_XICS_MASKED;
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i/CQJCAqWP/GQJtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0dRuIACgkQbDjKyiDZ
s5Jayg//Uzqyp68rQ8dJ8H8gWGKirfc+g/9Oz7OCevTmcAap/JsvfPjTk7xH5V83
l0ZjIWPfW9ca1y3vupUVJlqTWV6DDvKf/l2CbjO2LGViwyh1Tu+OUJiP8oIK4AuZ
kxr6GcKbeMuBq09L/w4tssT35ymDdpOOPY3hdxGskD4H0T4oRdT+vf2Jje1Zb1gI
oTYq5CYHFoVrnwwIhiRcQcg+NfdsoS6UD2N2aYwqACGcfR97B73GiVwtxH/8N9uS
HwZbSzA0FZmTxDj+onYVKW9mLTFYe+CKeOGo2OSxYZ9IJ7iMIwmK7t0B/5V9BIVB
F6xG+AscJ7XcHtiKmlX9qjLixwovkafQrKYpmTX/UhQ0mUVUGEQPy65bcLgC9mZ7
gBlPWqIl3tY2xrJvYYBePL1NOYLZeWW7tFvFiLSd9kZDKnE4AZQ99LjNubeBNMyF
+xHpCpfFVsxXREO/sqc22qiNCFrEqPOnVFe3x3eTdRaogsoBcEGLXbQb1kjo11ZQ
1VSgB+neO2GU4Q/lu8LEq5GCOvS7d9tG6J47Jp+ha8787+QbKf2UB/K6Cb8n1lBD
Ez7yxQVfDhSBddO5lT9PPYSjF7scpFDutwWjAXhKS6JSTl897a+xkKjJdx9hkZTP
ZMMMjVThtYJch22ZrGqYzRoT8OHdTxJwWiEIQCbz3HTvXb7JQ/4=
=gbVw
-----END PGP SIGNATURE-----

--i/CQJCAqWP/GQJtX--

