Received: from eggs.gnu.org ([2001:4830:134:3::10]:53298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fL3lq-0005Jc-Nk
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fL3lp-0006ka-U0
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:39:54 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:35420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fL3lp-0006kS-PY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:39:53 -0400
Received: by mail-yb0-x241.google.com with SMTP id y3-v6so1931491ybb.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:39:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512175724.5923-1-richard.henderson@linaro.org>
References: <20180512175724.5923-1-richard.henderson@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 May 2018 02:39:52 -0700
Message-ID: <CAMo8Bf+EpjvJqjv2JqksbXUx_j4Eds5ULE8-Bvs-jm9TgyrgoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/xtensa: Convert to TranslatorOps
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

Hi Richard,

On Sat, May 12, 2018 at 10:57 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I have one xtensa image against which to test this.
> There are enough options going on here in the xtensa
> frontend that this probably needs a better work-out.
>
>
> r~
>
>
> Richard Henderson (4):
>   target/xtensa: Replace DISAS_UPDATE with DISAS_NORETURN
>   target/xtensa: Convert to DisasContextBase
>   target/xtensa: Change gen_intermediate_code dc to pointer
>   target/xtensa: Convert to TranslatorOps
>
>  target/xtensa/translate.c | 345 +++++++++++++++++++-------------------
>  1 file changed, 177 insertions(+), 168 deletions(-)

With the change that I've mentioned in response to 4/4:
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
for the series.

Would you like to do that change and carry the series yourself
or should I take it?

-- 
Thanks.
-- Max
