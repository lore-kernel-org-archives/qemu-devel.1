Received: from eggs.gnu.org ([209.51.188.92]:44471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqdkI-0002HH-9g
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqdkG-00049x-Aa
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 07:53:06 -0500
Date: Mon, 4 Feb 2019 12:52:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190204125254.GI1905@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1549282241-23535-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1549282241-23535-1-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] ui/sdl_keysym: Remove obsolete SDL1.2
 related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Mon, Feb 04, 2019 at 01:10:41PM +0100, Thomas Huth wrote:
> sdl_keysym.h has only been included by sdl.c which has recently been
> removed recently with this commit:
>=20
>   0015ca5cbabe0b31d31610ddfaafd90a9e5911a4
>   ("ui: remove support for SDL1.2 in favour of SDL2")
>=20
> So we can drop this header file now completely, too.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: The file is now removed completely.
>=20
>  ui/sdl_keysym.h | 278 ------------------------------------------------=
--------
>  1 file changed, 278 deletions(-)
>  delete mode 100644 ui/sdl_keysym.h

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
