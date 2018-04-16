Received: from eggs.gnu.org ([2001:4830:134:3::10]:37912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f85OR-0006mS-Ry
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f85OR-0000Cl-3m
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:46:07 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:45743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f85OQ-0000CW-Ug
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:46:07 -0400
Received: by mail-ot0-x22c.google.com with SMTP id w2-v6so6689337otj.12
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 07:46:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87604rb4b5.fsf@linaro.org>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
	<aca6055a-1e49-7902-428f-e7e199ed8a12@mail.uni-paderborn.de>
	<87604rb4b5.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 15:45:45 +0100
Message-ID: <CAFEAcA9rmiisOeT1ZrApxoOn53y71U7jHeNH1wwD1U+ZcHfkZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 16 April 2018 at 15:42, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>
>> On 04/16/2018 03:54 PM, Alex Benn=C3=A9e wrote:
>>> The re-factoring of div_floats changed the order of checking meaning
>>> an operation like -inf/0 erroneously raises the divbyzero flag.
>>> IEEE-754 (2008) specifies this should only occur for operations on
>>> finite operands.
>>>
>>> We fix this by moving the check on the dividend being Inf/0 to before
>>> the divisor is zero check.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>> ---
>>>  fpu/softfloat.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>
> Peter are you going to grab these tags or do you want me to re-spin?

'patches' will grab them automatically when it applies the patch.

thanks
-- PMM
