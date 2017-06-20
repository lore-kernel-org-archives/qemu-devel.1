Received: from eggs.gnu.org ([2001:4830:134:3::10]:36815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLJa-0001Gb-T7
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNLJa-00017v-3X
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:43:38 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:36055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNLJZ-00017A-Sr
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 11:43:38 -0400
Received: by mail-wr0-x232.google.com with SMTP id c11so40718539wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 08:43:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2yeu2ew.fsf@linaro.org>
References: <1497969886-17773-1-git-send-email-peter.maydell@linaro.org>
	<1497969886-17773-2-git-send-email-peter.maydell@linaro.org>
	<87r2yeu2ew.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 16:43:16 +0100
Message-ID: <CAFEAcA_N-7N_10ocPKag_xO93CuYPhyyTcNsr4Gc30gS9gASiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] risu_reginfo_arm.c: Fix handling of
 size values in sigframe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 20 June 2017 at 16:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> The code in reginfo_init_vfp() to parse the signal frame
>> was mishandling the size counts:
>>  * the size includes the bytes for the magic and size fields,
>>    so the code to skip forward over unknown or undersize blocks
>>    was adding 4 more than it should
>>  * the size is in bytes but the "is this block too small"
>>    test was checking against an expected size in words
>>
>> This didn't cause any problems because the kernel happens
>> to generate signal frames with the VFP section first.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> I guess this would have tripped up once the kernel started dumping SVE
> registers in the context?

Probably not if it put them after the VFP registers (where
you'd expect them to be), though if we supported SVE regs in
risu we'd probably have found this bug in the process of
getting that working ;-)

thanks
-- PMM
