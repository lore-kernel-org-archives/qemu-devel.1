Received: from eggs.gnu.org ([2001:4830:134:3::10]:41693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkQYK-0003Fs-DO
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fkQYJ-0004Mh-HK
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:02:48 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fkQYJ-0004Lc-7p
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 05:02:47 -0400
Received: by mail-oi0-x243.google.com with SMTP id n21-v6so26570394oig.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 02:02:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730150958.14607-1-kwolf@redhat.com>
References: <20180730150958.14607-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jul 2018 10:02:25 +0100
Message-ID: <CAFEAcA8e44c71o6mmq6CatU68Pmux6SqRYDgU8kyaJ41rVvBGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Block layer patches
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

On 30 July 2018 at 16:09, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 6d9dd5fb9d0e9f4a174f53a0e20a39fbe809c71e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qobject-2018-07-27-v2' into staging (2018-07-30 09:55:47 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1239ac241fe170bb9fcf0be74bfff04f6f1c2560:
>
>   qemu-iotests: Test query-blockstats with -drive and -blockdev (2018-07-30 15:35:37 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-img convert -C is now required to enable copy offloading
> - file-posix: Fix write_zeroes with unmap on block devices (would fall
>   back to explicit writes on recent kernels)
> - Fix query-blockstats interface for use with -blockdev
> - Minor fixes and documentation updates
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
