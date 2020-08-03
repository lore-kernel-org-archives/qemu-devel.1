Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C03C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AEE2206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Ik/uc3qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEE2206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2VKA-0007K5-WF
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2VJW-0006kg-0n; Mon, 03 Aug 2020 03:55:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:52531)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k2VJT-0000Nw-5w; Mon, 03 Aug 2020 03:55:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BKqtM6pnzz9sTY; Mon,  3 Aug 2020 17:55:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596441307;
 bh=7JloPj3FNjQOe7FT/ixSxxkTbh7G5/5b7DM4ShMDM0Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ik/uc3qDRTZEAFG7S5pMWdMzw74ZKaouFRcX6eKucL9m2hIc2sKcgy68mUYd3awB0
 /6DzmKR7ziIcHb8SFyqqnmtNaCMdKmohh+Jv7Qtz9eyxMmksvrFTS+U5kjnDJL9V67
 TF2uFhC77Epi7e6PETevLrRo7ot9ziuD0tzglnrw=
Date: Mon, 3 Aug 2020 17:54:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [for-5.2 v4 10/10] s390: Recognize host-trust-limitation option
Message-ID: <20200803075459.GC7553@yekko.fritz.box>
References: <20200724025744.69644-1-david@gibson.dropbear.id.au>
 <20200724025744.69644-11-david@gibson.dropbear.id.au>
 <8be75973-65bc-6d15-99b0-fbea9fe61c80@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <8be75973-65bc-6d15-99b0-fbea9fe61c80@linux.ibm.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, brijesh.singh@amd.com, ehabkost@redhat.com,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, pair@us.ibm.com, dgilbert@redhat.com,
 pasic@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 pbonzini@redhat.com, mdroth@linux.vnet.ibm.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 03, 2020 at 09:49:42AM +0200, Janosch Frank wrote:
> On 7/24/20 4:57 AM, David Gibson wrote:
> > At least some s390 cpu models support "Protected Virtualization" (PV),
> > a mechanism to protect guests from eavesdropping by a compromised
> > hypervisor.
> >=20
> > This is similar in function to other mechanisms like AMD's SEV and
> > POWER's PEF, which are controlled bythe "host-trust-limitation"
> > machine option.  s390 is a slightly special case, because we already
> > supported PV, simply by using a CPU model with the required feature
> > (S390_FEAT_UNPACK).
> >=20
> > To integrate this with the option used by other platforms, we
> > implement the following compromise:
> >=20
> >  - When the host-trust-limitation option is set, s390 will recognize
> >    it, verify that the CPU can support PV (failing if not) and set
> >    virtio default options necessary for encrypted or protected guests,
> >    as on other platforms.  i.e. if host-trust-limitation is set, we
> >    will either create a guest capable of entering PV mode, or fail
> >    outright
> >=20
> >  - If host-trust-limitation is not set, guest's might still be able to
> >    enter PV mode, if the CPU has the right model.  This may be a
> >    little surprising, but shouldn't actually be harmful.
>=20
> As I already explained, they have to continue to work without any change
> to the VM's configuration.

Yes.. that's what I'm saying will happen.

> Our users already expect PV to work without HTL. This feature is already
> being used and the documentation has been online for a few months. I've
> already heard enough complains because users found small errors in our
> documentation. I'm not looking forward to complains because suddenly we
> need to specify new command line arguments depending on the QEMU version.
>=20
> @Cornelia: QEMU is not my expertise, am I missing something here?

What I'm saying here is that you don't need a new option.  I'm only
suggesting we make the new option the preferred way for future
upstream releases.  (the new option has the advantage that you *just*
need to specify it, and any necessary virtio or other options to be
compatible should be handled for you).

But existing configurations should work as is (I'm not sure they do
with the current patch, because I'm not familiar with the s390 code
and have no means to test PV, but that can be sorted out before
merge).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8nwtMACgkQbDjKyiDZ
s5IsZhAAgsa3YgrlsHUiYO8nNBG1OWzfq6DKk7uhUYZWy8XflNqqMFY+8QuN1SA2
vkVTWBUsbVYjESXeK/kfAHaMPKG/fUGKE/IAQOzxnkDJa2ZJMXhuUR+UaDaeutkl
9AgOsWpIGRU0gsWEb69Vv7KMdml0tfIRFXnGd+SxI1Wq8sQmm6UF6syT7yH4BTeG
YGPSWqk9euGLoge1yc+54UvMpUmUBUT6LHgDlmPV15GSaZEKfMnB+tp3iOQpKW67
5U01bENZbwoPFBBHSNFkQ3TQs6U+M0XGXVd/EGPZtS0dRnZErufG1poCBrNK7OKg
lACG/jHy+3iZlzqTB07S+3uS/P3rYzlRSPjUnKHOVSf6Dq1D02BTsDFEpCLrK4kM
NjmznvXLa37HH4GCZS1zcZKMkTQI+gAJalSpzsR/v3AyjfyqzOmN3LCirilFknJ5
VrbyK/evU1y91N7LW/XHbv5m76+GHBU9FqBtHHK/eefF8YVQB6uSNDM+CUV/b1hk
k6JjhGvu/SE+mh+BxqbdeTvMpzEwUxZhoIzY2bdcNERuCfEChk4cm/lQ5K+/Rwyz
iFa6KmZkKS4jouWiN89Z5iJP+v48NgMoEhDhfyWnBEj+QoBx8iY3oZfs76+YEgS9
syu4mCFQIh3ixNPSfFEbxi3p4kp7MSxFHo+TSBJALsRhYbJv+TA=
=iYHb
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--

