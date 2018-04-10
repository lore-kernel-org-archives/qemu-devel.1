Received: from eggs.gnu.org ([2001:4830:134:3::10]:50372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f60cu-0006yq-Hw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f60ct-0002wk-M3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:16:28 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f60ct-0002vM-GY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:16:27 -0400
Received: by mail-oi0-x229.google.com with SMTP id z8-v6so12595717oix.2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 14:16:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 22:16:06 +0100
Message-ID: <CAFEAcA_F7n74cv+JZ+Kg+xEqu80U+DBpTX2Gb99FmDjYU3NGdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.12 queue 20180410
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2018 at 13:52, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b32:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-04-09 17:29:10 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180410
>
> for you to fetch changes up to 6b3913e0858488ef3358c1683605d6894a6cadb0:
>
>   roms/u-boot-sam460ex: Change to qemu git mirror and update (2018-04-10 10:05:38 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2018-04-10
>
> Here's a rather late pull request with a handful of fixes for 2.12.
> These have been blocked for some time, because I wasn't able to
> complete my usual test set due to the SCSI problem fixed in 37c5174
> "scsi-disk: Don't enlarge min_io_size to max_io_size".
>
> Since we're in hard freeze, these are all bugfixes.  Most are also
> regressions, although in one case it's only a "regression" because a
> longstanding bug has been exposed by a new machine type (sam460ex) in
> the testcases.  There are also a couple of sam460ex fixes that aren't
> regressions since the board didn't exist before.  On the flipside
> though, they're low risk because they only touch board specific code
> for a board that doesn't exist in any released version.
>

Applied, thanks.

-- PMM
