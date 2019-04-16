Received: from eggs.gnu.org ([209.51.188.92]:60632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGLMD-00019U-UU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGLMD-0006lF-45
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:29 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGLMC-0006ku-SA
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 06:30:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id u15so17122616otq.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 03:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190415163337.2795-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190415163337.2795-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 11:30:15 +0100
Message-ID: <CAFEAcA-v+RJ7gYyJWTcZ5SBQO1MRPdfNq6jM9yXmg8Q_ig_J0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] socket: allow wait=false for client
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "reviewer:Incompatible changes" <libvir-list@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 15 Apr 2019 at 17:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Commit 767abe7 ("chardev: forbid 'wait' option with client sockets")
> is a bit too strict. Current libvirt always set wait=3Dfalse, and will
> thus fail to add client chardev.
>
> Make the code more permissive, allowing wait=3Dfalse with client socket
> chardevs. Deprecate usage of 'wait' with client sockets.
>
> Fixes: 767abe7f49e8be14d29da5db3527817b5d696a52
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

Applied to master for rc4, thanks.

-- PMM
