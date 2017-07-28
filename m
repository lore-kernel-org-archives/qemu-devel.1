Received: from eggs.gnu.org ([2001:4830:134:3::10]:57249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db25C-00046Z-1l
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db256-000431-CE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db256-000421-6t
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:01:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 052E7A2920
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:01:15 +0000 (UTC)
Date: Fri, 28 Jul 2017 11:01:07 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728100107.GJ31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170727140025.392-1-kraxel@redhat.com>
	<20170727140025.392-5-kraxel@redhat.com>
	<20170727174522.GA29600@redhat.com>
	<1501222909.10943.1.camel@redhat.com>
	<20170728082826.GE31495@redhat.com>
	<1501235829.10943.11.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501235829.10943.11.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 4/7] ui: add multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Fri, Jul 28, 2017 at 11:57:09AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > > > Missing Q_KEY_CODE_MEDIASELECT entry - presumably it was supposed
> > > > to map to=C2=A0=C2=A0KEY_MEDIA
> > >=20
> > > There is KEY_SELECT too, but not KEY_MEDIASELECT.=C2=A0=C2=A0Hmm.
> >=20
> > I found a keyboard with a key labelled "Media"=C2=A0=C2=A0and when pr=
essed
> > it generates Linux key 171=C2=A0=C2=A0/ AT set1=C2=A0=C2=A00xe0 0x01 =
which is KEY_CONFIG
> > and GNOME pops up the control panel when pressed !
>=20
> Oh joy!
>=20
> I guess we should just leave that unmapped for 2.10 and sort it later
> when switching to keycodemapdb ...

Ok, I found a reference

  http://www.computer-engineering.org/ps2keyboard/scancodes1.html

Lists 'Media select' as generating 0xe0 0x6d, which corresponds
to KEY_MEDIA in Linux.

So that confirms my keyboard is simply incorrectly labelled or
wired up, as suspected.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
