Received: from eggs.gnu.org ([2001:4830:134:3::10]:56593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWl1N-0000sh-G6
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWl1M-0004Im-Lz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:04:17 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWl1M-0004IW-Gk
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 12:04:16 -0400
Received: by mail-ot0-x241.google.com with SMTP id w16-v6so2076933otk.5
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 09:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4378ee8b-1eec-95e5-7b21-483a033b4c36@redhat.com>
References: <20180622134610.23713-1-f4bug@amsat.org>
	<CAFEAcA84t5uSTWqVoVS6dVh8YXL6SLHAv4DPAqvXUNtDb4jP3g@mail.gmail.com>
	<4378ee8b-1eec-95e5-7b21-483a033b4c36@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 23 Jun 2018 17:03:55 +0100
Message-ID: <CAFEAcA_N+VVNrPypGK=HrOvDU5b7NMCUo7wyMzBOCJSL3ViZdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] exec: Move hw_error() to the CPU
 namespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 20:09, Thomas Huth <thuth@redhat.com> wrote:
> ... but I really wonder why this function got so popular in the hw/
> folder. Printing a dump of all CPU states does not make much sense in
> most of the cases (which are really not directly related to CPU states).
> So yes, we should try to slowly get rid of hw_error() these days!

Maybe the idea was that if your guest accesses a bogus register
and QEMU falls over, a guest CPU register dump might help
in figuring out where in the guest that happened.

thanks
-- PMM
