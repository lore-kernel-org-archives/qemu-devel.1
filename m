Received: from eggs.gnu.org ([2001:4830:134:3::10]:55237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvL8-0007te-A4
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvL7-0003gj-9D
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:37:14 -0400
Date: Tue, 25 Jul 2017 09:37:01 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725083701.GD26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170724182751.18261-10-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 09/35] ui/vnc: fix leak of
 SocketAddress **
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Mon, Jul 24, 2017 at 03:27:25PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Extract the (correct) cleaning code as a new function vnc_free_addresse=
s() then
> use it to remove the memory leaks.
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  ui/vnc.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
