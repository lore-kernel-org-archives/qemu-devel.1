Received: from eggs.gnu.org ([2001:4830:134:3::10]:57332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstct-0001pO-Iv
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fstco-0003jb-Fe
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:42:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fstco-0003jF-8Z
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:42:26 -0400
Received: by mail-pf1-x42d.google.com with SMTP id d4-v6so3163210pfn.0
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 10:42:26 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-23-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <786e23f7-8492-477e-632b-10dc3ebd4576@linaro.org>
Date: Thu, 23 Aug 2018 10:42:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-23-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] hw/arm/mps2-tz: Fix MPS2 SCC config
 register values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:11 AM, Peter Maydell wrote:
> +    mmc->scc_id = 0x41040000 | (0x505 << 4);

Is it any less clear to say 0x41045050?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
