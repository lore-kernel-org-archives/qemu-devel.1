Received: from eggs.gnu.org ([209.51.188.92]:43807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gtbR2-0003og-7z
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gtbQz-0000Wt-RP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:01:28 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1gtbQz-0000U5-M0
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:01:25 -0500
Received: by mail-ot1-x341.google.com with SMTP id i5so5578104oto.9
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 09:01:24 -0800 (PST)
MIME-Version: 1.0
References: <20190212160953.29051-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190212160953.29051-1-marcandre.lureau@redhat.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 12 Feb 2019 18:01:12 +0100
Message-ID: <CABLmASFKma=LQ8+aZUfd_6apRC6_50nt7CjeqBVXq05uEqgJFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix slirp regression on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Tue, Feb 12, 2019 at 5:09 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@redhat.com> wrote:

> Hi,
>
> QEMU wraps the socket functions in os-win32.h, but in commit
> a9d8b3ec4385793815d71217857304, the header inclusion was dropped,
> breaking slirp on Windows. Fix the regression by wrapping all the
> socket functions.
>
> thanks
>
> Marc-Andr=C3=A9 Lureau (2):
>   slirp: remove slirp_ prefix for socket wrappers
>   slirp: wrap the remaining socket functions
>
>  slirp/util.h     |  75 ++++++++++++++++++----
>  slirp/ip_icmp.c  |   4 +-
>  slirp/misc.c     |  14 ++--
>  slirp/slirp.c    |   2 +-
>  slirp/socket.c   |  14 ++--
>  slirp/tcp_subr.c |  10 +--
>  slirp/udp.c      |   2 +-
>  slirp/util.c     | 164 ++++++++++++++++++++++++++++++++++++++++++++++-
>  8 files changed, 246 insertions(+), 39 deletions(-)
>
> --
> 2.21.0.rc0.1.g036caf7885
>

Confirmed, slirp working again in qemu-system-ppc for windows, so

Tested-by: Howard Spoelstra
