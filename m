Received: from eggs.gnu.org ([2001:4830:134:3::10]:38593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1sBk-0001Gf-J0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e1sBh-0000aZ-H3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:55:04 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:48163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e1sBh-0000Xg-AU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:55:01 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i124so3883474wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 03:55:01 -0700 (PDT)
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
	<87zi8z9vng.fsf@linaro.org>
	<CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
Date: Tue, 10 Oct 2017 11:54:58 +0100
Message-ID: <87y3oj9ssd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 10 October 2017 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> Running the test program
>>> http://people.linaro.org/~peter.maydell/thumb-over-page
>>> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
>>> in the usermode emulator:
>>>  ./build/x86/arm-linux-user/qemu-arm
>>> ~/linaro/qemu-misc-tests/thumb-over-page
>>
>> Does this fail when run via system mode as well?
>
> Nope, only usermode. (Makes sense, since the handle_cpu_signal()
> codepath is only used in usermode emulation.)

But surely system emulation has to deal with the same rolling over a
page issue. How is it's resolution different?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
