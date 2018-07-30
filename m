Received: from eggs.gnu.org ([2001:4830:134:3::10]:46167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFwa-0003OR-6x
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fkFwX-0000ef-1u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:43:08 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:46423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fkFwW-0000eL-SA
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 17:43:04 -0400
Received: by mail-vk0-x241.google.com with SMTP id b14-v6so6494949vke.13
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 14:43:04 -0700 (PDT)
References: <20180730134321.19898-1-alex.bennee@linaro.org>
	<20180730134321.19898-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6d9691b-eabe-4ed1-9a55-8a9b0356a4c2@linaro.org>
Date: Mon, 30 Jul 2018 17:42:59 -0400
MIME-Version: 1.0
In-Reply-To: <20180730134321.19898-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 1/2] linux-user/mmap.c: handle
 invalid len maps correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, 1783362@bugs.launchpad.net, Laurent Vivier <laurent@vivier.eu>

On 07/30/2018 09:43 AM, Alex Bennée wrote:
> I've slightly re-organised the check to more closely match the
> sequence that the kernel uses in do_mmap(). We check for both the zero
> case (EINVAL) and the overflow length case (ENOMEM).
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: umarcor <1783362@bugs.launchpad.net>
> 
> ---
> v2
>   - add comment on overflow
> ---
>  linux-user/mmap.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
