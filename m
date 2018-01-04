Received: from eggs.gnu.org ([2001:4830:134:3::10]:34552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWt56-00065W-M9
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eWt53-0005zB-Dp
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:08:24 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:36099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eWt53-0005xv-6y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 19:08:21 -0500
Received: by mail-pg0-x230.google.com with SMTP id 21so32416pgg.3
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 16:08:21 -0800 (PST)
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-13-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4dab684-3862-57da-2c6f-bd46bb3c4bfb@linaro.org>
Date: Wed, 3 Jan 2018 16:08:17 -0800
MIME-Version: 1.0
In-Reply-To: <1514940265-18093-13-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 12/21] RISC-V HART Array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On 01/02/2018 04:44 PM, Michael Clark wrote:
> Holds the state of a heterogenous array of RISC-V hardware threads.

At the moment they are homogeneous, since they are all created from the same
cpu_model.  Is that the ultimate intent?

> +static Property riscv_harts_props[] = {
> +    DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1),
> +    DEFINE_PROP_STRING("cpu-model", RISCVHartArrayState, cpu_model),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

How does num_harts interact with max_cpus and smp_cpus, and thus the related
command-line options?


r~
