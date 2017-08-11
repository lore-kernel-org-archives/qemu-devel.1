Received: from eggs.gnu.org ([2001:4830:134:3::10]:35459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAuB-00034g-F5
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAu7-0004UD-CO
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:27:15 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dgAu7-0004U5-8C
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:27:11 -0400
Received: by mail-qk0-x242.google.com with SMTP id m84so3626373qki.5
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:27:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <3710e9b8-4b16-1bcc-da17-80fb2cc2c644@adacore.com>
	<CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <06229d4d-3aba-e7e1-c650-b5e4b165171d@amsat.org>
Date: Fri, 11 Aug 2017 11:27:07 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-WJizoHGftAaHgNTmL5kTXM-yyFZBxVRBHU_K4BQ6edQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] big endian arm.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 08/11/2017 07:18 AM, Peter Maydell wrote:
> On 11 August 2017 at 10:59, KONRAD Frederic <frederic.konrad@adacore.com> wrote:
[...]>> It seems that when I try to load a big endian image on a
>> Cortex-R5 it gets confused:
>>   * the instructions are fine it executes some code.
>>   * GDB address / insns are wrong endianness.
>>   * in monitor x command is good endianness.
>>   * the data order seems to be wrong endianness:
>>     Here is my Hello World: lleHlroW
> 
[...]
> 
> Dunno about the gdbstub stuff.

Frederic you might try/improve those patches:

[PATCH v3 4/7] ARM big-endian semihosting support.
[PATCH v3 5/7] ARM big-endian system-mode gdbstub support.

see:
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg04386.html
http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg00843.html

Regards,

Phil.
