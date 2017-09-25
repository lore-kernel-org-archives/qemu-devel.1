Received: from eggs.gnu.org ([2001:4830:134:3::10]:51129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd7i-00058s-6b
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd7f-0004wC-54
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:49:14 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:51842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwd7e-0004w0-Tv
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:49:11 -0400
Received: by mail-pg0-x235.google.com with SMTP id k193so4914836pgc.8
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:49:10 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a546be0b-48e8-5295-9c65-248e522efe39@linaro.org>
Date: Mon, 25 Sep 2017 16:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 16/27] s390x/kvm: factor out SIGP code
 into sigp.c
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

On 09/18/2017 09:00 AM, David Hildenbrand wrote:
> We want to use the same code base for TCG, so let's cleanly factor it
> out.
> 
> The sigp mutex is currently not really needed, as everything is
> protected by the iothread mutex. But this could change later, so leave
> it in place and initialize it properly from common code.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c |   3 +
>  target/s390x/Makefile.objs |   1 +
>  target/s390x/cpu.c         |   8 -
>  target/s390x/cpu.h         |   6 +-
>  target/s390x/internal.h    |   4 +
>  target/s390x/kvm-stub.c    |   5 -
>  target/s390x/kvm.c         | 349 +-----------------------------------------
>  target/s390x/kvm_s390x.h   |   1 -
>  target/s390x/sigp.c        | 366 +++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/trace-events  |   4 +-
>  10 files changed, 388 insertions(+), 359 deletions(-)
>  create mode 100644 target/s390x/sigp.c


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
