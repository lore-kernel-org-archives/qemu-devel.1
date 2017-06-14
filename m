Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dL1uv-0001yg-3w
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dL1uu-0002zd-CB
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:36:37 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:34150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1dL1uu-0002zN-7c
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:36:36 -0400
Received: by mail-io0-x22c.google.com with SMTP id i7so86989671ioe.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 23:36:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1497421805.11748.3.camel@redhat.com>
References: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
	<1497421805.11748.3.camel@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 14 Jun 2017 14:36:35 +0800
Message-ID: <CAKXe6SLrbcj53G4Uh=DmGetJZ19hg5aSU+sLjC2XUgbAfm5YOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing
 event to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <liqiang6-s@360.cn>, P J P <ppandit@redhat.com>

2017-06-14 14:30 GMT+08:00 Gerd Hoffmann <kraxel@redhat.com>:

> On Tue, 2017-06-13 at 20:39 -0700, Li Qiang wrote:
> > From: Li Qiang <liq3ea@gmail.com>
> >
> > In 'xhci_write_event' function, the 'ev_trb' is not full initialized.
> > This will lead an info leak issue. This patch avoid this.
>
> I don't think so.  Note that only the first 16 bytes (TRB_SIZE) and not
> the whole struct is copied to guest memory.
>
>
Agree. Not notice the 'TRB_SIZE'.

Thanks.


> cheers,
>   Gerd
>
>
