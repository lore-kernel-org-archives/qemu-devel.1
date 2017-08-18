Received: from eggs.gnu.org ([2001:4830:134:3::10]:54159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijlq-0004cs-OH
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dijll-00087A-NT
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:05:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dijll-000866-HA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:05:09 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-7-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ece342b7-692f-6a59-5097-2099898e721e@redhat.com>
Date: Fri, 18 Aug 2017 18:04:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170818114353.13455-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 06/18] s390x/cpumodel: factor
 out determination of default model name
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
> Now we can drop inclusion of "sysemu/kvm.h" from "s390-virtio.c".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio.c    | 7 +------
>  target/s390x/cpu.h        | 1 +
>  target/s390x/cpu_models.c | 8 ++++++++
>  3 files changed, 10 insertions(+), 6 deletions(-)
>

Reviewed-by: Thomas Huth <thuth@redhat.com>
