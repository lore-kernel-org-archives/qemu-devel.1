Received: from eggs.gnu.org ([2001:4830:134:3::10]:45861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f9Mvc-0000oT-3Q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f9Mvb-00038L-BT
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:40 -0400
Received: from mail-yb0-x229.google.com ([2607:f8b0:4002:c09::229]:41887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f9Mvb-00037e-5q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 23:41:39 -0400
Received: by mail-yb0-x229.google.com with SMTP id e6-v6so821692ybn.8
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 20:41:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 19 Apr 2018 20:41:37 -0700
Message-ID: <CAMo8BfJzXkum4a-p2iNxv7dZ-OHzCHpQ9MZ949OqoMt7escb1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/43] fix building of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Apr 19, 2018 at 6:58 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> We still have quite a bit of test code that is not built. These are:
[...]
>   * tests/tcg/xtensa
>   Needs a cross-compiler

FWIW static bare-metal cross-compiler w/o libc for xtensa core
used in test/tcg/xtensa is available here:

https://github.com/foss-xtensa/toolchain/releases/download/2018.02/x86_64-2=
018.02-xtensa-dc232b-elf.tar.gz

--=20
Thanks.
-- Max
