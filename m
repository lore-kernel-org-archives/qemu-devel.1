Received: from eggs.gnu.org ([2001:4830:134:3::10]:36326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ88-0003XC-Ly
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWQ88-00056c-2D
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:13:36 -0500
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:32819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWQ87-00055u-Rp
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 12:13:35 -0500
Received: by mail-pl0-x22a.google.com with SMTP id 1so27551896plv.0
	for <qemu-devel@nongnu.org>; Tue, 02 Jan 2018 09:13:35 -0800 (PST)
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-17-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66de9791-d16c-39b5-9a43-b32910a03300@linaro.org>
Date: Tue, 2 Jan 2018 09:13:31 -0800
MIME-Version: 1.0
In-Reply-To: <20180102011032.30056-17-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 16/17] target/m68k: add the Interrupt
 Stack Pointer
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

On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>              env->sr = tmp;
> +            m68k_switch_sp(env);

I would much prefer a cpu_m68k_set_sr here, akin to cpu_m68k_set_ccr.


r~
