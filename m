Received: from eggs.gnu.org ([2001:4830:134:3::10]:51691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfRdc-00060A-I9
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfRdX-0005Uw-L1
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:07:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org> <87mv7aumav.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
Date: Wed, 9 Aug 2017 11:06:59 -0300
MIME-Version: 1.0
In-Reply-To: <87mv7aumav.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 18/47] MAINTAINERS: add missing TCG entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 08/08/2017 12:11 PM, Alex Bennée wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
[...]>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8cb94af6c5..6b83dac812 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1633,6 +1633,7 @@ Common code
>>   M: Richard Henderson <rth@twiddle.net>
>>   S: Maintained
>>   F: tcg/
>> +F: disas.c
> 
> Is this really TCG only? Can't the monitor call monitor_disas in any
> mode?

Indeed, this doesn't seem TCG only.

Do you think there should be another entry in "Block QAPI, monitor, 
command line"?
or this file (and related include) rather deserves an own section 
(possibly tagged Odd Fixes) to unburden Richard?
