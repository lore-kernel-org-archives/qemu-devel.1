Received: from eggs.gnu.org ([209.51.188.92]:34567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grq7c-00088Q-Bc
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grq7b-0004H6-Kg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:18:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1grq7b-0004G8-Fg
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 15:18:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id e24so2011585otp.11
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 12:18:06 -0800 (PST)
MIME-Version: 1.0
References: <20190206112729.37761-1-sgarzare@redhat.com>
	<20190207142945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190207142945-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 7 Feb 2019 21:17:54 +0100
Message-ID: <CAGxU2F4dSD=KRuD0ffpj9cNufG5A24X-vdua_t9GetVrtr_ieg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/6] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Thu, Feb 7, 2019 at 8:30 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Feb 06, 2019 at 12:27:23PM +0100, Stefano Garzarella wrote:
> > This series adds the support of DISCARD and WRITE_ZEROES commands
> > and extends the virtio-blk-test to test WRITE_ZEROES command when
> > the feature is enabled.
>
> pls note and fix patchew errors:
>
> https://patchew.org/QEMU/20190206112729.37761-1-sgarzare@redhat.com/

Oh, thanks! I'll fix on v4.

Stefano
