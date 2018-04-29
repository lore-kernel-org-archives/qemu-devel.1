Received: from eggs.gnu.org ([2001:4830:134:3::10]:51230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fCoEY-0002Us-UX
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 11:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fCoEY-0000kN-6P
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 11:27:26 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:32861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fCoEY-0000js-13
	for qemu-devel@nongnu.org; Sun, 29 Apr 2018 11:27:26 -0400
Received: by mail-ot0-x236.google.com with SMTP id l22-v6so7077141otj.0
	for <qemu-devel@nongnu.org>; Sun, 29 Apr 2018 08:27:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <05b38654-ae3a-1f02-019f-b71917509097@linaro.org>
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<20180425012300.14698-2-richard.henderson@linaro.org>
	<87y3h8k53u.fsf@linaro.org>
	<05b38654-ae3a-1f02-019f-b71917509097@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 29 Apr 2018 16:27:04 +0100
Message-ID: <CAFEAcA-sqH1=-N-L_Tyud5LyoDFfJmPwsPsb5T-Kw3W2c00Ygg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/9] target/arm: Implement vector shifted
 SCVF/UCVF for fp16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 29 April 2018 at 15:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 04/27/2018 11:04 AM, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>> +        elements =3D 8 << is_q >> size;
>>
>> That is a brain exercise for operator precedence. Would:
>>
>>      elements =3D (is_q ? 16 : 8) >> size;
>>
>> be clearer?
>
> I don't think so myself.

Can we at least put in the brackets if we're going to use
the << >> expression?

thanks
-- PMM
