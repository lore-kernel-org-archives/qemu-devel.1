Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPyG-0004sk-4b
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPoT-0005cY-7f
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:11:58 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPoS-0005c6-P2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:11:57 -0500
Received: by mail-pg1-x542.google.com with SMTP id c25so1637122pgb.4
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:11:56 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-17-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <133ee742-f121-91a3-e947-ed740f31a0b2@linaro.org>
Date: Wed, 23 Jan 2019 13:11:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-17-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 16/44] hw/alpha/Makefile.objs:
 Create CONFIG_* for alpha
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, sameo@linux.intel.com

On 1/22/19 10:55 PM, Yang Zhong wrote:
> @@ -19,3 +19,5 @@ CONFIG_I8259=y
>  CONFIG_MC146818RTC=y
>  CONFIG_ISA_TESTDEV=y
>  CONFIG_SMC37C669=y
> +CONFIG_DP264=y
> +CONFIG_TYPHOON=y

There's not really a point in two configs; just use DP264.

But beyond that, is there a point in adding configury that must be set to Y?
There is exactly one machine type implemented for Alpha.  I don't see anyone
implementing a different machine type in the future either.


r~
