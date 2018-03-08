Received: from eggs.gnu.org ([2001:4830:134:3::10]:51069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ets44-0005t0-0o
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ets43-0004Xp-9H
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:42:20 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ets43-0004XO-2Q
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:42:19 -0500
Received: by mail-wr0-x242.google.com with SMTP id v65so4966689wrc.11
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 01:42:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180308090618.30147-1-kraxel@redhat.com>
References: <20180308090618.30147-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Mar 2018 10:42:17 +0100
Message-ID: <CAJ+F1CLTobNzgxrQ_c4AQ=ZypCcg4Mn5P4bSR5GtcEB0qKA6Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] spice: add support for dmabufs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Mar 8, 2018 at 10:06 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> v3: rebase, handle surface =3D=3D NULL in tracepoint (Marc-Andr=C3=A9).
> v2: rebase, fix codestyle issues.
>
> Gerd Hoffmann (3):
>   spice: drop dprint() debug logging
>   spice: add scanout_dmabuf support
>   spice: add cursor_dmabuf support

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>  include/ui/spice-display.h |   9 +++
>  ui/spice-display.c         | 194 ++++++++++++++++++++++++++++++++-------=
------
>  ui/trace-events            |  12 +++
>  3 files changed, 162 insertions(+), 53 deletions(-)
>
> --
> 2.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
