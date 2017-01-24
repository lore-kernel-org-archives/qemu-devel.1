Received: from eggs.gnu.org ([2001:4830:134:3::10]:39052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxUv-0001XJ-KO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVxUu-0007ZN-GE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVxUu-0007YL-At
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:34:40 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 65CEEC00AFB7
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:34:40 +0000 (UTC)
Date: Tue, 24 Jan 2017 09:34:34 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170124093434.GA14563@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170120164322.21851-1-pbonzini@redhat.com>
	<20170120164322.21851-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120164322.21851-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/17] block: move AioContext and QEMUTimer
 to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com

On Fri, Jan 20, 2017 at 05:43:09PM +0100, Paolo Bonzini wrote:
> AioContext is fairly self contained, the only dependency is QEMUTimer but
> that in turn doesn't need anything else.  So move them out of block-obj-y
> to avoid introducing a dependency from io/ to block-obj-y.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: new patch [Daniel]
> 
>  Makefile.objs                       |  5 +---
>  block/io.c                          | 29 -------------------
>  stubs/Makefile.objs                 |  2 ++
>  stubs/linux-aio.c                   | 32 +++++++++++++++++++++
>  stubs/main-loop.c                   |  8 ++++++
>  stubs/set-fd-handler.c              | 11 --------
>  tests/Makefile.include              | 13 ++++-----
>  util/Makefile.objs                  |  5 +++-
>  aio-posix.c => util/aio-posix.c     |  0
>  aio-win32.c => util/aio-win32.c     |  0
>  util/aiocb.c                        | 55 +++++++++++++++++++++++++++++++++++++
>  async.c => util/async.c             |  3 +-
>  qemu-timer.c => util/qemu-timer.c   |  0
>  thread-pool.c => util/thread-pool.c |  0
>  14 files changed, 110 insertions(+), 53 deletions(-)
>  create mode 100644 stubs/linux-aio.c
>  create mode 100644 stubs/main-loop.c
>  rename aio-posix.c => util/aio-posix.c (100%)
>  rename aio-win32.c => util/aio-win32.c (100%)
>  create mode 100644 util/aiocb.c
>  rename async.c => util/async.c (99%)
>  rename qemu-timer.c => util/qemu-timer.c (100%)
>  rename thread-pool.c => util/thread-pool.c (100%)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
