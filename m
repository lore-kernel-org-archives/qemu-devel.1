Received: from eggs.gnu.org ([2001:4830:134:3::10]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMVib-0002H7-0k
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMViZ-000235-Tq
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:14:48 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMViZ-00022k-L1
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 05:14:47 -0500
Received: by mail-ot1-x341.google.com with SMTP id g27so10798293oth.6
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 02:14:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 10:14:26 +0000
Message-ID: <CAFEAcA8DJeczPLPWWxkczQZp1FJWgJnFNx-fFNLpkUnpjzY-dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Block layer patches
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

On 12 November 2018 at 17:05, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 5704c36d25ee84e7129722cb0db53df9faefe943:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181112-pull-request' into staging (2018-11-12 15:55:40 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1a42e5d8298d1b0f90d2254e7d559391dd3a45ca:
>
>   Merge remote-tracking branch 'mreitz/tags/pull-block-2018-11-12' into queue-block (2018-11-12 17:57:32 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - file-posix: Don't waste a file descriptor for locking, don't lock the
>   same bit multiple times
> - nvme: Fix double free and memory leak
> - Misc error handling fixes
> - Added NULL checks found by static analysis
> - Allow more block drivers to not be included in the qemu build
>

Applied, thanks.

-- PMM
