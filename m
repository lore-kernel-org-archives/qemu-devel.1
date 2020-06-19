Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87321C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5317220771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 01:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HOncGrgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5317220771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm5QZ-0003VL-KC
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 21:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm5Pa-0002JV-7W; Thu, 18 Jun 2020 21:01:42 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:35617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jm5PW-0007hO-B9; Thu, 18 Jun 2020 21:01:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49p0qv0X1tz9sR4; Fri, 19 Jun 2020 11:01:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592528491;
 bh=0+jSeCoiuy/+UjDaDaJIABDhYyK0PGMqi04PwiwV++I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HOncGrgSCwTGQWC8cRK4Pzex0GOlqIs5Zyi5PWc7UHnpDl4DUhgdsfz5Fk8gH19em
 ho1VOtlp2myA7UvP6L6FHAwhw6pvmAaejaCfaf+yZPyWHCfDyVPgc6cqOQouc2u5Ku
 JT1P+IYIhQnN+ib7q8LnMhmnj4sAm+P3iBR32zdU=
Date: Fri, 19 Jun 2020 10:59:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200619005910.GG17085@umbus.fritz.box>
References: <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
 <20200609182839.7ac80938.pasic@linux.ibm.com>
 <20200610042929.GE494336@umbus.fritz.box>
 <20200610155703.661aca83.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20200610155703.661aca83.pasic@linux.ibm.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 03:57:03PM +0200, Halil Pasic wrote:
> On Wed, 10 Jun 2020 14:29:29 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 09, 2020 at 06:28:39PM +0200, Halil Pasic wrote:
> > > On Tue, 9 Jun 2020 17:47:47 +0200
> > > Claudio Imbrenda <imbrenda@linux.ibm.com> wrote:
> > >=20
> > > > On Tue, 9 Jun 2020 11:41:30 +0200
> > > > Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > I don't know. Janosch could answer that, but he is on vacation. A=
dding
> > > > > Claudio maybe he can answer. My understanding is, that while it m=
ight
> > > > > be possible, it is ugly at best. The ability to do a transition is
> > > > > indicated by a CPU model feature. Indicating the feature to the g=
uest
> > > > > and then failing the transition sounds wrong to me.
> > > >=20
> > > > I agree. If the feature is advertised, then it has to work. I don't
> > > > think we even have an architected way to fail the transition for th=
at
> > > > reason.
> > > >=20
> > > > What __could__ be done is to prevent qemu from even starting if an
> > > > incompatible device is specified together with PV.
> > >=20
> > > AFAIU, the "specified together with PV" is the problem here. Currently
> > > we don't "specify PV" but PV is just a capability that is managed by =
the
> > > CPU model (like so many other). I.e. the fact that the
> > > visualization environment is capable providing PV (unpack facility
> > > available), and the fact, that the end user didn't fence the unpack
> > > facility, does not mean, the user is dead set to use PV.
> > >=20
> > > My understanding is, that we want PV to just work, without having to
> > > put together a peculiar VM definition that says: this is going to be
> > > used as a PV VM.
> >=20
> > Having had a similar discussion for POWER, I no longer think this is a
> > wise model.  I think we want to have an explicit "allow PV" option -
> > but we do want it to be a *single* option, rather than having to
> > change configuration of a whole bunch of places.
> >=20
> > My intention is for my 'host-trust-limitation' series to accomplish
> > that.
>=20
> Dave, many thanks for your input. I would be interested to read up that
> discussion you hand for POWER to try to catch the train of thought. Can
> you give me a pointer?

Urgh.. not really.. it was spread out over several discussions, some
of which were on IRC or Slack, rather than email.

> My current understanding is that s390x already has the "allow PV" option,
> which is the CPU model feature. But its dynamics is just like the
> dynamics of other CPU model features, in a sense that you may have to
> disable it explicitly.
>=20
> Our problem is, that iommu_platform=3Don comes at a price point for us,
> and we don't want to enforce it when it is not needed. And if the guest
> does not decide to do the transition to protected, it is not needed.
>=20
> Thus any scheme were we pessimise based on the sheer possibility of
> protected virtualization seems wrong to me.

Hrm, I see your point.  So... I guess my thinking is that although the
strict meaning of the proposed host-trust-limitation option is just
that "protection _can_ be used, at the guest/platform's option", it is
a strong hint that we're expecting protection to be used.

So would this work for s390:
  * The cpu feature remains, as now, enabled by default
  * The host-trust-limitation option would apply the protection
    necessary virtio options (and any other changes to defaults we
    discover we need), just as it does for SEV and POWER PEF
  * Optionally, the s390 machine type code could error out if
    host-trust-limitation is specified, but the cpu option is
    explicitly disabled

> The sad thing is that QEMU has every information it needs to do what is
> best: for paravirtualized devices
> * use F_ACCESS_PLATFORM when needed, to make the guest work harder and
> work around the access restrictions imposed by memory protection, and=20
> * don't use F_ACCESS_PLATFORM when when not needed, and allow for
>   optimization based on the fact that no such access restrictions exist.

Right.. IIUC you're suggesting delaying finalization of the device's
featureset until the guest driver actually starts probing it

> Sure we can burden up the user, to tell us if the VM is intended to be
> used with memory protection or not. But what does it buy us? The
> opportunity to create dodgy configurations?

So, I don't know what the situation is with z, but for POWER machines
with the ultravisor running are rare (read, not actually available
outside IBM yet), and not directly tied to a cpu version (obviously
you need a cpu with support, but you also need to actually be running
under an ultravisor, which is optional).  So what are our options:

1) Require explicitly enabling PEF support - this is burdening the
   user, as you say, but..

2) Allow by default - but fail if the host doesn't have support.  That
   means explicitly *disabling* on non-ultravisor machines, a much
   bigger imposition on the user

3) Enable conditionally depending on host support.  Seems nice, but
   it's badly broken, as we've found with previous times we've tried
   to automatically do things based on host capabilities.  The problem
   is that once you have this, it's not obvious without knowing a
   bunch about the hosts which ones it will be safe to migrate
   between.  That horribly breaks things like RHV that want to do load
   balancing migrations within a cluster

Basically having different guest-visible features depending on host
properties is just unworkable, which brings us back to (1) being the
least bad option.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7sDdwACgkQbDjKyiDZ
s5L1VxAAzHq5X0XQIIny0bQLXASlTiH0H5fmspZDt+/1tyU3hfJFdZv8ftPM9v1n
2ITVM0TeEW2Sc6MjM5BuxF4t+MAKN4D7PEGrZN9wCugt/nm3sCU/DHcqyQ0t55Z+
cSxCMWNyyL5sLM2X7nljVQfoPxJBNLvgBf/ZwGWhKGFThPBIBdeAQDbD6fY1PNwt
ph9MJYoNlmf/n0Pa0XYS33EfFKFFcMq4mf3dMJ5FXaGW87UhNWRixXn322YF5lNb
rgiaICYqKhGndukY7rMLp4w5mA7h1bbNihkA+6Sx3kiT1NJrHJKA4jR2NXAYDwbB
EYwkM88OpADF7TLZ6kh+Z37KGZv4PQpvIqGUr6Y9g+mveVW+OcC2/Sfxx8B8wIZv
4FpHPgtjQxRlGaHI4+CZHCA3txRtWRNG6kTkqEdtWuoteDO6+Udptv0XWegsU3Zz
3lWc6Xb0GK1/USdjZFUF8E9jGBa3XpHKvyCKETEuVPRsmKkqPUl7viX3BDjolU3T
0FXPl475GrtI0to+s7nW6QuOBh/0KMZjURz5QmgjLyQtCJlRdA73LrEq4sQRg6Ag
qp2zmunUCtibW5jprNoqRUZxzAIy5ofihOosDJjows3hqxGF+Rfi5Nb87upG19Km
r7DhiuHIqQes1ZtvGwCV6fnnXM5+ZLh7MMYn0hC7iVKoPQusoOs=
=D595
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--

