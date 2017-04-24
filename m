Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2bHW-0004oy-Oj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2bHV-0004vk-Q1
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:31:46 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2bHV-0004vR-IK
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:31:45 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m123so63140909wma.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 03:31:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 11:31:23 +0100
Message-ID: <CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>

On 21 April 2017 at 21:14, Stefano Stabellini <sstabellini@kernel.org> wrote:
> The following changes since commit 55a19ad8b2d0797e3a8fe90ab99a9bb713824059:
>
>   Update version for v2.9.0-rc1 release (2017-03-21 17:13:29 +0000)
>
> are available in the git repository at:
>
>   git://xenbits.xen.org/people/sstabellini/qemu-dm.git tags/xen-20170421-tag
>
> for you to fetch changes up to b0d48550a2d10f0fa8c30a7cc3ff5a1cbda8d4c4:
>
>   move xen-mapcache.c to hw/i386/xen/ (2017-04-21 12:41:29 -0700)
>
> ----------------------------------------------------------------
> Xen 2017/04/21
>
> ----------------------------------------------------------------

Hi; I'm afraid this doesn't build with clang:


  CC      hw/9pfs/xen-9p-backend.o
/home/petmay01/linaro/qemu-for-merges/hw/9pfs/xen-9p-backend.c:21:1:
error: unused fun
ction 'xen_9pfs_get_ring_ptr' [-Werror,-Wunused-function]
DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
^
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:469:79:
note: expanded
from macro 'DEFINE_XEN_FLEX_RING_AND_INTF'
};                                                                            \
                                                                              ^
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:387:30:
note: expanded from macro '\
DEFINE_XEN_FLEX_RING'
static inline unsigned char *name##_get_ring_ptr(unsigned char *buf,          \
                             ^
<scratch space>:151:1: note: expanded from here
xen_9pfs_get_ring_ptr
^
/home/petmay01/linaro/qemu-for-merges/hw/9pfs/xen-9p-backend.c:21:1:
error: unused function 'xen_9pfs_write_packet'
[-Werror,-Wunused-function]
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:469:79:
note: expanded from macro 'DEFINE_XEN_FLEX_RING_AND_INTF'
};                                                                            \
                                                                              ^
/home/petmay01/linaro/qemu-for-merges/include/hw/xen/io/ring.h:412:20:
note: expanded from macro '\
DEFINE_XEN_FLEX_RING'
static inline void name##_write_packet(unsigned char *buf,                    \
                   ^
<scratch space>:155:1: note: expanded from here
xen_9pfs_write_packet
^
2 errors generated.
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'hw/9pfs/xen-9p-backend.o' failed


Clang requires that functions, even inline functions, defined in .c files
must be used.

thanks
-- PMM
