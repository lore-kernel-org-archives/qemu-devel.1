Received: from eggs.gnu.org ([2001:4830:134:3::10]:41447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcWP-0003l6-T4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcWK-00079J-UI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:10:41 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:54508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcWK-00078V-Nd
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:10:36 -0400
Received: by mail-pg0-x230.google.com with SMTP id c137so4865424pga.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:10:36 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17f707d2-9fd7-470d-72ce-b706971bc46b@linaro.org>
Date: Mon, 25 Sep 2017 16:10:32 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/27] s390x: raise CPU hotplug irq
 after really hotplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> Let's move it into the machine, so we trigger the IRQ after setting
> ms->possible_cpus (which SCLP uses to construct the list of
> online CPUs).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 4 ++++
>  target/s390x/cpu.c         | 8 --------
>  2 files changed, 4 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
