Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5KN-0005S7-J8
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5KK-0006bL-DH
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:26:27 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei5KK-0006aD-77
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:26:24 -0500
Received: by mail-pl0-x243.google.com with SMTP id f8so8974613plk.11
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:26:24 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <918763b8-f185-66bc-c712-6acdd9445960@linaro.org>
Date: Sat, 3 Feb 2018 13:26:20 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm: Make
 v7m_push_callee_stack() honour MPU
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

On 01/30/2018 07:02 AM, Peter Maydell wrote:
> Make v7m_push_callee_stack() honour the MPU by using the
> new v7m_stack_write() function. We return a flag to indicate
> whether the pushes failed, which we can then use in
> v7m_exception_taken() to cause us to handle the derived
> exception correctly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 64 ++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
