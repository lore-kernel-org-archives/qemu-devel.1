Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77EC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:37:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67361206E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 04:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fNZk0Ne/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67361206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiAYD-0007z2-MK
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 00:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41757)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAAE-0008GJ-Kq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiAAC-0005Qd-KY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 00:13:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:50385 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiAAB-0005GF-Tz; Tue, 02 Jul 2019 00:13:04 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45d9nX56DKz9sBp; Tue,  2 Jul 2019 14:12:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562040768;
 bh=c0Dq0KUllXCCayf72BwIYzkyxR+YWNmggVRhhMjGeec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fNZk0Ne/Pv0CRTeknzFu6/21JtfRniPRMFGRED/Tex5fYflrfhgxECu8aYVqlA/gx
 LuB6FbOZ+LowBaNe+LT5R4Gn8BUr91/mjKcacn7JEnmxigskFoEDqgbIZe7SA98jnu
 4bYfR5GsqGiIVG+XmtAnX7BZQwvcoj30NjpOPaKA=
Date: Tue, 2 Jul 2019 14:12:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Message-ID: <20190702041236.GK6779@umbus.fritz.box>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
 <156033129836.26635.3348706829139659071.stgit@aravinda>
 <20190624162935.02d08837@bahia.lan>
 <658ed3c3-9722-e23a-b65c-89df6025461e@linux.vnet.ibm.com>
 <20190625090023.10c26982@bahia.lan>
 <29912bc9-4241-90f2-5cf6-57e6ed8f420b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline
In-Reply-To: <29912bc9-4241-90f2-5cf6-57e6ed8f420b@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: aik@au1.ibm.com, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
 paulus@ozlabs.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2019 at 10:43:33AM +0530, Aravinda Prasad wrote:
>=20
>=20
> On Tuesday 25 June 2019 12:30 PM, Greg Kurz wrote:
> > On Tue, 25 Jun 2019 11:46:06 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >=20
> >> On Monday 24 June 2019 07:59 PM, Greg Kurz wrote:
> >>> On Wed, 12 Jun 2019 14:51:38 +0530
> >>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >>>  =20
> >>>> This patch adds support in QEMU to handle "ibm,nmi-register"
> >>>> and "ibm,nmi-interlock" RTAS calls and sets the default
> >>>> value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
> >>>> type 4.0.
> >>>> =20
> >>>
> >>> Next machine type is 4.1. =20
> >>
> >> ok.
> >>
> >>>  =20
> >>>> The machine check notification address is saved when the
> >>>> OS issues "ibm,nmi-register" RTAS call.
> >>>>
> >>>> This patch also handles the case when multiple processors
> >>>> experience machine check at or about the same time by
> >>>> handling "ibm,nmi-interlock" call. In such cases, as per
> >>>> PAPR, subsequent processors serialize waiting for the first
> >>>> processor to issue the "ibm,nmi-interlock" call. The second
> >>>> processor that also received a machine check error waits
> >>>> till the first processor is done reading the error log.
> >>>> The first processor issues "ibm,nmi-interlock" call
> >>>> when the error log is consumed.
> >>>>
> >>>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>>> ---
> >>>>  hw/ppc/spapr.c         |    6 ++++-
> >>>>  hw/ppc/spapr_rtas.c    |   63 +++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  include/hw/ppc/spapr.h |    5 +++-
> >>>>  3 files changed, 72 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>>> index 3d6d139..213d493 100644
> >>>> --- a/hw/ppc/spapr.c
> >>>> +++ b/hw/ppc/spapr.c
> >>>> @@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>>          /* Create the error string for live migration blocker */
> >>>>          error_setg(&spapr->fwnmi_migration_blocker,
> >>>>                  "Live migration not supported during machine check =
handling");
> >>>> +
> >>>> +        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS cal=
ls */
> >>>> +        spapr_fwnmi_register(); =20
> >>>
> >>> IIRC this was supposed to depend on SPAPR_CAP_FWNMI_MCE being ON. =20
> >>
> >> Yes this is inside SPAPR_CAP_FWNMI_MCE check:
> >>
> >> if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) =3D=3D SPAPR_CAP_ON) {
> >>     /*
> >>      * Ensure that the rtas image size is less than RTAS_ERROR_LOG_OFF=
SET
> >>      * or else the rtas image will be overwritten with the rtas error =
log
> >>      * when a machine check exception is encountered.
> >>      */
> >>     g_assert(spapr->rtas_size < RTAS_ERROR_LOG_OFFSET);
> >>
> >>     /* Resize rtas blob to accommodate error log */
> >>     spapr->rtas_size =3D RTAS_ERROR_LOG_MAX;
> >>
> >>     /* Create the error string for live migration blocker */
> >>     error_setg(&spapr->fwnmi_migration_blocker,
> >>             "Live migration not supported during machine check handlin=
g");
> >>
> >>     /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
> >>     spapr_fwnmi_register();
> >> }
> >>
> >=20
> > Oops my bad... sorry for the noise.
> >=20
> >>
> >>>  =20
> >>>>      }
> >>>> =20
> >>>>      spapr->rtas_blob =3D g_malloc(spapr->rtas_size);
> >>>> @@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectCla=
ss *oc, void *data)
> >>>>      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_O=
FF;
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_ON;
> >>>>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >>>> -    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_ON;
> >>>>      spapr_caps_add_properties(smc, &error_abort);
> >>>>      smc->irq =3D &spapr_irq_dual;
> >>>>      smc->dr_phb_enabled =3D true;
> >>>> @@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(Ma=
chineClass *mc)
> >>>>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >>>>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> >>>>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_C=
AP_OFF;
> >>>> +    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] =3D SPAPR_CAP_OFF; =
=20
> >>>
> >>> This should have been put into spapr_machine_4_0_class_options(). =20
> >>
> >> ok. I will change it.
> >>
> >>>
> >>> But unless you manage to get this merged before soft-freeze (2019-07-=
02),
> >>> I'm afraid this will be a 4.2 feature. =20
> >>
> >> If there are no other comments, can this be merged to 4.1? I will send=
 a
> >> revised version with the above changes.
> >>
> >=20
> > This is David's call.
>=20
> David, can you let me know if this can be merged to 4.1 with the above
> minor changes?

Nope, sorry.  I've been away, but also this still needs more polish.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0a2bQACgkQbDjKyiDZ
s5JddQ//Qo7UsuTWrmVMk1DKcyycMzbGt2FIkyyVrUOXFk55F9jXrxdb0XkaCbbX
oBu+h+wPIMVC4+x6XstGiF2Hbyfx2yW9Cw0mPX9Ww6VxzJsBK0C58bzMeIklUeBu
PZ2lEuSHUWQ/CaUt00ug8JP46+92K6z2jqf6zzPVx1fl+c8B91ONx8QRCyFH5Xpa
jnyoyFgzA55GmJmGnhqb5gmVPO77NoKZYx/fK3v2hTRPA6qreFyJDvLLNKIAfEB4
LS8y8NRkgkR6LXwGkLyJlhCXxC1GMTKoJBUxIdJgpMSdFcZx34oECQ3rEOoaQLh1
VC0himTo2kFzXSkR2YNk32taYLSuJDH50xiuEnL6lNtwfD8dZftzQ6T82wNJ83pE
mhf1O8A+c1dJXXbSX3ahGWSGufogSgbuUXTolRqH7V9TWF1Q74DITfmFj6dRsRjY
sg0YNpbl72A7FAsTdz1D3IhxR8W1gQ1pSjhHihBOAmCT8w9dFBh39cWCpV1/9sUm
JdSXrJw+jMe07HgaQfrceOeMRVHSKbrlDaV7xyJs8aQVu5J6GfZvEiLsZii6uTXb
TddNVCr/g5DoegbY1bTC/2SC8lz4KfEdyCCnCHAGzykELiyOVEPcfodAKrw25eGf
4aiggfzoqKH1EhCnD1cwJfSDhHmDNMA/d4Ds5x87F0VcmOQy1mk=
=/olb
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--

