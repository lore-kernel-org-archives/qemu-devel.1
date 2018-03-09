Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLb6-0006W8-Qe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLb3-00082Y-Mb
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:24 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1euLb3-00082L-EY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:14:21 -0500
Received: by mail-wr0-x231.google.com with SMTP id o8so9719612wra.1
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 09:14:21 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180309153654.13518-1-f4bug@amsat.org>
	<CAFEAcA-RQT8a6tJ9Radqt3_n=cP6FhyNcjNfJa6VyN=jtS_GZw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <40c2f50f-7e4e-8603-9f8f-d5eb367021bb@amsat.org>
Date: Fri, 9 Mar 2018 18:14:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RQT8a6tJ9Radqt3_n=cP6FhyNcjNfJa6VyN=jtS_GZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] SDCard: improve tracing, support UHS-I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 03/09/2018 06:08 PM, Peter Maydell wrote:
> On 9 March 2018 at 15:36, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> This series contains the leftover patches from these 2 series:
>> - SDCard: housekeeping, add tracing (part 4)
>> - SDCard: bugfixes, support UHS-I (part 5)
>> with Peter Maydell comments addressed.
>>
>> I misunderstood the 2.12 train deadline, but better to have the series
>> standing in the list rather than forgot it.
>>
>> Philippe Mathieu-Daudé (8):
>>   sdcard: Do not trace CMD55, except when we already expect an ACMD
>>   sdcard: Display command name when tracing CMD/ACMD
>>   sdcard: Display which protocol is used when tracing (SD or SPI)
>>   sdcard: Add the Tuning Command (CMD19)
>>   sdcard: Implement the UHS-I SWITCH_FUNCTION entries (Spec v3)
>>   sdcard: Add a 'uhs' property, update the OCR register ACCEPT_SWITCH_1V8 bit
>>   sdhci: Fix a typo in comment
>>   MAINTAINERS: Add entries for SD (SDHCI, SDBus, SDCard)
> 
> Thanks. I've applied patches 1-4, 7 and 8 to target-arm.next, so
> they will make 2.12. Patches 5 and 6 I had review comments on.

Thanks \o/

> 
> (We may be able to call 5/6 bugfix patches and get them into 2.12;
> depends on timing.)

I'll do my best, the "misc" pull didn't hit the list yet :)

Phil.
