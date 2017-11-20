Received: from eggs.gnu.org ([2001:4830:134:3::10]:59824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGpgv-0007wu-TN
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGpgu-00059b-PL
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:05 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGpgu-00059G-Ia
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:17:04 -0500
Received: by mail-wr0-x22e.google.com with SMTP id k18so3790149wre.1
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 09:17:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171120152411.GD7197@localhost.localdomain>
References: <20171117181653.20651-1-kwolf@redhat.com>
	<CAFEAcA8Y9OpRpSkQwAHPaN8gAPen7M3kJmLi4FDLB7DWBKV1WA@mail.gmail.com>
	<20171120152411.GD7197@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:16:42 +0000
Message-ID: <CAFEAcA_fnQYQcVBmbs=xPU2tJg_u6gbW5M+5HuLGb6TLqVad2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/25] Block layer patches for 2.11.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 20 November 2017 at 15:24, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 20.11.2017 um 15:53 hat Peter Maydell geschrieben:
>>   GTESTER tests/test-replication
>> **
>> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/test-replication.c:117:test_blk_write:
>> assertion failed: (async_ret == 0)
>> GTester: last random seed: R02S7bcadec8b2ecdf71fa8abd7f833c90f5
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:863:
>> recipe for target 'check-tests/test-replication' failed
>
> I'll try to reproduce this, but so far I don't seem to be able to get it
> to fail on my main laptop.

As you point out on IRC, I actually applied this on Friday.
Nonetheless I do see this failure at least some of the time.

The problem here actually turns out to be in my setup. If the
test printed the (human readable) errno this would have been
much faster to debug -- the write is failing ENOSPC.

thanks
-- PMM
