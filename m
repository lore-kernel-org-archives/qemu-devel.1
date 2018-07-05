Received: from eggs.gnu.org ([2001:4830:134:3::10]:51369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Wv-0001rW-II
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb6Wu-0007NP-O9
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:50:49 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:46782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb6Wu-0007N2-KJ
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 11:50:48 -0400
Received: by mail-oi0-x22e.google.com with SMTP id y207-v6so17766275oie.13
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 08:50:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 16:50:27 +0100
Message-ID: <CAFEAcA-CtuWBSENpNsGBaTcyA8KdQmMuGT6DJMFxwmGJwNux3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/12] Block layer patches
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

On 5 July 2018 at 11:25, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit fe8d2d5737ab20ed0118863f5eb888cae37122ab:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.0-pull-request' into staging (2018-07-04 22:38:10 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 7c20c808a5cbf5d244735bc78fc3138c739c1946:
>
>   file-posix: Unlock FD after creation (2018-07-05 11:07:58 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Use worker threads for compression to improve performance of
>   'qemu-img convert -W' and compressed backup jobs
> - blklogwrites: New filter driver to log write requests to an image in
>   the dm-log-writes format
> - file-posix: Fix image locking during image creation
> - crypto: Fix memory leak in error path
> - Error out instead of silently truncating node names
>

Applied, thanks.

-- PMM
