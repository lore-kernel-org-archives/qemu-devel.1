Received: from eggs.gnu.org ([2001:4830:134:3::10]:59149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gSJtr-0006xw-5K
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gSJtm-0000Sl-82
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:50:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gSJtm-0000SO-3C
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 05:50:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so1370952qtr.12
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 02:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20181122110039.15972-1-marcandre.lureau@redhat.com>
	<2a53c96f-a712-5719-6e29-4df04b7256af@redhat.com>
	<da361a05-a31f-9ae1-f268-589f632ca9cf@weilnetz.de>
In-Reply-To: <da361a05-a31f-9ae1-f268-589f632ca9cf@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Nov 2018 14:50:09 +0400
Message-ID: <CAMxuvayaXHhGs1V1FysNBbHH62XfoH-9gpRytNFOjdE9bimuzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Weil <sw@weilnetz.de>
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Michael Roth <mdroth@linux.vnet.ibm.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Thu, Nov 29, 2018 at 2:45 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 29.11.2018 um 11:16 schrieb Paolo Bonzini:
> > On 22/11/18 12:00, Marc-Andr=C3=A9 Lureau wrote:
> >>  include/qemu/osdep.h      | 17 ++++++++++
> >>  accel/tcg/translate-all.c |  4 ---
> >>  qga/commands-win32.c      | 70 +-------------------------------------=
-
> >>  util/qemu-thread-win32.c  |  4 ---
> >>  configure                 |  3 --
> >>  roms/seabios              |  2 +-
> >>  6 files changed, 19 insertions(+), 81 deletions(-)
> >>
> > Queued, thanks.
> >
> > Paolo
>
>
> Was the change for roms/seabios intentional?

oh no! sorry Paolo
