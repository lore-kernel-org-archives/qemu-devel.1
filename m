Received: from eggs.gnu.org ([2001:4830:134:3::10]:48705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijMd-00064J-Hi
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:39:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijMa-0002zb-Dg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:39:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijMa-0002zJ-7P
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:39:08 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30e8c8be-85db-30c4-37a7-466b9e6faff6@redhat.com>
Date: Fri, 18 Aug 2017 17:39:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 02/18] s390x/kvm: drop KVMState
 parameter from kvm_s390_set_mem_limit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18.08.2017 13:43, David Hildenbrand wrote:
> Not needed at that point. Also drop it from kvm_s390_query_mem_limit()
> we call in kvm_s390_set_mem_limit().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h |  7 +++----
>  target/s390x/kvm.c | 12 ++++++------
>  2 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
