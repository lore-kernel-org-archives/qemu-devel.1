Received: from eggs.gnu.org ([2001:4830:134:3::10]:34089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Fjg-0007x5-8P
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2Fje-0000rN-TS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:03:40 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:51032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2Fje-0000pw-MW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:03:38 -0400
Received: by mail-wm0-x236.google.com with SMTP id u138so4022915wmu.5
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 05:03:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507696406-11168-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1507696406-11168-1-git-send-email-jiang.biao2@zte.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Oct 2017 13:03:15 +0100
Message-ID: <CAFEAcA_EefcYLjt5aG1D+rcQes9vig6OFZGJrxNhgp5q2vfqbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: replace ERROR with WARN for
 extern checking.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: QEMU Developers <qemu-devel@nongnu.org>, zhong.weidong@zte.com.cn

On 11 October 2017 at 05:33, Jiang Biao <jiang.biao2@zte.com.cn> wrote:
> There are some rare cases which need external declarations in .c
> files. patchew.org and checkpatch.pl will complain errors on
> patches for these declarations.
>
> Degrade ERROR to WARN to erase the error complaints taking
> checkpatch.pl in kernel as reference.
>
> Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'd rather not drop this to a warning for the sake of a single
use case that's already in the tree (and which if you really
cared about you could work around by putting the link_error()
declaration in a header file I suppose, though I wouldn't
bother personally.)

thanks
-- PMM
