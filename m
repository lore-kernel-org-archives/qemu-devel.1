Received: from eggs.gnu.org ([2001:4830:134:3::10]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijKa-0004fn-IR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijKX-0002EL-EK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijKX-0002DS-7b
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 11:37:01 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3b3cea0c-3411-00c6-b10f-f13396f18988@redhat.com>
Date: Fri, 18 Aug 2017 17:36:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 01/18] s390x/kvm: drop KVMState
 parameter from s390_get_memslot_count()
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
> Not needed at that point.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/sclp.c    | 2 +-
>  target/s390x/cpu.h | 8 ++++----
>  target/s390x/kvm.c | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
