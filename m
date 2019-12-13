Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB6C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60ECE214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="kJXzZ6Zp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60ECE214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdvv-0000QG-0d
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ifduG-0007RP-66
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ifduE-0006Lx-Su
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:54:28 -0500
Received: from ozlabs.org ([203.11.71.1]:58045)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ifduE-0006Dq-Dm; Fri, 13 Dec 2019 00:54:26 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47Z0Gw27cBz9sPh; Fri, 13 Dec 2019 16:54:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576216456;
 bh=11FLIDYz0JdsWUJZBhjur1OD2ess6rsjdZd2jQu2AI4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kJXzZ6ZpUKs0CNqnWFTu2bAio8F5Qf+gJYx+GuW8BI0D5dKuqvrQAGE40XD4kgp0V
 fRENsNW81oU6KMNQG6Zm1tnvB2HU4i5vKYOutjQJGuE9ff7bcnRUDXWHxz+52qzRWW
 sl9M5W4GL2Hl+UXjWZ2gbz4XEMHWMXkCels1XBbc=
Date: Fri, 13 Dec 2019 16:54:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v2 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191213055409.GG207300@umbus.fritz.box>
References: <20191212055059.9399-1-bharata@linux.ibm.com>
 <20191212055059.9399-3-bharata@linux.ibm.com>
 <20191212132723.5fdfee47@bahia.tlslab.ibm.com>
 <20191213040438.GC28362@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d5ZB48mKYG2jsBgL"
Content-Disposition: inline
In-Reply-To: <20191213040438.GC28362@in.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxram@us.ibm.com,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d5ZB48mKYG2jsBgL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


65;5803;1cOn Fri, Dec 13, 2019 at 09:34:38AM +0530, Bharata B Rao wrote:
> On Thu, Dec 12, 2019 at 01:27:23PM +0100, Greg Kurz wrote:
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index f11422fc41..25e1a3446e 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1597,6 +1597,21 @@ static void spapr_machine_reset(MachineState *=
machine)
> > >      void *fdt;
> > >      int rc;
> > > =20
> > > +    /*
> > > +     * KVM_PPC_SVM_OFF ioctl can fail for secure guests, check and
> > > +     * exit in that case. However check for -ENOTTY explicitly
> > > +     * to ensure that we don't terminate normal guests that are
> > > +     * running on kernels which don't support this ioctl.
> > > +     *
> > > +     * Also, this ioctl returns 0 for normal guests on kernels where
> > > +     * this ioctl is supported.
> > > +     */
> > > +    rc =3D kvmppc_svm_off();
> > > +    if (rc && rc !=3D -ENOTTY) {
> >=20
> > This ioctl can also return -EINVAL if the ultravisor actually failed to=
 move
> > the guest back to non-secure mode or -EBUSY if a vCPU is still running.=
 I
> > agree that the former deserve the VM to be terminated. What about the l=
atter ?
> > Can this happen and if yes, why ? Should we try again as suggested by A=
lexey ?
> > Could this reveal a bug in QEMU, in which case we should maybe abort ?
>=20
> We are in machine reset path, so all vcpus are already paused. So we don't
> expect any vcpus to be running to handle -EBUSY here. Neither do I see any
> sane recovery path from here.

Right.  Because this path should only happen in the case of qemu (or
kernel) error, abort() would also be appropriate.  However, it's not
worth making that a separate case from the other fatal errors.

>=20
> As Alexey mentioned earlier, may be we can just stop the VM?
> Do vm_stop() with RUN_STATE_PAUSED or some such reason?
>=20
> Regards,
> Bharata.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d5ZB48mKYG2jsBgL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3zJ4AACgkQbDjKyiDZ
s5JWBhAAz0lnS1rlKzwbEa5AcL6h5NXrqkjYBfYmv5V7ID5QjYMej09p1N+qjWWA
7JNsegXfkWog86mpLnbV4ygHIAXmicPnoF9Vo8D2+/TJ2NsNiOaYIiOcrfPt5Uy+
2Rguow/1qHF2ErLwMGEFqhhqtRsi0uPDyYRRiq5fVNG6U4T8dep2aHaWyxNDeqZJ
A5/A3De3P8ZBovj1szTjRO9MG/BmZN0wIMntEWFkUOT9kBizr+2T9k18wfUUv4n6
a7MM3HjM9TChEdH2NawmSNO5dVfjkQujrtMhHYVKj62NShPak41THiv8aYQaBFVC
9oQKpFFBgYoD3svBgVxAI/uBye5LmTbHruMnMJQGjqkMwreURxM6nyYm/dkd/X93
8JL+koNOWcM95MzGoll53YZhPnvmwpQatTm+mTI2rWorET15TkN+dxSQEgPUptqW
ThE29rZho8QLZjCtFvxZFUHl5gIYl1cvgRBSOPdPKSkM9FWivtCWVsFUmwK6l9G5
C2q3Fm2quDsAB9Wu0uAqnghTEDYAYo4dpLQbyLziJ/qyAos/qaspnfOrTcalFKKo
N81lySuq3/po4QepslZvV96JRFbuGEtKrjfl8cccEsz1vb8KuzR+1Ec1cmdcfT1E
hkyU0+z/wAopcnSdaiqS0mdt9/K74MJ4yI4xGkE85p3s7tVaBvQ=
=/Si0
-----END PGP SIGNATURE-----

--d5ZB48mKYG2jsBgL--

