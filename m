Received: from eggs.gnu.org ([2001:4830:134:3::10]:58525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2sW-0005n0-7f
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG2sV-0006fw-FH
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:04 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:45476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG2sV-0006fd-91
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:42:03 -0400
Received: by mail-ot0-x234.google.com with SMTP id 15-v6so21283698otn.12
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 06:42:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
References: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 14:41:41 +0100
Message-ID: <CAFEAcA9npKPEEXXekw+eahJfopn5+7Cf40Ltrh9tbPPvN-GOog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 8 May 2018 at 13:41, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote=
:
> Hi,
>
> Travis CI hit this error testing commit 853f8ca13cd6d256:
>
> $ clang --version
> Apple LLVM version 8.1.0 (clang-802.0.42)
> Target: x86_64-apple-darwin16.7.0
>
> $ ./configure
> C compiler        clang
> host CPU          x86_64
> ...
> TPM support       yes
> libssh2 support   no
> TPM passthrough   no
> TPM emulator      yes
>
>   GTESTER check-qtest-i386
> Unexpected error in qio_channel_socket_readv() at io/channel-socket.c:494=
:
> **
> ERROR:tests/tpm-emu.c:27:tpm_emu_test_wait_cond: code should not be reach=
ed
> make: *** [check-qtest-i386] Error 1
> make: *** Waiting for unfinished jobs....
>
> see https://travis-ci.org/qemu/qemu/jobs/376289241

I see this on my OSX test box from time to time as well.

thanks
-- PMM
