Received: from eggs.gnu.org ([2001:4830:134:3::10]:54857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFnA-0005Zl-OJ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:32:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEFn9-0007nW-NM
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:32:52 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:54785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEFn9-0007nO-HZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:32:51 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r68so15673114wmr.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:32:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171109180142.13923-1-samuel.thibault@ens-lyon.org>
References: <20171109180142.13923-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 14:32:29 +0000
Message-ID: <CAFEAcA_x3YrnL5QXJiQugY9AjP20+oYnF5CPfBcYB7qo=_h-6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] slirp update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 9 November 2017 at 18:01, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 990132cda9baa27bdc558df6c9c15aacb0322d2c:
>
>   slirp: don't zero the whole ti_i when m == NULL (2017-11-09 18:59:22 +0100)
>
> ----------------------------------------------------------------
> slirp updates
>
> ----------------------------------------------------------------
> Tao Wu (1):
>       slirp: don't zero the whole ti_i when m == NULL
>
> This fixes the qemu slirp behavior is some rare cases (some RST cases,
> keep alive probes), packets would be sent to 0.0.0.0.
>
>  slirp/tcp_subr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
