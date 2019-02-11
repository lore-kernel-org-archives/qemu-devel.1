Received: from eggs.gnu.org ([209.51.188.92]:41785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt6S6-0003MZ-8a
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 02:56:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt6Ry-0001gL-MG
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 02:56:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gt6Rv-0001ff-Gr
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 02:56:20 -0500
References: <CABLmASFLwswYELUGHKjZct6XnEYb4tKn1XEuCAgwniN7NM110g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0be24d4d-19e3-0c4a-e414-ed61b043f1cb@redhat.com>
Date: Mon, 11 Feb 2019 08:56:11 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASFLwswYELUGHKjZct6XnEYb4tKn1XEuCAgwniN7NM110g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Bug: Lost slirp functionality on qemu-system-ppc
 build for windows.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On 2019-02-10 23:12, Howard Spoelstra wrote:
> Hi,
>=20
> I just cross compiled Qemu-system-ppc for Windows on Fedora 29 and
> discovered slirp does not work anymore. Tap networking works fine.
> Bisecting got me here:
>=20
> a9d8b3ec4385793815d7121785730422fa3dfb68 is the first bad commit
> commit a9d8b3ec4385793815d7121785730422fa3dfb68
> Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Date:   Thu Jan 17 15:43:52 2019 +0400
>=20
>     slirp: replace remaining qemu headers dependency
>=20
>     Except for the migration code which is gated by WITH_QEMU, only
>     include our own headers, so libslirp can be built standalone.
>=20
>     Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>=20
> :040000 040000 cd06df21ed96497cd12f2a20adb3d66cb0da8010
> ab5afd3f50910e39b2b700722cd47de8f0cf9e2c M    slirp

Thanks for bisecting the issue already! ... adding Marc-Andr=C3=A9 and Sa=
muel
to the thread, maybe they have a clue what might be wrong here...

 Thomas
