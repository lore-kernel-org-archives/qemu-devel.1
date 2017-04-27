Received: from eggs.gnu.org ([2001:4830:134:3::10]:50344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3hy7-0001KZ-VQ
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d3hy6-0007HL-Vf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:52:20 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d3hy6-0007H5-On
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 07:52:18 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l9so15675386wre.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 04:52:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <tencent_0B0C9551621D40450A004D34@qq.com>
References: <tencent_0B0C9551621D40450A004D34@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Apr 2017 12:51:56 +0100
Message-ID: <CAFEAcA_SX0HNMbSf-yN1Hs99RHz_ff1ieFj8i-qnWb+CAvCMHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu integrator hardware error: icp_control_write:
 Bad offset 789688
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: heavybird <4345099@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 27 April 2017 at 04:23, heavybird <4345099@qq.com> wrote:
> Hi Peter,
>
> I am using your qemu integrator to debug my application but it encouters the
> exception below, i have no idea to figure out the message below. could you
> give me some suggestion or show me some document to get out this issues?? i
> noticed there is trace option in the qeumu, but don't know how to use it
> more efficently.
>
> thanks.
> jason
>
> qemu: hardware error: icp_control_write: Bad offset 789688
>
> CPU #0:
> R00=00000000 R01=cb789688 R02=00000000 R03=00000000
> R04=00109a0c R05=00000505 R06=00000606 R07=00000707
> R08=00000808 R09=00000909 R10=00001010 R11=0010c46c
> R12=0000000a R13=0007e000 R14=00000028 R15=00000004
> PSR=600001db -ZC- A und32

Looks like your guest tried to write to address
0xcb789688, which is either part of a device we
don't emulate, or more likely just a bogus address.
(you can see that value in register r01 matching up
with the offset in the error message).
Your guest is probably buggy and I suggest debugging
why it's writing there.

thanks
-- PMM
