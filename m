Received: from eggs.gnu.org ([209.51.188.92]:37704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giNze-0001wL-8u
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:26:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1giNrk-0006BM-Co
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:18:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1giNrk-00066Q-6p
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:18:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id y23so14850897oia.4
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 10:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20190111131836.107549-1-sgarzare@redhat.com>
	<20190111131836.107549-3-sgarzare@redhat.com>
	<20190111162649.GC14776@stefanha-x1.localdomain>
	<CAGxU2F6mpxE7-xw1LWS3Q6R+NSPMnkrqo8mdhhgn-SfARN3XKQ@mail.gmail.com>
	<20190111124742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190111124742-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Sat, 12 Jan 2019 19:18:15 +0100
Message-ID: <CAGxU2F4uiHoWyqeqNaAaHavDLPvJKc3iCaaQHaEz68dHj+wYXw@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Maran Wilson <maran.wilson@oracle.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jan 11, 2019 at 6:48 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > +#include "../../include/standard-headers/linux/qemu_fw_cfg.h"
> > >
> > > This depends on <stdint.h>, please include it first.
>
> Better to just pull in qemu/osdep.h

This header is used in the option roms that are bare-metal, so IMHO I
can't include qemu/osdep.h here or in the option roms.

Thanks,
Stefano
