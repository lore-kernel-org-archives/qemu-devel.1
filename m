Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVKp2-0002Co-6K
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVKox-0002EC-BG
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVKox-0002Dc-4R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:03 -0400
Date: Wed, 12 Jul 2017 17:48:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170712164844.GG30658@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170628190047.26159-2-dgilbert@redhat.com>
	<20170710092813.GD3738@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170710092813.GD3738@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 01/29] RAMBlock/migration: Add migration flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, marcandre.lureau@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Wed, Jun 28, 2017 at 08:00:19PM +0100, Dr. David Alan Gilbert (git) wrote:
> 
> [...]
> 
> > diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> > index af5bf26080..0cb6c5cb73 100644
> > --- a/include/exec/ram_addr.h
> > +++ b/include/exec/ram_addr.h
> > @@ -32,6 +32,8 @@ struct RAMBlock {
> >      ram_addr_t max_length;
> >      void (*resized)(const char*, uint64_t length, void *host);
> >      uint32_t flags;
> > +    /* These flags are owned by migration, initialised to 0 */
> > +    uint32_t migration_flags;
> 
> Since we have RAMBlock.flags, would it be possible to use that
> directly? Currently it only used 3 bits.  Thanks,

OK, gone - we now have:
bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
void qemu_ram_set_uf_zeroable(RAMBlock *rb);

which work on the new RAM_UF_ZEROPAGE flag.

Dave


> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
