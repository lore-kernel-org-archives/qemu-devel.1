Received: from eggs.gnu.org ([2001:4830:134:3::10]:49073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zN0-0006sX-G6
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6zMw-0003hK-I9
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:08:06 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6zMw-0003gu-EA
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:08:02 -0400
Received: by mail-oi0-x244.google.com with SMTP id x9-v6so8466627oig.7
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3a3a9132-8f03-c476-bd0d-b6c91a9cc3a4@mail.uni-paderborn.de>
References: <20180413140334.26622-1-alex.bennee@linaro.org>
	<20180413140334.26622-3-alex.bennee@linaro.org>
	<3a3a9132-8f03-c476-bd0d-b6c91a9cc3a4@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 15:07:41 +0100
Message-ID: <CAFEAcA9FWu7VU1-RtXA4h-LQOXVoDfOG9P8aTs02B-NF9N93qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid
 for NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 13 April 2018 at 15:06, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> On 04/13/2018 04:03 PM, Alex Benn=C3=A9e wrote:
>> The re-factor broke the raising of INVALID when NaN/Inf is passed to
>> the float_to_int conversion functions. round_to_uint_and_pack got this
>> right for NaN but also missed out the Inf handling.
>>
>> Fixes https://bugs.launchpad.net/qemu/+bug/1759264
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>> ---
>>  fpu/softfloat.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Could you run your tricore test case with this patch? I think
Alex was having difficulty getting that running...

thanks
--  PMM
