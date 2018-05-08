Received: from eggs.gnu.org ([2001:4830:134:3::10]:34272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG39W-0007SP-9u
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG39U-0003Pg-Kv
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:59:38 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:34208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG39U-0003PI-GY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:59:36 -0400
Received: by mail-ot0-x235.google.com with SMTP id i5-v6so24490782otf.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 06:59:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tvriv0yz.fsf@linaro.org>
References: <20180504100547.14621-1-peter.maydell@linaro.org>
	<87tvriv0yz.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 14:59:15 +0100
Message-ID: <CAFEAcA99c1XNdCNs3aNwzvZJFOtmVX22kU-twDuFMLYy8an=qA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] softfloat: Handle default NaN mode after
 pickNaNMulAdd, not before
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, qemu-stable <qemu-stable@nongnu.org>

On 8 May 2018 at 12:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> It is implementation defined whether a multiply-add of
>> (0,inf,qnan) or (inf,0,qnan) raises InvalidaOperation or
>> not, so we let the target-specific pickNaNMulAdd function
>> handle this. This means that we must do the "return the
>> default NaN in default NaN mode" check after the call,
>> not before. Correct the ordering, and restore the comment
>> from the old propagateFloat64MulAddNaN() that warned about
>> this corner case.
>>
>> This fixes a regression from 2.11 for Arm guests where we would
>> incorrectly fail to set the Invalid flag for these cases.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks; applied to target-arm.next.

-- PMM
