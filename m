Received: from eggs.gnu.org ([2001:4830:134:3::10]:47908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJQe-0000Lh-Tf
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJQe-00077v-4y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:44:00 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyJQe-00077M-18
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:44:00 -0400
Received: by mail-oi0-x244.google.com with SMTP id 71-v6so1699490oie.12
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:43:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320090813.852-1-laurent@vivier.eu>
References: <20180320090813.852-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 15:43:38 +0000
Message-ID: <CAFEAcA-xx0SWaymZy6mUqgYscj8WUxMX19T6VYM+4w6xkyOdrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2018 at 09:08, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 55901900ec69d6fd6f332003d8ab81b2f8a38529:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.12-pull-request' into staging (2018-03-15 17:58:28 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to ecc207d2fc1d45fabb16c38742a6675a7ba56cbc:
>
>   target/m68k: add a mechanism to automatically free TCGv (2018-03-20 09:38:58 +0100)
>
> ----------------------------------------------------------------
> This series of patches is needed to fix a problem
> in the m68k translator that can crash QEMU when translation
> cache has too many instructions:
>
>   qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>
> I have reproduced it in linux user mode, with "ghc", and in
> system mode with the debian-installer for unstable distro
> from debian-ports.
> ----------------------------------------------------------------
>
> Laurent Vivier (2):
>   target/m68k: add DisasContext parameter to gen_extend()
>   target/m68k: add a mechanism to automatically free TCGv
>
>  target/m68k/translate.c | 102 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 36 deletions(-)

Applied, thanks.

-- PMM
