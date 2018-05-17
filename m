Received: from eggs.gnu.org ([2001:4830:134:3::10]:57281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPpK-0000mR-Fo
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPpF-0004ec-S5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:48:42 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:37139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPpF-0004eO-La
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:48:37 -0400
Received: by mail-pl0-x243.google.com with SMTP id w19-v6so3233327plq.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:48:37 -0700 (PDT)
References: <20180516185146.30708-1-edgar.iglesias@gmail.com>
	<20180516185146.30708-36-edgar.iglesias@gmail.com>
	<9e6a126f-4fc8-15a9-1b11-e1d3d6dba691@linaro.org>
	<20180517180333.voovwdnnlr5eaapq@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8323e109-803a-836f-6db5-05745c49e360@linaro.org>
Date: Thu, 17 May 2018 13:48:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180517180333.voovwdnnlr5eaapq@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 35/38] target-microblaze: Convert
 env_btarget to i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com

On 05/17/2018 11:03 AM, Edgar E. Iglesias wrote:
> On Thu, May 17, 2018 at 10:34:38AM -0700, Richard Henderson wrote:
>> On 05/16/2018 11:51 AM, Edgar E. Iglesias wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>>
>>> Convert env_btarget to i64.
>>> No functional change.
>>>
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> ---
>>
>> I thought you were going to drop this one?
> 
> 
> I dropped the conversion of env_btaken as it's not really useful
> since it's a boolean. btarget will eventually need to be 64bit
> allthought strictly necessary in this series so I've kept btarget
> as 64bit.

Oh, duh.  Target vs taken.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
