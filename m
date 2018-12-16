Received: from eggs.gnu.org ([2001:4830:134:3::10]:35273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYZLH-00058B-52
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 11:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gYZLF-0000J2-Uk
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 11:32:35 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:46078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gYZLF-0000Ho-OS
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 11:32:33 -0500
Received: by mail-ot1-x333.google.com with SMTP id 32so9974288ota.12
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 08:32:33 -0800 (PST)
MIME-Version: 1.0
References: <20181214105707.10707-1-kwolf@redhat.com>
In-Reply-To: <20181214105707.10707-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 16 Dec 2018 16:32:21 +0000
Message-ID: <CAFEAcA9s=b7iNnUiB5+Z0FWXQbGShuwZFDQQWWD7k8cLPRL53Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/42] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 10:57, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit d8d5fefd8657d4f7b380b3a1533340434b5b9def:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2018-12-13 18:45:18 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 537c3d4f64297911a5b70a151926cd7851bbf752:
>
>   block/mirror: add missing coroutine_fn annotations (2018-12-14 11:55:02 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Decompression worker threads
> - dmg: lzfse compression support
> - file-posix: Simplify delegation to worker thread
> - Don't pass flags to bdrv_reopen_queue()
> - iotests: make 235 work on s390 (and others)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
