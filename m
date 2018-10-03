Received: from eggs.gnu.org ([2001:4830:134:3::10]:48164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nbc-0004lU-Tx
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7nbZ-00062S-VZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:18:48 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7nbZ-0005wz-IY
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 16:18:45 -0400
Received: by mail-oi1-x241.google.com with SMTP id a203-v6so5661202oib.0
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 13:18:38 -0700 (PDT)
References: <20181002163556.10279-1-peter.maydell@linaro.org>
	<20181002163556.10279-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c806cd70-9c09-9525-eb46-d606d4510969@linaro.org>
Date: Wed, 3 Oct 2018 15:18:34 -0500
MIME-Version: 1.0
In-Reply-To: <20181002163556.10279-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/13] target/arm: Add v8M stack checks for
 T32 load/store single
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
> Add v8M stack checks for the instructions in the T32
> "load/store single" encoding class: these are the
> "immediate pre-indexed" and "immediate, post-indexed"
> LDR and STR instructions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
