Received: from eggs.gnu.org ([209.51.188.92]:37471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLcL4-0003Y5-O7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hLcL3-0003oO-QN
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hLcL1-0003mj-W6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:39:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id c35so18469407qtk.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 16:39:03 -0700 (PDT)
Date: Tue, 30 Apr 2019 19:38:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190430193838-mutt-send-email-mst@kernel.org>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
	<20190430185011-mutt-send-email-mst@kernel.org>
	<86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, pagupta@redhat.com, xiaoguangrong.eric@gmail.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com

On Wed, May 01, 2019 at 01:11:34AM +0200, Paolo Bonzini wrote:
> On 01/05/19 00:50, Michael S. Tsirkin wrote:
> >> Stefan, did you hit a build failure, or it was just theoretical?
> >>
> >> linux-headers/*/mman.h is updated by "linux-headers: add
> >> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
> >> something else is broken in our build system.
> > I think it's for non-linux hosts. linux-headers/ is only used
> > on linux hosts.
> 
> Yes, it is.  Maybe the #ifndef/#define  part should be only used for
> non-Linux.
> 
> Paolo

Makes sense. We'd rather have an error on linux than stub it out as 0.

-- 
MST
