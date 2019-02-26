Received: from eggs.gnu.org ([209.51.188.92]:36419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhj5-0002OX-RG
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhj1-0001ui-RC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:10 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyhiy-0001gK-AU
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:45:06 -0500
Received: by mail-pl1-x643.google.com with SMTP id m10so6634845plt.10
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:44:53 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc885681-3b65-11b7-4aa9-686ad45ac9bc@linaro.org>
Date: Tue, 26 Feb 2019 10:44:49 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/33] s390x/tcg: Implement VECTOR
 GATHER ELEMENT
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

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> Let's start with a more involved one, but it is the first in the list
> of vector support instructions (introduced with the vector facility).
> 
> Good thing is, we need a lot of basic infrastructure for this. Reading
> and writing vector elements, checking element validity as well as loading
> vector elements from memory. Storing will be added later, once needed.
> 
> All vector instruction related translation functions will reside in
> translate_vx.inc.c, to be included in translate.c - similar to how
> other architectures handle it.
> 
> While at it, directly add some documentation (which contains parts about
> things added in follow-up patches, but splitting this up does not make
> too much sense).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
