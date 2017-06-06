Received: from eggs.gnu.org ([2001:4830:134:3::10]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dICDq-00037m-U3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dICDk-0000nO-0g
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:00:24 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dICDj-0000me-PF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:00:19 -0400
Received: by mail-lf0-x243.google.com with SMTP id v20so8654267lfa.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 04:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20170606105339.3613-1-kraxel@redhat.com>
In-Reply-To: <20170606105339.3613-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 06 Jun 2017 11:00:05 +0000
Message-ID: <CAJ+F1C+R1ntaq8MNm8bBtxjg2pJYO4mV9TEB3OtvecDMBwxnoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] gtk/sdl: use newer versions by default,
 deprecate the old ones.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 6, 2017 at 2:54 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> High time to use new versions (gtk3 and SDL2) by default.  This patch
> series switches over qemu to prefer the newer versions and adds a
> deprecation warning for the old versions.
>
> Note that qemu uses the new versions automatically for quite a while
> already in case the older isn't installed.
>
> cheers,
>   Gerd
>
> Gerd Hoffmann (4):
>   gtk: prefer gtk3 over gtk2
>   sdl: prefer sdl2 over sdl1
>   gtk: add deprecation warning for gtk2
>   sdl: add deprecation warning for sdl1
>

That's a relieve :)
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>   configure | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
>
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
