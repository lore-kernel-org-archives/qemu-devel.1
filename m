Received: from eggs.gnu.org ([2001:4830:134:3::10]:54089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNbK-0001jW-I9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNbE-0006H6-R1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:34:54 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNbE-0006G2-Lz
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:34:48 -0400
Received: by mail-oi0-x241.google.com with SMTP id f186so12293675oig.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:34:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312131806.23209-1-stefanha@redhat.com>
References: <20180312131806.23209-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:34:27 +0000
Message-ID: <CAFEAcA8VxyrDVMija0C219E5cPtKLC13YHcLFbB+VMRw9uCA_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: warn about missing MAINTAINERS
 file changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 March 2018 at 13:18, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Warn if files are added/renamed/deleted without MAINTAINERS file
> changes.  This has helped me in Linux and we could benefit from this
> check in QEMU.
>
> This patch is a manual cherry-pick of Linux commit
> 13f1937ef33950b1112049972249e6191b82e6c9 ("checkpatch: emit a warning on
> file add/move/delete") by Joe Perches <joe@perches.com>.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

Unfortunately the patch doesn't magically cause maintainers
to appear for the new files :-)

thanks
-- PMM
