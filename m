Received: from eggs.gnu.org ([2001:4830:134:3::10]:42783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxcSE-0004DT-N6
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cxcSD-0005Mb-RF
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:46:14 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cxcSD-0005Lt-L4
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:46:13 -0400
Received: by mail-wr0-x230.google.com with SMTP id z109so12943383wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 09:46:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6a8d54a6-cf11-38d3-390f-dd4536b2c2b6@amsat.org>
References: <1491820793-5348-1-git-send-email-peter.maydell@linaro.org>
	<1491820793-5348-6-git-send-email-peter.maydell@linaro.org>
	<6a8d54a6-cf11-38d3-390f-dd4536b2c2b6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 17:45:52 +0100
Message-ID: <CAFEAcA9LAHe9=nnS8tAJLsW-xDXb2oLq8jU6tRTT9vnDe6bnmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 5/7] arm: Move condition-failed
 codepath generation out of if()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "patches@linaro.org" <patches@linaro.org>

On 10 April 2017 at 14:22, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wr=
ote:
> I'm custom to think "let's change that and think how to protect the code =
to
> help the next one who will modify it" and wonder if it isn't safer to
> define:
>
> const bool singlestepping;
>
> singlestepping =3D cs->singlestep_enabled || dc->ss_active;
>
> Then use:
>
> if unlikely(singlestepping)
>
> At line 11993 and here, what do you think?

I think we could do this with a function (that takes the DisasContext*);
then we can use it in the new gen_bx_excret_final_code() too.

I'll add an extra patch to the set in v2 that does that.

thanks
-- PMM
