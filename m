Received: from eggs.gnu.org ([2001:4830:134:3::10]:33056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9VM-0003T0-Tl
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eb9VI-00052E-8K
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:29:08 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eb9VI-00051l-2V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:29:04 -0500
Received: by mail-pl0-x244.google.com with SMTP id d21so4274411pll.1
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:29:03 -0800 (PST)
References: <20180113004338.16867-1-laurent@vivier.eu>
	<20180113004338.16867-5-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f553e496-d645-c91d-9b50-fd2f71ad957e@linaro.org>
Date: Mon, 15 Jan 2018 10:28:59 -0800
MIME-Version: 1.0
In-Reply-To: <20180113004338.16867-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] target/m68k: add index parameter to
 gen_load()/gen_store() and Co.
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

On 01/12/2018 04:43 PM, Laurent Vivier wrote:
> The instruction "moves" can select source and destination
> address space (user or kernel). This patch modifies
> all the load/store functions to be able to provide
> the address space the caller wants to use instead
> of using the current one. All the callers are modified
> to provide the default address space to these functions.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v2: new patch in the series
>     needed by "add moves" to pass the MMU index
>     to gen_load()/gen_store().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
