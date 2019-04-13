Received: from eggs.gnu.org ([209.51.188.92]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWx-00061b-P6
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWv-0006ix-K0
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBWt-0006fm-LN
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id y13so6107727pfm.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:48:42 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-34-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3b1cf982-0357-a9e0-93d0-827c1a096c44@linaro.org>
Date: Fri, 12 Apr 2019 19:48:37 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-34-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 33/41] s390x/tcg: Implement VECTOR SHIFT
 RIGHT LOGICAL *
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
> Similar to VECTOR SHIFT RIGHT ARITHMETICAL.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  target/s390x/vec_int_helper.c   |  6 ++++++
>  4 files changed, 28 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
