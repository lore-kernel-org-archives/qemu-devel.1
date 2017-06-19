Received: from eggs.gnu.org ([2001:4830:134:3::10]:53419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMquT-00076F-TF
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dMquS-0000oY-OO
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:15:41 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dMquS-0000ml-AK
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 03:15:40 -0400
Received: by mail-wr0-x236.google.com with SMTP id y25so27095572wrd.2
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 00:15:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619040829.GA10709@flamenco>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<149727924970.28532.9346819516051209538.stgit@frigg.lan>
	<20170615220501.GA26408@flamenco>
	<87y3spcqfg.fsf@frigg.lan> <20170619040829.GA10709@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2017 08:15:18 +0100
Message-ID: <CAFEAcA8skpecZY1uigwdaj+ryFTYKpkv_5=rH4FxFU1r387xwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] translator mega-patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 19 June 2017 at 05:08, Emilio G. Cota <cota@braap.org> wrote:
> On Sun, Jun 18, 2017 at 17:37:39 +0300, Llu=C3=ADs Vilanova wrote:
>> I kind of dislike it every time I see container_of, and it makes type
>> checking from the compiler a bit more fragile.
>
> container_of is *very* useful! You should like it more :-)

Or you could use qom objects, where the parent-to-child
cast is checked.

thanks
-- PMM
