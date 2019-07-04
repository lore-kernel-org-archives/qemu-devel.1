Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEBDC0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 00:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6F7218A4
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 00:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="gTeH0IDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6F7218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hipwV-0003FG-P2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 20:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38116)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hipuk-0002BT-KX
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 20:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hipuj-0007Kx-B2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 20:47:54 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56551 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hipui-0007IY-4w; Wed, 03 Jul 2019 20:47:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45fK830hpmz9s8m; Thu,  4 Jul 2019 10:47:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562201267;
 bh=Katb7tZKndxLwVSEcP6pSuEt5uVEaQuBaZdGlUXaYss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gTeH0IDFZJgND5u46coHct5oiG0FtXL23bMk++SyAjy75P9zFpbyFLagbNdZE7bkj
 voFjYEcS7LdmlQWDEXZc9WWO5l+gE/52QU32wZNIrLLtE2ifv9HmUXQeNLeRQv7yIS
 5ITDb7xw0FYoCAXslgOh0NEXYWfyhtsHOnCxrQBQ=
Date: Thu, 4 Jul 2019 10:23:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Message-ID: <20190704002357.GR9442@umbus.fritz.box>
References: <156217621200.562209.8968691631915806468.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gMqNd2jlyJQcupG/"
Content-Disposition: inline
In-Reply-To: <156217621200.562209.8968691631915806468.stgit@bahia.lan>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH for-4.2] xics/kvm: Convert assert() to
 error_setg()
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


--gMqNd2jlyJQcupG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 07:50:12PM +0200, Greg Kurz wrote:
> ics_set_kvm_state_one() is called either during reset, in which case
> both 'saved priority' and 'current priority' are equal to 0xff, or
> during migration. In the latter case, 'saved priority' may differ
> from 'current priority' only if the interrupt had been masked with
> the ibm,int-off RTAS call. Instead of aborting QEMU, print out an
> error and exit.

What's the rationale for this?  Doesn't hitting this indicate an error
in the qemu code, for which an abort is the usual response?

>=20
> Based-on: <156217454083.559957.7359208229523652842.stgit@bahia.lan>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> This isn't a bugfix, hence targetting 4.2, but it depends on an actual
> fix for 4.1, as mentionned in the Based-on tag.
> ---
>  hw/intc/xics_kvm.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 2df1f3e92c7e..f8758b928250 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -255,8 +255,21 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno, =
Error **errp)
>      state =3D irq->server;
>      state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
>          << KVM_XICS_PRIORITY_SHIFT;
> -    if (irq->priority !=3D irq->saved_priority) {
> -        assert(irq->priority =3D=3D 0xff);
> +
> +    /*
> +     * An interrupt can be masked either because the ICS is resetting, in
> +     * which case we expect 'current priority' and 'saved priority' to be
> +     * equal to 0xff, or because the guest has called the ibm,int-off RT=
AS
> +     * call, in which case we we have recorded the priority the interrupt
> +     * had before it was masked in 'saved priority'. If the interrupt is=
n't
> +     * masked, 'saved priority' and 'current priority' are equal (see
> +     * ics_get_kvm_state()). Make sure we restore a sane state, otherwise
> +     * fail migration.
> +     */
> +    if (irq->priority !=3D irq->saved_priority && irq->priority !=3D 0xf=
f) {
> +        error_setg(errp, "Corrupted state detected for interrupt source =
%d",
> +                   srcno);
> +        return -EINVAL;
>      }
> =20
>      if (irq->priority =3D=3D 0xff) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gMqNd2jlyJQcupG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0dRx0ACgkQbDjKyiDZ
s5IqVg//Z2uVauHkQ2N3bb8+CjgBqz6lHQqgQkEspmynl/mFrT4hg0/qYquqZBIa
8JQY/3pp960FXxOomL5hfKFuIlLdxYidRTqPUBwKigdWZ2jK72ZQqJi5HsCg0wYp
lgwCB7l7NMaamYBwOnFLGLCp4oHw7xuN1vztMnqIgT+bUk7hr+uFyTKcvv5OXmDf
+EaELtBucliTIJwe3TJrkcABFlK0u9QqPPgrez/teIU2vIo65p6HHKnZ+LtynjnN
VVL58jEG6kblnUbs1xJIFcvUAjjQQ0EZhpdbpxtYhxv1iB1ueCSCMKnsPNU28aKm
jwinlT4vzFfdCNex7heDfKBhd72bf4/uA76bXQQWlN8AsrJIc1q+Z75KGD/ijAhy
5JGp+eLPerRUY4G/fGQJfc2TIIiSgm+0PjirSmypOvpf1PKN3OEZ1UpHYZSPC3jF
AvoHkSjxSPSqWiyYchX2Vdt9wbrRCPZ8xRYWpHL4x+oM76P923zAd8CzEFddVq2q
BTObsy6SfErl+6dnlKTLzHNRS+8k3xUSBlRhrzRGVdiez3i7Q/KOKZ0Fz/7z11W2
d0Bij0mFaruYG8Gdq3MTyFHGiIAO9qxaI13CBTcHFAS7AqMsOzkUZLhn74Jg7OvP
ybon9f11H/Ts9xtUbP6DwsPPTd+cL0yWzZlL5acQtOWm6B5GfhA=
=cvjk
-----END PGP SIGNATURE-----

--gMqNd2jlyJQcupG/--

