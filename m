Received: from eggs.gnu.org ([2001:4830:134:3::10]:44128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoA1G-00048z-Nm
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eoA1F-0004dF-MI
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:50 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eoA1F-0004d8-GX
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:39:49 -0500
Received: by mail-oi0-x244.google.com with SMTP id l124so9764268oib.0
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 07:39:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180220104942.14531-1-groug@kaod.org>
References: <20180220104942.14531-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2018 15:39:28 +0000
Message-ID: <CAFEAcA_H1auuesqUu6SBj-ksLd2eghftQHDxDAVHre_z0ENyNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] 9p patches for 2.12 20180220
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

On 20 February 2018 at 10:49, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 299a2e6fac397be9b82c66583d53d1daaa3ffe=
6c:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' in=
to staging (2018-02-19 12:51:11 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6ce7177ae2e547999ef9e6f467415963991e28da:
>
>   9p: fix leak in synth_name_to_path() (2018-02-19 18:27:32 +0100)
>
> ----------------------------------------------------------------
> Fix memory leak in synth backend.
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (2):
>       9p: v9fs_path_copy() readability
>       9p: fix leak in synth_name_to_path()
>
>  hw/9pfs/9p-synth.c | 1 +
>  hw/9pfs/9p.c       | 9 ++++-----
>  hw/9pfs/9p.h       | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> --

Applied, thanks.

-- PMM
