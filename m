Received: from eggs.gnu.org ([2001:4830:134:3::10]:52929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejsvQ-0001CC-GZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ejsvN-0004qL-KH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:36:08 -0500
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:37725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ejsvN-0004q1-FW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:36:05 -0500
Received: by mail-io0-x233.google.com with SMTP id f89so7209380ioj.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:36:05 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e5fbe91-3c4f-315a-a116-be97a319229e@linaro.org>
Date: Thu, 8 Feb 2018 12:36:01 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] target/arm/cpu64: allow fp16 to
 be disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> While for CONFIG_USER_ONLY it is policy for the "cpu" to be the most
> capable is can be this does cause problems. For example legacy RISU
> runs would fail as there are a bunch of implemented instructions which
> would have caused failures that now trigger actual calculations.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu64.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
