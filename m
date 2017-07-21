Received: from eggs.gnu.org ([2001:4830:134:3::10]:54725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUhC-0005NW-7c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYUh9-0001nu-5c
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:58:06 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYUh8-0001nU-WA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:58:03 -0400
Received: by mail-wm0-x236.google.com with SMTP id e131so9538715wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:58:02 -0700 (PDT)
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-15-alex.bennee@linaro.org>
	<eb3454ed-4a7c-180b-a005-00557031cf60@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <eb3454ed-4a7c-180b-a005-00557031cf60@twiddle.net>
Date: Fri, 21 Jul 2017 10:58:00 +0100
Message-ID: <87r2xa6riv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 14/23]
 target/arm/translate-a64.c: add ARMv8.2 fadd scalar half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 07/20/2017 05:04 AM, Alex Bennée wrote:
>> This brings in the initial decode skeleton and the helpers for a
>> scalar half-precision fadd using SoftFloat3c.
>>
>> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
>> ---
>>   target/arm/advsimd_helper.c | 15 ++++++++++++
>>   target/arm/translate-a64.c  | 60 +++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 75 insertions(+)
>
> ... and there it is.  Squash this with previous?  Anyway, do something
> so that they're bisectable.

Yeah a re-basing failure on my part as I cleaned up the tree. It was
fairly messy by the time I got everything working ;-)

--
Alex Bennée
