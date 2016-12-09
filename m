Received: from eggs.gnu.org ([2001:4830:134:3::10]:34154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOlI-0001Jx-IF
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOlD-0005n8-Kp
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:15:08 -0500
Received: from mail-wj0-f171.google.com ([209.85.210.171]:33644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFOlD-0005m8-FS
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:15:03 -0500
Received: by mail-wj0-f171.google.com with SMTP id xy5so19929413wjc.0
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 09:15:03 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-4-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-4-bobby.prani@gmail.com>
Date: Fri, 09 Dec 2016 17:14:01 +0000
Message-ID: <87lgvpxbxi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/19] check-help: add some hint to run a
 single test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> It's possible to run the test directly, tests/test-foo, but then
> recompilation is not triggered and test environment variables aren't set
> for you.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  tests/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index e98d3b6..2a2b78d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -731,6 +731,7 @@ check-help:
>  	@echo " make check-qtest-TARGET   Run qtest tests for given target"
>  	@echo " make check-qtest          Run qtest tests"
>  	@echo " make check-unit           Run qobject tests"
> +	@echo " make check-tests/test-foo Run the tests/test-foo unit test only"
>  	@echo " make check-qapi-schema    Run QAPI schema tests"
>  	@echo " make check-block          Run block tests"
>  	@echo " make check-report.html    Generates an HTML test report"


--
Alex Bennée
