Received: from eggs.gnu.org ([2001:4830:134:3::10]:45445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwck6-0002qF-T9
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwck2-00042s-V0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:24:50 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:50946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwck2-00042X-OR
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:24:46 -0400
Received: by mail-pf0-x22d.google.com with SMTP id m63so4601770pfk.7
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:24:46 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2625fc95-3120-d564-92a3-b3e9e9cdfa95@linaro.org>
Date: Mon, 25 Sep 2017 16:24:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/27] s390x/kvm: pass ipb directly into
 handle_sigp()
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
> No need to pass kvm_run.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
