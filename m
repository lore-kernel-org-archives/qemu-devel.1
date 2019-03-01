Received: from eggs.gnu.org ([209.51.188.92]:60675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkvB-0007ao-8T
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:22:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkvA-0006Z2-FJ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:22:01 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzkv6-0006Vn-NI
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:58 -0500
Received: by mail-pl1-x641.google.com with SMTP id bj4so11708140plb.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:21:56 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2eb985d2-2a53-a615-dd51-7f44ed37e552@linaro.org>
Date: Fri, 1 Mar 2019 08:21:51 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/32] s390x/tcg: Implement VECTOR LOAD
 LOGICAL ELEMENT AND ZERO
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
> Fairly easy, zero out the vector before we load the desired element.
> Load the element before touching the vector.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 46 +++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
