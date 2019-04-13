Received: from eggs.gnu.org ([209.51.188.92]:43139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBZv-0008Sn-QE
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBZu-0000Vn-17
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:51:51 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:34628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBZs-0000TD-Pf
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:51:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so6125286plt.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:51:46 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-36-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5facee3-1a0b-e316-83a8-3726e9e03c13@linaro.org>
Date: Fri, 12 Apr 2019 19:51:41 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-36-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 35/41] s390x/tcg: Implement VECTOR
 SUBTRACT COMPUTE BORROW INDICATION
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
> Let's keep it simple for now and handle 8/16/128 bit elements via helpers.
> Especially for 8/16, we could come up with some bit tricks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  3 +++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 30 +++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 47 +++++++++++++++++++++++++++++++++
>  4 files changed, 82 insertions(+)

Similar comments to add carry, really,
but what you have is not wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
