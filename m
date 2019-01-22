Received: from eggs.gnu.org ([209.51.188.92]:60152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glsW9-0007DE-2B
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1glsW8-0001UX-D2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1glsW8-0001U3-6u
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:38:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so26494385wra.6
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:38:48 -0800 (PST)
Date: Tue, 22 Jan 2019 10:38:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190122093843.ayg66u53w4s3fq6m@steredhat>
References: <20190118120143.21631-1-sgarzare@redhat.com>
	<20190118120143.21631-5-sgarzare@redhat.com>
	<20190121170541.GN4136@habkost.net>
	<20190121173650.ydihxdyhheq7xcpq@steredhat>
	<e889e61c-f5fe-51cc-c703-45487efd4d3f@redhat.com>
	<20190122092232.dij3zujx32w3n6wq@steredhat>
	<21327094-fe12-df44-c23f-d001e75228db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21327094-fe12-df44-c23f-d001e75228db@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On Tue, Jan 22, 2019 at 10:29:30AM +0100, Paolo Bonzini wrote:
> On 22/01/19 10:22, Stefano Garzarella wrote:
> > 
> > I tried to migrate from a QEMU with PVH support to a QEMU without PVH,
> > (both with the same pc-q35-4.0 machine) and the migration doesn't fail.
> > 
> > The guest, after the migration, works well, but when I tried to reboot,
> > the guest stuck.
> > 
> > The "info ramblock" on both QEMU produce the same output:
> >               Block Name    PSize              Offset               Used              Total
> >                   pc.ram    4 KiB  0x0000000000000000 0x0000000020000000 0x0000000020000000
> >     /rom@etc/acpi/tables    4 KiB  0x0000000020080000 0x0000000000020000 0x0000000000200000
> >                  pc.bios    4 KiB  0x0000000020000000 0x0000000000040000 0x0000000000040000
> >                   pc.rom    4 KiB  0x0000000020040000 0x0000000000020000 0x0000000000020000
> >    /rom@etc/table-loader    4 KiB  0x0000000020280000 0x0000000000001000 0x0000000000001000
> >       /rom@etc/acpi/rsdp    4 KiB  0x00000000202c0000 0x0000000000001000 0x0000000000001000
> > 
> > 
> > The following patch solves the issue. (Thanks Michael!)
> > Should I send the v6 of series or this patch alone for the review?
> 
> Send the patch alone, but there's no need to introduce 4.1 since the
> feature will be included in 4.0.

Okay, I'll modify the patch.

Thanks,
Stefano
