Received: from eggs.gnu.org ([2001:4830:134:3::10]:58477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.frederic@yahoo.fr>) id 1cjtDR-0007fX-90
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.frederic@yahoo.fr>) id 1cjtDO-0003Ay-7r
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:13 -0500
Received: from nm32.bullet.mail.ir2.yahoo.com ([212.82.96.57]:43629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <konrad.frederic@yahoo.fr>) id 1cjtDN-0003A2-S9
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:50:10 -0500
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
From: =?UTF-8?B?RnLDqWTDqXJpYyBLb25yYWQ=?= <konrad.frederic@yahoo.fr>
Message-ID: <d60e33d6-6ef1-c61a-a187-5798e5b36d35@yahoo.fr>
Date: Fri, 3 Mar 2017 20:50:06 +0100
MIME-Version: 1.0
In-Reply-To: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nutaro, James J." <nutarojj@ornl.gov>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Jim,

I think Alex and Paolo worked on an mttcg/icount issue.
Not sure if its related or not.

Fred

On 03/03/2017 08:38 PM, Nutaro, James J. wrote:
> My original problem seems to stem from something that changed in the way that device emulation and instruction execution interact (I'm guessing). To reproduce the issue, I started a linux image with
> 
> qemu-system-i386 -rtc clock=vm -monitor none -icount 1,sleep=off jack.img
> 
> After booting, I run
> 
> ping localhost
> 
> The first round trip time reports look reasonable, being in the millisecond to sub-millisecond range. These occur while the emulator is running slower than real time. 
> 
> After a bit, the emulator speeds up (skipping over idle periods during I/O?) and the round trip times jump to hundreds of milliseconds, which I had not expected.
> 
> If you want to try this experiment yourself, you can get the disk image that I used from here:
> 
> http://www.ornl.gov/~1qn/qemu-images/jack.img
> 
> 
> Jim
> 
