Received: from eggs.gnu.org ([2001:4830:134:3::10]:50122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08EH-000247-GI
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g08ED-0001zM-EC
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:43:01 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g08ED-0001yq-6u
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:42:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id k19-v6so1301403pfi.1
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 09:42:57 -0700 (PDT)
References: <20180911013211.27340-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c55a66b7-5fc1-90ce-9dc2-0a276faa3631@linaro.org>
Date: Wed, 12 Sep 2018 09:42:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180911013211.27340-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: fix s32c1i TCGMemOp flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 09/10/2018 06:32 PM, Max Filippov wrote:
> s32c1i must load and store value with target endianness, not host.
> This results in an infinite loop in atomic cmpxchg sequences when target
> endianness doesn't match host endianness.
> 
> Fixes: 9fb40342d4b3 ("target/xtensa: support MTTCG")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
