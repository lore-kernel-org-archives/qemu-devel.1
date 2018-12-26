Received: from eggs.gnu.org ([208.118.235.92]:44625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gby0J-0008SV-0L
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makren67@gmail.com>) id 1gby0E-0008N5-Cm
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:28:58 -0500
Received: from mail-yw1-xc34.google.com ([2607:f8b0:4864:20::c34]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makren67@gmail.com>) id 1gby0E-0008Ms-83
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 20:28:54 -0500
Received: by mail-yw1-xc34.google.com with SMTP id x2so5857529ywc.9
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 17:28:54 -0800 (PST)
MIME-Version: 1.0
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
In-Reply-To: <945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
From: Nick Renieris <makren67@gmail.com>
Date: Wed, 26 Dec 2018 03:28:26 +0200
Message-ID: <CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

Hi Richard,

I did know about https://github.com/andikleen/qemu-avx but didn't
mention it as it seems abandoned and quite old (also it doesn't use
`TCGv_vec`).
Do you think this could work as a GSoC project? I'm potentially
interested in working on it this summer.

Thanks,
Nick R.

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84, 26 =CE=94=CE=B5=CE=BA 2018 =CF=
=83=CF=84=CE=B9=CF=82 3:07 =CF=80.=CE=BC., =CE=BF/=CE=B7 Richard Henderson
<richard.henderson@linaro.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On 12/26/18 10:43 AM, Nick Renieris wrote:
> > Hello,
> >
> > What's the current status on AVX support for TCG? Is there anyone worki=
ng on it?
> > Is there interest for it?
>
> A couple of people, including myself, have started on it, but no results =
posted
> so far.  It's a large amount of work to clean up the exiting sse support =
before
> avx could be added.
>
>
> r~
