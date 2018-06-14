Received: from eggs.gnu.org ([2001:4830:134:3::10]:35356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTKzY-00077B-MX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTKzV-0001py-Mj
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:40:16 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTKzV-0001pC-I5
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 01:40:13 -0400
Received: by mail-pg0-x243.google.com with SMTP id q4-v6so2386871pgr.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 22:40:13 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf445619-d1dc-6b91-37f2-5dcaa7aa3c23@linaro.org>
Date: Wed, 13 Jun 2018 19:40:07 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 01/22] risu_reginfo_aarch64:
 include signal.h for FPSIMD_MAGIC
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

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> Building with the Bionic Beaver cross compilers fails which probably
> means we were getting this as a side effect before. Include the
> correct header to get at these bits.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
