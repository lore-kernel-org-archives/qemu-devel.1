Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C78C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:13:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D40221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 11:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I46cRYFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D40221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGjg-0008F6-Nx
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 06:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaGgn-0004Ry-2M
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaGgk-0008GS-Qz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 06:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604488248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUIXBXIPo0eR+eyxY9YTLCJI3mWD4fORO+1dRYXClyQ=;
 b=I46cRYFmH6H96aDm97e3l1RpIvvOxKZuVOaoub5BQX+aTvBWhXI/RSUBPdqTiYg4CI3Z6p
 29Grz8T50QEMiBMAPwnykOTCcTzoyVjhq8HZ6upJShkYQZcIK7w3knCv1lD6uGtiUGCehO
 2gBVewbqXDNsTWwhSVm06374gGp8JZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-pDADO__4O92qKNY92vKcSw-1; Wed, 04 Nov 2020 06:10:45 -0500
X-MC-Unique: pDADO__4O92qKNY92vKcSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6163101F009;
 Wed,  4 Nov 2020 11:10:43 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F087F8C8;
 Wed,  4 Nov 2020 11:10:25 +0000 (UTC)
Date: Wed, 4 Nov 2020 10:13:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104101356.GC390503@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ly5z6m79c0.fsf@redhat.com> <20201103153356.GO205187@redhat.com>
 <20201103103135.7da0a9c5@w520.home>
MIME-Version: 1.0
In-Reply-To: <20201103103135.7da0a9c5@w520.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 10:31:35AM -0700, Alex Williamson wrote:
> On Tue, 3 Nov 2020 15:33:56 +0000
> Daniel P. Berrang=E9 <berrange@redhat.com> wrote:
>=20
> > On Tue, Nov 03, 2020 at 04:23:43PM +0100, Christophe de Dinechin wrote:
> > >=20
> > > On 2020-11-02 at 12:11 CET, Stefan Hajnoczi wrote... =20
> > > > There is discussion about VFIO migration in the "Re: Out-of-Process
> > > > Device Emulation session at KVM Forum 2020" thread. The current sta=
tus
> > > > is that Kirti proposed a VFIO device region type for saving and loa=
ding
> > > > device state. There is currently no guidance on migrating between
> > > > different device versions or device implementations from different
> > > > vendors. This is known to be non-trivial and raised discussion abou=
t
> > > > whether it should really be handled by VFIO or centralized in QEMU.
> > > >
> > > > Below is a document that describes how to ensure migration compatib=
ility
> > > > in VFIO. It does not require changes to the VFIO migration interfac=
e. It
> > > > can be used for both VFIO/mdev kernel devices and vfio-user devices=
.
> > > >
> > > > The idea is that the device state blob is opaque to the VMM but the=
 same
> > > > level of migration compatibility that exists today is still availab=
le.
> > > >
> > > > I hope this will help us reach consensus and let us discuss specifi=
cs.
> > > >
> > > > If you followed the previous discussion, I changed the approach fro=
m
> > > > sending a magic constant in the device state blob to identifying de=
vice
> > > > models by URIs. Therefore the device state structure does not need =
to be
> > > > defined here - the critical information for ensuring device migrati=
on
> > > > compatibility is the device model and configuration defined below.
> > > >
> > > > Stefan
> > > > ---
> > > > VFIO Migration
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > This document describes how to save and load VFIO device states. Sa=
ving a
> > > > device state produces a snapshot of a VFIO device's state that can =
be loaded
> > > > again at a later point in time to resume the device from the snapsh=
ot.
> > > >
> > > > The data representation of the device state is outside the scope of=
 this
> > > > document.
> > > >
> > > > Overview
> > > > --------
> > > > The purpose of device states is to save the device at a point in ti=
me and then
> > > > restore the device back to the saved state later. This is more chal=
lenging than
> > > > it first appears.
> > > >
> > > > The process of saving a device state and loading it later is called
> > > > *migration*. The state may be loaded by the same device that saved =
it or by a
> > > > new instance of the device, possibly running on a different compute=
r.
> > > >
> > > > It must be possible to migrate to a newer implementation of the dev=
ice
> > > > as well as to an older implementation of the device. This allows us=
ers
> > > > to upgrade and roll back their systems.
> > > >
> > > > Migration can fail if loading the device state is not possible. It =
should fail
> > > > early with a clear error message. It must not appear to complete bu=
t leave the
> > > > device inoperable due to a migration problem.
> > > >
> > > > The rest of this document describes how these requirements can be m=
et.
> > > >
> > > > Device Models
> > > > -------------
> > > > Devices have a *hardware interface* consisting of hardware register=
s,
> > > > interrupts, and so on.
> > > >
> > > > The hardware interface together with the device state representatio=
n is called
> > > > a *device model*. Device models can be assigned URIs such as
> > > > https://qemu.org/devices/e1000e to uniquely identify them. =20
> > >=20
> > > Like others, I think we should either
> > >=20
> > > a) Give a relatively strong requirement regarding what is at the URL =
in
> > > question, e.g. docs, maybe even a machine-readable schema describing
> > > configuration and state for the device. Leaving the option "there can=
 be
> > > nothing here" is IMO asking for trouble.
> > >=20
> > > b) simply call that a unique ID, and then either drop the https: enti=
rely or
> > > use something else, like pci:// or, to be more specific, vfio://
> > >=20
> > > I'd favor option (b) for a different practical reason. URLs are subje=
ct to
> > > redirection and other mishaps. For example, using https:// begs the q=
uestion
> > > whether
> > > https://qemu.org/devices/e1000e and
> > > https://www.qemu.org/devices/e1000e
> > > should be treated as the same device. I believe that your intent is t=
hat
> > > they shouldn't, but if the qemu web server redirects to www, and some=
one
> > > wants to copy-paste their web browser's URL bar to the command line, =
they'd
> > > get the wrong one. =20
> >=20
> > That's not a real world problem IMHO, because neither of these URLs
> > ever need resolve to a real webpage, and thus not need to be cut +
> > paste from a browser.
> >=20
> > They are simply expressing a resource identifier using a URI as a
> > convenient format. This is the same as an XML namespace using a URI,
> > and rarely, if ever, resolving to any actual web page.
> >=20
> > This is a good thing, because if you say there needs to be a real page
> > there, then it creates a pile of corporate beaurocracy for contributors=
.
> > I can freely create a URI under https://redhat.com for purposes of bein=
g
> > a identifier, but I cannot get any content published there without jump=
ing
> > through many tedious corporate approvals and stand a good chance of bei=
ng
> > rejected.
> >=20
> > If we're truely treating the URIs as an opaque string, we don't especia=
lly
> > need to define any rules other than to say it should be under a domain =
that
> > you have authority over either directly, or via membership of a project
> > that delegates. We can suggest "https" since seeing "http" is a red fla=
g
> > for many people these days.
>=20
> Hmm, an opaque string, sort of like the existing "name" attribute we
> have now where Christophe quoted some examples in his message.  Thanks,

Let's go for b) in the next revision.

There will still be a structure <domain>/<path> but it won't be a URI
with a scheme ("https"). The reason for keeping a structure and not
simply declaring it a unique opaque string is that it's hard to
ensure uniqueness if there is no structure. Two people might
accidentally choose the same name, so let's keep the domain and path
there.

Stefan

--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ifuQACgkQnKSrs4Gr
c8j+lgf/bQjsd51if0gLjC3dzklM7ZA73av/8ZDlwKT3oVO2kYVlrGn43o/iujXM
hYRGubnF6Pq8vESY8IvW1Acout/6Mwg+tGBeL8a9Zy5LTUsoDBhZCKl0ooD8WIUz
63vDIK42QSIaXjZqHDS3XpX9gyz+FznrACO2W28XE7e7lkDTU+a05HF9AAV6T0oP
wHgMj6JxQYQ0TJ1/xkdt1AH7kPCuKr5H/M1no2/qb+66KPV3m17WK8fTOY47673/
D4JdXDWZ5dzDfM4U+AwLfsJhdP9KypzPByREOPJa4ZSZSjMKoq0lx+cwBl7A4eL7
HwKRxzg51SFF37AYVdiJVcdTUOM+ZA==
=l1Fd
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--


