Received: from eggs.gnu.org ([209.51.188.92]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5NL-00053j-Nv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5NK-0000zw-U9
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:38554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5NK-0000zV-Am
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:14:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id 10so5828231pfo.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:14:26 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-11-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59b43a53-8c25-53ea-c5a8-1cd33b4011e5@linaro.org>
Date: Fri, 12 Apr 2019 13:14:19 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/41] s390x/tcg: Implement VECTOR
 ELEMENT COMPARE *
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
> +                         es | logical ? 0 : MO_SIGN);

Incorrect operator precedence.  You need:

  es | (logical ? 0 : MO_SIGN)

or

  logical ? es : es | MO_SIGN

And perhaps cse this expression into a temporary
and not replicate it between the two reads.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
