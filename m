Received: from eggs.gnu.org ([209.51.188.92]:57933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1griFC-0006kU-Lh
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1griFB-00013p-Ro
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:53:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1griFB-00013M-MG
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:53:25 -0500
Date: Thu, 7 Feb 2019 11:53:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190207115316.GE19438@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190205182848.29887-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8zvq6eUVWhAVSmaxKe4hyrDu08m==RbwKXvL+2zBDrnQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULLv3 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Feb 07, 2019 at 11:46:23AM +0000, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 18:28, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> >
> > The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e159d:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-request' into staging (2019-02-05 14:01:29 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >
> > for you to fetch changes up to 1e924479dce65a26a7432bf5920f89c1bf957d74:
> >
> >   slirp: API is extern C (2019-02-05 20:27:27 +0200)
> >
> > ----------------------------------------------------------------
> > More work towards libslirp
> >
> 
> Format string issues for the Windows build:
> 
> /home/petmay01/qemu-for-merges/slirp/slirp.c: In function
> 'slirp_send_packet_all':
> /home/petmay01/qemu-for-merges/slirp/slirp.c:1116:20: error: unknown
> conversion type character 'z' in format [-Werror=format=]
>          g_critical("Failed to send packet, ret: %zd", ret);
>                     ^

Note that with any of the glib functions that take a format string,
you *must* use the glib format macros, not the system provided
format macros.  ie  G_*_FORMAT, not any of the PRI*  macros
from stdint.h.   This is because you can't assume that the glib
functions call through to the platform's own printf impl. See:

  https://developer.gnome.org/glib/stable/glib-Basic-Types.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
