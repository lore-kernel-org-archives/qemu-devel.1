Received: from eggs.gnu.org ([2001:4830:134:3::10]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fHuk7-0001Ei-Qz
	for qemu-devel@nongnu.org; Sun, 13 May 2018 13:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fHuk6-0006T5-W0
	for qemu-devel@nongnu.org; Sun, 13 May 2018 13:25:07 -0400
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fHuk6-0006Sp-RF
	for qemu-devel@nongnu.org; Sun, 13 May 2018 13:25:06 -0400
Received: by mail-yw0-x22c.google.com with SMTP id l15-v6so2963053ywk.3
	for <qemu-devel@nongnu.org>; Sun, 13 May 2018 10:25:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512175724.5923-5-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
	<20180512175724.5923-5-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 May 2018 10:25:05 -0700
Message-ID: <CAMo8BfKShAJFFr8j_fwQjSQSXwh97=UCOinzfS1Lio=fdFFxug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/4] target/xtensa: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Sat, May 12, 2018 at 10:57 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/xtensa/translate.c | 229 ++++++++++++++++++++------------------
>  1 file changed, 122 insertions(+), 107 deletions(-)

This patch breaks tests/tcg/xtensa/test_mmu.S cross_page_tb test.
Looking at it...

-- 
Thanks.
-- Max
