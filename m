Received: from eggs.gnu.org ([2001:4830:134:3::10]:56161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HSz-00089x-LL
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HSy-0001gV-SO
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:59:45 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HSy-0001gH-KT
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:59:44 -0400
Received: by mail-ot1-x341.google.com with SMTP id e18-v6so1278637oti.8
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:59:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926112048.17778-5-alex.bennee@linaro.org>
References: <20180926112048.17778-1-alex.bennee@linaro.org>
	<20180926112048.17778-5-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:59:23 +0100
Message-ID: <CAFEAcA9fMwG+a=XaxsOrMb=t-w4dbQ-0yAPbRhvRZgB60YRbnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/4] tests/guest-debug: fix scoping of
 failcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Omair Javaid <omair.javaid@linaro.org>

On 26 September 2018 at 12:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> You should declare you are using a global version of a variable before
> you attempt to modify it in a function.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/guest-debug/test-gdbstub.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-g=
dbstub.py
> index 474d2c5c65..7bfc95b187 100644
> --- a/tests/guest-debug/test-gdbstub.py
> +++ b/tests/guest-debug/test-gdbstub.py
> @@ -16,6 +16,7 @@ def report(cond, msg):
>          print ("PASS: %s" % (msg))
>      else:
>          print ("FAIL: %s" % (msg))
> +        global failcount
>          failcount +=3D 1


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Incidentally, if we ever get above 127 tests in this file,
the "exit(failcount)" at the bottom of the script will
not DTRT :-)

thanks
-- PMM
