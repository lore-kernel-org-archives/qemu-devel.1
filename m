Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxHfH-0002iu-JG
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxHfE-0001pK-Co
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:35 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:51803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxHfE-0001mx-6j
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:32 -0400
Received: by mail-pg0-x22a.google.com with SMTP id k193so8285390pgc.8
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 12:06:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20170926201427.2833-1-richard.henderson@linaro.org>
Message-ID: <38f809cc-9b8a-7c2b-dc23-0c5a1204aaad@linaro.org>
Date: Wed, 27 Sep 2017 12:06:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170926201427.2833-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] Support the Capstone disassembler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org

On 09/26/2017 01:14 PM, Richard Henderson wrote:
> Richard Henderson (9):
>   target/i386: Convert to disas_set_info hook
>   target/ppc: Convert to disas_set_info hook
>   disas: Remove unused flags arguments
>   disas: Support the Capstone disassembler library
>   i386: Support Capstone in disas_set_info
>   arm: Support Capstone in disas_set_info
>   ppc: Support Capstone in disas_set_info
>   disas: Remove monitor_disas_is_physical
>   disas: Add capstone as submodule

Ho hum, ignore this patch.  Need to handle this in a different way.

And, apparently, figure out what's wrong with the patchew docker builds,
considering that it didn't even check out the capstone submodule...


r~
