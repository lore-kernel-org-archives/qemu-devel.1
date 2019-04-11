Received: from eggs.gnu.org ([209.51.188.92]:49560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEbdd-0000nT-Ua
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEbdd-0001Bq-3c
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hEbdc-0001BM-O8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:29:17 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 85so3688046pgc.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:29:16 -0700 (PDT)
References: <20190410194838.10123-1-sw@weilnetz.de>
	<46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
	<f7f4f96e-7900-45e8-10ef-65f7870b3c3e@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7423e23c-244b-3481-db82-e84baa4976d1@linaro.org>
Date: Thu, 11 Apr 2019 05:29:10 -1000
MIME-Version: 1.0
In-Reply-To: <f7f4f96e-7900-45e8-10ef-65f7870b3c3e@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tci: Add implementation for
 INDEX_op_ld16u_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 4/10/19 9:37 PM, Stefan Weil wrote:
>> Why not use tci_write_reg64, since that is the size of the register you're
>> modifying?  Let the zero-extension explicit in the name of the opcode to be
>> reflected in the zero-extension implied by the passing of a uint16_t value to a
>> uint64_t argument.
> 
> I think that using tci_write_reg64 would be wrong on 32 bit hosts.

... as would using INDEX_op_ld16u_i64 in the first place.
This is already within #if TCG_TARGET_REG_BITS == 64.


r~
