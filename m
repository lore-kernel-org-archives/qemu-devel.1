Received: from eggs.gnu.org ([2001:4830:134:3::10]:45355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAY1G-0003wd-DB
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fAY1D-0007fi-9n
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:44:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57968 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fAY1D-0007fO-55
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:44:19 -0400
Date: Mon, 23 Apr 2018 10:44:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180423094416.GG3267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <3F07299A-A7AC-4254-B2C7-8DF15859ED58@me.com>
	<8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8503f3e9-e945-0cff-c210-72fa8f08b911@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unknown keycodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mike R <picnet@me.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Apr 23, 2018 at 05:31:28AM +0200, Thomas Huth wrote:
> On 21.04.2018 11:27, Mike R wrote:
> > (qemu) unknown keycodes `empty+aliases(qwerty)=E2=80=99, please repor=
t to qemu-devel@nongnu.org
> >=20
> > reported.
>=20
> Well, please also report:
>=20
> - Which version of QEMU are you using?
>=20
> - Which keyboard layout do you have on your physical keyboard?
>=20
> - Which key did you press to get that message?
>=20
> - Which user interface of QEMU are you using (GTK, SDL1.2, SDL2 or VNC)=
?

FYI, offlist we determined that it was QEMU 2.10 displaying over
ssh on XQuartz display server.  This is known to be broken because
QEMU historically only understands the Linux evdev & kbd keycode
mappings.

QEMU 2.12 is much improved with explicit support for XQuartz and
XWin, so hopefully the problem will be solved for this particular
case.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
