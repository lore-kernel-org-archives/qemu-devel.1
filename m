Received: from eggs.gnu.org ([209.51.188.92]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQb6-0005Dc-H8
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQb5-00036N-IF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:19:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:39373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMQb5-00035d-5I
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:18:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id e92so2138388plb.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:18:58 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f5e80e59-726f-831d-ae58-2e8b9e5a48f3@linaro.org>
Date: Thu, 2 May 2019 22:18:54 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/40] s390x/tcg: Implement VECTOR COUNT
 TRAILING ZEROS
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

On 5/2/19 7:09 AM, David Hildenbrand wrote:
> Implement it similar to VECTOR COUNT LEADING ZEROS.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
