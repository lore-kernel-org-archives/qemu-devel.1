Received: from eggs.gnu.org ([2001:4830:134:3::10]:36508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzKLQ-0004qA-PO
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzKLM-0002rB-V7
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:27:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzKLM-0002qP-Ha
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:27:00 -0400
Received: by mail-wr1-x444.google.com with SMTP id g33-v6so21552874wrd.1
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 04:27:00 -0700 (PDT)
References: <20180908191735.22861-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180908191735.22861-1-cota@braap.org>
Date: Mon, 10 Sep 2018 12:26:58 +0100
Message-ID: <878t49d24d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] softfloat tests based on berkeley's
 testfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>


Emilio G. Cota <cota@braap.org> writes:

> A few fixes since yesterday's v1:
>   https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00884.html
>
> - Convert copy_qemu_to_soft80 to qemu_to_soft80, just like the other
>   conversion functions
> - Set fp-test as the program name as reported by itself
> - Fix Makefile to include .d files so that dependencies are
>   properly tracked
> - Update commit log

Just some general comments:

 - I think this is a better way to go than the IBM test suite
 - I'm ambivalent about maintaining our fp-test.c in close alignment to
   softfloat unless we expect much upstreaming of changes.
 - the coverage seems a bit low. Rebuilding everything with
   --enable-gcov and running -all1 -all2 I get:

  tests/fp/fp-test.c - 53.5 % coverage 43.3 % branch coverage
  fpu/softfloat.c - 32.5 % coverage 25.1 % branch coverage

But maybe I didn't pass enough options to fp-test? I could really do
with a --just-run-everything-and-summarise-failing-functions option so I
can then go through in more detail with fp-test fFOO_BAR.

>
> Grab this from:
>   https://github.com/cota/qemu/tree/fp-test-v2
>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
