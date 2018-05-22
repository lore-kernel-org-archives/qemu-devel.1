Received: from eggs.gnu.org ([2001:4830:134:3::10]:48641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL8ct-0002Py-FB
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL8cs-00037x-DS
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:50:59 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:44361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL8cs-00036y-7g
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:50:58 -0400
Received: by mail-ot0-x235.google.com with SMTP id g7-v6so21265556otj.11
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:50:57 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 15:50:36 +0100
Message-ID: <CAFEAcA-aD98+wh=XfMkY1iUwHjDJZ6dH7Juv0_o_VbgkcV0etw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] TCG helpers that return f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi; I was reading about the x86-64 calling convention and I found
out that apparently for returns of smaller-than-register types the
high parts may contain garbage:
https://stackoverflow.com/questions/36706721/is-a-sign-or-zero-extension-required-when-adding-a-32bit-offset-to-a-pointer-for/36760539#36760539

However, for TCG helper functions, although we allow the helper
macro to say that the return type is 'f16', in helper-head.h we
seem to just alias f16 as i32, and in dh_sizemask() we only record
"is this 64 bits" and "is this signed". Am I missing the place
where we zero-extend the value we get back from the helper so
that it's the right thing in TCG's i32 ?

thanks
-- PMM
