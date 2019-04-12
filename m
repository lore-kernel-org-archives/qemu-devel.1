Received: from eggs.gnu.org ([209.51.188.92]:46051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5UE-0007uO-Se
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5UE-000439-1P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:34 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5UD-00042m-L2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:21:33 -0400
Received: by mail-pf1-x444.google.com with SMTP id 8so5836907pfr.4
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:21:33 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03a8bd4b-3f26-445c-3a50-81fca2fe6a99@linaro.org>
Date: Fri, 12 Apr 2019 13:21:28 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/41] s390x/tcg: Implement VECTOR COUNT
 LEADING ZEROS
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

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> For 8/16, use the 32 bit variant and properly subtract the added
> leading zero bits.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 49 insertions(+)
> 
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
