Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqAQu-0001XC-AC
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqAQp-0005J1-QP
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:58:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dqAQp-0005Ie-L6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 23:58:15 -0400
References: <20170907201335.13956-1-david@redhat.com>
	<20170907201335.13956-8-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ad4baf4-b325-ec96-3494-aa91a83d6173@redhat.com>
Date: Fri, 8 Sep 2017 05:58:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170907201335.13956-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 07/21] s390x: move subsystem_reset() to
 s390-virtio-ccw.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

On 07.09.2017 22:13, David Hildenbrand wrote:
> Implemented in s390-virtio-ccw.c, so move it to the right header.
> We can also drop the extern. Fix up one include.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/hw/s390x/s390-virtio-ccw.h | 2 ++
>  target/s390x/cpu.h                 | 1 -
>  target/s390x/diag.c                | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
