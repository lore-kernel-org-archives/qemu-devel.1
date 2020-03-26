Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEEC2D0E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8EDE20737
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 00:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XFVIDk2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8EDE20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHGbw-00046J-RM
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 20:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXN-0003lk-Ch
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jHGXL-0002JZ-IB
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 20:38:21 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:49579)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jHGXL-0002HO-4x; Wed, 25 Mar 2020 20:38:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48nmL83vBLz9sSb; Thu, 26 Mar 2020 11:38:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1585183088;
 bh=Hc01cLbq2/P1PD4PouqD+7EVV48p5N6TJf5rB9hAAo4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XFVIDk2Vcwk7JWHlYIyzQRitRvf3Hf3DGGAPjYCRRmdLV8V6qEF+TkURIwCQLVn71
 +KgHAZB1PZnqtNbybq1IY/4qYtXvt3cSgLJgGWgL2l1lm4ie/9ec34U1Hi2/rFNP/O
 awGNT698KrYxDnYI8FP9DY5LmrifdHIAy2RRQqeo=
Date: Thu, 26 Mar 2020 11:30:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 4/4] ppc/spapr: Don't kill the guest if a recovered
 FWNMI machine check delivery fails
Message-ID: <20200326003031.GP36889@umbus.fritz.box>
References: <20200325142906.221248-1-npiggin@gmail.com>
 <20200325142906.221248-5-npiggin@gmail.com>
 <20200325191332.7da79231@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ugCSa1rMkiCAmd9S"
Content-Disposition: inline
In-Reply-To: <20200325191332.7da79231@bahia.lan>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ugCSa1rMkiCAmd9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 07:13:32PM +0100, Greg Kurz wrote:
> On Thu, 26 Mar 2020 00:29:06 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> > Try to be tolerant of FWNMI delivery errors if the machine check had be=
en
> > recovered by the host.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  hw/ppc/spapr_events.c | 27 ++++++++++++++++++++++-----
> >  1 file changed, 22 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
> > index c8964eb25d..b90ecb8afe 100644
> > --- a/hw/ppc/spapr_events.c
> > +++ b/hw/ppc/spapr_events.c
> > @@ -833,13 +833,25 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *c=
pu, bool recovered)
> >      /* get rtas addr from fdt */
> >      rtas_addr =3D spapr_get_rtas_addr();
> >      if (!rtas_addr) {
> > -        error_report(
> > +        if (!recovered) {
> > +            error_report(
> >  "FWNMI: Unable to deliver machine check to guest: rtas_addr not found.=
");
> > -        qemu_system_guest_panicked(NULL);
> > +            qemu_system_guest_panicked(NULL);
> > +        } else {
> > +            warn_report(
> > +"FWNMI: Unable to deliver machine check to guest: rtas_addr not found.=
 "
> > +"Machine check recovered.");
> > +        }
> >          g_free(ext_elog);
> >          return;
> >      }
> > =20
> > +    /*
> > +     * Must not set interlock if the MCE does not get delivered to the=
 guest
> > +     * in the error case above.
> > +     */
>=20
> It is a bit confusing to read "must not set interlock" and to see the
> interlock being set the line below IM-non-native-speaker-HO... also
> a small clarification of the outcome of taking the interlock without
> delivering the MCE could help people who aren't familiar with FWNMI
> to avoid doing bad things.

That's a good point.  That comment made sense to me (and presumably to
Nick) because it directly answers a question I had on an earlier draft
(which moved this without comment).  But someone without that context
(say, future me) could well find that confusing.

>=20
> What about something like the following ?
>=20
>     /*
>      * By taking the interlock, we assume that the MCE will be
>      * delivered to the guest. CAUTION: don't add anything that
>      * could prevent the MCE to be delivered after this line,
>      * otherwise the guest won't be able to release the interlock
>      * and ultimately hang/crash?
>      */

I've substituted your comment inline.

>=20
> > +    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
> > +
>=20
> For improved paranoia, this could even be done just before calling
> ppc_cpu_do_fwnmi_machine_check().
>=20
> Anyway, the change is good enough so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> >      stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFS=
ET,
> >                  env->gpr[3]);
> >      cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
> > @@ -876,9 +888,15 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool rec=
overed)
> >           * that CPU called "ibm,nmi-interlock")
> >           */
> >          if (spapr->fwnmi_machine_check_interlock =3D=3D cpu->vcpu_id) {
> > -            error_report(
> > +            if (!recovered) {
> > +                error_report(
> >  "FWNMI: Unable to deliver machine check to guest: nested machine check=
=2E");
> > -            qemu_system_guest_panicked(NULL);
> > +                qemu_system_guest_panicked(NULL);
> > +            } else {
> > +                warn_report(
> > +"FWNMI: Unable to deliver machine check to guest: nested machine check=
=2E "
> > +"Machine check recovered.");
> > +            }
> >              return;
> >          }
> >          qemu_cond_wait_iothread(&spapr->fwnmi_machine_check_interlock_=
cond);
> > @@ -906,7 +924,6 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool reco=
vered)
> >          warn_report("Received a fwnmi while migration was in progress"=
);
> >      }
> > =20
> > -    spapr->fwnmi_machine_check_interlock =3D cpu->vcpu_id;
> >      spapr_mce_dispatch_elog(cpu, recovered);
> >  }
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ugCSa1rMkiCAmd9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl5796QACgkQbDjKyiDZ
s5KB2g//RbsYnmsVC0+p0hafeO8/EFus/RLkIubLvAoMFjhqEmVixkCWbIPpEA8y
gtXGn39cHzBrw194m62M9r+lH/K865cGDUUzlhBAOxMh+jFLxYsgpDhmDdAGpeVo
2pt/lFpwtJ4j+9E572tM+l6SKCX8jvLFVl/7KFnHhRjVd/8P+kAtofzHCmmV3JXu
8jxov2OusmxrwNiSwVzY+XyN2ZLIxZO92yCzB/0LFulhpM4qAFWho8A52MWCF51S
v+cc/iYVbMb78yl+gzhz8AQqfowNEwQMuZa/7DcsaWJscJzMMCQ6aft7bJDEenFw
Xlp/Dpo6CN2lr/jHYUcWMSl80mqJDv2DX4D7+ghKStVnxKjFiZTDV9PUnBkbUVA1
u7L9ElyNLN5vBOrxAsnQmzbS+UDBMMUK+OLVkwTPekMzJhWVaGRge3CkGAGtiwUh
bWSw6p8DUjDxZXxgL78Rj/JEFs5CjbYu/WZiPdxM/jvl3t27FJwAJDLXWjx/A1cA
HfhBVr7td/syaWwdmOTswUkadv6FWZb7fCU5uFyNBwny/2DPTq6bu9UGFXHGUZPg
VaoWzoseBERfT5+xPcXPcUWnU4N7nlZtR7w7CKTTuxIP9e6ZVrynZ+mAxLPiDF1V
xwz5ofEN823PNCDNZ64Bg44IJ5VufoOIpjFF/GyF7eU/ym4Sl80=
=dVvy
-----END PGP SIGNATURE-----

--ugCSa1rMkiCAmd9S--

