Received: from eggs.gnu.org ([2001:4830:134:3::10]:42623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMf1R-0002WQ-Gc
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMf1Q-0005s1-PE
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:06:21 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:42035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMf1Q-0005ri-JF
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 14:06:20 -0500
Received: by mail-ot0-x22a.google.com with SMTP id i1so4270648oth.9
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 11:06:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171206152845.8215-1-alex.bennee@linaro.org>
References: <20171206152845.8215-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Dec 2017 19:05:59 +0000
Message-ID: <CAFEAcA_o2F8fSmKYxgd5ueVxuQksxWu2hKrMd7529QTW=moUig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 2.11] target/sh4/translate.c: fix TCG
 leak during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 6 December 2017 at 15:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> This fixes bug #1735384 while running java under qemu-sh4. When debug
> was enabled it showed a problem with TCG temps. Once fixed I was able
> to run java -version normally.
>

I don't think this merits holding up 2.11, which has already
had what I hope is its final release candidate.

thanks
-- PMM
