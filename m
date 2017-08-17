Received: from eggs.gnu.org ([2001:4830:134:3::10]:41872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIYu-0006YE-8W
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diIYp-0006Ew-E1
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1diIYp-0006Er-7A
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 07:01:59 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3e56aeeb-0980-ca7b-e451-c8f206ca2b99@redhat.com>
Date: Thu, 17 Aug 2017 13:01:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 01/10] target/s390x: move
 cc_name() to cc_helper.c
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
> While at it, move the translations into the function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h       | 48 +-----------------------------------------------
>  2 files changed, 49 insertions(+), 47 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
