Received: from eggs.gnu.org ([2001:4830:134:3::10]:33508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMxcb-0003AZ-1x
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMxca-0004PB-EZ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:57:57 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMxca-0004Og-8U
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:57:56 -0500
Received: by mail-ot0-x242.google.com with SMTP id q3so6559200oth.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 06:57:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
References: <20171205044844.3597-1-richard.henderson@linaro.org>
	<CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
	<659ad21b-5c17-a194-6104-fe4f50e58009@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 14:57:34 +0000
Message-ID: <CAFEAcA8cj7d7PEYVK5B0nerhBkbaBvCWsDN1fp03wfd-chJRjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 7 December 2017 at 14:43, Richard Henderson <rth@twiddle.net> wrote:
> On 12/07/2017 05:05 AM, Peter Maydell wrote:
>> gcc doesn't like this pattern:
>>
>> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c: In
>> function =E2=80=98do_name_to_handle_at=E2=80=99:
>> /home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c:7231:13=
:
>> error: switch condition has boolean value [-Werror=3Dswitch-bool]
>>      switch (interp_dirfd > 0 && name[0] =3D=3D '/') {
>>              ^
>>
>> It seems like an odd way to write an if().
>
> Huh.  My gcc likes it just fine.  What version are you using?
>
> It's an IF with a /* fallthru */, so there are very few
> less ugly ways to write it...

gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
(for x86-64).

thanks
-- PMM
