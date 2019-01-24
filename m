Received: from eggs.gnu.org ([209.51.188.92]:56877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmjmt-0005uU-36
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gmjms-00006M-9E
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:31:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gmjms-0008SV-0y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:31:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id s13so6146382otq.4
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 10:31:27 -0800 (PST)
MIME-Version: 1.0
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-2-sgarzare@redhat.com>
	<20190124175533.GC2404@work-vm>
In-Reply-To: <20190124175533.GC2404@work-vm>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 24 Jan 2019 19:31:14 +0100
Message-ID: <CAGxU2F7bPCv4f5J7oKYXBdK+SnxP34JT17KOTmuc=E5=2D-OaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jan 24, 2019 at 6:55 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Stefano Garzarella (sgarzare@redhat.com) wrote:
> > This patch adds the support of DISCARD and WRITE ZEROES commands,
> > that have been introduced in the virtio-blk protocol to have
> > better performance when using SSD backend.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
> Hi,
>   Do you need to make those features machine-type dependent
> so that a VM started on a nice new qemu with this feature doesn't
> get confused when live migrated back to an older version?
>

Hi Dave,
oh, thanks! I think the answer is absolutely yes :)
I'll fix it!

Another doubt that I have now is that I need to flush the
MultiReqBuffer before submitting DISCARD or WRITE ZEROES commands.

Thanks,
Stefano
