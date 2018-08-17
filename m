Received: from eggs.gnu.org ([2001:4830:134:3::10]:48631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqeKU-0002ra-UG
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqeKR-00027e-OE
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:58:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52034 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqeKR-00027W-JX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 08:58:11 -0400
Date: Fri, 17 Aug 2018 13:58:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817125808.GO11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
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

On Fri, Aug 17, 2018 at 08:44:36AM -0400, Phillip Susi wrote:
> On 8/17/2018 4:56 AM, Daniel P. Berrang=C3=A9 wrote:
> > Oh one other thing, is whether your QEMU process has an explicit keym=
ap
> > configured (this is the -k arg to QEMU), as when that it set, it
> > completely changes the way keyboard input is handled in VNC. That cod=
e
> > has also been massively refactored recently.
>=20
> I'm not using that argument.  I just checked the man page and it says i=
t
> defaults to en-us, which should be correct.

Actually for QEMU there is no default localized keymap. This is desirable
because it allows VNC to activate its raw scancode extension which is mor=
e
reliable than passing translated X11 key symbols.

I guess there's a chance that Xen might secretly pass a '-k' arg anyway,
but hopefully it doesn't...


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
