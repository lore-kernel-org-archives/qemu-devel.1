Received: from eggs.gnu.org ([2001:4830:134:3::10]:41052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1ehIn0-0001YH-By
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar_kulk@yahoo.com>) id 1ehImv-0001QX-VO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:36:46 -0500
Received: from sonic309-14.consmr.mail.bf2.yahoo.com ([74.6.129.124]:38243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sridhar_kulk@yahoo.com>)
	id 1ehImv-0001OY-QB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:36:41 -0500
Date: Thu, 1 Feb 2018 17:36:35 +0000 (UTC)
From: sridhar kulkarni <sridhar_kulk@yahoo.com>
Reply-To: sridhar kulkarni <sridhar_kulk@yahoo.com>
Message-ID: <1484301432.1457228.1517506595503@mail.yahoo.com>
In-Reply-To: <CAFEAcA-OSN4MVVr6hbMVwiFs-tYVFH8hW5QvF3KvyXZPsEZpKQ@mail.gmail.com>
References: <1972503886.3523325.1517308471375.ref@mail.yahoo.com>
	<1972503886.3523325.1517308471375@mail.yahoo.com>
	<20180130115510.GA13988@xz-mi>
	<75114832.1210415.1517487560355@mail.yahoo.com>
	<CAFEAcA-OSN4MVVr6hbMVwiFs-tYVFH8hW5QvF3KvyXZPsEZpKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Savevm and loadvm not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

 

    On Thursday, February 1, 2018 5:56 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
 

 On 1 February 2018 at 12:19, sridhar kulkarni via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> I thought that RAM contents are not saved because of return value RAM_SAVE_CONTROL_NOT_SUPP. Now that you clarified about this, I debugged this further. After doing loadvm operation, I am getting following error,qemu-system-arm: error while loading state for instance 0x0 of device 'cpu'
> qemu-system-arm: Error -1 while loading VM state
> I figured out that, this error is because of following function returning FALSE. "write_raw_cp_reg" writes a value and "read_raw_cp_reg" reads the value back. There is mismatch between what we write and what is being read back, and hence function returns FALSE.
> Between I want to mention that, I am trying the snapshot on a VM which runs ARM 7 core. I am not sure if this snapshot feature is fully function for ARM targets.

It is supposed to work for ARM, and it does for
the CPUs I've tested it with. Which exact CPU
model are you using? (Do you really mean "ARM 7"?
We don't support that. We have ARMv7 architecture
CPUs like the cortex-a9 -- did you mean one of those?)

Are you using an unmodified upstream QEMU? We don't
have an "arm-machine" board model which is what your
command line is using with "-M arm-machine", so if
you're using a modified QEMU it's possible those
modifications haven't been written to support VM
state saving.

The next step in debugging would be to run QEMU under
gdb or add tracing printfs so that you can identify
which emulated system register it is that is causing the
failure.

Sorry I meant to say arm a7. We are using a custom board "arm-machine" which is based on Vexpress-a15 but we use a7 core. I learnt reading through web sources that A7 emulation is not supported in qemu. Is this causing this behaviour? But in general we are able to run all our code on this virtual board without any issues. While doing snapshot, this problem is seen.

thanks
-- PMM

   
