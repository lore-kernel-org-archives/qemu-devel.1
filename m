Received: from eggs.gnu.org ([209.51.188.92]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLbgx-00019q-Sa
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLbaO-0003Lv-IW
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:50:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hLbaO-0003Ju-Cu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:50:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so18332782qth.5
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 15:50:51 -0700 (PDT)
Date: Tue, 30 Apr 2019 18:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190430185011-mutt-send-email-mst@kernel.org>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430224816.GL28722@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v15 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, pagupta@redhat.com, xiaoguangrong.eric@gmail.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com

On Tue, Apr 30, 2019 at 07:48:16PM -0300, Eduardo Habkost wrote:
> On Tue, Apr 30, 2019 at 10:36:18PM +0000, Wei Yang wrote:
> [...]
> > >> +#ifdef CONFIG_LINUX
> > >> +#include <linux/mman.h>
> > >> +#endif /* CONFIG_LINUX */
> > >> +
> > >> +#ifndef MAP_SYNC
> > >> +#define MAP_SYNC 0
> > >> +#endif
> > >> +#ifndef MAP_SHARED_VALIDATE
> > >> +#define MAP_SHARED_VALIDATE 0
> > >> +#endif
> > >
> > >Why would we need this, if we added copies of mman.h to
> > >linux-headers?
> > 
> > This is reported by Stefan.
> > 
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg612168.html
> 
> Stefan, did you hit a build failure, or it was just theoretical?
> 
> linux-headers/*/mman.h is updated by "linux-headers: add
> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
> something else is broken in our build system.

I think it's for non-linux hosts. linux-headers/ is only used
on linux hosts.

> -- 
> Eduardo
