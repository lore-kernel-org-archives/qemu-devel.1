Received: from eggs.gnu.org ([2001:4830:134:3::10]:49557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWtSS-0005jI-GQ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWtSO-0007x5-HF
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:32:32 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:33267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWtSO-0007wB-B9
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:32:28 -0500
Received: by mail-pl0-x234.google.com with SMTP id 1so83330plv.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 16:32:28 -0800 (PST)
References: <20180102234108.32713-1-laurent@vivier.eu>
	<20180102234108.32713-8-laurent@vivier.eu>
	<5630ba80-503f-f7e7-2764-c433aa3ea19a@linaro.org>
	<2ec23cfd-ead8-8119-ab37-0f74a62c3df0@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a76ed80-0bae-721f-b1d4-e5024cb147af@linaro.org>
Date: Wed, 3 Jan 2018 16:32:24 -0800
MIME-Version: 1.0
In-Reply-To: <2ec23cfd-ead8-8119-ab37-0f74a62c3df0@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 07/17] target/m68k: add chk and chk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/03/2018 03:40 PM, Laurent Vivier wrote:
>> Did you examine the real hw change to the other flags?
> 
> yes, C is modified, and the logic is:
>   C = 0 <= ub ? val < 0 || ub < val : val < 0 && ub < val;
> All other flags are not modified.
> 
> I'm going to update the patch to reflect the change of N and C by the
> real hardware.

Ok, thanks.  Adding a comment to note following hw over and above the spec
would be appreciated.


r~
