Received: from eggs.gnu.org ([209.51.188.92]:44380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJimI-0008Ki-Hz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJimF-00071G-Py
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJimB-0006e7-Se
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 14:07:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id b1so679645wru.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:07:09 -0700 (PDT)
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
Date: Thu, 25 Apr 2019 20:07:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

Hi Peter, Stefan,

On 1/4/19 4:16 PM, Peter Maydell wrote:
> On Thu, 3 Jan 2019 at 14:41, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> This reverts commit 01fd41ab3fb69971c24a69ed49cde96086d81278.
>>
>> The generic loader device (-device loader,file=kernel.bin) can be used
>> to load a kernel instead of the -kernel option.  Some boards have flash
>> memory (pflash) that is set via the -pflash or -drive options.
>>
>> Allow starting QEMU without the -kernel option to accommodate these
>> scenarios.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Previous to this commit (v3.1), we have:

$ qemu-system-aarch64 -M netduino2
qemu-system-aarch64: Guest image must be specified (using -kernel)

Now (v4.0) we get:

$ qemu-system-aarch64 -M netduino2
qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=00000000 R01=00000000 R02=00000000 R03=00000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=00000000
XPSR=40000003 -Z-- A handler
FPSCR: 00000000
Aborted (core dumped)

This is confusing.

(same happens with emcraft-sf2, microbit, musca-*)

Regards,

Phil.
