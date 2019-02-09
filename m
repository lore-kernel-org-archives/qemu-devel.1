Received: from eggs.gnu.org ([209.51.188.92]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSXg-0000La-P4
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gsSXa-00073B-NO
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:19:34 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gsSXZ-0006zY-33
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 08:19:30 -0500
Received: by mail-wm1-x344.google.com with SMTP id f16so8191573wmh.4
	for <qemu-devel@nongnu.org>; Sat, 09 Feb 2019 05:19:27 -0800 (PST)
MIME-Version: 1.0
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
In-Reply-To: <20181220141553.24098-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Feb 2019 14:19:13 +0100
Message-ID: <CAJ+F1CLPOKu395m=_J07H4heAs4KFLC6gNnYZLQY29RjT8tu1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/12] spice: add -display spice-app,
 setup and launch a Spice client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi

On Thu, Dec 20, 2018 at 3:44 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> The QEMU GTK UI is quite featurful. Yet, it doesn't provide many of
> the functionalities one can expect from a VM desktop application (USB
> redirection, shared folders, drag and drop, better multimonitor
> support etc.).
>
> Spice is able to export many of the VM controls to a client, including
> QMP monitor, serial ports etc... It's thus possible for a Spice client
> to provide a similar experience as the QEMU GTK UI (while keeping
> similar display performances locally) and more.
>
> This series provides "-display spice-app" to setup a Spice server and
> launch a client (associated with the spice+unix:// URI). With
> virt-viewer series "Add QEMU-like UI: VT console & basic VM state"
> (under review), the resulting user experience is close to what qemu
> GTK UI provides.
>
> v2:
> - renamed -display app -> -display spice-app
> - error if full-screen or window-close is provided (supports can be
>   added later)
> - use a stable URI when -name is provided
> - print the URI at start
> - added "qapi: document DisplayType enum"
> - added "spice: use a default name for the server"
> - commit message tweaks
> - include previously reviewed "configure: bump spice-server required
>   version to 0.12.5", to avoid conflicts
> - rebased
>

ping for reviews

(rebased version pushed on github https://github.com/elmarco/qemu/commits/s=
pice)

thanks

> Marc-Andr=C3=A9 Lureau (12):
>   configure: bump spice-server required version to 0.12.5
>   char/spice: trigger HUP event
>   char/spice: discard write() if backend is disconnected
>   spice: avoid spice runtime assert
>   spice: merge options lists
>   spice: do not stop spice if VM is paused
>   char: move SpiceChardev and open_spice_port() to spice.h header
>   char: register spice ports after spice started
>   build-sys: add gio-2.0 check
>   qapi: document DisplayType enum
>   spice: use a default name for the server
>   display: add -display spice-app launching a Spice client
>
>  qapi/ui.json            |  31 ++++++-
>  include/chardev/spice.h |  27 ++++++
>  include/ui/qemu-spice.h |   6 --
>  chardev/spice.c         |  70 +++++++-------
>  hw/display/qxl.c        |   2 -
>  ui/spice-app.c          | 200 ++++++++++++++++++++++++++++++++++++++++
>  ui/spice-core.c         |  21 +++--
>  chardev/trace-events    |   1 +
>  configure               |  17 +++-
>  qemu-options.hx         |   5 +
>  ui/Makefile.objs        |   5 +
>  11 files changed, 330 insertions(+), 55 deletions(-)
>  create mode 100644 include/chardev/spice.h
>  create mode 100644 ui/spice-app.c
>
> --
> 2.20.1.2.gb21ebb671b
>
>


--=20
Marc-Andr=C3=A9 Lureau
