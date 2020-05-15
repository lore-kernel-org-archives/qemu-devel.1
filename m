Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2293C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 01:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7912054F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 01:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DwlwBHhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7912054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZPZ0-00065N-FY
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 21:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZPXl-0005Ed-Gg; Thu, 14 May 2020 21:53:45 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:45803 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jZPXi-0001Mg-Op; Thu, 14 May 2020 21:53:44 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49NWdj4nlDz9sSk; Fri, 15 May 2020 11:53:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1589507593;
 bh=8+HDl0+Mb9/gGf6aZeh8gPCrbogAfW1EuRBO8TNJsC0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DwlwBHhbmTR7yM2M4GNJQvX6qrk/w6o5PEueg45XJz8SY/EMZ3vfjYeFo41AlRAZe
 /dyqWsHcySTMELY2rdCKIlO/t2WBjowTZH845N4COQ22qcj8SLuQn7hqDnwKUcLQpx
 jk3TZeTfwWBeqFvC6FJgvBruouH16jU+pbSXefbQ=
Date: Fri, 15 May 2020 10:20:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC 16/18] use errp for gmpo kvm_init
Message-ID: <20200515002046.GG2183@umbus.fritz.box>
References: <20200514064120.449050-1-david@gibson.dropbear.id.au>
 <20200514064120.449050-17-david@gibson.dropbear.id.au>
 <20200514170808.GS2787@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oPYnW2SrAqZUvu4n"
Content-Disposition: inline
In-Reply-To: <20200514170808.GS2787@work-vm>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: brijesh.singh@amd.com, frankja@linux.ibm.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--oPYnW2SrAqZUvu4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2020 at 06:09:46PM +0100, Dr. David Alan Gilbert wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
[snip]
> > @@ -649,20 +649,20 @@ static int sev_kvm_init(GuestMemoryProtection *gm=
po)
> >      devname =3D object_property_get_str(OBJECT(sev), "sev-device", NUL=
L);
> >      sev->sev_fd =3D open(devname, O_RDWR);
> >      if (sev->sev_fd < 0) {
> > -        error_report("%s: Failed to open %s '%s'", __func__,
> > -                     devname, strerror(errno));
> > -    }
> > -    g_free(devname);
> > -    if (sev->sev_fd < 0) {
> > +        g_free(devname);
> > +        error_setg(errp, "%s: Failed to open %s '%s'", __func__,
> > +                   devname, strerror(errno));
> > +        g_free(devname);
>=20
> You seem to have double free'd devname - would g_autofree work here?

Oops, fixed.  I'm not really familiar with the g_autofree stuff as
yet, so, maybe?

I also entirely forgot to write a non-placeholder commit message for
this patch.  Oops.

> other than that, looks OK to me.



>=20
> Dave
>=20
> >          goto err;
> >      }
> > +    g_free(devname);
> > =20
> >      ret =3D sev_platform_ioctl(sev->sev_fd, SEV_PLATFORM_STATUS, &stat=
us,
> >                               &fw_error);
> >      if (ret) {
> > -        error_report("%s: failed to get platform status ret=3D%d "
> > -                     "fw_error=3D'%d: %s'", __func__, ret, fw_error,
> > -                     fw_error_to_str(fw_error));
> > +        error_setg(errp, "%s: failed to get platform status ret=3D%d "
> > +                   "fw_error=3D'%d: %s'", __func__, ret, fw_error,
> > +                   fw_error_to_str(fw_error));
> >          goto err;
> >      }
> >      sev->build_id =3D status.build;
> > @@ -672,14 +672,14 @@ static int sev_kvm_init(GuestMemoryProtection *gm=
po)
> >      trace_kvm_sev_init();
> >      ret =3D sev_ioctl(sev->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
> >      if (ret) {
> > -        error_report("%s: failed to initialize ret=3D%d fw_error=3D%d =
'%s'",
> > -                     __func__, ret, fw_error, fw_error_to_str(fw_error=
));
> > +        error_setg(errp, "%s: failed to initialize ret=3D%d fw_error=
=3D%d '%s'",
> > +                   __func__, ret, fw_error, fw_error_to_str(fw_error));
> >          goto err;
> >      }
> > =20
> >      ret =3D sev_launch_start(sev);
> >      if (ret) {
> > -        error_report("%s: failed to create encryption context", __func=
__);
> > +        error_setg(errp, "%s: failed to create encryption context", __=
func__);
> >          goto err;
> >      }
> > =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oPYnW2SrAqZUvu4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl694F4ACgkQbDjKyiDZ
s5Ld6RAAjjnTBYvSoeB8OguHxaf+Op4h3GWm9edsFHpqqsdGRwW/1Hfn+MvCi24F
iV0iUPhksKarxOnsgmfbKDNe0onkjiQf3CmwmhNLX6urRkpDj5H+k2fWQuVa7dTe
jdkIrcNdVWPuEU1GgNbWSSMGWMfQ2XmIJxvgVPMGYgvDoH2gwjN8oVprVcOw9NO/
HF7hCGwwZs22x1qLXmrvBPQOeOQ2lh4s38DBGoeJJPIsivumdoJNac9TrHxAetDc
/Rqy//xMtLFtB8lvDxDLJsvrZvX+yjdLTjqtV4U4WXEpTXA4+nWbFyTndgcdCVkH
RB+IAdVEXAReCyrSc8JL25rgB41j18xb9lSCLKlh6Hel9Q6jUQzLN8xudAdfigBT
9akUvOW/8FWT8fjKfoBjwfcG5Qo2FbomEsX453Qg9jFpJopJ0eKucomxiKb3jbrR
IrvjPU+8H+m0lREMQp+2IrVABT5GUunMQzrIxx0UjNSGqjafjSaRdb9ylmebPSni
NgAIf1Q1RFHVzHLLXFR8PD/i09Z3W3QMBVBcOR8LR8SjH/sRcwZA67kKD9zcOrn1
x2o9PEZ4dOBhIS7ANBzqlIRbJK2tiQ79tijUbQLLvbQHhEtvm3kKyUcp+361V+lS
T5C6gTaO1R1zZf68S/lXPO3w6ftT+2RCyC5DiXg3ObHRpY7eUqQ=
=z7mk
-----END PGP SIGNATURE-----

--oPYnW2SrAqZUvu4n--

