Received: from eggs.gnu.org ([209.51.188.92]:47297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm6H-0007PS-Iv
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:37:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzm6G-0005lU-Qg
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:37:33 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzm6G-0005kF-JO
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:37:32 -0500
Received: by mail-pg1-x543.google.com with SMTP id u9so11757174pgo.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:37:32 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-26-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f909a3eb-1ae8-7f4e-f3de-bfa75c0f9844@linaro.org>
Date: Fri, 1 Mar 2019 09:37:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-26-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 25/32] s390x/tcg: Implement VECTOR SELECT
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
> Provide an implementation based on i64 and on real host vectors.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
