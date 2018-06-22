Received: from eggs.gnu.org ([2001:4830:134:3::10]:44508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWN7R-0006Ui-OT
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWN7Q-0007M2-S8
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:32:57 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:34200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWN7Q-0007Lq-NI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 10:32:56 -0400
Received: by mail-ot0-x242.google.com with SMTP id r18-v6so7735865otk.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:32:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622134610.23713-1-f4bug@amsat.org>
References: <20180622134610.23713-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 15:32:35 +0100
Message-ID: <CAFEAcA84t5uSTWqVoVS6dVh8YXL6SLHAv4DPAqvXUNtDb4jP3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 14:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> hw_error() is only meant for CPU errors (since it dumps the CPU state).

I would disagree. hw_error() dumps the state of every CPU. The
corresponding function for CPU errors is cpu_abort(), which
dumps only the state of the relevant CPU. It is used pretty
much only by device models, not by cpu models.

In any case, this is one of those functions that's a left
over from a more innocent time when causing QEMU to bomb out
with a screenful of hexdump was a reasonable response to the
guest doing something weird or unsupported. In an ideal world
we'd gradually get rid of the existing callsites...

thanks
-- PMM
