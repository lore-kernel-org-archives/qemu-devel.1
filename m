Received: from eggs.gnu.org ([2001:4830:134:3::10]:44506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcgU-0000ML-Kt
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwcgQ-0002lE-CK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:21:06 -0400
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233]:54529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwcgQ-0002jv-5n
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:21:02 -0400
Received: by mail-pg0-x233.google.com with SMTP id c137so4878671pga.11
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:21:02 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7f808ea-ecb2-b928-3cbd-e13c4dcddf9b@linaro.org>
Date: Mon, 25 Sep 2017 16:20:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 08/27] s390x/tcg: a CPU cannot switch
 state due to an interrupt
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
> Going to OPERATING here looks wrong. A CPU should even never be
> !OPERATING at this point. Unhalting will already be done in
> cpu_handle_halt() if there is work, so we can drop this statement
> completely.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
