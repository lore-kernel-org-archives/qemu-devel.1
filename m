Received: from eggs.gnu.org ([2001:4830:134:3::10]:56542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftXNF-0006sY-L6
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftXNE-0001Y9-Ii
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:09:01 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftXNE-0001VD-6W
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 08:09:00 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so19758507oib.10
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 05:08:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153504858585.3676.10222732707932789866.stgit@gimli.home>
References: <153504858585.3676.10222732707932789866.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Aug 2018 13:08:38 +0100
Message-ID: <CAFEAcA8S3iVgA8mOKkO=uK-ymmY_Vdho8idkz4Q7Rxv-twYGYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] vfio: Fix coverity, postcopy,
 and error path issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 19:27, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 3392fbee4e435658733bbe9aab23392660558b59:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-08-23 12:28:17 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180823.1
>
> for you to fetch changes up to 154304cd6e99e4222ed762976f9d9aca33c094d3:
>
>   postcopy: Synchronize usage of the balloon inhibitor (2018-08-23 10:45:58 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2018-08-23
>
>  - Fix coverity reported issue with use of realpath (Alex Williamson)
>
>  - Cleanup file descriptor in error path (Alex Williamson)
>
>  - Fix postcopy use of new balloon inhibitor (Alex Williamson)
>
> ----------------------------------------------------------------
> Alex Williamson (3):
>       vfio/pci: Handle subsystem realpath() returning NULL
>       vfio/pci: Fix failure to close file descriptor on error
>       postcopy: Synchronize usage of the balloon inhibitor
>
>  hw/vfio/common.c         |  1 +
>  hw/vfio/pci.c            |  2 +-
>  migration/postcopy-ram.c | 18 ++++++++++++++++--
>  3 files changed, 18 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
