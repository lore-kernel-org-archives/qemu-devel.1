Received: from eggs.gnu.org ([2001:4830:134:3::10]:57976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH5tN-0000ob-W7
	for qemu-devel@nongnu.org; Fri, 11 May 2018 07:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH5tN-00043q-6w
	for qemu-devel@nongnu.org; Fri, 11 May 2018 07:07:17 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:33946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH5tN-00043b-1m
	for qemu-devel@nongnu.org; Fri, 11 May 2018 07:07:17 -0400
Received: by mail-ot0-x243.google.com with SMTP id i5-v6so5791814otf.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 04:07:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e561ca57-1c93-5d9e-94f8-788ee0dce39e@vivier.eu>
References: <20180508185520.23757-1-richard.henderson@linaro.org>
	<e561ca57-1c93-5d9e-94f8-788ee0dce39e@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 12:06:55 +0100
Message-ID: <CAFEAcA_iQkFhtBWLzNthM-Sj88gQ5647cG9NekMVK4fiZGWvZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Fix build Werror with gcc
 8.0.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 21:42, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 08/05/2018 =C3=A0 20:55, Richard Henderson a =C3=A9crit :
>> Fedora 28 ships with the released gcc 8.
>>
>> The Werror stems from the compiler finding a path through the second
>> switch via a missing default case in which src1 is uninitialized, and
>> not being able to prove that the missing default case is unreachable
>> due to the first switch.
>>
>> Simplify the second switch to merge default with OS_LONG,
>> which returns directly.  This removes the unreachable path.
>>
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/m68k/translate.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Applied to master as a buildfix, thanks.

-- PMM
