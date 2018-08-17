Received: from eggs.gnu.org ([2001:4830:134:3::10]:48766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqaZ6-0001pd-KD
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:57:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqaZ2-0001Nc-5Z
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:57:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqaZ2-0001Lv-16
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 04:57:00 -0400
Date: Fri, 17 Aug 2018 09:56:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817085656.GA11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
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

On Thu, Aug 16, 2018 at 03:44:54PM -0400, Phillip Susi wrote:
> On 8/16/2018 1:27 PM, Daniel P. Berrang=C3=A9 wrote:
> > Did you actually 'git bisect' to that commit, or is that just a guess=
 ?
>=20
> No, I haven't actually tried to build it from sources myself yet so I
> just found the source file that handles the keyboard, saw a bunch of
> scancode translation stuff in it, did a git log on that file and that
> first commit sticks out like a sore thumb; it changes the way scancodes
> are translated in a big way and the timing of it seems about right.  Th=
e
> other commits talk about fixing specific key codes that are unrelated t=
o
> pipe, and it looks like this commit threw out the code those commits
> touched anyhow and refactored the whole thing.

Oh one other thing, is whether your QEMU process has an explicit keymap
configured (this is the -k arg to QEMU), as when that it set, it
completely changes the way keyboard input is handled in VNC. That code
has also been massively refactored recently.

> > If not, could you 'git bisect' to confirm the actual commit, as there
> > have been lots of changes in this area.
>=20
> I'll try.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
