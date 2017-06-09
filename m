Received: from eggs.gnu.org ([2001:4830:134:3::10]:50009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCdw-00084v-GK
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCdt-0002j1-D9
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:39:32 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJCdt-0002ip-8r
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:39:29 -0400
Received: by mail-qt0-x22c.google.com with SMTP id c10so65057539qtd.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 22:39:29 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170607212058.6124-1-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <559b8c2d-2ff3-81cf-2c99-e8862cb80a40@twiddle.net>
Date: Thu, 8 Jun 2017 22:39:25 -0700
MIME-Version: 1.0
In-Reply-To: <20170607212058.6124-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/sh4: optimize cross-page and
 indirect jumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 06/07/2017 02:20 PM, Aurelien Jarno wrote:
>           if (ctx->singlestep_enabled)
>               gen_helper_debug(cpu_env);
> -        tcg_gen_exit_tb(0);
> +        tcg_gen_lookup_and_goto_ptr(cpu_pc);

That really should be an else for that if, since helper_debug doesn't return.


r~
