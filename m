Received: from eggs.gnu.org ([2001:4830:134:3::10]:60414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gM9vr-0006It-I8
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gM9vq-00046N-I2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:03 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:44181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gM9vq-00044E-BN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:59:02 -0500
Received: by mail-oi1-x236.google.com with SMTP id p82-v6so6767568oih.11
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 02:59:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
References: <20181110140925.22457-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 10:58:39 +0000
Message-ID: <CAFEAcA_mUMN0gfjXy=y9+Lj3WvF+iJXyNPsihA3dYCeO4g2sgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] slirp updates
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

On 10 November 2018 at 14:09, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> The following changes since commit 160e5c22e55b3f775c2003dfc626fa872ee4a7a1:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2018-11-09 10:54:10 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to 5c75f3adbbfcdf8fae6e74875b44efb8d928974a:
>
>   slirp: fork_exec(): create and connect child socket before fork() (2018-11-10 15:07:53 +0100)
>
> ----------------------------------------------------------------
> slirp updates
>
> Peter Maydell (4):
>   slirp: Don't pass possibly -1 fd to send()
>   slirp: Use g_new() to allocate sockets in socreate()
>   slirp: Remove code that handles socreate() failure
>   slirp: fork_exec(): create and connect child socket before fork()
>
> ----------------------------------------------------------------
> Peter Maydell (4):
>       slirp: Don't pass possibly -1 fd to send()
>       slirp: Use g_new() to allocate sockets in socreate()
>       slirp: Remove code that handles socreate() failure
>       slirp: fork_exec(): create and connect child socket before fork()

Applied, thanks.

-- PMM
