Received: from eggs.gnu.org ([209.51.188.92]:39404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIN2t-00065V-KZ
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hIN2s-0008Hy-N2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:46237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hIN2s-0008GN-EL
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:42:54 -0400
Date: Mon, 22 Apr 2019 08:37:16 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190422003716.GA1570@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <cover.1549555521.git.yi.z.zhang@linux.intel.com>
	<5d07bf7e9a3e576f5a87e81d786e8886fb2bb551.1549555521.git.yi.z.zhang@linux.intel.com>
	<20190418220516.GP25134@habkost.net>
	<20190418223301.GQ25134@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418223301.GQ25134@habkost.net>
Subject: Re: [Qemu-devel] [PATCH V13 4/5] util/mmap-alloc: support MAP_SYNC
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
Cc: "Zhang, Yi" <yi.z.zhang@linux.intel.com>, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, mst@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, Apr 18, 2019 at 07:33:01PM -0300, Eduardo Habkost wrote:
>On Thu, Apr 18, 2019 at 07:05:16PM -0300, Eduardo Habkost wrote:
>> Hi,
>> 
>> I found out that this series missed QEMU 4.0 and I was going to
>> queue for 4.1, but unfortunately this patch conflicts with:
>> 
>> commit 2044c3e7116eeac0449dcb4a4130cc8f8b9310da
>> Author: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>> Date:   Wed Jan 30 21:36:04 2019 -0200
>> 
>>     mmap-alloc: unfold qemu_ram_mmap()
>[...]
>> On Fri, Feb 08, 2019 at 06:11:11PM +0800, Zhang, Yi wrote:
>> > From: Zhang Yi <yi.z.zhang@linux.intel.com>
>> > 
>> > When a file supporting DAX is used as vNVDIMM backend, mmap it with
>> > MAP_SYNC flag in addition which can ensure file system metadata
>> > synced in each guest writes to the backend file, without other QEMU
>> > actions (e.g., periodic fsync() by QEMU).
>> > 
>> > Current, We have below different possible use cases:
>> > 
>> > 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>> >    a: backend is a dax supporting file.
>> >     - MAP_SYNC will active.
>> >    b: backend is not a dax supporting file.
>> >     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
>> > 
>> > 2. The rest of cases:
>> >    - we will never pass the MAP_SYNC to mmap2
>> > 
>> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> > Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>
>Untested patch rebase is below.  Can Intel help test it and
>submit v14?
>

Thanks Eduardo, the patch looks good to me and I have tested it.

-- 
Wei Yang
Help you, Help me
