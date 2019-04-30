Received: from eggs.gnu.org ([209.51.188.92]:60430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLbui-0008Dj-Gl
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hLbuh-0007y2-KO
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hLbuh-0007xo-Ce
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:11:51 -0400
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
	<20190430223618.lyl3ribm7gg5haa5@master>
	<20190430224816.GL28722@habkost.net>
	<20190430185011-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86e00247-588c-37c1-0737-82614a8f18c0@redhat.com>
Date: Wed, 1 May 2019 01:11:34 +0200
MIME-Version: 1.0
In-Reply-To: <20190430185011-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, pagupta@redhat.com, xiaoguangrong.eric@gmail.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com

On 01/05/19 00:50, Michael S. Tsirkin wrote:
>> Stefan, did you hit a build failure, or it was just theoretical?
>>
>> linux-headers/*/mman.h is updated by "linux-headers: add
>> linux/mman.h" (commit 8cf108c5d159).  If the build really fails,
>> something else is broken in our build system.
> I think it's for non-linux hosts. linux-headers/ is only used
> on linux hosts.

Yes, it is.  Maybe the #ifndef/#define  part should be only used for
non-Linux.

Paolo
