Received: from eggs.gnu.org ([209.51.188.92]:59231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkq4-0003Us-MC
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzkq4-0000ZV-2s
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:44 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzkq1-0000X3-Hs
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:16:42 -0500
Received: by mail-pl1-x642.google.com with SMTP id y5so11700783plk.8
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 08:16:41 -0800 (PST)
References: <20190301115413.27153-1-david@redhat.com>
	<20190301115413.27153-4-david@redhat.com>
	<4f8ff92c-9770-b69a-0857-2b85a87090f1@linaro.org>
	<b44d3dde-fdc0-3ba5-051d-255723d9c71c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <89c00071-7a4d-a34a-50d0-f09de72fd139@linaro.org>
Date: Fri, 1 Mar 2019 08:16:31 -0800
MIME-Version: 1.0
In-Reply-To: <b44d3dde-fdc0-3ba5-051d-255723d9c71c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] s390x/tcg: Utilities for vector
 instruction helpers
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

On 3/1/19 8:13 AM, David Hildenbrand wrote:
>> These, I think, should be static inline.  Certainly I think they're too small
>> to warrant a real call across modules, as you appear to be preparing for...
> 
> I'm wondering, won't link-time optimization properly handle this? (so
> far the theory I know of)

It would, but who does that?  It's certainly not in -O2.

I suspect -flto is a set of -Werror and other sorts of compiler appeasement
changes beyond what anyone has tried.


r~
