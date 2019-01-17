Received: from eggs.gnu.org ([209.51.188.92]:51050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkAIj-000272-WB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gkAIi-0004f9-M0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:13:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gkAIh-0004bN-UL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:13:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so1684924wmt.0
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 08:13:48 -0800 (PST)
Date: Thu, 17 Jan 2019 17:13:44 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117161344.xxqbtbet6bnk6imb@steredhat>
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
	<0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
	<aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
	<8cdb60f6-4a52-f968-d498-ee9273cb69b3@oracle.com>
	<20190117150515.rr2ksgkob7t6kene@steredhat>
	<d3180f6c-8d35-4d82-4bde-ddec5116b88f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3180f6c-8d35-4d82-4bde-ddec5116b88f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On Thu, Jan 17, 2019 at 04:18:00PM +0100, Paolo Bonzini wrote:
> On 17/01/19 16:05, Stefano Garzarella wrote:
> >> That's part of what I didn't quite understand.
> >> pc-bios/optionrom/linuxboot.bin (and the other binaries in the 'build-all'
> >> target in pc-bios/optionrom/Makefile) are in .gitignore.
> >>
> >> Also, should pvh.bin be added to BLOBS in Makefile like those files?
> > Yes, indeed I added pvh.bin to BLOBS in patch 3/5 and I committed the
> > binary file in /pc-bios/ (note: not in /pc-bios/optionrom/ where it is
> > compiled, maybe is here the confusion, but I following what was done for
> > the other option roms)
> 
> Nevermind---I was totally sure .bin files are committed.  Though perhaps
> they should, since non-x86 binaries are.

They are committed (in /pc-bios/) but not were they are compiled
(in /pc-bios/optionrom/).
