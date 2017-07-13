Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdOU-0006b2-1J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVdOT-0002Jd-6u
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:38:58 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVdOT-0002JJ-08
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 08:38:57 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 62so22303966wmw.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 05:38:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
References: <1499786165-9404-1-git-send-email-yongbok.kim@imgtec.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 13:38:35 +0100
Message-ID: <CAFEAcA8MosyikKamBMx5Vwym+Anf09a7wiaDFwSs=e3P9_b+SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] target-mips queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 July 2017 at 16:16, Yongbok Kim <yongbok.kim@imgtec.com> wrote:
> The following changes since commit b5ed2e11ef39a308dcbef46f66774557b4a41fce:
>
>   build: disable Xen on ARM (2017-07-11 11:23:47 +0100)
>
> are available in the git repository at:
>
>   git://github.com/yongbok/upstream-qemu.git tags/mips-20170711
>
> for you to fetch changes up to 9768e2abf7ca3ef181f7cec134d7305c1643f78a:
>
>   mips/malta: load the initrd at the end of the low memory (2017-07-11 15:06:34 +0100)
>
> ----------------------------------------------------------------
> MIPS patches 2017-07-11
>
> Changes:
> * Fix MSA copy_[s|u]_df corner case of rd = 0
> * Update malta to load the initrd at the end of the low memory
>
> ----------------------------------------------------------------
>
> Aurelien Jarno (1):
>   mips/malta: load the initrd at the end of the low memory
>
> Miodrag Dinic (1):
>   target/mips: fix msa copy_[s|u]_df rd = 0 corner case
>
>  hw/mips/mips_malta.c    | 5 +++--
>  target/mips/translate.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
