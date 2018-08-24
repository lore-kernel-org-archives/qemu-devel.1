Received: from eggs.gnu.org ([2001:4830:134:3::10]:40795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftFtW-0000VF-K6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftFj8-0005Le-H2
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:18:31 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:46733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=76755a058=roger.pau@citrix.com>)
	id 1ftFj4-0005Cw-3J
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:18:23 -0400
Date: Fri, 24 Aug 2018 19:18:10 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20180824171810.pqz5eblyvz7fhhbc@mac.bytemobile.com>
References: <20180824155804.azxqj5kvhbswyy5n@mac.bytemobile.com>
	<1efbdd93-03c4-26d6-7ea0-8d1c85654d5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1efbdd93-03c4-26d6-7ea0-8d1c85654d5b@gmail.com>
Subject: Re: [Qemu-devel] usage of mremap in pvrdma break FreeBSD build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Fri, Aug 24, 2018 at 07:49:01PM +0300, Marcel Apfelbaum wrote:
> Hi Roger,
> 
> 
> On 08/24/2018 06:58 PM, Roger Pau Monné wrote:
> > Hello,
> > 
> > The usage of mremap in the pvrdma code breaks the build on FreeBSD:
> > 
> > /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: implicit declaration of
> >        function 'mremap' is invalid in C99 [-Wimplicit-function-declaration]
> >      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> >                  ^
> > /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning: this function
> >        declaration is not a prototype [-Wstrict-prototypes]
> > /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:60:46: error: use of undeclared
> >        identifier 'MREMAP_MAYMOVE'
> >      host_virt = mremap(curr_page, 0, length, MREMAP_MAYMOVE);
> >                                               ^
> > /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:48: error: use of undeclared
> >        identifier 'MREMAP_MAYMOVE'
> >          mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
> >                                                 ^
> > /root/src/xen/tools/qemu-xen-dir/hw/rdma/vmw/pvrdma_cmd.c:97:65: error: use of undeclared
> >        identifier 'MREMAP_FIXED'
> >          mremap(curr_page, 0, TARGET_PAGE_SIZE, MREMAP_MAYMOVE | MREMAP_FIXED,
> >                                                                  ^
> > 
> > FreeBSD has librdma in base so by default QEMU configure script will
> > enable the build of the rdma bits in QEMU. Sadly this code uses mremap
> > which is Linux-specific.
> > 
> > AFAICT either the build of pvrdma is limited to Linux in the configure
> > script, or the calls to mremap are replaced with a portable
> > equivalent.
> > 
> > Thanks, Roger.
> 
> A fix has been submitted and merged:
> 
> https://patchew.org/QEMU/20180819202300.10590-1-marcel.apfelbaum@gmail.com/20180819202300.10590-16-marcel.apfelbaum@gmail.com/

Thanks! And sorry for the noise.

Roger.
