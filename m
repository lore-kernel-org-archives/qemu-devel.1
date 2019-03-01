Received: from eggs.gnu.org ([209.51.188.92]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm4R-00064U-IT
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm4Q-00044n-Vo
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:39 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzm4Q-00044G-OL
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:35:38 -0500
Received: by mail-pg1-x544.google.com with SMTP id u9so11754950pgo.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:35:38 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-24-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <970559c8-19c6-1ccd-4249-a57c2779e414@linaro.org>
Date: Fri, 1 Mar 2019 09:35:34 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-24-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/32] s390x/tcg: Implement VECTOR
 REPLICATE IMMEDIATE
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

On 3/1/19 3:54 AM, David Hildenbrand wrote:
> Like VECTOR REPLICATE, but the element to be replicated comes from an
> immediate.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
