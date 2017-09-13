Received: from eggs.gnu.org ([2001:4830:134:3::10]:35093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAeX-0007ju-1m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsAeT-0001H8-2H
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:36:41 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:46265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsAeS-0001G8-T2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 12:36:37 -0400
Received: by mail-pg0-x236.google.com with SMTP id i130so1365032pgc.3
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 09:36:36 -0700 (PDT)
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae8bab29-9341-26ac-bc4a-6f8140d42744@linaro.org>
Date: Wed, 13 Sep 2017 09:36:33 -0700
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] target/arm: Remove unnecessary '|
 0xf0000000' from do_v7m_exception_exit()
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
> In do_v7m_exception_exit(), there's no need to force the high 4
> bits of 'type' to 1 when calling v7m_exception_taken(), because
> we know that they're always 1 or we could not have got to this
> "handle return to magic exception return address" code. Remove
> the unnecessary ORs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
