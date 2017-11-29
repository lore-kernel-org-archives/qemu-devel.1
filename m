Received: from eggs.gnu.org ([2001:4830:134:3::10]:33204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK9Ti-0008OR-5w
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK9Te-0002z8-A4
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 16:01:10 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171129202701.16117-1-david@redhat.com>
	<20171129202701.16117-9-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5908190f-05d0-a596-b528-1fba52a8d522@twiddle.net>
Date: Wed, 29 Nov 2017 21:01:02 +0000
MIME-Version: 1.0
In-Reply-To: <20171129202701.16117-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 08/16] s390x/tcg: don't exit
 the cpu loop in s390_cpu_virt_mem_rw()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 11/29/2017 08:26 PM, David Hildenbrand wrote:
> s390_cpu_virt_mem_rw() must always return, so callers can react on
> an exception (e.g. see ioinst_handle_stcrw()).
> 
> Therefore, using program_interrupt() is wrong. Fix that up.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/mmu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
