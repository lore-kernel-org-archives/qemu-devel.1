Received: from eggs.gnu.org ([2001:4830:134:3::10]:41404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13A9-00026p-7U
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f13A6-0001aJ-7Z
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:58:17 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:41896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f13A6-0001aD-1o
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:58:14 -0400
Received: by mail-ot0-x234.google.com with SMTP id i28-v6so1293882otf.8
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:58:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180328022233.13400-1-richard.henderson@linaro.org>
	<20180328022233.13400-3-richard.henderson@linaro.org>
Message-ID: <37e158cf-4c89-1505-3fa0-7e6651afd1bd@linaro.org>
Date: Wed, 28 Mar 2018 12:58:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180328022233.13400-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/riscv: Mark MSTATUS_FS dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mjc@sifive.com, patches@groups.riscv.org, palmer@sifive.com

On 03/28/2018 10:22 AM, Richard Henderson wrote:
> +            /* Mark fp status as dirty.  */
> +            env->mstatus = MSTATUS_FS;

Bah.  This should of course be |=.


r~
