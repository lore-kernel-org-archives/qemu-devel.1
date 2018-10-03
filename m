Received: from eggs.gnu.org ([2001:4830:134:3::10]:48500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ncX-0005cj-Gl
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7ncU-0006VV-9g
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:19:45 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:34141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7ncS-0006Rd-6p
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:19:40 -0400
Received: by mail-ot1-x343.google.com with SMTP id i12-v6so6935505otl.1
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:19:29 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b6879bf-ab53-4c50-75c5-5f4e2abbf47c@linaro.org>
Date: Wed, 3 Oct 2018 15:19:25 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/13] target/arm: Add v8M stack checks for
 Thumb push/pop
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
> Add v8M stack checks for the 16-bit Thumb push/pop
> encodings: STMDB, STMFD, LDM, LDMIA, LDMFD.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
