Received: from eggs.gnu.org ([209.51.188.92]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR2F-0006Th-38
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvR2D-000895-JP
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:19:27 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvR2C-000831-3p
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:19:25 -0500
Received: by mail-pg1-x541.google.com with SMTP id h11so4922586pgl.0
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:19:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-12-peter.maydell@linaro.org>
	<4e8fa2b1-5cfe-152f-8fab-13bb8e3ff440@linaro.org>
Message-ID: <21030ec1-6ad9-0c0b-f654-e3071e83d463@linaro.org>
Date: Sun, 17 Feb 2019 10:19:20 -0800
MIME-Version: 1.0
In-Reply-To: <4e8fa2b1-5cfe-152f-8fab-13bb8e3ff440@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] hw/arm/musca: Add PPCs
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

On 2/17/19 10:14 AM, Richard Henderson wrote:
> On 2/14/19 4:51 AM, Peter Maydell wrote:
>> +    const PPCPortInfo devices[] = {
>> +    const PPCInfo a_ppcs[] = { {
>> +    const PPCInfo b1_ppcs[] = { {
> 
> static const for all of these.  Otherwise,

... but of course in subsequent patches you put non-const things in there.
Nevermind.


r~
