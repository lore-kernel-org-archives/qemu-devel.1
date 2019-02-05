Received: from eggs.gnu.org ([209.51.188.92]:46002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0Wm-0004L3-GT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0Wi-00071i-OX
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:12:38 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr0Wg-0006vf-Rq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:12:35 -0500
Received: by mail-ot1-x341.google.com with SMTP id t5so5603111otk.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:12:28 -0800 (PST)
MIME-Version: 1.0
References: <20190205023937.18245-1-eblake@redhat.com>
In-Reply-To: <20190205023937.18245-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:12:12 +0000
Message-ID: <CAFEAcA_zxFJWqzD22d2f2Kj3fwQ2jxHu9SoSFojOLVU1bMS0Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Avoid non-portable 'test -o/-a'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Tue, 5 Feb 2019 at 02:46, Eric Blake <eblake@redhat.com> wrote:
>
> POSIX says that it is better to use &&/|| and two separate test
> invocations than it is to try and use -a and -o (in fact, there
> are some tests that are inherently ambiguous to parse if the
> user passes in corner-case input like "(").
>
> Since we cannot guarantee which shell runs configure, we cannot
> rely on -o/-a always following bash's parser rules.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
