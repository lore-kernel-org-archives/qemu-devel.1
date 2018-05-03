Received: from eggs.gnu.org ([2001:4830:134:3::10]:56106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKqx-0002zO-Ie
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKqw-0002I8-HQ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:29:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKqw-0002Gu-8Z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 16:29:22 -0400
Date: Thu, 3 May 2018 23:29:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180503232542-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-6-git-send-email-mst@redhat.com>
	<5fbe4232-ca1a-5e0c-437c-8b63cf83c510@redhat.com>
	<20180503230505-mutt-send-email-mst@kernel.org>
	<c4f0bb7a-f5db-383b-60fd-683dd65de7f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f0bb7a-f5db-383b-60fd-683dd65de7f8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/67] migration: drop an unused include,
 add a used one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 03, 2018 at 03:18:47PM -0500, Eric Blake wrote:
> On 05/03/2018 03:15 PM, Michael S. Tsirkin wrote:
> > On Thu, May 03, 2018 at 03:02:59PM -0500, Eric Blake wrote:
> > > On 05/03/2018 02:50 PM, Michael S. Tsirkin wrote:
> > > > we just need a struct name, let's add a forward
> > > > declaration instead of an include.
> > > 
> > > Reasonable.
> > > 
> > > > 
> > > > We also use size_t, so add stddef.h
> > > 
> > > Why? osdep.h already does this, and ALL .c files that use include/ should be
> > > including osdep.h prior to any other in-tree .h file.  So size_t should
> > > already be in scope by the time this header is included.
> > 
> > It seemed cleaner to have the file self-contained.
> > OK, I will drop this.
> > There's a small number of files which do not include qemu/osdep.h.
> > Might be worth fixing.
> 
> scripts/clean-includes is already supposed to fix these.
> 
> There are a few .c files exempt from including osdep.h, but in general,
> those files should probably also not be including anything from include/.

Here's a list from a quick grep.
Most of them probably get osdep.h indirectly.


+contrib/libvhost-user/libvhost-user.c
+hw/rdma/rdma_utils.c
+libuser/trace.c
+target/mips/translate_init.c
+target/ppc/mfrom_table.c
+target/ppc/translate/dfp-impl.inc.c
+target/ppc/translate/dfp-ops.inc.c
+target/ppc/translate/fp-impl.inc.c
+target/ppc/translate/fp-ops.inc.c
+target/ppc/translate/spe-impl.inc.c
+target/ppc/translate/spe-ops.inc.c
+target/ppc/translate/vmx-impl.inc.c
+target/ppc/translate/vmx-ops.inc.c
+target/ppc/translate/vsx-impl.inc.c
+target/ppc/translate/vsx-ops.inc.c
+target/s390x/gen-features.c
+target/xtensa/core-dc232b/gdb-config.inc.c
+target/xtensa/core-dc233c/gdb-config.inc.c
+target/xtensa/core-de212/gdb-config.inc.c
+target/xtensa/core-sample_controller/gdb-config.inc.c
+tcg/aarch64/tcg-target.inc.c
+tcg/arm/tcg-target.inc.c
+tcg/i386/tcg-target.inc.c
+tcg/mips/tcg-target.inc.c
+tcg/ppc/tcg-target.inc.c
+tcg/s390/tcg-target.inc.c
+tcg/sparc/tcg-target.inc.c
+tcg/tcg-ldst.inc.c
+tcg/tcg-pool.inc.c
+tcg/tci/tcg-target.inc.c
+tests/multiboot/libc.c
+tests/multiboot/mmap.c
+tests/multiboot/modules.c

lots of files under tests/tcg

+tests/test-qapi-event.c
+tests/test-qapi-types.c
+tests/test-qapi-visit.c
+tests/test-qmp-introspect.c
+tests/test-qmp-marshal.c

+ui/keycodemapdb/tests/stdc.c


> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
