Received: from eggs.gnu.org ([209.51.188.92]:46362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5Vz-0000Bb-PA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5Vz-0004lx-1T
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:43558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5Vy-0004ld-MB
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:23:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id n8so5802377plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:23:22 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb483994-1809-d628-df9b-983736c66315@linaro.org>
Date: Fri, 12 Apr 2019 13:23:17 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/41] s390x/tcg: Implement VECTOR COUNT
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

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +        s390_vec_write_element##BITS(v1, i, ctz32(a));                         

Wrong result for a == 0.  You need a ? ctz32(a) : BITS.


r~
