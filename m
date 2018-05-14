Received: from eggs.gnu.org ([2001:4830:134:3::10]:41780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFe2-0004Ef-Dv
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFdy-0000MR-7Z
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:14 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:40309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fIFdy-0000M8-2c
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:44:10 -0400
Received: by mail-qt0-x244.google.com with SMTP id h2-v6so16715971qtp.7
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 08:44:09 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180512014801.17566-1-richard.henderson@linaro.org>
	<20180512014801.17566-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c6a98f25-0e03-1c6a-df07-b71ea867e8bb@amsat.org>
Date: Mon, 14 May 2018 12:44:03 -0300
MIME-Version: 1.0
In-Reply-To: <20180512014801.17566-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/s390x: Fix brace Werror with
 clang 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 05/11/2018 10:48 PM, Richard Henderson wrote:
> The warning is
> 
> target/s390x/misc_helper.c:209:21: error: suggest
>       braces around initialization of subobject [-Werror,-Wmissing-braces]
>     SysIB sysib = { 0 };
>                     ^
>                     {}
> 
> While the original code is correct, and technically exactly correct
> as per ISO C89, both GCC and Clang support plain empty set of braces
> as an extension.
> 
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/s390x/misc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index e0b23c1fd1..1f834f35ef 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -206,7 +206,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>      const MachineState *ms = MACHINE(qdev_get_machine());
>      uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
>      S390CPU *cpu = s390_env_get_cpu(env);
> -    SysIB sysib = { 0 };
> +    SysIB sysib = { };
>      int i, cc = 0;
>  
>      if ((r0 & STSI_R0_FC_MASK) > STSI_R0_FC_LEVEL_3) {
> 
