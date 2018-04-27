Received: from eggs.gnu.org ([2001:4830:134:3::10]:58783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3fY-0002Ui-W2
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC3fY-0005rs-09
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:44:13 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC3fX-0005rl-Qe
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 09:44:11 -0400
Received: by mail-ot0-x244.google.com with SMTP id l22-v6so2078407otj.0
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 06:44:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309142630.2170-3-laurent@vivier.eu>
References: <20180309142630.2170-1-laurent@vivier.eu>
	<20180309142630.2170-3-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 14:43:50 +0100
Message-ID: <CAFEAcA_9biKcR9pon0eTVkDXwobBepUgs12rCfdGcRyE3HfUXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 2/8] target/m68k: implement flognp1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 March 2018 at 14:26, Laurent Vivier <laurent@vivier.eu> wrote:
> Using a local m68k floatx80_lognp1()
> [copied from previous:
> Written by Andreas Grabher for Previous, NeXT Computer Emulator.]
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Message-Id: <20180305203910.10391-3-laurent@vivier.eu>

> +floatx80 floatx80_lognp1(floatx80 a, float_status *status)
> +{

...

> +    if (aSign && aExp >= one_exp) {
> +        if (aExp == one_exp && aSig == one_sig) {
> +            float_raise(float_flag_divbyzero, status);
> +            packFloatx80(aSign, floatx80_infinity.high, floatx80_infinity.low);

Hi; Coverity (CID1390587) points out that packFloatx80 doesn't
do anything except return a value which is here being thrown
away, making the call useless. Should this be maybe
"return packFloatx80(...)" ?

> +        }

thanks
-- PMM
