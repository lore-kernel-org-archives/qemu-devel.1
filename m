Received: from eggs.gnu.org ([209.51.188.92]:53618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1qa8-00018I-JO
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1qa7-00021s-T5
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:48:56 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:46137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1qa7-00021P-NP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:48:55 -0500
Received: by mail-oi1-x22d.google.com with SMTP id j10so12499326oij.13
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:48:55 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
In-Reply-To: <13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 10:48:43 +0000
Message-ID: <CAFEAcA_t=okvOgHNKHttJS0XNcoFhnhX2MHqY1AA-C+nz6d=jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Thu, 7 Mar 2019 at 10:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
> ---
> # This would be ui/meson.build:
>
> vnc_sources = source_set.source_set()
> vnc_sources.add([], files(
>     'vnc.c',
>     'vnc-auth-vencrypt.c',
>     'vnc-enc-hextile.c',
>     'vnc-enc-tight.c',
>     'vnc-enc-zlib.c',
>     'vnc-enc-zrle.c',
>     'vnc-jobs.c',
>     'vnc-palette.c',
>     'vnc-ws.c'))
> vnc_sources.add('CONFIG_VNC_SASL', files(
>     'vnc-auth-sasl.c'))

All this foo_sources.add() seems pretty clunky syntax,
which doesn't seem like a good sign for what is
pretty much the simplest possible case for the build system.

thanks
-- PMM
