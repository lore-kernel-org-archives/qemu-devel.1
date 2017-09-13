Received: from eggs.gnu.org ([2001:4830:134:3::10]:39715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAjk-0005NZ-RD
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAjh-0000W2-LX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:42:04 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:47533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsAjh-0000Uo-E6
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:42:01 -0400
Received: by mail-pg0-x230.google.com with SMTP id d8so1371886pgt.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:42:01 -0700 (PDT)
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d3c3c1e9-8dba-14a7-7d1a-2234473ac85e@linaro.org>
Date: Wed, 13 Sep 2017 09:41:57 -0700
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Rename 'type' to 'excret'
 in do_v7m_exception_exit()
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

On 09/11/2017 06:52 AM, Peter Maydell wrote:
> In the v7M and v8M ARM ARM, the magic exception return values are
> referred to as EXC_RETURN values, and in QEMU we use V7M_EXCRET_*
> constants to define bits within them. Rename the 'type' variable
> which holds the exception return value in do_v7m_exception_exit()
> to excret, making it clearer that it does hold an EXC_RETURN value.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
