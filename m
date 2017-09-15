Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsu1v-0001Sh-LG
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsu1s-0006X3-IU
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:03:51 -0400
Received: from mail-pg0-x22f.google.com ([2607:f8b0:400e:c05::22f]:52017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsu1s-0006Wr-8p
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:03:48 -0400
Received: by mail-pg0-x22f.google.com with SMTP id k193so1846399pgc.8
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 10:03:48 -0700 (PDT)
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-13-richard.henderson@linaro.org>
	<87zi9w8dpu.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93cffc82-7621-7d7d-addd-859a8813cc2e@linaro.org>
Date: Fri, 15 Sep 2017 10:03:43 -0700
MIME-Version: 1.0
In-Reply-To: <87zi9w8dpu.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 12/16] tcg: Remove tcg_regset_set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org

On 09/15/2017 03:21 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This breaks the mips cross build:
> 
> In file included from /tmp/qemu-test/src/tcg/tcg.c:254:0:
> /tmp/qemu-test/src/tcg/mips/tcg-target.inc.c: In function 'target_parse_constraint':
> /tmp/qemu-test/src/tcg/mips/tcg-target.inc.c:198:9: error: implicit
> declaration of function 'tcg_regset_set' [-Werror=implicit-function-declaration]
> 
>          tcg_regset_set(ct->u.regs, 0xffffffff);     

Yes, I found this myself yesterday.
Fixed in tcg-next.

Thanks,


r~
