Received: from eggs.gnu.org ([2001:4830:134:3::10]:46525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIWg-00080Z-C7
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dNIWb-00036d-HG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:44:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dNIWb-00036T-BE
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 08:44:53 -0400
References: <20170620123553.16186-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4f34b052-b2d6-4b1f-4a39-1c809b00eeb6@redhat.com>
Date: Tue, 20 Jun 2017 14:44:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170620123553.16186-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/3] target/s390x: implement idte and
 improve ipte
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 20.06.2017 14:35, David Hildenbrand wrote:
> One step into the direction of adding the DAT-enhancement facility.
> 
> To improve the TLB flushing, we will have to remember each used table (or
> at least a hash!) for each tlb entry, just like real HW does.
> 
> idte is pretty much untested, before I can test it with linux (by enabling
> DAT-enhancement) we will have to implement cspg. Will look into this next.
> 
> David Hildenbrand (3):
>   target/s390x: Indicate and check for local tlb clearing
>   target/s390x: Improve heuristic for ipte
>   target/s390x: Implement idte instruction
> 
>  target/s390x/cpu_models.c  |  1 +
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/mem_helper.c  | 80 +++++++++++++++++++++++++++++++++++++++-------
>  target/s390x/translate.c   | 11 +++++++
>  5 files changed, 83 insertions(+), 12 deletions(-)
> 

Just realized that cspg is already implemented. By forcing
DAT-Enhacement on, my Linux guests crashes at some point. So either
invalidation in idte is still wrong or cspg is broken. Will look into it.

-- 

Thanks,

David
