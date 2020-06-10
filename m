Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C771C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FF72072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vc/kRCQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FF72072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jispo-00052I-7U
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjK-0002cE-Qh; Wed, 10 Jun 2020 00:52:50 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43345 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jisjJ-0004eW-Pi; Wed, 10 Jun 2020 00:52:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49hZFC2z6Gz9sSS; Wed, 10 Jun 2020 14:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591764367;
 bh=y7HlwqTKbDy59aiQWMeE2Z0qPBaYi75unrlWvGEsqHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vc/kRCQ9Y1JBpaPfWA5jpr+QYiND4ofQSVw9l6p3ciE2h3Ch6wn8wNVS3exmn9q1U
 3GaDHpvpS0zv42cFpTLpWknEvILdXpQA0o3Lf3GPv2lLJ0FNtme+1K1XZzYAG6DimK
 ZAUHoKUE/0SJceZz8t7mCRZiZTrhJNk71eGRZAdA=
Date: Wed, 10 Jun 2020 14:31:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200610043118.GF494336@umbus.fritz.box>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200609124155-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <20200609124155-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Viktor Mihajlovski <mihajlov@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 12:44:39PM -0400, Michael S. Tsirkin wrote:
> On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> > On Tue, 9 Jun 2020 17:47:47 +0200
> > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> >=20
> > > On Tue, 9 Jun 2020 11:41:30 +0200
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > >=20
> > > [...]
> > >=20
> > > > I don't know. Janosch could answer that, but he is on vacation. Add=
ing
> > > > Claudio maybe he can answer. My understanding is, that while it mig=
ht
> > > > be possible, it is ugly at best. The ability to do a transition is
> > > > indicated by a CPU model feature. Indicating the feature to the gue=
st
> > > > and then failing the transition sounds wrong to me.
> > >=20
> > > I agree. If the feature is advertised, then it has to work. I don't
> > > think we even have an architected way to fail the transition for that
> > > reason.
> > >=20
> > > What __could__ be done is to prevent qemu from even starting if an
> > > incompatible device is specified together with PV.
> >=20
> > AFAIU, the "specified together with PV" is the problem here. Currently
> > we don't "specify PV" but PV is just a capability that is managed by the
> > CPU model (like so many other).
>=20
> So if we want to keep it user friendly, there could be
> protection property with values on/off/auto, and auto
> would poke at host capability to figure out whether
> it's supported.
>=20
> Both virtio and CPU would inherit from that.

Right, that's what I have in mind for my 'host-trust-limitation'
property (a generalized version of the existing 'memory-encryption'
machine option).  My draft patches already set virtio properties
accordingly, it should be possible to set (default) cpu properties as
well.

> This will allow other useful features such as ability
> to hide PV from guest, which could in turn be handy e.g.
> to allow migration to hosts without PV support,
> or if host wants to force ability to read guest memory
> e.g. for security.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7gYhYACgkQbDjKyiDZ
s5JAFg//Q4OCfdVTh27/L1sMXc3cA5AqgdHQyrUNRYQo6Xl0uGJPAwqtmfNCjpX1
zhaJIycD9kf1696M0hqSe77AfFa96QrahjWn1a6Uv8GymBD2GrscEXkOX0Fosen7
OxKHlqLjXI5dejRX1IIP62C6/Xy3HxYkWKGzb1deHpciEuSnShUxqbW1blV6diaN
5N9hAQZqeLtEB16y2ct5hh0AY4pujmoHrg51D0EfCrB99Rcfeo0OXvQu2FbPNm8D
SjMmSQ2kWl+gp7yEmgDnQBVQ9824gkSbEl1v/BIWYxJ8r5KlPh4LGDu18gM6lw0j
aJNbCZEjJ+czWnJD/HPWk+AoycXHlLuAx80ZKcuvSI3RoTWm8gSOqNa95Uccgdl0
eHdKwfrmsox5BdOemZki5XQGibn0nze85zozRafqvwaqioTfFieqJWWbkOwCknqn
Z9wM/x8TBc5Mr+i50LwixdCfSHeNCMJPFTUWQdEP0xtw+Cvc1vwS0MkLgCugbWIE
D8lTdurYepitRZw7qHP5xbyquCHPOwlf5kRm8eA9oPvWxBfjgjfHqaeadRu10ywW
eLvSyDtiFyAsZ1NVEO78MoCVAfz1KBxfESIZ/OSf4qAHb1XKBfG0XnFvDtFWIkM2
H0A6//tIbswBJNBuBCAshpf1ZfPlrYO463XdVFmevfilTIfF7Kw=
=zspb
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--

