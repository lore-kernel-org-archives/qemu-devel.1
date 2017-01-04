Received: from eggs.gnu.org ([2001:4830:134:3::10]:39479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOii9-0001Ud-8c
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOii5-0001ph-HT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:22:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cOii5-0001of-BX
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 05:22:21 -0500
Date: Wed, 4 Jan 2017 10:22:14 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170104102214.GB10541@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170103191933.19416-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103191933.19416-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] win32: use glib gpoll if glib >= 2.50
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, sw@weilnetz.de

On Tue, Jan 03, 2017 at 08:19:33PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> A fix has been committed in upstream glib commit
> 210a9796f78eb90f76f1bd6a304e9fea05e97617.
> (See also related bug https://bugzilla.gnome.org/show_bug.cgi?id=3D7644=
15)

The bug is a little misleading because the comments indicate that
patch was going to be merged to master after 2.50 branched. The
git commit hash though shows it merged before branching

$ git describe 210a9796f78eb90f76f1bd6a304e9fea05e97617
2.48.0-41-g210a979

so the >=3D 2.50 check is good.

> It is desirable to use the glib version instead of qemu copy, since it
> provides more debugging facilities (G_MAIN_POLL_DEBUG etc), and
> hopefully has a better maintainance. Hopefully, we can drop the qemu
> copy in a few years.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/glib-compat.h | 2 +-
>  util/oslib-win32.c    | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
