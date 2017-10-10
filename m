Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1rRx-0005NG-PI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1rRw-0005tV-UG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:07:45 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:53206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1rRw-0005sL-NO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 06:07:44 -0400
Received: by mail-wm0-x231.google.com with SMTP id k4so3693301wmc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 03:07:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zi8z9vng.fsf@linaro.org>
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
	<87zi8z9vng.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 11:07:23 +0100
Message-ID: <CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 10 October 2017 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> Running the test program
>> http://people.linaro.org/~peter.maydell/thumb-over-page
>> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
>> in the usermode emulator:
>>  ./build/x86/arm-linux-user/qemu-arm
>> ~/linaro/qemu-misc-tests/thumb-over-page
>
> Does this fail when run via system mode as well?

Nope, only usermode. (Makes sense, since the handle_cpu_signal()
codepath is only used in usermode emulation.)

thanks
-- PMM
