Received: from eggs.gnu.org ([209.51.188.92]:45189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzlxH-0001hQ-R0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:28:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzlxH-0007yk-0z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:28:15 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzlxG-0007yF-OF
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:28:14 -0500
Received: by mail-pf1-x442.google.com with SMTP id n22so11734976pfa.3
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 09:28:14 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11898cbe-3f98-4c2e-90f0-8b4c0048e835@linaro.org>
Date: Fri, 1 Mar 2019 09:28:09 -0800
MIME-Version: 1.0
In-Reply-To: <20190301115413.27153-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/32] s390x/tcg: Implement VECTOR PACK *
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

On 3/1/19 3:54 AM, David Hildenbrand wrote:
> +    static gen_helper_gvec_3 * vpk[3] = {

                                  ^ const

and so on for the other static arrays.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
