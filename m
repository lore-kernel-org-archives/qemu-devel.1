Received: from eggs.gnu.org ([2001:4830:134:3::10]:44404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlho-0000cg-96
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlhk-0000Jx-VM
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:18:32 -0500
Received: from mail-pl0-x230.google.com ([2607:f8b0:400e:c01::230]:42384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqlhk-0000JO-OJ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:18:28 -0500
Received: by mail-pl0-x230.google.com with SMTP id 93-v6so55918plc.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:18:28 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4d63ab53-f056-9f86-4317-9565f1d8a792@linaro.org>
Date: Tue, 27 Feb 2018 12:18:24 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/19] target/arm: Define init-svtor
 property for the reset secure VTOR value
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> +        env->v7m.vecbase[M_REG_S] = cpu->init_svtor;

Perhaps & ~0x3f here; that part of the field is RES0.

That said, if the only setter of this property is within qemu code, and not
from the command line, then I suppose it doesn't matter in practice.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
