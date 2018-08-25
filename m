Received: from eggs.gnu.org ([2001:4830:134:3::10]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftYDv-0001PQ-NS
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 09:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftY22-0002Rj-PK
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:51:11 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftY22-0002QX-Bb
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:51:10 -0400
Received: by mail-oi0-x242.google.com with SMTP id c190-v6so19864413oig.6
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 05:51:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823145230.13183-1-otubo@redhat.com>
References: <20180823145230.13183-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Aug 2018 13:50:49 +0100
Message-ID: <CAFEAcA9dfmD9f0yQvVQ5xV=srG5W7BtPdvunj1jDpES9DUjFqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paul Moore <pmoore@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>

On 23 August 2018 at 15:52, Eduardo Otubo <otubo@redhat.com> wrote:
> The following changes since commit 3392fbee4e435658733bbe9aab23392660558b=
59:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-08-23 12:28:17 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20180823
>
> for you to fetch changes up to 70dfabeaa79ba4d7a3b699abe1a047c8012db114:
>
>   seccomp: set the seccomp filter to all threads (2018-08-23 16:45:44 +02=
00)
>
> ----------------------------------------------------------------
> pull-seccomp-20180823
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (4):
>       seccomp: use SIGSYS signal instead of killing the thread
>       seccomp: prefer SCMP_ACT_KILL_PROCESS if available
>       configure: require libseccomp 2.2.0
>       seccomp: set the seccomp filter to all threads
>
>  configure      |  7 ++-----
>  qemu-seccomp.c | 36 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 6 deletions(-)


Applied, thanks.

-- PMM
