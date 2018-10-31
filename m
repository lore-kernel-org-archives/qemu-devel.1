Received: from eggs.gnu.org ([2001:4830:134:3::10]:37107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHnWl-00004x-1q
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gHnWh-0001n6-UL
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gHnWh-0001mR-Lv
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:15:03 -0400
References: <20181023152306.3123-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5ba604ad-0441-93f2-ba07-33ee7de38175@redhat.com>
Date: Wed, 31 Oct 2018 11:14:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181023152306.3123-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] qapi/range/memory-device: fixes and
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 23.10.18 17:22, David Hildenbrand wrote:
> While working on memory device code, I noticed that specifiying an uint64_t
> on command line does not work in all cases as we always parse an int64_t.
> So I fix that and also cleanup the old int64_t parser.
> 
> To be able to fix some overflows in memory-device code in a clean way,
> I am reusing the range implementation of qemu, for which I need some
> more helpers.
> 
> This series is based on
>     "[PATCH v5 00/16] memory-device: complete refactoring"
> which should get pulled soon.
> 
> v2 -> v3:
> - "qapi: correctly parse uint64_t values from strings"
> -- don't parse range
> -- don't rename "parse_str"
> 
> v1 -> v2:
> - "range: add some more functions"
> -- Reduce number of functions
> -- make range_init() return an error in case of overflow
> -- provide range_init_nofail()
> - "memory-device: rewrite address assignment using ranges"
> -- Use new functions range_init/range_init_nofail
> -- Use range_contains_range instead of starts_before/ends_after
> 
> 
> David Hildenbrand (7):
>   qapi: use qemu_strtoi64() in parse_str
>   qapi: correctly parse uint64_t values from strings
>   range: pass const pointer where possible
>   range: add some more functions
>   memory-device: use QEMU_IS_ALIGNED
>   memory-device: avoid overflows on very huge devices
>   memory-device: rewrite address assignment using ranges
> 
>  hw/mem/memory-device.c      | 60 ++++++++++++++++++--------------
>  include/qemu/range.h        | 68 +++++++++++++++++++++++++++++++++++--
>  qapi/string-input-visitor.c | 34 ++++++++-----------
>  3 files changed, 114 insertions(+), 48 deletions(-)
> 

Any more comments? If not, I think this is good to go.

-- 

Thanks,

David / dhildenb
