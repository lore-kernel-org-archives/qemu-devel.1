Received: from eggs.gnu.org ([2001:4830:134:3::10]:54096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqeYN-0003zP-1Q
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqeYI-0001qp-7i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:12:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42828 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqeYH-0001qP-Uz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:12:30 -0400
Date: Fri, 17 Aug 2018 14:12:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817131226.GP11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
	<b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phillip Susi <psusi@ubuntu.com>
Cc: qemu-devel@nongnu.org

On Fri, Aug 17, 2018 at 09:10:54AM -0400, Phillip Susi wrote:
> On 8/17/2018 8:58 AM, Daniel P. Berrang=C3=A9 wrote:
> > Actually for QEMU there is no default localized keymap. This is desir=
able
> > because it allows VNC to activate its raw scancode extension which is=
 more
> > reliable than passing translated X11 key symbols.
> >=20
> > I guess there's a chance that Xen might secretly pass a '-k' arg anyw=
ay,
> > but hopefully it doesn't...
>=20
> It also happens when I just run qemu.  How can I check to see if it is
> using raw scancodes or keycodes?

It depends on what the VNC client asks for too. With no '-k' arg, if the
VNC client asks for raw scancodes it'll get that, otherwise QEMU will
fallback to en-US.    GTK-VNC based clients (remote-viewer, virt-viewer,
vinagre, virt-manager, GNOME boxes) use the raw scancodes. Most other
clients do not.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
