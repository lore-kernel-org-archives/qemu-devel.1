Received: from eggs.gnu.org ([209.51.188.92]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzogG-0001V1-7m
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzogE-0001F4-4q
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:22:51 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzog7-0000pa-1e
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 15:22:48 -0500
Received: by mail-pf1-x443.google.com with SMTP id u9so11936760pfn.1
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 12:22:42 -0800 (PST)
References: <20190301134709.4695-1-eric.auger@redhat.com>
	<20190301134709.4695-2-eric.auger@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48f9a583-b3ed-7e46-dd8b-e47d8b387901@linaro.org>
Date: Fri, 1 Mar 2019 12:22:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190301134709.4695-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 01/10] hw/arm/boot: introduce
 fdt_add_memory_node helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: pbonzini@redhat.com, drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

On 3/1/19 5:47 AM, Eric Auger wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> We introduce an helper to create a memory node.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 
> ---
> v7 -> v8:
> - Added Igor's R-b
> 
> v6 -> v7:
> - msg error in the caller
> - add comment about NUMA ID
> ---
>  hw/arm/boot.c | 54 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
