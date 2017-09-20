Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dum9f-0001Qv-V5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dum9f-00021h-1o
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:35 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:54871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dum9e-000218-SK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:34 -0400
Received: by mail-wr0-x22c.google.com with SMTP id g29so3127211wrg.11
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:03:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170920135038.21058-1-groug@kaod.org>
References: <20170920135038.21058-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Sep 2017 22:03:12 +0100
Message-ID: <CAFEAcA-houyt5ZS-ss8PiiZogpYOySJ5GkvPs2PTGVKcL0WUjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] 9pfs fixes for 2.11 20170920
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 September 2017 at 14:50, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit c51700273ad9802a21c19f8d2b4bcb67c38e74ac:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging (2017-09-19 18:08:48 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 772a73692ecb52bace0cff6f95df62f59b8cabe0:
>
>   9pfs: check the size of transport buffer before marshaling (2017-09-20 08:48:52 +0200)
>
> ----------------------------------------------------------------
> These patches fix regressions in 2.10
>
> ----------------------------------------------------------------
> Jan Dakinevich (3):
>       9pfs: fix readdir() for 9p2000.u
>       9pfs: fix name_to_path assertion in v9fs_complete_rename()
>       9pfs: check the size of transport buffer before marshaling
>
>  hw/9pfs/9p.c | 60 ++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> --
> 2.13.5

Applied, thanks.

-- PMM
