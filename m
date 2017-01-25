Received: from eggs.gnu.org ([2001:4830:134:3::10]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWSPE-0006Ef-Ba
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWSPD-0006Bu-3x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:34:52 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWSPC-0006Bm-U6
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:34:51 -0500
Received: by mail-ua0-x234.google.com with SMTP id y9so166620701uae.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 10:34:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485352082-16830-1-git-send-email-groug@kaod.org>
References: <1485352082-16830-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 18:34:29 +0000
Message-ID: <CAFEAcA-1ZPXhV+KNj5e9V8Fr96tJF9VvSY+unBZBMiQXOCs-Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/5] 9p patches 20170125
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 25 January 2017 at 13:47, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit a9e404600a9bd1e6a26431fc89e5069092e67f14:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170124' into staging (2017-01-24 17:26:26 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to fa0eb5c512d17a223d9f9bac45da48d78d12f584:
>
>   9pfs: fix offset error in v9fs_xattr_read() (2017-01-25 09:34:35 +0100)
>
> ----------------------------------------------------------------
> This pull request fixes a 2.9 regression and a long standing bug that can
> cause 9p clients to hang. Other patches are minor enhancements.
>
> ----------------------------------------------------------------
> Greg Kurz (5):
>       9pfs: add missing coroutine_fn annotations
>       tests: virtio-9p: improve error reporting
>       9pfs: fix off-by-one error in PDU free list
>       9pfs: local: trivial cosmetic fix in pwritev op
>       9pfs: fix offset error in v9fs_xattr_read()

Applied, thanks.

-- PMM
