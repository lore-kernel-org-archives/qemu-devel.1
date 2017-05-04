Received: from eggs.gnu.org ([2001:4830:134:3::10]:33565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6HXF-0003ul-5i
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6HX9-0005ZP-G3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6HX9-0005Xz-AA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:15:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E5B93D972
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 14:15:06 +0000 (UTC)
Message-ID: <1493907304.371.29.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 04 May 2017 16:15:04 +0200
In-Reply-To: <87vapgg7vh.fsf@dusky.pond.sub.org>
References: <1493888311-30839-1-git-send-email-thuth@redhat.com>
	<87vapgg7vh.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

> > -PCI UHCI USB controller and a virtual USB hub.
> > +PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1 hub.
>=20
> Do we need to say "USB-1.1 hub", or would "USB hub" do?

Makes sense to explicitly say it is 1.1 (full speed) hub, usb2+3 devices
will work either with reduced speed or not at all.

In general you want avoid the hub.  xhci can be configured with up to 15
ports, and if that isn't enough you can plug a second xhci
controller ...

> > +only works with certain host operating systems). QEMU will automatical=
ly create
> > +and connect virtual USB hubs as necessary to connect multiple USB devi=
ces.
>=20
> Extra points for updating "works only on Linux".
>=20
> Gerd, can we drop "experimental" now?

Can be dropped.

> > -Pass through the host device identified by @var{vendor_id:product_id}
> > +@item usb-host,vendorid=3D@var{vendor},productid=3D@var{product}
> > +Pass through the host device identified by @var{vendor} and @var{produ=
ct} ID
> >  (Linux only)
>=20
> Gerd, is this still Linux only?

No.  windows doesn't work, any un*x which has libusb support work, not
sure about macos.

> I figure users almost always use one of these two forms.  However, the
> code treats all four of hostbus, hostaddr, vendorid, productid as
> optional, and grabs the first device that matches.  Missing parameter
> matches anything.  Not sure how precisely we want to document that
> here.  Gerd?

docs/usb2.txt has some suggestions which combinations make sense.

>     $ qemu-system-x86_64 -nodefaults -S -usb -usbdevice serial:vendorid=
=3D403,productid=3D6001:null
>     Unexpected error in object_property_find() at /work/armbru/qemu/qom/o=
bject.c:1008:
>     upstream-qemu: -usbdevice serial:vendorid=3D403,productid=3D6001:null=
: Property '.vendorid' not found
>     Aborted (core dumped)
>=20
> Someone broke the feature.  Unless it's recent breakage, we can bury it,
> I guess.  Gerd?

In tree for a while already with nobody noticing so far.

cheers,
  Gerd
