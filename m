Received: from eggs.gnu.org ([209.51.188.92]:33192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1rGV-0003ZU-2C
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1rGU-00011b-Ce
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:32:43 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:37136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1rGU-00011H-5u
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:32:42 -0500
Received: by mail-ot1-x32b.google.com with SMTP id b3so13767451otp.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 03:32:41 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
	<CAFEAcA_RQU+HYczN4Z=vEL8U31---GTi_HOxg8y50pzX8p+p7Q@mail.gmail.com>
	<20190307112933.GA2853@work-vm>
In-Reply-To: <20190307112933.GA2853@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 11:32:29 +0000
Message-ID: <CAFEAcA8SSaZ8NbEfU2u1Pbn-FgxTm=X40VNehGiGtw5iXQpSrg@mail.gmail.com>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Thu, 7 Mar 2019 at 11:29, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> Pretty regularly I just give up on build directories and recreate
> them because of changes that our Makefiles haven't realised
> when updating a tree.
> (I can't say it's any one fault anywhere)

That's usually the awkward problem of "newer version of the
build rules doesn't work when it starts against older
version of the built objects" or similar. Does Meson do
a better job about handling that situation?

thanks
-- PMM
