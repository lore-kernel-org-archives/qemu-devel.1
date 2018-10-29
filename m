Received: from eggs.gnu.org ([2001:4830:134:3::10]:46199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3bT-0007q5-BX
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3bO-00050H-9m
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:12:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH3bM-0004zr-Vf
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:12:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEC1BC050E19
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 09:12:47 +0000 (UTC)
Date: Mon, 29 Oct 2018 10:12:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029091244.mgq4xhodjv62quof@sirius.home.kraxel.org>
References: <20181025085256.20522-1-kraxel@redhat.com>
	<20181025085256.20522-4-kraxel@redhat.com>
	<20181025203758.GA29995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181025203758.GA29995@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Prasad J Pandit <ppandit@redhat.com>

On Thu, Oct 25, 2018 at 09:37:58PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Oct 25, 2018 at 10:52:56AM +0200, Gerd Hoffmann wrote:
> > While being at it deprecate cirrus too.
> >=20
> > Reason (short version): use stdvga instead.
> > Verbose version:
> >     https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-=
harmful
>=20
> Every single one of my guests is using cirrus. This wasn't an explicit
> choice on my part, so I believe it is being used as the default in
> virt-install.
>=20
> I don't debate the points in the blog post above that stdvga is a
> better choice, but I don't think that's enough to justify deprecating
> cirrus at this point in time, because when it then gets deleted it
> will break way too many existing deployments.
>=20
> We need to socialize info in that blog post above more widely and
> especially ensure that apps are not using that by default. I don't
> see it being viable to formally deprecate it in QEMU any time soon
> though given existing usage.

Well, getting that message to the users is the point of deprecating it.
I think in this specific case we'll need a longer (maybe much longer)
deprecation period than only two releases.  But I think it still makes
sense to deprecate it now.

In qemu it isn't the default any more since release 2.2.
libvirt switched the default not too long after that.
Not fully sure how things look like higher up the stack.

cheers,
  Gerd
