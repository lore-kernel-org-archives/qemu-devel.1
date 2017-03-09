Received: from eggs.gnu.org ([2001:4830:134:3::10]:54282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm0hU-00045x-PT
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cm0hR-0001jQ-DC
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:14:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cm0hR-0001iS-6K
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:13:57 -0500
Date: Thu, 9 Mar 2017 16:13:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170309161352.GI2480@work-vm>
References: <20170309152708.30635-1-dgilbert@redhat.com>
	<fa186054-0b8c-924f-b30b-34ed92a83337@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa186054-0b8c-924f-b30b-34ed92a83337@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] memory_region: Fix name comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 09/03/2017 16:27, Dr. David Alan Gilbert (git) wrote:
> > + * @name: Region name, becomes part of RAMBlock name used in migration stream
> > + *        must be unique within any device
> >   * @size: size of the region; any subregions beyond this size will be clipped
> >   */
> >  void memory_region_init(MemoryRegion *mr,
> >                          struct Object *owner,
> >                          const char *name,
> >                          uint64_t size);
> 
> This one should not be necessary I guess?

Why? It's not static so something else could be calling it for
any use.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
