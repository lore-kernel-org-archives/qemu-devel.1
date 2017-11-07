Received: from eggs.gnu.org ([2001:4830:134:3::10]:54690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC2H0-0005q8-9s
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC2Gz-0002Ba-B3
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:42:30 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:45501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC2Gz-0002B4-4t
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 06:42:29 -0500
Received: by mail-wm0-x244.google.com with SMTP id y80so3083465wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 03:42:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171106200554.5894-1-groug@kaod.org>
References: <20171106200554.5894-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 11:42:07 +0000
Message-ID: <CAFEAcA9dc2jZvi=B5AWmOJP8U0KFQNPnbqqSD3E_OezSsQvYxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] 9pfs fixes for 2.11 20171106
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

On 6 November 2017 at 20:05, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 299d1ea9bb56bd9f45f905125489bdd7d543a1aa:
>
>   Merge remote-tracking branch 'remotes/yongbok/tags/mips-20171106' into staging (2017-11-06 16:13:10 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 267fcadf325e54c6e1cb27321413dbdbe2200510:
>
>   9pfs: fix v9fs_mark_fids_unreclaim() return value (2017-11-06 18:05:35 +0100)
>
> ----------------------------------------------------------------
> This fixes a bad errno returned to the guest and a trivial coding style nit.
>
> ----------------------------------------------------------------
> Greg Kurz (2):
>       9pfs: drop one user of struct V9fsFidState
>       9pfs: fix v9fs_mark_fids_unreclaim() return value
>
>  hw/9pfs/9p.c | 2 +-
>  hw/9pfs/9p.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> --

Applied, thanks.

-- PMM
