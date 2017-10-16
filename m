Received: from eggs.gnu.org ([2001:4830:134:3::10]:33109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e488P-0003Vc-IL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e488M-0005NU-5D
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e488L-0005Lg-VD
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 12:20:54 -0400
References: <20171016144302.24284-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fea07b0-e3b6-c880-f7d2-ca152874ac7e@redhat.com>
Date: Mon, 16 Oct 2017 18:20:46 +0200
MIME-Version: 1.0
In-Reply-To: <20171016144302.24284-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/7] kvm: slot handling fixes (and small
 cleanups)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Joe Clifford <joeclifford@gmail.com>

On 16/10/2017 16:42, David Hildenbrand wrote:
> Hopefully this is the last bunch of fixes for the cleanup series.
> 
> 1. log_start() was called before region_add(), which is wrong.
> 2. I messed up the calculation of the delta when aligning the ram address
>    (maybe we should simply also use ROUND_UP there ...).
> 3. I think we could get log_start/log_stop/log_sync when we actually
>    haven't registered a slot (due to trapping).
> 4. Some further cleanups
> 
> Available on: https://github.com/davidhildenbrand/qemu/commits/kvm_slot
> 
> @Joe, if you could retest, this would be great! I updated the branch.
> 
> David Hildenbrand (7):
>   memory: call log_start after region_add
>   kvm: fix alignment of ram address
>   kvm: tolerate non-existing slot for log_start/log_stop/log_sync
>   kvm: fix error message when failing to unregister slot
>   kvm: region_add and region_del is not called on updates
>   kvm: simplify kvm_align_section()
>   memory: reuse section_from_flat_range()
> 
>  accel/kvm/kvm-all.c | 39 ++++++++++++++-------------------------
>  memory.c            | 16 +++++-----------
>  2 files changed, 19 insertions(+), 36 deletions(-)
> 

Looks good!  I'll wait for testing results if they come soon.

Paolo
