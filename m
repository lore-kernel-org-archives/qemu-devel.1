Received: from eggs.gnu.org ([2001:4830:134:3::10]:50520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYYRp-0003b2-Gn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYYRn-0000V5-FW
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:58:28 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYYRn-0000TC-6q
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:58:27 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v105so52636294wrb.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:58:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mv7x7vbq.fsf@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-13-alex.bennee@linaro.org>
	<4d6ac494-d606-ebaf-6498-7c526467ac62@twiddle.net>
	<87tw266rm3.fsf@linaro.org>
	<20170721132140.xy2uqronprhzjiga@aurel32.net>
	<87mv7x7vbq.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 14:58:02 +0100
Message-ID: <CAFEAcA9kEa2PCjEKn1A=-bM7jjFhZc8pjef2J_c9qL8p4bLdaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 12/23]
 target/arm/translate-a64.c: add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 July 2017 at 14:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Aurelien Jarno <aurelien@aurel32.net> writes:
>> As said in another email, some architectures actually use more than one
>> float_status. We therefore need to implement a solution like the one
>> proposed by Richard.
>
> Ahh you mean more than one float_status for a given vCPU context?

Yep. ARM's cpu state struct has
        float_status fp_status;
        float_status standard_fp_status;

which we use to handle (1) operations which use the state
controlled by the FPSCR value and (2) operations which
ignore the FPSCR and use the "Standard FPSCR Value" (generally
Neon ops). More info in the comment in cpu.h...

thanks
-- PMM
