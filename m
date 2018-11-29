Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJNZ-000642-IM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSJNU-0004Xj-L0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:17:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSJNU-0004XN-CR
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:17:00 -0500
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a53c96f-a712-5719-6e29-4df04b7256af@redhat.com>
Date: Thu, 29 Nov 2018 11:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181122110039.15972-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 0/4] build-sys: require Vista API
 by default globally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, samuel.thibault@ens-lyon.org, Richard Henderson <rth@twiddle.net>

On 22/11/18 12:00, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> Here is a small series improving a bit Windows headers inclusion, and
> setting the default required API version globally to Vista. It also
> allows easier tweaking of available API version via CFLAGS.
>=20
> Building QGA for older versions (XP) seems possible so far: the
> dependency on libqemuutil.a implies building qemu-thread-win32.c,
> which requires Vista API since commit 12f8def0 (v2.9). But qemu-thread
> isn't being used in QGA, the resulting binary may still work on XP.
> XP is no longer supported for the past 4.5y, it's time to drop support
> for it.
>=20
> Marc-Andr=C3=A9 Lureau (4):
>   build-sys: don't include windows.h, osdep.h does it
>   build-sys: move windows defines in osdep.h header
>   build-sys: build with Vista API by default
>   RFC: qga: drop < Vista compatibility
>=20
>  include/qemu/osdep.h      | 17 ++++++++++
>  accel/tcg/translate-all.c |  4 ---
>  qga/commands-win32.c      | 70 +--------------------------------------
>  util/qemu-thread-win32.c  |  4 ---
>  configure                 |  3 --
>  roms/seabios              |  2 +-
>  6 files changed, 19 insertions(+), 81 deletions(-)
>=20

Queued, thanks.

Paolo
