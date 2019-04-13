Received: from eggs.gnu.org ([209.51.188.92]:53926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Do-0006Ua-8j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6Dn-0004gI-GM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:40 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:43620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6Dn-0004fQ-3N
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:08:39 -0400
Received: by mail-pl1-x62a.google.com with SMTP id n8so5838378plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:08:39 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-27-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <614f17af-4445-a3f5-62b4-30a8a05de8d8@linaro.org>
Date: Fri, 12 Apr 2019 14:08:34 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-27-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 26/41] s390x/tcg: Implement VECTOR
 POPULATION COUNT
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
> Similar to VECTOR COUNT TRAILING ZEROES.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 19 +++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++++
>  4 files changed, 37 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
