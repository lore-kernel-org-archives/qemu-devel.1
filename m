Received: from eggs.gnu.org ([2001:4830:134:3::10]:42497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaA6-0000Uw-IK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIaA5-0005vI-UD
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:10:58 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIaA5-0005ul-IE
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:10:57 -0400
Received: by mail-ot1-x342.google.com with SMTP id 81so1815221otj.2
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:10:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87muqr64or.fsf@linaro.org>
References: <20181102102025.3546-1-richard.henderson@linaro.org>
	<87muqr64or.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Nov 2018 14:10:36 +0000
Message-ID: <CAFEAcA_DpD8qTCj9u0txk9cCWM+Ci8F0PR-dh79QWbS_ohet1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Conditionalize some asserts
 on aarch32 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 November 2018 at 12:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> When populating id registers from kvm, on a host that doesn't support
>> aarch32 mode at all, neither arm_div nor jazelle will be supported eithe=
r.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> v2: Test aa64pfr.el0 >=3D 2; rename to isar_feature_aa64_aa32.
>>     Pull out realizefn test to no_aa32 bool; use it for jazelle as well.
>>
>> Alex, can you give this a test please?
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>



Applied to target-arm.next, thanks.

-- PMM
