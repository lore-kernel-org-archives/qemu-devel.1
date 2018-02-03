Received: from eggs.gnu.org ([2001:4830:134:3::10]:55110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5NO-0007J2-BY
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:29:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5NL-000833-6X
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:29:34 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei5NK-00082g-VF
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:29:31 -0500
Received: by mail-pg0-x243.google.com with SMTP id s73so1465205pgc.1
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:29:30 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d8f08bf-1532-c99f-1267-a2758317f99f@linaro.org>
Date: Sat, 3 Feb 2018 13:29:27 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] target/arm: Make exception vector
 loads honour the SAU
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
> Make the load of the exception vector from the vector table honour
> the SAU and any bus error on the load (possibly provoking a derived
> exception), rather than simply aborting if the load fails.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 71 +++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 55 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
