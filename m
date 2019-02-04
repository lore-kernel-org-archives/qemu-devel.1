Received: from eggs.gnu.org ([209.51.188.92]:54012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqaww-0001rp-RN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:53:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gqawu-0000xT-Sq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:53:58 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gqawt-0000wV-RG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:53:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id z3so2609355wrv.3
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 01:53:55 -0800 (PST)
References: <20190201193234.20796-1-eblake@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201193234.20796-1-eblake@redhat.com>
Date: Mon, 04 Feb 2019 09:53:52 +0000
Message-ID: <87zhrbc21b.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore fp test outputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


Eric Blake <eblake@redhat.com> writes:

> Commit 2cade3d wired up new tests, but did not exclude the
> new *.out files produced by running the tests.

Queued to fpu/next, thanks.

>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 72c18aaab04..f2bf85c8c4c 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -5,6 +5,7 @@ benchmark-crypto-hmac
>  check-*
>  !check-*.c
>  !check-*.sh
> +fp/*.out
>  qht-bench
>  rcutorture
>  test-*


--=20
Alex Benn=C3=A9e
