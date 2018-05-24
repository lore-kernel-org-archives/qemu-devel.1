Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLsym-0004Gw-Jb
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fLsyh-0007v7-6c
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:20:40 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:35182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fLsyg-0007u1-A8
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:20:34 -0400
Received: by mail-pl0-x22e.google.com with SMTP id i5-v6so1369739plt.2
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 09:20:34 -0700 (PDT)
References: <7A85DF989CAE8F42902CF7B31A7D94A139685B1D@SHSMSX101.ccr.corp.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <97f6fbe7-af48-ba95-d17e-caa3a1fa0bf4@linaro.org>
Date: Thu, 24 May 2018 09:20:16 -0700
MIME-Version: 1.0
In-Reply-To: <7A85DF989CAE8F42902CF7B31A7D94A139685B1D@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] About the TCG code in arm64!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhong, Yang" <yang.zhong@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On 05/24/2018 07:53 AM, Zhong, Yang wrote:
> Hello Richard,
> 
> I am coming from intel and ready to disable TCG code in arm64, there are some
> unclear issue in the target/arm directory
> 
> (The TCG code in x86 was disabled by Paolo and me)
>

[Identifying some files that are indeed TCG related.]

> but I checked the code, and felt below helper files are still TCG related files,
> 
> helper.c, helper.h, iwmmxt_helper.c ,  neon_helper.c  vec_helper.c
>  crypto_helper.c 
> 
> Please help correct me if I am wrong, many thanks!


If you are asking if these files are TCG related, the answer is yes to all but
the first.  In helper.c it appears there are things related to gdbstub and
system registers, both of which I believe are still required for kvm and for
migration.

But perhaps a broader audience for the question can give a more complete answer.


r~
