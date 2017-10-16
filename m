Received: from eggs.gnu.org ([2001:4830:134:3::10]:42095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44Q4-0006nf-W1
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e44Q2-0006Gk-46
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:22:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e44Q1-0006FQ-TE
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 08:22:54 -0400
References: <20171013054842.32120-1-sw@weilnetz.de>
	<dacdf7e7-0b16-99a0-ab50-ea7a458e0ec6@amsat.org>
	<4028eece-c9ff-113a-3cab-1a95c9ce79cc@redhat.com>
	<81efd75c-0716-c149-c483-6cf487748ab5@weilnetz.de>
	<2be5f194-ccc4-d3cc-6001-feae580e77e1@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f1681f83-c337-1b40-a98d-d4d740f6f576@redhat.com>
Date: Mon, 16 Oct 2017 14:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <2be5f194-ccc4-d3cc-6001-feae580e77e1@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] oslib-posix: Fix compiler warning and
 some data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 15/10/2017 19:53, Stefan Weil wrote:
>> I see your arguments. Maybe that part can be removed from my patch
>> when it is applied, or should I send a v3 (cc'ing qemu-trivial)?

Sending v3 to trivial makes sense.

> While thinking more about that line of code, I wonder whether
> it would make sense to replace the byte r/w by a 32 bit r/w.
> Would that be faster on architectures with a 32 bit memory bus?

In practice this goes to the cache, so it's not affected by the size of
the write.

Paolo
