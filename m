Received: from eggs.gnu.org ([209.51.188.92]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj2jJ-0004mz-4D
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj2dq-00021l-Iw
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:51:03 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj2dq-00021T-Ea
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 08:51:02 -0500
Received: by mail-ot1-x341.google.com with SMTP id 81so19348379otj.2
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 05:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20190114104641.19186-1-alex.bennee@linaro.org>
In-Reply-To: <20190114104641.19186-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 13:50:50 +0000
Message-ID: <CAFEAcA812=2rFxpXFW=Zqjs59ruimZLBjz0w_ZKXVGFsZWjXdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: use g_usleep instead of rem =
 sleep(time)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, 14 Jan 2019 at 11:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Relying on sleep to always return having slept isn't safe as a signal
> may have occurred. If signals are constantly incoming the program will
> never reach it's termination condition. This is believed to be the
> mechanism causing time outs for qht-test in Travis.
>
> The glib g_usleep() deals with all of this for us so lets use it instead.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/atomic64-bench.c   | 6 ++----
>  tests/atomic_add-bench.c | 6 ++----
>  tests/qht-bench.c        | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
