Received: from eggs.gnu.org ([2001:4830:134:3::10]:54123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBhOU-0003wj-Dd
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBhOP-0003ak-19
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:57:06 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:45746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBhOO-0003aE-SI
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:57:00 -0400
Received: by mail-ot0-x231.google.com with SMTP id w4-v6so29498148ote.12
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:57:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 14:56:39 +0100
Message-ID: <CAFEAcA9F4qSb5YBJoHHZxAmo44kvGkuzLaRPsokO5rCJYXZrFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/13] Drop compile time limit on number of
 serial ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 20 April 2018 at 15:52, Peter Maydell <peter.maydell@linaro.org> wrote:
> For many years, QEMU has had a compile time restriction on how
> many serial port devices you can create and configure with the
> -serial argument. This is 4, largely because for x86 PC the
> traditional number of ISA serial devices is 4, and nobody's
> ever changed the limit since.
>
> This patchset drops the compile time limit.

Applied to master, with minor tweak in patch 13.

I only realised when I came back to here that I'd forgotten
about checkpatch's preference for not zero-initializing
static globals; I'll send a fixup patch for that.

thanks
-- PMM
