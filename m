Received: from eggs.gnu.org ([2001:4830:134:3::10]:57075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY3A0-0005T2-Pt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY39v-000157-NV
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:38:32 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:35719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY39v-00014m-HT
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:38:27 -0400
Received: by mail-pl0-x243.google.com with SMTP id k1-v6so499751plt.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:38:27 -0700 (PDT)
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dfbf7c2-5db5-eb3f-78e7-6700aadc40e1@linaro.org>
Date: Tue, 26 Jun 2018 22:38:23 -0700
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] tests/tcg/aarch64: userspace system
 register test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/25/2018 09:00 AM, Alex Bennée wrote:
> This tests a bunch of registers that the kernel allows userspace to
> read including the CPUID registers.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target |  2 +-
>  tests/tcg/aarch64/sysregs.c       | 99 +++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/sysregs.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
