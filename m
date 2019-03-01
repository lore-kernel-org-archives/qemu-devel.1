Received: from eggs.gnu.org ([209.51.188.92]:60502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkuZ-00075G-6z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkuR-0005XT-W0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:17 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzkuQ-0005Q7-3Z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:14 -0500
Received: by mail-pl1-x630.google.com with SMTP id k2so11712290plt.3
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:21:09 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <465db76d-5961-ec03-0c8c-fa40de050592@linaro.org>
Date: Fri, 1 Mar 2019 08:21:05 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/32] s390x/tcg: Implement VECTOR LOAD
 GR FROM VR ELEMENT
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
> To avoid an helper, we have to do the actual calculation of the element
> address (offset in cpu_env + cpu_env) manually. Factor that out into
> get_vec_element_ptr_i64(). The same logic will be reused for "VECTOR
> LOAD VR ELEMENT FROM GR".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
