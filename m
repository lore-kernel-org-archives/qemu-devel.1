Received: from eggs.gnu.org ([2001:4830:134:3::10]:55726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dmbGP-0002rB-F8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dmbGM-0003Hx-DL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:48:45 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dmbGM-0003Hf-8e
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:48:42 -0400
Received: by mail-ua0-f174.google.com with SMTP id 105so8021829uad.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 00:48:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823135113.25769-1-kraxel@redhat.com>
References: <20170823135113.25769-1-kraxel@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 29 Aug 2017 09:48:40 +0200
Message-ID: <CABdb7378sHekFNCvSkO6U7JQaO-nME9+Ok=+xOVCgWi__3E5-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Aug 23, 2017 at 3:51 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> qemu uses wheel-up/down button events for mouse wheel input, however
> linux applications typically want REL_WHEEL events.
>
> This fixes wheel with linux guests. Tested with X11/wayland, and
> windows virtio-input driver.
>
> Based on a patch from Marc.
> Added property to enable/disable wheel axis.
> TODO: add compat properties for old machine types.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Verified that the Windows driver correctly handles axis-based wheel. Thanks=
!

Tested-by: Ladi Prosek <lprosek@redhat.com>
