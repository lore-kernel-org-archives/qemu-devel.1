Received: from eggs.gnu.org ([209.51.188.92]:38433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpOr-0005Np-SL
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpOq-000590-Qz
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:49 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpOq-00058c-JP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 07:58:48 -0400
Received: by mail-ot1-x331.google.com with SMTP id f10so9136219otb.6
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 04:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190408193711.32680-1-laurent@vivier.eu>
In-Reply-To: <20190408193711.32680-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 12:58:36 +0100
Message-ID: <CAFEAcA9Cc3i83kqjm0Yj9xZyRy0SMDpg7yvcNeTet4LJGB82WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Linux user for 4.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Mon, 8 Apr 2019 at 20:38, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit f55a585d1037e5de6088f25e75443c2776786e=
29:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2019-04-07 14:54:55 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.0-pull-request
>
> for you to fetch changes up to 71ba74f67eaca21b0cc9d96f534ad3b9a7161400:
>
>   linux-user: rename gettid() to sys_gettid() to avoid clash with glibc (=
2019-04-08 17:27:13 +0200)
>
> ----------------------------------------------------------------
> fix gettid() clash with new glibc
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (2):
>   linux-user: assume __NR_gettid always exists
>   linux-user: rename gettid() to sys_gettid() to avoid clash with glibc
>
>  linux-user/syscall.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
