Received: from eggs.gnu.org ([209.51.188.92]:51673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1xbN-0001aR-Q1
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1xbN-00088X-9h
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:18:41 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:45314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1xbN-000883-0q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:18:41 -0500
Received: by mail-oi1-x231.google.com with SMTP id t82so13689469oie.12
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:18:40 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
In-Reply-To: <CAMxuvaxeAdZKk_CQOyqCJdd_1kVZEBPCm0LRoP2u9aijOtbDxg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 18:18:28 +0000
Message-ID: <CAFEAcA_hqpHfJkXa1SkyOaxdEYPYOOyOX0urRh6X2zYadPprXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 7 Mar 2019 at 18:17, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> As someone who has also been annoyed having to support in-tree and
> out-of-tree, I support that move. I used to be a pretty happy use of
> in-tree builds, but out-of-tree his generally equally convenient.
>
> Who is volunteering to do patches to deprecate the support? warning in
> 4.0, and error in 4.1?

Do we need to bother to deprecate it? It doesn't affect end-users,
only those who build QEMU, and the change is easy...

thanks
-- PMM
