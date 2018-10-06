Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8ptH-000721-Df
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 12:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8ptB-0001de-V7
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 12:57:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8ptA-0001ZI-Ax
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 12:57:13 -0400
Received: by mail-pg1-x541.google.com with SMTP id g12-v6so6066976pgs.1
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 09:57:11 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1857b002-97fb-20a3-706a-77703229b841@linaro.org>
Date: Sat, 6 Oct 2018 09:57:06 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 01/21] util/log: allow -dfilter to stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:48 AM, Alex Bennée wrote:
> The original dfilter was patched to avoid a leak in the case of
> multiple -dfilter ranges. There is no reason not to allow the user to
> stack several dfilter options rather than push them all into one mega
> line. We avoid the leak by simply only allocating the first time
> around. As we are using a g_array it will automatically re-size as
> needed.
> 
> The allocation is pushed to a helper as future patches will offer
> additional ways to add to the dfilter.
> 
> We also add a helper qemu_reset_dfilter_ranges() so we can be explicit
> in our unit tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/log.h   |  1 +
>  tests/test-logging.c | 14 ++++++++++++++
>  util/log.c           | 23 +++++++++++++++++------
>  3 files changed, 32 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
