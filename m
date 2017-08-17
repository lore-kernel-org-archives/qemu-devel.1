Received: from eggs.gnu.org ([2001:4830:134:3::10]:42045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIa1-0007JX-6E
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIZw-0006R7-Bf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:03:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diIZw-0006Qx-5h
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:03:08 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c979ecb-51e9-7ef5-b94d-cc051559d60f@redhat.com>
Date: Thu, 17 Aug 2017 13:03:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 02/10] target/s390x: move
 cpu_mmu_idx_to_asc() to excp_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 17.08.2017 11:22, David Hildenbrand wrote:
> Only used in that file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h         | 14 --------------
>  target/s390x/excp_helper.c | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
