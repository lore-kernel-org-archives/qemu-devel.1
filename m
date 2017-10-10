Received: from eggs.gnu.org ([2001:4830:134:3::10]:46828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1y9e-0003tO-1B
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1y9a-00017H-SZ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:17:18 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:55061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1y9a-000178-Km
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:17:14 -0400
Received: by mail-pf0-x22b.google.com with SMTP id m28so12970100pfi.11
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:17:14 -0700 (PDT)
References: <20171007155522.25436-1-sw@weilnetz.de>
	<bfac5ec4-885e-7531-2d00-ce48bf518a6d@linaro.org>
	<c01459d1-81f4-8af3-4e52-f7703ff389ea@weilnetz.de>
	<d2025f3e-d54d-e5d0-d834-6e088a6f09ec@linaro.org>
	<d72c1f3d-9f4f-ff08-4a27-e3b330333c6c@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <56334b40-29c1-2a80-1ca5-fccf82306cad@linaro.org>
Date: Tue, 10 Oct 2017 10:17:11 -0700
MIME-Version: 1.0
In-Reply-To: <d72c1f3d-9f4f-ff08-4a27-e3b330333c6c@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 10/10/2017 09:48 AM, Stefan Weil wrote:
> If we really expect more than 2^32 pages, touching all those pages
> will need a significant time even on fast machines.

Sure.  But surely taking a long time is better than silently ignoring high-bits
of a quantity.

> What about using size_t instead of uint64_t? Parts of the code already
> use size_t, and it makes a difference for QEMU running on 32 bit hosts.

I'm ok with that, so long as all of the relevant variables are changed, not
just that of "i".


r~
