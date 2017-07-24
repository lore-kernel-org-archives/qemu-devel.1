Received: from eggs.gnu.org ([2001:4830:134:3::10]:35655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZktZ-00012Q-Rd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dZktY-0005WD-OI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:28:05 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dZktY-0005VN-Id
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:28:04 -0400
Received: by mail-wm0-x230.google.com with SMTP id c184so41796098wmd.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:28:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2017 22:27:43 +0100
Message-ID: <CAFEAcA8ABKSfKRFSnYxztVj7LjK+a-5JtbgDY1R=7hsBmXsgCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.10 00/35] fix bugs reported by Clang
 Static Analyzer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 24 July 2017 at 19:27, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi,
>
> This series is the result of having fun with Clang's Static Analyzer duri=
ng
> the week-end (see https://clang-analyzer.llvm.org/).
>
> No need to delay the first batch for -rc0.

I had a quick look through the mostly ARM related ones,
and there seem to be an awful lot of false positives :-(
For getting this into 2.10 it would be helpful to trim
down the series so that it has a more manageable number
of patches in it and they're fixing actual bugs...

thanks
-- PMM
