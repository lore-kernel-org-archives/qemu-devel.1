Received: from eggs.gnu.org ([2001:4830:134:3::10]:60881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRKUP-0007FC-5D
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRKUO-0006XM-9G
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:11:33 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:39926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRKUO-0006Ws-2l
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:11:32 -0500
Received: by mail-oi0-x22f.google.com with SMTP id r63so12713251oia.6
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 08:11:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513684540-13949-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513684540-13949-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2017 16:11:10 +0000
Message-ID: <CAFEAcA-_CeZ08vyaV5ihi9QsC=cByAK-W1LmvygCPktJxKJHgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1] Merge tpm 2017/12/19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 December 2017 at 11:55, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The patch in this pull request fixes a linker error when --disable-tpm is used.
>
>    Stefan
>
> The following changes since commit eaefea537b476cb853e2edbdc68e969ec777e4bb:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2017-12-18 14:17:42 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-19-1
>
> for you to fetch changes up to 89be9e99c83095af25ce16907143c31f2959188b:
>
>   tpm: move qdev_prop_tpm to hw/tpm/ (2017-12-19 06:40:04 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2017/12/19 v1
>
> ----------------------------------------------------------------
> Cornelia Huck (1):
>       tpm: move qdev_prop_tpm to hw/tpm/
>
>  hw/core/qdev-properties-system.c | 64 --------------------------------------------------------------
>  hw/tpm/Makefile.objs             |  5 +++--
>  hw/tpm/tpm_util.c                | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_util.h                |  3 +++
>  include/hw/qdev-properties.h     |  2 --
>  5 files changed, 73 insertions(+), 68 deletions(-)
>

Applied, thanks.

-- PMM
