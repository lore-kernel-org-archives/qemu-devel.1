Received: from eggs.gnu.org ([2001:4830:134:3::10]:52945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWkQK-0008AX-3W
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 11:26:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWkQH-0002KQ-0J
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 11:26:00 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWkQG-0002K6-PP
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 11:25:56 -0400
Received: by mail-pg0-x242.google.com with SMTP id n2-v6so794607pgq.6
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 08:25:56 -0700 (PDT)
References: <20180621173635.21537-1-richard.henderson@linaro.org>
	<20180622211244.GA11346@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1319a0f0-0009-ebfc-dab4-eec196ba8ba5@linaro.org>
Date: Sat, 23 Jun 2018 08:25:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180622211244.GA11346@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Change mmap_lock to rwlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, qemu-arm@nongnu.org

On 06/22/2018 02:12 PM, Emilio G. Cota wrote:
> I'm curious to see how much perf could be gained. It seems that the hold
> times in SVE code for readers might not be very large, which
> then wouldn't let us amortize the atomic inc of the read lock
> (IOW, we might not see much of a difference compared to a regular
> mutex).

In theory, the uncontended case for rwlocks is the same as a mutex.

> Are you using any benchmark that shows any perf difference?

Not so far.  Glibc has some microbenchmarks for strings, which I will try next
week, but they are not multi-threaded.  Maybe just run 4 threads of those
benchmark?


r~
