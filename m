Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtY7G-0004Qp-Ql
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtXv4-0006bc-5D
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:16:15 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:45957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtXv0-0006FY-1T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 08:16:12 -0500
Received: by mail-ot1-x334.google.com with SMTP id 32so4162291ota.12
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 05:16:07 -0800 (PST)
MIME-Version: 1.0
References: <20190212045721.28041-1-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 13:15:54 +0000
Message-ID: <CAFEAcA_Oc4fTfcC-RFmV3zi7RnAbjDv=xWG8uPb_AT9buGnAcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/24] target/hppa patch queue
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

On Tue, 12 Feb 2019 at 04:57, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-hppa-20190211
>
> for you to fetch changes up to 23e76627deba013509b5f1a1e1c53e8e111145aa:
>
>   hw/hppa: forward requests to CPU HPA (2019-02-11 20:49:06 -0800)
>
> ----------------------------------------------------------------
> Convert to decodetree.
> Fix signed overflow conditions.
> Fix dcor.
> Add CPU MIE to PCI address space.

Hi -- clang compiles fail with:

In file included from
/home/petmay01/linaro/qemu-for-merges/target/hppa/translate.c:337:
target/hppa/decode.inc.c:471:16: error: redefinition of typedef
'arg_be' is a C11 feature [-Werror,-Wtypedef-redefinition]
typedef arg_be arg_be;
               ^
target/hppa/decode.inc.c:9:3: note: previous definition is here
} arg_be;
  ^
target/hppa/decode.inc.c:473:16: error: redefinition of typedef
'arg_bl' is a C11 feature [-Werror,-Wtypedef-redefinition]
typedef arg_bl arg_bl;
               ^
target/hppa/decode.inc.c:15:3: note: previous definition is here
} arg_bl;
  ^

thanks
-- PMM
