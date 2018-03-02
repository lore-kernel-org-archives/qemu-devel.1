Received: from eggs.gnu.org ([2001:4830:134:3::10]:49823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erpeg-0004kb-12
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erpef-0001dB-3a
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:43:42 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erpee-0001cK-T7
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:43:41 -0500
Received: by mail-oi0-x241.google.com with SMTP id e9so1095028oii.0
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 10:43:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
References: <20180302115743.3409-1-kbastian@mail.uni-paderborn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 18:43:19 +0000
Message-ID: <CAFEAcA8ZiLeuEyQb3rxDDPsS1DW8uOYYVNBQ215fDphkg+=a=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] tricore-patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 11:57, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/bkoppelmann/qemu-tricore-upstream.git tags/pull-tricore-2018-03-02
>
> for you to fetch changes up to ce46335c9f31f9eea1736d9c2d3a11d3a8c2cb6b:
>
>   tricore: renamed masking of PIE (2018-03-02 11:46:36 +0100)
>
> ----------------------------------------------------------------
> tricore patches
>
> ----------------------------------------------------------------
> David Brenken (4):
>       tricore: added some missing cpu instructions
>       tricore: added CORE_ID
>       tricore: renamed masking of IE
>       tricore: renamed masking of PIE
>
>  target/tricore/cpu.h             |  7 +++++--
>  target/tricore/csfr.def          |  1 +
>  target/tricore/op_helper.c       | 29 +++++++++++++++--------------
>  target/tricore/translate.c       | 31 +++++++++++++++++++++++++++++--
>  target/tricore/tricore-opcodes.h |  3 +++
>  5 files changed, 53 insertions(+), 18 deletions(-)

Applied, thanks.

-- PMM
