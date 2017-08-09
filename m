Received: from eggs.gnu.org ([2001:4830:134:3::10]:38392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dfS82-0002ZE-24
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:38:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dfS7z-0003W4-0m
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:38:34 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dfS7y-0003UT-N0
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:38:30 -0400
Received: by mail-wr0-x232.google.com with SMTP id k71so24755373wrc.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 07:38:30 -0700 (PDT)
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-19-f4bug@amsat.org>
	<87mv7aumav.fsf@linaro.org>
	<8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8e2e3aa5-4459-76ba-3309-af6b30220346@amsat.org>
Date: Wed, 09 Aug 2017 15:38:27 +0100
Message-ID: <87fud0vmak.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> On 08/08/2017 12:11 PM, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> [...]>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8cb94af6c5..6b83dac812 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1633,6 +1633,7 @@ Common code
>>>   M: Richard Henderson <rth@twiddle.net>
>>>   S: Maintained
>>>   F: tcg/
>>> +F: disas.c
>>
>> Is this really TCG only? Can't the monitor call monitor_disas in any
>> mode?
>
> Indeed, this doesn't seem TCG only.
>
> Do you think there should be another entry in "Block QAPI, monitor,
> command line"?
> or this file (and related include) rather deserves an own section
> (possibly tagged Odd Fixes) to unburden Richard?

Well the default for un-matched files is qemu-devel right? It would be
nice for it to be properly maintained but that requires someone to
step-up to the plate.

--
Alex Bennée
