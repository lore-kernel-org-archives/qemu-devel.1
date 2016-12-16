Received: from eggs.gnu.org ([2001:4830:134:3::10]:33213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cHo9L-0003qW-Cr
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cHo9G-0001SL-EU
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:45:55 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cHo9G-0001RU-7P
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 03:45:50 -0500
Received: by mail-wm0-x244.google.com with SMTP id a20so3878018wme.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 00:45:48 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
From: Liviu Ionescu <ilg@livius.net>
In-Reply-To: <d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
Date: Fri, 16 Dec 2016 10:45:44 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF1ADB09-8FDD-49D2-8D61-08F12F600757@livius.net>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161215202505-mutt-send-email-mst@kernel.org>
	<20161215211838-mutt-send-email-mst@kernel.org>
	<d6eb5b6d-3e8b-be10-33b6-289ef1ffec1a@redhat.com>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cole Robinson <crobinso@redhat.com>


> On 16 Dec 2016, at 10:26, Thomas Huth <thuth@redhat.com> wrote:
>=20
> ... so I would recommend to keep the SDL code in QEMU.

SDL 1.2 is largely deprecated now, when I upgraded to macOS 10.12 I =
suddenly started to have various problems. so I decided to upgrade GNU =
ARM Eclipse to SDL 2.=20

if all graphic calls are performed on the main thread, SDL2 is fine. if =
not, it crashes.


regards,

Liviu
