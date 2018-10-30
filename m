Received: from eggs.gnu.org ([2001:4830:134:3::10]:35607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHYK8-0005nk-TC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gHYK5-0001cO-A7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gHYK5-0001bm-00
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB1AF307DAA1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:00:59 +0000 (UTC)
Date: Tue, 30 Oct 2018 18:00:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181030180050.GD3541@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
	<20181029091244.mgq4xhodjv62quof@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029091244.mgq4xhodjv62quof@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] cirrus: mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On Mon, Oct 29, 2018 at 10:12:44AM +0100, Gerd Hoffmann wrote:
> On Thu, Oct 25, 2018 at 09:37:58PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> > > While being at it deprecate cirrus too.
> > >=20
> > > Reason (short version): use stdvga instead.
> > > Verbose version:
> > >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considere=
d-harmful
> >=20
> > Every single one of my guests is using cirrus. This wasn't an explici=
t
> > choice on my part, so I believe it is being used as the default in
> > virt-install.
> >=20
> > I don't debate the points in the blog post above that stdvga is a
> > better choice, but I don't think that's enough to justify deprecating
> > cirrus at this point in time, because when it then gets deleted it
> > will break way too many existing deployments.
> >=20
> > We need to socialize info in that blog post above more widely and
> > especially ensure that apps are not using that by default. I don't
> > see it being viable to formally deprecate it in QEMU any time soon
> > though given existing usage.
>=20
> Well, getting that message to the users is the point of deprecating it.
> I think in this specific case we'll need a longer (maybe much longer)
> deprecation period than only two releases.  But I think it still makes
> sense to deprecate it now.

As mentioned elsewhere in this thread, I think it is important that
QEMU distinction between devices that are best practice / recommended
for use with KVM virt, vs devices that exist solely for sake of
emulating hardware for use with old platforms.

I agree that cirrus doesn't have a place in a KVM guest for future,
but I don't thjink that means it should be deprecated & removed from
QEMU entirely, as its still relevant from POV of QEMU's goal to
emulate old hardware platforms.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
