Received: from eggs.gnu.org ([209.51.188.92]:37606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giNz6-0001p1-Dy
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giNz2-0002Xj-3X
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:26:13 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1giNz1-0002WS-VJ
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:26:12 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so14820831oiw.9
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 10:26:10 -0800 (PST)
MIME-Version: 1.0
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
	<CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
	<20190111124742-mutt-send-email-mst@kernel.org>
	<a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
In-Reply-To: <a313ccb0-4c81-5753-6ca7-95b6811d6f5d@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Sat, 12 Jan 2019 19:25:59 +0100
Message-ID: <CAGxU2F7RuG9LSrXykKnYG+Ax9x5Pk7FhNuBFXx7gh0evo=kqBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/4] linuxboot_dma: move common functions
 in a new header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 6:55 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 1/11/19 11:48 AM, Michael S. Tsirkin wrote:
>
> >>>
> >>>> diff --git a/pc-bios/optionrom/optrom.h b/pc-bios/optionrom/optrom.h
> >>>> new file mode 100644
> >>>> index 0000000000..36f43b43fd
> >>>> --- /dev/null
> >>>> +++ b/pc-bios/optionrom/optrom.h
>
> >>>> +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
> >>>
> >>> This depends on <stdint.h>, please include it first.
> >>
> >> Sure.
> >>
> >>
> >> Thanks,
> >> Stefano
> >
> > Better to just pull in qemu/osdep.h
>
> Except that qemu/osdep.h should already have been pulled in by whatever
> .c file is including this header. We specifically document that .h files
> shouldn't need to include osdep.h (and in turn, anything that osdep.h
> already pulls in, like <stdint.h>).

Since I can't include qemu/osdep.h because this header file is used by
the option roms (bare metal), do you think is better to include
stdint.h in optrom.h or in the .c files that use it?
As Stefan pointed out, I'm including qemu_fw_cfg.h in optrom.h and it
depends on stdint.h. In this case, what is the best approach?

Thanks,
Stefano
