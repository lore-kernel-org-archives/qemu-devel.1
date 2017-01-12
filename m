Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRg4V-00082I-A3
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRg4R-000547-CW
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:09:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRg4R-00053e-6D
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:09:39 -0500
Date: Thu, 12 Jan 2017 12:09:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112140936.GN3565@thinpad.lan.raisama.net>
References: <20170104205722.26492-1-marcandre.lureau@redhat.com>
	<20170112132558.GL3565@thinpad.lan.raisama.net>
	<CAP_ceTy5QZZ=by5vzfT51KyHm0M2-4_LyR-LFQk1-fQfDOVtXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAP_ceTy5QZZ=by5vzfT51KyHm0M2-4_LyR-LFQk1-fQfDOVtXw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "win32: don't run subprocess tests
 on Mingw32 platform"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jan 12, 2017 at 02:47:37PM +0100, Vincent Palatin wrote:
> On Thu, Jan 12, 2017 at 2:25 PM, Eduardo Habkost <ehabkost@redhat.com> =
wrote:
> > On Wed, Jan 04, 2017 at 09:57:22PM +0100, Marc-Andr=E9 Lureau wrote:
> >> This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.
> >>
> >> The error "Failed to execute helper program (No such file or directo=
ry)"
> >> is due to broken glib installation, missing windows gspawn helpers.
> >>
> >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >
> > Daniel, are you still unable to run subprocess tests on Migw32?
> >
> > Anybody else able to test this and send a Tested-by line?
>=20
> Works on my setup (mingw32-w64 build on Windows 10, with glib-2.46.2)
>=20
> Tested-by: Vincent Palatin <vpalatin@chromium.org>

Thanks! Unless another maintainer is already planning to apply
it, I will include it on my next pull request.

--=20
Eduardo
