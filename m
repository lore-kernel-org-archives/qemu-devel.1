Received: from eggs.gnu.org ([2001:4830:134:3::10]:49045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN5U7-0000lI-26
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dN5U3-0004ud-Oh
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:49:27 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dN5U3-0004uJ-IR
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 18:49:23 -0400
Received: by mail-qk0-x242.google.com with SMTP id 16so3464267qkg.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 15:49:23 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
	<c1efba1b-0af9-50a5-e200-a3f74a88d1c1@redhat.com>
	<CAFEAcA9ShizMdZRg_EboKK_7kKhakX8rtF32jCgva77e24rnZA@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <104840a4-9665-324e-329a-3ae92c657b4f@twiddle.net>
Date: Mon, 19 Jun 2017 15:49:18 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9ShizMdZRg_EboKK_7kKhakX8rtF32jCgva77e24rnZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 06/16/2017 02:18 AM, Peter Maydell wrote:
> (As an aside I wonder whether any still-used hardware has
> the cache aliasing constraints in question :-))

I strongly doubt it.  Certainly none of the 64-bit chips have this.

Amusingly, while we require a 64-bit chip in TCG, we do allow elf32 via 
sparcv8plus, which still runs afoul of this check.  In hindsight, sparcv8plus 
probably should have relaxed this, but it's 20 years too late for that.


r~
