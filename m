Received: from eggs.gnu.org ([2001:4830:134:3::10]:47021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSmhy-00080G-OJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSmhv-0000x5-MS
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:59:18 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSmhv-0000wg-HO
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:59:15 -0400
Received: by mail-pg0-x22b.google.com with SMTP id j186so126369724pge.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 08:59:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170608184944.19406-1-mrolnik@gmail.com>
	<CAK4993hiFSozkL-5B0gud-nPVFqcvP2mgBR1Rk1vQSmhts3fGQ@mail.gmail.com>
	<7103e7ca-1504-58b0-1f32-aabba7f45792@twiddle.net>
	<CAK4993j5SEAqySt4VQhXCwAkbU09+4YUfiaw8zypvW3803GJ_A@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <517fcd97-6664-025d-dc03-114bc5b49dff@twiddle.net>
Date: Wed, 5 Jul 2017 05:59:08 -1000
MIME-Version: 1.0
In-Reply-To: <CAK4993j5SEAqySt4VQhXCwAkbU09+4YUfiaw8zypvW3803GJ_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v19 00/13] QEMU AVR 8 bit cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Rolnik <mrolnik@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anichang <anichang@protonmail.ch>

On 07/04/2017 08:34 PM, Michael Rolnik wrote:
> Hi Richard.
> 
> Thank you for finding a bug.
> As for the testing
> 1. I have a small program that calculates fibonacci numbers. I use it to test 
> mainly stack operations for different CPU flavors (1, 2 or 3 bytes PC).
> 2. I manually verified that I can debug with gdb, that includes
>      a. stepping
>      b. running
>      c. stopping
>      d. breakpoints
>      e. backtrace shows correct stack
> 3. I manually verified that I can save and load vm states
> 4. `make check` passes
> 
> If you please point me to a doc that explains how automatic unit tests can be 
> added to a QEMU target, I will happily add them.

Can you boot an AVR kernel?

How about the environment that newlib builds with libgloss?  With that you'd be 
able to run the gcc testsuite, which would be extremely helpful.


r~
