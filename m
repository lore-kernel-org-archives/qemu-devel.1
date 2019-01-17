Received: from eggs.gnu.org ([209.51.188.92]:59678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk9Eg-0003U0-7p
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk9Ec-0008FZ-BY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:05:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34987)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk9Ea-0007tw-Ac
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:05:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so1431730wmt.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 07:05:19 -0800 (PST)
Date: Thu, 17 Jan 2019 16:05:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117150515.rr2ksgkob7t6kene@steredhat>
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
	<0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
	<aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
	<8cdb60f6-4a52-f968-d498-ee9273cb69b3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cdb60f6-4a52-f968-d498-ee9273cb69b3@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Thu, Jan 17, 2019 at 02:52:25PM +0000, Liam Merwick wrote:
> 
> 
> On 17/01/2019 14:37, Paolo Bonzini wrote:
> > On 17/01/19 15:33, Liam Merwick wrote:
> > > #    pc-bios/optionrom/pvh.bin
> > > #    pc-bios/optionrom/pvh.img
> > > #    pc-bios/optionrom/pvh.raw
> > 
> > pvh.bin should not be ignored.
> > 
> 
> That's part of what I didn't quite understand.
> pc-bios/optionrom/linuxboot.bin (and the other binaries in the 'build-all'
> target in pc-bios/optionrom/Makefile) are in .gitignore.
> 
> Also, should pvh.bin be added to BLOBS in Makefile like those files?

Yes, indeed I added pvh.bin to BLOBS in patch 3/5 and I committed the
binary file in /pc-bios/ (note: not in /pc-bios/optionrom/ where it is
compiled, maybe is here the confusion, but I following what was done for
the other option roms)

Of course, I forgot to add the pc-bios/optionrom/pvh.* entries in
.gitignore :)

Thanks,
Stefano
