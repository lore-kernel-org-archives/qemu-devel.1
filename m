Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSWPX-0000L4-Cn
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dSWPW-0003L7-HH
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:35:11 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:35047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dSWPW-0003KD-8r
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:35:10 -0400
Received: by mail-wm0-x233.google.com with SMTP id w126so206335802wme.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 15:35:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ee87713c-82f1-5a3f-2c42-41833e2ea932@twiddle.net>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865316837.17063.1608754834009945976.stgit@frigg.lan>
	<528c921e-d04c-f064-08f8-2c6a0b3f23f1@twiddle.net>
	<8760f8av0c.fsf@frigg.lan>
	<CAFEAcA8VPgejz7oUKMR7965BjyU3t+DA8Vq7GatUUhTC0j9XRg@mail.gmail.com>
	<ee87713c-82f1-5a3f-2c42-41833e2ea932@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2017 23:34:48 +0100
Message-ID: <CAFEAcA8RJcGJU-r+mhTVQaGgdKk5=JR8EXVV6HHfwptFQOHpWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 04/29] target: [tcg] Add generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 4 July 2017 at 23:31, Richard Henderson <rth@twiddle.net> wrote:
> On 07/04/2017 09:14 AM, Peter Maydell wrote:
>> I kind of like not having CPUState* in DisasContext, because
>> it enforces the rule that you can't read from fields of
>> it inside the target translate.c code without jumping through
>> a hoop (ie copying the info from CPUState->foo to
>> DisasContext->foo). That then acts as a useful flag in code
>> review (or when writing the code) to confirm that foo really
>> is constant for the life of the simulation (or to recommend
>> using a TB flag instead).
>
>
> I don't see how the spelling "cpu" vs "dc->cpu" really affects that.

If you put it in dc->cpu then everywhere that gets the dc gets
the cpu, unavoidably (which is why I'm suggesting it would
be nicer not to do that). If you don't put it in dc then you
can structure your translate code so that pretty much all of
it gets the dc but not the cpu. target/arm/translate-a64.c
does this, for instance.

thanks
-- PMM
