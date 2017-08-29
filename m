Received: from eggs.gnu.org ([2001:4830:134:3::10]:59615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj1D-0008QH-NR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmj1A-0002Yu-Hq
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:05:35 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:33495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmj1A-0002YV-9s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:05:32 -0400
Received: by mail-pf0-x229.google.com with SMTP id r62so11506365pfj.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:05:32 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-15-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7e28796-d080-f7bb-b283-6f78f404a36e@linaro.org>
Date: Tue, 29 Aug 2017 09:05:27 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-15-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/20] target/arm: Make MPU_RNR register
 banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> +        env->pmsav7.rnr[M_REG_NS] = 0;
> +        env->pmsav7.rnr[M_REG_S] = 0;
>          memset(env->pmsav8.mair0, 0, sizeof(env->pmsav8.mair0));
>          memset(env->pmsav8.mair1, 0, sizeof(env->pmsav8.mair1));

Why some memset and some by-element?

Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
