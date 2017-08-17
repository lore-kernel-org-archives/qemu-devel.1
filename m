Received: from eggs.gnu.org ([2001:4830:134:3::10]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIbF-0008JE-To
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIbB-0006t4-1H
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diIbA-0006sX-Rp
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:04:24 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-4-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8dad38ad-7c94-9e1f-e91a-3da3da89fe83@redhat.com>
Date: Thu, 17 Aug 2017 13:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 03/10] target/s390x: move
 psw_key_valid() to mem_helper.c
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
>  target/s390x/cpu.h        | 11 -----------
>  target/s390x/mem_helper.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
