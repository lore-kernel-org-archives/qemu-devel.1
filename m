Received: from eggs.gnu.org ([2001:4830:134:3::10]:58190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9p8-000685-Cj
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9p7-0003Ar-E1
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:07:02 -0400
References: <20180508193645.3960-1-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <03ab4fb3-b49c-b9e4-f171-7a5efa723473@vivier.eu>
Date: Tue, 8 May 2018 23:06:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180508193645.3960-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Limit the number of ops in a TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org

Le 08/05/2018 à 21:36, Richard Henderson a écrit :
> In 6001f7729e12 we partially attempt to address the branch
> displacement overflow caused by 15fa08f845.
> 
> However, gcc/testsuite/gcc.target/aarch64/advsimd-intrinsics/vqtbX.c
> is a testcase that contains a TB so large as to overflow anyway.
> The limit here of 8000 ops produces a maximum output TB size of
> 24112 bytes on a ppc64le host with that test case.  This is still
> much less than the maximum forward branch distance of 32764 bytes.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 15fa08f845 ("tcg: Dynamically allocate TCGOps")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.h | 8 +++++++-
>  tcg/tcg.c | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
