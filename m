Received: from eggs.gnu.org ([209.51.188.92]:33880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzJJw-00057M-9c
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzJJv-0007rF-Js
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:53:44 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:34969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzJJv-0007qc-Af
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:53:43 -0500
Received: by mail-wr1-x430.google.com with SMTP id t18so21418123wrx.2
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 02:53:43 -0800 (PST)
References: <20181129185113.30353-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181129185113.30353-1-stefanha@redhat.com>
Date: Thu, 28 Feb 2019 10:53:41 +0000
Message-ID: <87d0nckwui.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3] target/arm: add ARMv6-M UNDEFINED 32-bit
 instruction test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu.ml@steffen-goertz.de, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, joel@jms.id.au, jusual@mail.ru, jim@groklearning.com


Stefan Hajnoczi <stefanha@redhat.com> writes:

> Test that 32-bit instructions declared UNDEFINED in the ARMv6-M
> Reference Manual really do raise an exception.  Also test that the 6
> 32-bit instructions defined in the ARMv6-M Reference Manual do not raise
> an exception.
>
> The Intel HEX (.hex) file is included to save people the trouble of
> installing a cross-compiler toolchain.
>
> To run the test (make sure qemu-system-arm is in your $PATH):
>
>   $ cd tests/tcg/arm
>   $ make run-test-armv6m-undef
>
> Based-on: <20181029194519.15628-1-stefanha@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

I'm snarfing this into my testing/enable-system-tcg-tests-v2 as I need a
few more example system tests ;-)

--
Alex Benn=C3=A9e
