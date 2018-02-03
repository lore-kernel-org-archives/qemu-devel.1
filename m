Received: from eggs.gnu.org ([2001:4830:134:3::10]:55532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5Pk-0000eg-6p
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei5Ph-0000o4-1t
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:32:00 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei5Pg-0000ns-SQ
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 16:31:56 -0500
Received: by mail-pf0-x242.google.com with SMTP id 68so1206186pfj.8
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 13:31:56 -0800 (PST)
References: <1517324542-6607-1-git-send-email-peter.maydell@linaro.org>
	<1517324542-6607-8-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cdb08124-4a4c-270e-ab68-13134d3c624a@linaro.org>
Date: Sat, 3 Feb 2018 13:31:52 -0800
MIME-Version: 1.0
In-Reply-To: <1517324542-6607-8-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] target/arm: Handle exceptions during
 exception stack pop
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
> Handle possible MPU faults, SAU faults or bus errors when
> popping register state off the stack during exception return.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 115 ++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 94 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
