Received: from eggs.gnu.org ([2001:4830:134:3::10]:42981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA2H-0003eq-VO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsA2E-0001NK-T9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:57:10 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:48457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsA2E-0001My-MW
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 11:57:06 -0400
Received: by mail-pg0-x22a.google.com with SMTP id v66so1140572pgb.5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 08:57:06 -0700 (PDT)
References: <1505137930-13255-1-git-send-email-peter.maydell@linaro.org>
	<1505137930-13255-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6b345da1-e937-cb0f-ab9f-f2ef4ac01da8@linaro.org>
Date: Wed, 13 Sep 2017 08:57:03 -0700
MIME-Version: 1.0
In-Reply-To: <1505137930-13255-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] target/arm: Get PRECISERR and IBUSERR
 the right way round
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
> For a bus fault, the M profile BFSR bit PRECISERR means a bus
> fault on a data access, and IBUSERR means a bus fault on an
> instruction access. We had these the wrong way around; fix this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
