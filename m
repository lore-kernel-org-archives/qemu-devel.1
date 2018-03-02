Received: from eggs.gnu.org ([2001:4830:134:3::10]:50649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erpjG-0006Ob-4D
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erpjF-0004zh-8Q
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:48:26 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:34457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erpjE-0004zV-VY
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:48:25 -0500
Received: by mail-oi0-x229.google.com with SMTP id c83so7750659oib.1
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 10:48:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516112253-14480-13-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
	<1516112253-14480-13-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 18:48:03 +0000
Message-ID: <CAFEAcA_9WhO31ZWTT_OK-ruO+PNFR+nBCUbEyTgbnDZbz7Xm9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 16 January 2018 at 14:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> When --enable-debug is turned on, configure doesn't set -O level, and
> uses default compiler -O0 level, which is slow.
>
> Instead, use -Og if supported by the compiler (optimize debugging
> experience), or -O1 (keeps code somewhat debuggable and works around
> compiler bugs).

This gives me a noticeably worse debug experience (using -Og),
because gdb shows a lot more "<optimised out>" variables and
function arguments. (I've been mildly irritated by this for
the last few weeks and only just figured out why this was
happening.)

Can we go back to the previous behaviour, please ? I don't
care if the build is slow if I'm debugging, but I really do
care that I don't have my variables and arguments all
optimised away by the compiler so I can't tell what's going on.

thanks
-- PMM
