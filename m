Received: from eggs.gnu.org ([2001:4830:134:3::10]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nX4-0002dx-V4
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nX3-0003BM-Nk
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:14:06 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nX3-0003Ai-80
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:14:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id c18-v6so6898344otm.3
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:14:05 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <211fa1a4-3886-a585-dcec-d06e9786cd15@linaro.org>
Date: Wed, 3 Oct 2018 15:14:01 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/13] target/arm: Add v8M stack limit
 checks on NS function calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/2/18 11:35 AM, Peter Maydell wrote:
> Check the v8M stack limits when pushing the frame for a
> non-secure function call via BLXNS.
> 
> In order to be able to generate the exception we need to
> promote raise_exception() from being local to op_helper.c
> so we can call it from helper.c.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h | 9 +++++++++
>  target/arm/helper.c    | 4 ++++
>  target/arm/op_helper.c | 4 ++--
>  3 files changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
