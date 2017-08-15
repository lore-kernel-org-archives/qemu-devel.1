Received: from eggs.gnu.org ([2001:4830:134:3::10]:43057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dhYDS-0000fB-4u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dhYDO-0006I2-Vy
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:32:50 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:37586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dhYDO-0006H0-NL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 05:32:46 -0400
Received: by mail-wr0-x22e.google.com with SMTP id o62so1439078wrc.4
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 02:32:45 -0700 (PDT)
References: <20170810085025.14076-1-famz@redhat.com>
	<0d899b2a-19a0-5b52-c63e-dba8b1d2d851@amsat.org>
	<20170815070927.GB29320@lemon>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170815070927.GB29320@lemon>
Date: Tue, 15 Aug 2017 10:32:42 +0100
Message-ID: <87inhpdvlx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Let "make check-help" work
 without running ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> On Thu, 08/10 08:59, Philippe Mathieu-Daudé wrote:
>> Hi Fam,
>>
>> thank for fixing this :)
>>
>> I think as a bugfix it should enter 2.10
>> (maybe through Alex's Travis series, CC'ing him)
>
> Since Alex hasn't replied, I'll send a pull request for -rc3.

Yes please. Sorry I got distracted by other stuff.

>
>>
>> On 08/10/2017 05:50 AM, Fam Zheng wrote:
>> > Currently if you do "make check-help" in a fresh checkout, only an error
>> > is printed which is not nice:
>> >
>> >      $ make check-help V=1
>> >      cc -nostdlib  -o check-help.mo
>> >      cc: fatal error: no input files
>> >      compilation terminated.
>> >      rules.mak:115: recipe for target 'check-help.mo' failed
>> >      make: *** [check-help.mo] Error 1
>> >
>> > Move the config-host.mak condition into the body of
>> > tests/Makefile.include and always include the rule for check-help.
>> >
>> > Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
>
> Fam


--
Alex Bennée
