Received: from eggs.gnu.org ([2001:4830:134:3::10]:36235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f85LQ-0004XS-3r
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f85LN-0006wa-0q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:43:00 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:39637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f85LM-0006vk-Q0
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:42:56 -0400
Received: by mail-wr0-x22b.google.com with SMTP id q6so14685967wrd.6
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:42:56 -0700 (PDT)
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<aca6055a-1e49-7902-428f-e7e199ed8a12@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <aca6055a-1e49-7902-428f-e7e199ed8a12@mail.uni-paderborn.de>
Date: Mon, 16 Apr 2018 15:42:54 +0100
Message-ID: <87604rb4b5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> On 04/16/2018 03:54 PM, Alex Benn=C3=A9e wrote:
>> The re-factoring of div_floats changed the order of checking meaning
>> an operation like -inf/0 erroneously raises the divbyzero flag.
>> IEEE-754 (2008) specifies this should only occur for operations on
>> finite operands.
>>
>> We fix this by moving the check on the dividend being Inf/0 to before
>> the divisor is zero check.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>  fpu/softfloat.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Peter are you going to grab these tags or do you want me to re-spin?


--
Alex Benn=C3=A9e
