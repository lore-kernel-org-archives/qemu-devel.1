Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDA8C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 00:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F07520773
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 00:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="J707pin2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDclN-0002UW-8Z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 20:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDckg-0001rX-47; Wed, 02 Sep 2020 20:05:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54349 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kDckc-0000a0-I2; Wed, 02 Sep 2020 20:05:17 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bhgzm1Zg7z9sTh; Thu,  3 Sep 2020 10:05:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599091508;
 bh=CgdKZiIv/Rj/ZHU+vo/A1+uGi32f1sg6Q7Q3r1QU3JE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J707pin2EMlA4r6OEV8Ygg8U48gR8GpNbWk0BH0T8XWXmxhyJIUHQ85sFxHRLrqj5
 Gq85yDILGDYZbBsL0ROnLCpYtmrFOfT1hc5LvcMQq4UeEaUZ5gL/yD+J+39jaycqgn
 Vse2ZflLfx3PADyvN8B2F/SokYt6oXSqLTO7GV+M=
Date: Thu, 3 Sep 2020 09:57:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC v8 5/5] memory: Skip bad range assertion if notifier is
 DEVIOTLB type
Message-ID: <20200902235737.GF1897@yekko.fritz.box>
References: <20200901142608.24481-1-eperezma@redhat.com>
 <20200901142608.24481-6-eperezma@redhat.com>
 <44d9e8a5-79fa-11c8-9ec1-4c3d76929408@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <44d9e8a5-79fa-11c8-9ec1-4c3d76929408@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 20:05:08
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2020 at 04:24:50PM +0200, Auger Eric wrote:
> Hi Eugenio,
>=20
> On 9/1/20 4:26 PM, Eugenio P=E9rez wrote:
> > Signed-off-by: Eugenio P=E9rez <eperezma@redhat.com>
> Please could you explain in the commit message why you need to remove
> the assert()? I know you described the assert() in the cover letter but
> the commit msg is the one that remains.

Right... neither in the cover letter nor the individual patches,
AFAICT, does anything actually explain why that assert() could be
hit.  Nor does it connect the dots from an assert() hitting to adding
infrastructure for a new event type.

> > ---
> >  softmmu/memory.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/softmmu/memory.c b/softmmu/memory.c
> > index 09b3443eac..3ee99b4dc0 100644
> > --- a/softmmu/memory.c
> > +++ b/softmmu/memory.c
> > @@ -1895,6 +1895,7 @@ void memory_region_notify_iommu_one(IOMMUNotifier=
 *notifier,
> >  {
> >      IOMMUTLBEntry *entry =3D &event->entry;
> >      hwaddr entry_end =3D entry->iova + entry->addr_mask;
> > +    IOMMUTLBEntry tmp =3D *entry;
> > =20
> >      /*
> >       * Skip the notification if the notification does not overlap
> > @@ -1904,10 +1905,18 @@ void memory_region_notify_iommu_one(IOMMUNotifi=
er *notifier,
> >          return;
> >      }
> > =20
> > -    assert(entry->iova >=3D notifier->start && entry_end <=3D notifier=
->end);
> > +    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB) {
> > +        /* Crop (iova, addr_mask) to range */
> > +        tmp.iova =3D MAX(tmp.iova, notifier->start);
> > +        tmp.addr_mask =3D MIN(entry_end, notifier->end) - tmp.iova;
> > +        /* Confirm no underflow */
> > +        assert(MIN(entry_end, notifier->end) >=3D tmp.iova);
> > +    } else {
> > +        assert(entry->iova >=3D notifier->start && entry_end <=3D noti=
fier->end);
> > +    }
> > =20
> >      if (event->type & notifier->notifier_flags) {
> > -        notifier->notify(notifier, entry);
> > +        notifier->notify(notifier, &tmp);
> >      }
> >  }
> > =20
> >=20
> Thanks
>=20
> Eric
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TU+u6i6jrDPzmlWF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl9QMW8ACgkQbDjKyiDZ
s5JyRw//U5bGlLAunPO1A1Lj43tv+Yj1GQOFr58RvdIhYGayAGdNmh/fBhkIaLaw
LEG8fMXhpjPBsH/FaQ7LaXErPJ9rnWv9PWSecn2+R9vDzPN/dASI08wiDpZaLwyb
NoeiDXjPsIClyYuaYy4SH0TTu8yF8cUOTiC8zdjEqV9BOq2q01G5pNU6qKtiRWxV
zCgenT+L9zF6B0G8CkWoDuXB8ffxbHj72BMSMGxatjSTRxohQbJPQdUR+NTNP/+7
6EWxS5STL08Yn2JrLKh9f/mtLvRijOTBS86tXRvonkriRB0N/gkW0jGXfjKDpEfM
gUdzs5F8ZdvVdFY7YZrHAQuyTetibHbUHeL64dM7meuzKgCYe5ggUvl71h91+nbO
qPu4cJlAeYtz8So1IA2/H8iAJVYff2wcUSHSIdDJucVmIqRKOkIDDH20PQaGnJ8Y
n5zFu0lRrJs48eWevhxRTDeghu4wAXEUPsjKkuH8MPDXV7ciWXl5IP+mpaAfovPh
TytIZlBOPYlBGRugXUDFqhrokz+p5ky9baaXZizCfjgjBmru9Zfa6qcvyaOr0ZwP
9BxtMqWNJA6VXMdN5odyAfBp9HIbRyl17lqynmy1bhH2P9An7020T01GtGw7ykKK
RRxo8gpXCI0FF2G4dqatpmn+lnhjGKP8aEQTJDXqlO9IMwbmHFA=
=5cD7
-----END PGP SIGNATURE-----

--TU+u6i6jrDPzmlWF--

