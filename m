Received: from eggs.gnu.org ([209.51.188.92]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzklF-0008EP-Ec
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:11:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzklE-0004Ms-Pd
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:11:45 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzklA-0004BI-UT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:11:42 -0500
Received: by mail-pg1-x543.google.com with SMTP id e17so9602678pgd.2
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:11:29 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7787c1b6-82e4-cc11-15d4-1b3e8333295d@linaro.org>
Date: Fri, 1 Mar 2019 08:11:25 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/32] s390x/tcg: Implement VECTOR
 GENERATE BYTE MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 3/1/19 3:53 AM, David Hildenbrand wrote:
> Let's optimize it for the common cases (setting a vector to zero or all
> ones) - courtesy of Richard.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate.c        |  1 +
>  target/s390x/translate_vx.inc.c | 39 +++++++++++++++++++++++++++++++++
>  3 files changed, 42 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
