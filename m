Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFZZ-0005JK-2g
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFZY-0002kc-8O
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:35:05 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIFZY-0002kK-2V
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:35:04 -0400
Received: by mail-wr0-x22f.google.com with SMTP id g76so55136512wrd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 07:35:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 15:34:42 +0100
Message-ID: <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
> I've linked qemu with the original patch and:
> ./configure --disable-linux-user --disable-system --static
>
> I got some warnings, I think they are originated from our libc and are
> not related to qemu:
>   LINK    sparc64-bsd-user/qemu-sparc64
> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
> overridden by definition
> /usr/lib/crt0.o: warning: defined here
> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
> /usr/lib/crt0.o: warning: previous common is here
> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
> overridden by definition
> /usr/lib/crt0.o: warning: defined here

Yes, I think I've seen those before on NetBSD -- they look
like a bug in your libc to me, it shouldn't be confusing itself
with itself like that :-)

thanks
-- PMM
