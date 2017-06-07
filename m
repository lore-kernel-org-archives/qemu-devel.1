Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIegg-0007l1-Eu
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIegf-00042r-Mj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:24:06 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIegf-000421-Dl
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:24:05 -0400
Received: by mail-wm0-x22e.google.com with SMTP id d73so15823392wma.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 10:24:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a85jdbd1.fsf@linaro.org>
References: <1496849369-30282-1-git-send-email-peter.maydell@linaro.org>
	<87a85jdbd1.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 18:23:43 +0100
Message-ID: <CAFEAcA-YQBLJJvAcN82N1BTVsC-rQP2kZ1ccvCv9z48x+XPKUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] arm_gicv3: Fix ICC_BPR1 reset value when
 EL3 not implemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 7 June 2017 at 17:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> If EL3 is not implemented (ie only one security state) then the
>> one and only ICC_BPR1 register behaves like the Non-secure
>> ICC_BPR1 in an EL3-present configuration. In particular, its
>> reset value is GIC_MIN_BPR_NS, not GIC_MIN_BPR.
>>
>> Correct the erroneous reset value; this fixes a problem where
>> we might hit the assert added in commit a89ff39ee901.
>>
>> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks; applied to master as a fix for an assertion failure
(still not sure why I don't see it).

-- PMM
