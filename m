Received: from eggs.gnu.org ([2001:4830:134:3::10]:56054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYeY6-0000Qm-3n
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYeY5-0003Vo-EV
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:01:38 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:32957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYeY5-0003V8-8k
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 16:01:37 -0500
Received: by mail-oi0-x235.google.com with SMTP id y141so2177205oia.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 13:01:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bb1c8d49-c800-fe4f-4a93-ca5274a830f9@amsat.org>
References: <1515431442-23795-1-git-send-email-peter.maydell@linaro.org>
	<bb1c8d49-c800-fe4f-4a93-ca5274a830f9@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 21:01:15 +0000
Message-ID: <CAFEAcA-+qwxFWF_PX7vKgp+Cvd0seyiAdY6zRMkd7R2feeuYzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Fix incorrect string comparison
 operator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 8 January 2018 at 17:16, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> On 01/08/2018 02:10 PM, Peter Maydell wrote:
>> In commit c97d6d2cdf97ed we accidentally added code to configure
>> that uses '=3D=3D' for string equality testing. This is a bashism --
>> the portable way to write this is '=3D'.
>>
>> This fixes the "Unexpected operator error" complaint produced
>> if the system /bin/sh is dash.
>
> Thanks :)
>
>>
>> Fixes: c97d6d2cdf97ed
>> Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Applied to master, thanks.

-- PMM
