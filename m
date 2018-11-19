Received: from eggs.gnu.org ([2001:4830:134:3::10]:43974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOkQE-0005Hl-Nj
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gOkQC-0001JE-3u
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:21:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gOkQB-0001Ij-Ub
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:21:04 -0500
Date: Mon, 19 Nov 2018 14:20:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181119142059.GP19532@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181119151527.4a925a75@naga>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119151527.4a925a75@naga>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'serial'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: qemu-devel@nongnu.org

On Mon, Nov 19, 2018 at 03:15:27PM +0100, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> I tried to run my VM with qemu git and I am greeted with:
>=20
> Block format 'raw' does not support the option 'serial'
>=20
> Is there any sensible reason to *not^ support disk serial number?

The 'serial' property on -drive was deprecated in QEMU 2.10, and deleted
in 3.1, as it is not a property that makes sense for the backend.

It should be set on the virtual device instead via the -device arg

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
