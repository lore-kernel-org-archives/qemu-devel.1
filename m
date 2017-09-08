Received: from eggs.gnu.org ([2001:4830:134:3::10]:60211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqGgP-0004g5-JP
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqGgL-0006CJ-41
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:38:45 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqGgK-0006BO-TV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:38:41 -0400
Received: by mail-wr0-x232.google.com with SMTP id m18so3928145wrm.2
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 03:38:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170907184447.22752-1-richard.henderson@linaro.org>
References: <20170907184447.22752-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 11:38:19 +0100
Message-ID: <CAFEAcA9dix6oyk7Hp1CZB2aqNeCCvA_DZ6fk7AxAPztAk_9d-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] target/hppa update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 September 2017 at 19:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Just the conversion to TranslatorOps.
>
>
> r~
>
>
> The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
>
>   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/rth7680/qemu.git tags/pull-pa-20170907
>
> for you to fetch changes up to 51b061fbf027f844cc0bfb1eaaf0ae818e3ceb36:
>
>   target/hppa: Convert to TranslatorOps (2017-09-07 11:23:13 -0700)
>
> ----------------------------------------------------------------
> Conversion to TranslatorOps
>
> ----------------------------------------------------------------
> Richard Henderson (3):
>       target/hppa: Convert to DisasJumpType
>       target/hppa: Convert to DisasContextBase
>       target/hppa: Convert to TranslatorOps
>
>  target/hppa/translate.c | 894 ++++++++++++++++++++++++------------------------
>  1 file changed, 448 insertions(+), 446 deletions(-)

Applied, thanks.

-- PMM
