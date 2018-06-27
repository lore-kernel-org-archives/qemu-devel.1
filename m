Received: from eggs.gnu.org ([2001:4830:134:3::10]:54102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2z5-0002gy-Ds
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2z4-0007oW-Ob
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:27:15 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY2z4-0007ns-Io
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:27:14 -0400
Received: by mail-pl0-x242.google.com with SMTP id k1-v6so485489plt.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:27:14 -0700 (PDT)
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a9360a8e-cdcc-14a1-2fd7-623faf779abc@linaro.org>
Date: Tue, 26 Jun 2018 22:27:11 -0700
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] linux-user/elfload: enable
 HWCAP_CPUID for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On 06/25/2018 09:00 AM, Alex Bennée wrote:
> Userspace programs should (in theory) query the ELF HWCAP before
> probing these registers. Now we have implemented them all make it
> public.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/elfload.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
