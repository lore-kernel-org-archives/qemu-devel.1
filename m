Received: from eggs.gnu.org ([209.51.188.92]:55516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQxm-0004j3-5H
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQxd-0003zd-Tq
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:14:46 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:42103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQxc-0003v7-49
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:14:41 -0500
Received: by mail-pg1-x52d.google.com with SMTP id b2so1542937pgl.9
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:14:27 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4e8fa2b1-5cfe-152f-8fab-13bb8e3ff440@linaro.org>
Date: Sun, 17 Feb 2019 10:14:23 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/14] hw/arm/musca: Add PPCs
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> +    const PPCPortInfo devices[] = {
> +    const PPCInfo a_ppcs[] = { {
> +    const PPCInfo b1_ppcs[] = { {

static const for all of these.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
