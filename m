Received: from eggs.gnu.org ([2001:4830:134:3::10]:46124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBU34-0002qy-Et
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBU31-0004PA-8w
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:37:34 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dBU31-0004OC-3i
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:37:31 -0400
Received: by mail-oi0-x241.google.com with SMTP id m17so9736995oik.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:37:31 -0700 (PDT)
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<20170518190052.qxzzcpurulnghlog@aurel32.net>
From: Rob Landley <rob@landley.net>
Message-ID: <53613c44-1785-28f1-ae60-22adac96c8ad@landley.net>
Date: Thu, 18 May 2017 17:37:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170518190052.qxzzcpurulnghlog@aurel32.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org, Rich Felker <dalias@libc.org>



On 05/18/2017 02:00 PM, Aurelien Jarno wrote:
> On 2017-05-18 11:08, Rob Landley wrote:
>> Serial input hangs after the first character in the 4.11 kernel:
>>
>>   http://www.spinics.net/lists/linux-sh/msg51183.html
>>
>> Because they enabled support for a buffer size thing QEMU doesn't
>> emulate right:
>>
>>   http://www.spinics.net/lists/linux-sh/msg51189.html
> 
> Indeed the SCIF emulation in QEMU is quite limited. The problem is that
> it exposes many internal states to the software (and that's the same for
> the SH4 CPU in general), and that's not really compatible with quick
> emulation. In that case the timer should depend on the baud rate which
> we don't really emulate.
> 
> I'll try to have a look, that said my test environment is stuck with
> kernel 4.8 due to the broken futex support on UP in kernel 4.9 (and
> that's not QEMU specific). I'll try to build a more recent kernel with
> additional patches.

I thought Rich fixed that. Rich?

I'm doing a new https://github.com/landley/mkroot thing on top of Rich's
musl-cross-make toolchain, but it's still cooking and the kernels it
builds are really simple so far.

Rob
