Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkk4l-0007z6-JA
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 01:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fkk4j-0002XU-BT
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 01:53:35 -0400
MIME-Version: 1.0
In-Reply-To: <b29881c1-ae9f-d6c1-9dbf-eec3051d65a7@linaro.org>
References: <CABoDooME+KJVWJQcodVC-Mo2qpZhmYA3LVBLQcTj88qW1i5h5g@mail.gmail.com>
	<b29881c1-ae9f-d6c1-9dbf-eec3051d65a7@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 1 Aug 2018 07:53:31 +0200
Message-ID: <CABoDooOQN7_5Qa3Mz__GywTHj2eSG6965h5renG_4xk2ORZkQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ARM: SVE while issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

Hello,

On Tue, Jul 31, 2018 at 6:36 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 07/31/2018 09:52 AM, Laurent Desnogues wrote:
>> Hello Richard,
>>
>> according to SVE specification, whilels/whilele instructions have a
>> special case where if the second operand is the maximum (un)signed
>> integer then the result is an all-true predicate.  The current code in
>> trans_WHILE doesn't seem to capture that requirement.  I'm afraid the
>> fix won't be as trivial as for the other two bugs I reported :-)
>
> Still not too bad.
> Testing a fix for my branch now.

I gave it a look and tested it, it works fine!

Thanks,

Laurent

> Annoying that risu didn't randomly generate this case,
> and I totally mis-read the documentation for this.
>
>
> r~
>
