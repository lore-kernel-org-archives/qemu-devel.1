Received: from eggs.gnu.org ([209.51.188.92]:39792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjixr-0003HL-BM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gjixj-0002E6-Lw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:02:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gjixf-00021q-Qq
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:02:22 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so6411022wrw.5
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 03:02:09 -0800 (PST)
Date: Wed, 16 Jan 2019 12:02:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190116110204.kx7tmg3vgz4fitkc@steredhat>
References: <20190115100058.44712-1-sgarzare@redhat.com>
	<20190115100058.44712-4-sgarzare@redhat.com>
	<9737a9f4-bc26-73fd-f3ee-b394b46d861b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9737a9f4-bc26-73fd-f3ee-b394b46d861b@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/4] optionrom: add new PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Maran Wilson <maran.wilson@oracle.com>

Hi Liam,

On Wed, Jan 16, 2019 at 10:16:04AM +0000, Liam Merwick wrote:
> Hi Stefano,
> 
> Code LGTM, just a few minor comments below
> 
> On 15/01/2019 10:00, Stefano Garzarella wrote:
> > The new pvh.bin option rom can be used with SeaBIOS to boot
> > uncompressed kernel using the x86/HVM direct boot ABI.
> > 
> > pvh.S contains the entry point of the option rom. It runs
> > in real mode, loads the e820 table querying the BIOS, and
> > then it switches to 32bit protect mode and jump to the
> 
> "protect" -> "protected"
> "jump" -> "jumps"
> 

Thanks!

> > diff --git a/pc-bios/optionrom/pvh_main.c b/pc-bios/optionrom/pvh_main.c
> > +
> > +asm (".code32"); /* this code will be executed in protect mode */
> 
> 
> "protect" -> "protected"
> 
> 

Thanks!

> > +
> > +struct hvm_start_info start_info;
> 
> Can this be static?
> 

Yes.

> > +struct hvm_modlist_entry ramdisk_mod;
> 
> Is this used?
> 

Thanks, I forgot to remove it. I'm using it for initrd, but of course is
not used in this patch.

> > +uint8_t cmdline_buffer[CMDLINE_BUFSIZE];
> 
> Can this be static?
> 

Yes.

I'll include these changes in v3.

Thanks,
Stefano

--

Stefano Garzarella
Red Hat
