Received: from eggs.gnu.org ([209.51.188.92]:50987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wy-0008Ie-0p
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wx-0002eb-5w
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:15 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5ww-0002dl-TX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:51:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id 85so5908794pgc.3
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:51:14 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2c980718-0a9d-10a9-5c39-aa2b99d99b8e@linaro.org>
Date: Fri, 12 Apr 2019 13:51:09 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 18/41] s390x/tcg: Implement VECTOR
 (MAXIMUM|MINIMUM) (LOGICAL)
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
> Luckily, we already have gvec helpers for all four cases.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  8 ++++++++
>  target/s390x/translate_vx.inc.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
