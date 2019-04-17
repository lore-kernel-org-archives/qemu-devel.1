Received: from eggs.gnu.org ([209.51.188.92]:41871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcDn-0003ff-Kq
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcDm-00085P-Mu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:55 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:33239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcDm-00084v-A7
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:30:54 -0400
Received: by mail-pg1-x533.google.com with SMTP id k19so11400799pgh.0
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:30:54 -0700 (PDT)
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ab7e798-1d68-99f8-acda-873ad94a5fae@linaro.org>
Date: Tue, 16 Apr 2019 18:30:48 -1000
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/41] tcg: Implement tcg_gen_gvec_3i()
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

On 4/16/19 8:52 AM, David Hildenbrand wrote:
> Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
> without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
> for now.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-gvec.h |  24 ++++++++
>  2 files changed, 163 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
