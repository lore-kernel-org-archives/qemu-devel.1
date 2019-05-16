Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733B1C04E87
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B8620873
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 01:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="QZCkd6nm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B8620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR5XV-0001FG-FP
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 21:50:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WE-0000dW-QJ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hR5WC-0007tx-DN
	for qemu-devel@nongnu.org; Wed, 15 May 2019 21:49:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58627 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hR5WB-0007qU-Cd; Wed, 15 May 2019 21:49:12 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 454DqQ5G5dz9sDn; Thu, 16 May 2019 11:49:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1557971346;
	bh=OMnZtmSbza04Rog52QhKBprI3OFUAqDHv/qox3A3TVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZCkd6nmNtu0iNVaBmW/OvaTh+y2XzDAz8pHHtH2DGDhWLDWumFOu+qzy9Xu4E6rx
	8JCOnqTc633uwJObiClXCZyP3b3RdU+77QcEy9ZQnmsRyTiv5rxz5ytfyIIK8fQHg0
	rZmfj3y3bL0s0MeO8BaAdESqFPG8OcmgvlbIqbO8=
Date: Thu, 16 May 2019 11:47:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190516014733.GE3207@umbus.fritz.box>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<20190513133053.4d900d4a@bahia.lan>
	<20190514000819.GA6441@umbus.fritz.box>
	<9eb7a5a6-a018-d08a-4556-26da0b6cc3ca@linux.vnet.ibm.com>
	<20190514044005.GH6441@umbus.fritz.box>
	<2cc48944-4ad7-6fd6-7d59-f041339fc6ec@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <2cc48944-4ad7-6fd6-7d59-f041339fc6ec@linux.vnet.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 10:36:17AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 14 May 2019 10:10 AM, David Gibson wrote:
> > On Tue, May 14, 2019 at 09:56:41AM +0530, Aravinda Prasad wrote:
> >>
> >>
> >> On Tuesday 14 May 2019 05:38 AM, David Gibson wrote:
> >>> On Mon, May 13, 2019 at 01:30:53PM +0200, Greg Kurz wrote:
> >>>> On Mon, 22 Apr 2019 12:33:26 +0530
> >>>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >>>>
> >>>>> Upon a machine check exception (MCE) in a guest address space,
> >>>>> KVM causes a guest exit to enable QEMU to build and pass the
> >>>>> error to the guest in the PAPR defined rtas error log format.
> >>>>>
> >>>>> This patch builds the rtas error log, copies it to the rtas_addr
> >>>>> and then invokes the guest registered machine check handler. The
> >>>>> handler in the guest takes suitable action(s) depending on the type
> >>>>> and criticality of the error. For example, if an error is
> >>>>> unrecoverable memory corruption in an application inside the
> >>>>> guest, then the guest kernel sends a SIGBUS to the application.
> >>>>> For recoverable errors, the guest performs recovery actions and
> >>>>> logs the error.
> >>>>>
> >>>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>>> ---
> >>>>>  hw/ppc/spapr.c         |    4 +
> >>>>>  hw/ppc/spapr_events.c  |  245 ++++++++++++++++++++++++++++++++++++=
++++++++++++
> >>>>>  include/hw/ppc/spapr.h |    4 +
> >>>>>  3 files changed, 253 insertions(+)
> >>>>>
> >>>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>>> index 2779efe..ffd1715 100644
> >>>>> --- a/hw/ppc/spapr.c
> >>>>> +++ b/hw/ppc/spapr.c
> >>>>> @@ -2918,6 +2918,10 @@ static void spapr_machine_init(MachineState =
*machine)
> >>>>>          error_report("Could not get size of LPAR rtas '%s'", filen=
ame);
> >>>>>          exit(1);
> >>>>>      }
> >>>>> +
> >>>>> +    /* Resize blob to accommodate error log. */
> >>>>> +    spapr->rtas_size =3D spapr_get_rtas_size(spapr->rtas_size);
> >>>>> +
> >>>>
> >>>> This is the only user for spapr_get_rtas_size(), which is trivial.
> >>>> I suggest you simply open-code it here.
> >>>
> >>> I agree.
> >>
> >> Sure.
> >>
> >>>
> >>>> But also, spapr->rtas_size is a guest visible thing, "rtas-size" pro=
p in the
> >>>> DT. Since existing machine types don't do that, I guess we should on=
ly use
> >>>> the new size if cap-fwnmi-mce=3Don for the sake of compatibility.
> >>>
> >>> Yes, that's a good idea.  Changing this is very unlikely to break a
> >>> guest, but it's easy to be safe here so let's do it.
> >>
> >> I did it like that because the rtas_blob is allocated based on rtas_si=
ze
> >> in spapr_machine_init(). During spapr_machine_init() it is not know if
> >> the guest calls "ibm, nmi-register". So if we want to use the new size
> >> only when cap_fwnmi=3Don, then we have to realloc the blob in "ibm,
> >> nmi-register".
> >=20
> > What?  Just always allocate the necessary space in
> > spapr_machine_init() if cap_fwnmi=3Don, it'll be wasted if
> > ibm,nmi-register is never called, but it's not that much space so we
> > don't really care.
>=20
> Yes, not that much space, and ibm,nmi-register is called when the Linux
> kernel boots. I guess, even though other OSes might not call
> ibm,nmi-register, they do not constitute significant QEMU on Power users.
>=20
> So I think, I will keep the code as is.

No, that's not right.  It's impractical to change the allocation
depending on whether fwnmi is currently active.  But you *can* (and
should) base the allocation on whether fwnmi is *possible* - that is,
the value of the spapr cap.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzcwTUACgkQbDjKyiDZ
s5KVcg//RaOsfpN6N+7yYikVoWWCVMTWKrzHgSJdPF8C2YqnwktajGXI6YM7wdAv
gkTgc3+jryt8BiQsfI+DMaAzF2PhZtrD5kc2csIG6LI5bOXvyHzzVt86QVUZpbHp
Hj0xSpenbX5vfkpLU7A8U9nJlNbSAKFKIZYEbJU/GoZWbx/hHjJr2tfsjKMWZSLA
hpyTCgDEZPF2RzLv6+2c7TTBdfESexFmRW6Q8fkXDsgpbjddbXz/Vl12GnWVkFj1
xozSunV5oT3tnSxaGZrGuYTMiO/aeoChht3rFIj48Ej280QaneVAzXcV4O6Sxeue
SX/YNA4shLWvq31Tcrj+QVQHez1vRcXgNCX/rubcJ+BJEGBeSROI5quhYD8Y96RF
FZeHmFAKV4wifbirLjO8/aHXFhxo7DD7s/q7KsAqSq8xDc3tBq3sQY5f7/0OVUiU
LkyXazFPJ7jwIrdQKN6kHX4iJu4wTi8i3h48BsexxbVd8Y0oNLLyHfNu7UqG0iX5
AdraB131yrs8/1V9HgoxQeNvBats+oafh58+5IleduCbRY67LOJrnwRuH7HAGkYZ
AA03mEUDGOFFMLS5u1w+VOWuD7G7nJNymKrL49F2i0jLy9ZUWnw40uwpV0Kn7p/M
oKFMBM4wS8wdG2/d6zgUjkG9482q+d/SM2fqDWq3lueXIJ6tlf8=
=uOx5
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--

