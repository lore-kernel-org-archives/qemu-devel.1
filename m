Received: from eggs.gnu.org ([2001:4830:134:3::10]:38176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXf6-0007el-3l
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXf5-00045h-8E
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:12:40 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXf4-000455-Pb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:12:39 -0400
Received: by mail-ot0-x242.google.com with SMTP id d19-v6so6278549oti.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:12:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3ezuozw.fsf@linaro.org>
References: <20180627043328.11531-1-richard.henderson@linaro.org>
	<87y3ezuozw.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:12:17 +0100
Message-ID: <CAFEAcA_EXZAHQEyj63Pko8XJqiEnsAHjLXAP6G1R29tqSf+W0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v6 00/35] target/arm SVE patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 28 June 2018 at 12:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> This is the remainder of the SVE enablement patches,
>> with an extra bonus patch to enable ARMv8.2-DotProd.
>>
>> V6 updates based on review.
>
> One failure from the VQ3 test set:
>
> ../qemu.git/aarch64-linux-user/qemu-aarch64 \
>   ./risu --test-sve=3D3 \
>   sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin \
>   --trace=3Dsve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin.tr=
ace
>
> Gives:
>
>   loading test image
>   sve-all-short-v8.3+sve@vq3/insn_sdiv_z_p_zz___INC.risu.bin...
>   starting apprentice image at 0x4000801000
>   starting image
>   fish: =E2=80=9C../qemu.git/aarch64-linux-user/=E2=80=A6=E2=80=9D termin=
ated by signal SIGFPE
>   (Floating point exception)

Do you have the insn that it's barfing on? In particular,
I'm guessing from the test name that this is for something
covered by one of the SDIV_zpzz lines in sve.decode, which
is already in master rather than in this test series.
If that's true, then it shouldn't block applying this set...

thanks
-- PMM
