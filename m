Received: from eggs.gnu.org ([209.51.188.92]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzl1V-0004tx-74
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzl1U-0003jC-Kg
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:28:33 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:37913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzl1U-0003i4-Bq
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:28:32 -0500
Received: by mail-pf1-x435.google.com with SMTP id n125so11661798pfn.5
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:28:31 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e640dbe-5654-3767-1180-52f991aafcdd@linaro.org>
Date: Fri, 1 Mar 2019 08:28:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/32] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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
> We cannot use gvec expansion as source and destination elements are
> have different element numbers. So we'll expand using a fancy loop.
> Also, we have to take care of overlapping source and destination
> registers, therefore use a safe evaluation irder depending on the
> operation.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 42 +++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
