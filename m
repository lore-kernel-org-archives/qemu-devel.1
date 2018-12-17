Received: from eggs.gnu.org ([2001:4830:134:3::10]:50233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYskM-00065f-18
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYsY1-0002Ha-7E
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:03:02 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:40098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYsY1-0002H2-24
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:03:01 -0500
Received: by mail-oi1-x22f.google.com with SMTP id t204so10056738oie.7
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 05:03:01 -0800 (PST)
MIME-Version: 1.0
References: <20181214151718.5041-1-alex.bennee@linaro.org>
In-Reply-To: <20181214151718.5041-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Dec 2018 13:02:48 +0000
Message-ID: <CAFEAcA82eXLnsHb3hpTtqD-2eWQyLYZmnR1Vvyi7-toGsB88qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .shippable.yml: disable the win cross tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Fri, 14 Dec 2018 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The pkg.mxe.cc package repositories have been down for the last two
> weeks causing the builds to fail when shippable re-builds the
> containers.

:-(

> This is really just a sticking plaster until we can get our own docker
> hub images properly setup so we can avoid having dependencies on
> external repos.

Applied to master, thanks.

-- PMM
