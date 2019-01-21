Received: from eggs.gnu.org ([209.51.188.92]:34431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gladF-0006x0-OH
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gladE-0003H4-2k
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:32:57 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gladD-0003GJ-UZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:32:56 -0500
Received: by mail-oi1-x242.google.com with SMTP id i6so14678102oia.6
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 06:32:55 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20190118185402.3065-1-peter.maydell@linaro.org>
	<75f3486c-a1a9-6025-16af-e9a34cc4a663@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <840a3bb1-1f60-50a6-5adb-2e3424a2d6b5@acm.org>
Date: Mon, 21 Jan 2019 08:32:50 -0600
MIME-Version: 1.0
In-Reply-To: <75f3486c-a1a9-6025-16af-e9a34cc4a663@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 1/21/19 12:19 AM, Thomas Huth wrote:
> On 2019-01-18 19:54, Peter Maydell wrote:
>> The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
>> The frequency of this failure has recently gone up sharply to the
>> point that I'm having to retry the NetBSD build multiple times
>> to get a pass when merging pull requests.
>>
>> Disable the test until we can figure out why it's failing.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Fed up with this failing all the time so let's just turn it off.
>> Feel free to investigate what's actually going wrong with it...
>>
>>   tests/Makefile.include | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index eaa81ee1d07..5e6b2c7058d 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -186,7 +186,8 @@ check-qtest-i386-$(CONFIG_SGA) += tests/boot-serial-test$(EXESUF)
>>   check-qtest-i386-$(CONFIG_SLIRP) += tests/pxe-test$(EXESUF)
>>   check-qtest-i386-y += tests/rtc-test$(EXESUF)
>>   check-qtest-i386-y += tests/ipmi-kcs-test$(EXESUF)
>> -check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
>> +# Disabled temporarily as it fails intermittently especially under NetBSD VM
>> +# check-qtest-i386-y += tests/ipmi-bt-test$(EXESUF)
>>   check-qtest-i386-y += tests/i440fx-test$(EXESUF)
>>   check-qtest-i386-y += tests/fw_cfg-test$(EXESUF)
>>   check-qtest-i386-y += tests/drive_del-test$(EXESUF)
> Acked-by: Thomas Huth <thuth@redhat.com>

Acked-by: Corey Minyard <minyard@acm.org>

I'll try to figure out why it's failing.  I assume I'll need a freebsd 
system.

Thanks,

-corey
