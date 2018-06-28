Received: from eggs.gnu.org ([2001:4830:134:3::10]:37108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYZ8s-000225-2A
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYZ8p-0000LC-0C
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:47:30 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:32979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYZ8o-0000KY-QX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:47:26 -0400
Received: by mail-pf0-x241.google.com with SMTP id b17-v6so2796622pfi.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:47:26 -0700 (PDT)
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<20180627043328.11531-34-richard.henderson@linaro.org>
	<87sh57uhva.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6a72cd5-d4c9-ee47-434d-1576a5e455d3@linaro.org>
Date: Thu, 28 Jun 2018 08:47:23 -0700
MIME-Version: 1.0
In-Reply-To: <87sh57uhva.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 33/35] target/arm: Implement
 SVE dot product (indexed)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org

On 06/28/2018 07:04 AM, Alex Bennée wrote:
> Looking at the dissembler output I guess the metrics don't make it worth
> the compiler vectorising any of this which is a shame.

I think dot product pattern recognition is still being worked on.  At least
that's what I recall from a conversation from Richard Sandiford a few weeks ago.


r~
