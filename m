Received: from eggs.gnu.org ([209.51.188.92]:37065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzbkt-0003CI-4f
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzbks-0007rl-CU
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:34:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:42967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzbks-0007p2-3Z
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:34:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id v11so5569104plg.9
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 22:34:45 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-15-david@redhat.com>
	<c57c068f-1c42-9cba-0f0f-3204f6648d8d@linaro.org>
	<f11109de-6ba3-5104-71b6-1245c42b282e@redhat.com>
	<864f3ba7-3115-c6f8-e018-15425ca67a72@twiddle.net>
	<f2a45ec5-fee3-ce78-c321-d2f96bca6584@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b2cdfae-54a7-72f7-7a2f-70f4d0ff996b@linaro.org>
Date: Thu, 28 Feb 2019 22:34:41 -0800
MIME-Version: 1.0
In-Reply-To: <f2a45ec5-fee3-ce78-c321-d2f96bca6584@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 14/33] s390x/tcg: Implement VECTOR LOAD
 MULTIPLE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

On 2/28/19 11:05 AM, David Hildenbrand wrote:
> So for writing from helpers, I can use probe_write(). What about testing
> write access from TCG code?
> 
> I could do a load, followed by a store of the loaded value. This should
> work in most cases (but eventually could be observed by somebody really
> wanting to observe it - which is highly unlikely).

I would call a helper for probe_write.


r~
