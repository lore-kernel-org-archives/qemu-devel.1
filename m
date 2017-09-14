Received: from eggs.gnu.org ([2001:4830:134:3::10]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTM9-00071B-GN
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsTM8-0001Mx-Bb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:34:57 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:47982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsTM8-0001Jv-3y
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:34:56 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 13so593524wmq.2
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:34:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <633f5a2d-a333-5c78-1e0c-3af2a4c896f9@linaro.org>
References: <CGME20170908110212eucas1p27c5eecf44c5501d23b322d3679a4f12d@eucas1p2.samsung.com>
	<001801d32891$ec40b930$c4c22b90$@samsung.com>
	<633f5a2d-a333-5c78-1e0c-3af2a4c896f9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 13:34:34 +0100
Message-ID: <CAFEAcA91W=NxnVkacqD+vH-73H+aGej2E+qm_YQMY9rpF8aMsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/1] AArch64: Fix single
 stepping of ERET instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Jaroslaw Pelczar <j.pelczar@samsung.com>, QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 8 September 2017 at 17:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/08/2017 04:02 AM, Jaroslaw Pelczar wrote:
>> Previously when single stepping through ERET instruction via GDB
>> would result in debugger entering the "next" PC after ERET instruction.
>> When debugging in kernel mode, this will also cause unintended behavior,
>> because debugger will try to access memory from EL0 point of view.
>>
>> Signed-off-by: Jaroslaw Pelczar <j.pelczar@samsung.com>
>> ---
>>  target/arm/translate-a64.c | 1 +
>>  1 file changed, 1 insertion(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Applied, thanks.

-- PMM
