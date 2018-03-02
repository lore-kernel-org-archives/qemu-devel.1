Received: from eggs.gnu.org ([2001:4830:134:3::10]:53625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1errrX-0002bi-7e
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:05:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1errrU-0005Ms-2Y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:05:07 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1errrT-0005MT-Qv
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 16:05:03 -0500
Received: by mail-wm0-x236.google.com with SMTP id s206so4608130wme.0
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 13:05:02 -0800 (PST)
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-13-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_9WhO31ZWTT_OK-ruO+PNFR+nBCUbEyTgbnDZbz7Xm9w@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_9WhO31ZWTT_OK-ruO+PNFR+nBCUbEyTgbnDZbz7Xm9w@mail.gmail.com>
Date: Fri, 02 Mar 2018 21:04:59 +0000
Message-ID: <87o9k6ur2c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/51] build-sys: compile with -Og or -O1
 when --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 16 January 2018 at 14:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> When --enable-debug is turned on, configure doesn't set -O level, and
>> uses default compiler -O0 level, which is slow.
>>
>> Instead, use -Og if supported by the compiler (optimize debugging
>> experience), or -O1 (keeps code somewhat debuggable and works around
>> compiler bugs).
>
> This gives me a noticeably worse debug experience (using -Og),
> because gdb shows a lot more "<optimised out>" variables and
> function arguments. (I've been mildly irritated by this for
> the last few weeks and only just figured out why this was
> happening.)

I was wondering why my:

   ./configure --enable-debug --enable-debug-tcg --extra-cflags=3D"-O0 -g3"=
 --target-list=3Daarch64-linux-user

builds where showing that.

> Can we go back to the previous behaviour, please ? I don't
> care if the build is slow if I'm debugging, but I really do
> care that I don't have my variables and arguments all
> optimised away by the compiler so I can't tell what's going on.

+1

There is a lot of other stuff enabled when debugging which slows stuff
down anyway.

--
Alex Benn=C3=A9e
