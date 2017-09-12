Received: from eggs.gnu.org ([2001:4830:134:3::10]:45448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfnl-0004q9-DQ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drfng-0008EL-Hb
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drfng-0008Dy-B4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 03:40:04 -0400
References: <20170911174933.20789-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55ff3bc7-6e83-5347-4a7d-e77058e84abc@redhat.com>
Date: Tue, 12 Sep 2017 09:39:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170911174933.20789-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/6] QEMU: kvm: cleanup kvm_slot handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, kvm@vger.kernel.org

On 11/09/2017 19:49, David Hildenbrand wrote:
> We can heavily simplify the kvm_slot code. Flatview will make sure that we
> don't have to deal with overlapping slots. E.g. when a memory section is
> resized, we are first notified about the removal and then about the new
> memory section.
> 
> So basically, we can directly always map one memory section to one
> kvm slot (if the fixed up size is > 0).
> 
> 
> RFC -> v1:
> - minor changes to avoid changing indentation, therefore making it easier
>   to review

Queued, thanks!

Paolo

> 
> David Hildenbrand (6):
>   kvm: require JOIN_MEMORY_REGIONS_WORKS
>   kvm: factor out alignment of memory section
>   kvm: use start + size for memory ranges
>   kvm: we never have overlapping slots in kvm_set_phys_mem()
>   kvm: kvm_log_start/stop are only called with known sections
>   kvm: kvm_log_sync() is only called with known memory sections
> 
>  accel/kvm/kvm-all.c | 235 +++++++++++++++-------------------------------------
>  1 file changed, 68 insertions(+), 167 deletions(-)
> 
