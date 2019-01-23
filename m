Received: from eggs.gnu.org ([209.51.188.92]:37713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPy0-0004sk-IU
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmPsh-0007N9-JW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:16:20 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmPsh-0007Mq-BM
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 16:16:19 -0500
Received: by mail-pf1-x444.google.com with SMTP id w73so1795993pfk.10
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 13:16:19 -0800 (PST)
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-20-yang.zhong@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b6bd049-fcf9-6cb2-070a-4da978503e7d@linaro.org>
Date: Wed, 23 Jan 2019 13:16:15 -0800
MIME-Version: 1.0
In-Reply-To: <20190123065618.3520-20-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 19/44] hw/moxie/Makefile.objs:
 Conditionally build moxie
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
> +++ b/hw/moxie/Makefile.objs
> @@ -1,2 +1,2 @@
>  # moxie boards
> -obj-y += moxiesim.o
> +obj-$(CONFIG_MOXIE) += moxiesim.o

Repeat question about single machine type.


r~
