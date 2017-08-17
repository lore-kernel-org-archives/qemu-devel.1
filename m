Received: from eggs.gnu.org ([2001:4830:134:3::10]:42777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIcV-0000ul-Nm
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIcQ-0007n6-QY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:05:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diIcQ-0007lC-Kf
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:05:42 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-5-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <794f2906-fe19-0986-3f1e-c23984b03f30@redhat.com>
Date: Thu, 17 Aug 2017 13:05:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 04/10] target/s390x: move
 s390_do_cpu_reset() to diag.c
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
> Only used in that file. Also drop the comment, not really needed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h  | 7 -------
>  target/s390x/diag.c | 7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
