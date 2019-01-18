Received: from eggs.gnu.org ([209.51.188.92]:42812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYv2-00050m-G7
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkYv0-0004dX-Ic
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:31:04 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkYux-0004ZN-UQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:31:00 -0500
Received: by mail-oi1-x234.google.com with SMTP id x23so9719760oix.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 10:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<871s5byriy.fsf@linaro.org>
	<e655e325-15ad-9e97-eb27-8a15ea77a889@redhat.com>
	<87won1yk7y.fsf@linaro.org> <20190118181651.GA4194@flamenco>
In-Reply-To: <20190118181651.GA4194@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 18:30:45 +0000
Message-ID: <CAFEAcA_-rWCT=S6hf=83tozdGtsj_U4zHi6jza4usbXk7cxkhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 18 Jan 2019 at 18:16, Emilio G. Cota <cota@braap.org> wrote:
>
> On Fri, Jan 18, 2019 at 17:00:17 +0000, Alex Benn=C3=A9e wrote:
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
> > > Can you modify the Makefile.include to use:
> > >  "fp-test ... 2>int-to-float.err || {cat int-to-float.err && exit 1;}=
"
> >
> > Well it's in the test-softfloat macro but sure...
>
> Actually, can we do &> instead of 2> ?

"&>" is a bashism. The POSIX equivalent is >file.err 2>&1

thanks
-- PMM
