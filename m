Received: from eggs.gnu.org ([209.51.188.92]:39579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCWH-0002Hx-TB
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCGk-0006BF-TO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:21:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:60196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1guCGk-000693-2L
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:21:18 -0500
Date: Thu, 14 Feb 2019 16:20:50 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190214082050.GB19789@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190214031004.32522-1-stefanha@redhat.com>
	<20190214031004.32522-3-stefanha@redhat.com>
	<20190214041915.GA10412@richard>
	<20190214081558.GA7652@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214081558.GA7652@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hostmem-file: reject invalid pmem
 file sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

On Thu, Feb 14, 2019 at 04:15:58PM +0800, Stefan Hajnoczi wrote:
>On Thu, Feb 14, 2019 at 12:19:15PM +0800, Wei Yang wrote:
>> On Thu, Feb 14, 2019 at 11:10:04AM +0800, Stefan Hajnoczi wrote:
>> >diff --git a/util/oslib-win32.c b/util/oslib-win32.c
>> >index b4c17f5dfa..bd633afab6 100644
>> >--- a/util/oslib-win32.c
>> >+++ b/util/oslib-win32.c
>> >@@ -560,6 +560,11 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
>> >     }
>> > }
>> > 
>> >+uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
>> >+{
>> >+    error_setg(errp, "pmem support not available");
>> >+    return 0;
>> >+}
>> 
>> After the cleanup from Igor, qemu_get_pmem_size() would be invoked only on
>> POSIX system.
>> 
>> Is it still necessary to define this on win32?
>
>Either way is possible.  I'd like to leave it like this unless there are
>strong feelings against this.
>

Well, I am fine with this.

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>Stefan



-- 
Wei Yang
Help you, Help me
