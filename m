Received: from eggs.gnu.org ([2001:4830:134:3::10]:55650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eme3H-0008Ro-Mq
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:19:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eme3G-0002HE-U8
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:19:39 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:45506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eme3G-0002FX-NS
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:19:38 -0500
Received: by mail-ot0-x22a.google.com with SMTP id m15so2380647otf.12
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 03:19:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5660fbb9-6998-e659-fcc2-6cd1bba1804b@redhat.com>
References: <1518761564-9899-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_s1C3md4Vw6fQu2GLy=hZBLDSrvnHppQswL8+K1giLwg@mail.gmail.com>
	<5660fbb9-6998-e659-fcc2-6cd1bba1804b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 11:19:17 +0000
Message-ID: <CAFEAcA_Pam6j22400oY7_N2LpAPkAofB-_j0Ym7Ln-_ZHcuSvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Fix problem with
 timeout due to dropped characters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 16 February 2018 at 10:25, Thomas Huth <thuth@redhat.com> wrote:
> PS: I think the OpenBSD compiler is wrong here, nbr should get
> initialized at least once before the g_assert(nbr >= 0) check ...

Yes, I agree, but it does require some intelligence on the
part of the compiler to figure out that the ccnt++ < 512
condition can't trigger first time round the loop. (It's
a gcc 4.9.3, so presumably newer gcc are indeed smarter.)

Applied to master.

thanks
-- PMM
