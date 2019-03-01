Received: from eggs.gnu.org ([209.51.188.92]:59332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkqQ-0003lK-US
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkqQ-0000uu-9X
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:17:06 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzkqQ-0000uI-2S
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:17:06 -0500
Received: by mail-pf1-x442.google.com with SMTP id h1so11641286pfo.7
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:17:06 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d33f9e22-e6e2-e4d0-f455-19de3217012a@linaro.org>
Date: Fri, 1 Mar 2019 08:17:02 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/32] s390x/tcg: Implement VECTOR LOAD
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
> When loading from memory, load both elements into temps first before
> modifying the target vector
> 
> Loading with strange alingment from the end of the address space will
> not properly wrap, we can ignore that for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  3 +++
>  target/s390x/translate_vx.inc.c | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
