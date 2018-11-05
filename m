Received: from eggs.gnu.org ([2001:4830:134:3::10]:57403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJdne-0007WP-PZ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJdnZ-00022n-MF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:16:10 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gJdnZ-0001ld-BW
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:16:05 -0500
Received: by mail-wr1-x443.google.com with SMTP id j17-v6so4130541wrq.11
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:16:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20181102134112.26370-1-richard.henderson@linaro.org>
	<20181102134112.26370-3-richard.henderson@linaro.org>
Message-ID: <102bd244-b80d-9445-48e0-304a1a3cde37@linaro.org>
Date: Mon, 5 Nov 2018 12:15:55 +0000
MIME-Version: 1.0
In-Reply-To: <20181102134112.26370-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 2/4] target/arm: Implement the
 ARMv8.1-LOR extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 11/2/18 1:41 PM, Richard Henderson wrote:
> +            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
> +              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
> +              .access = PL1_RW, .type = ARM_CP_CONST, .resetvalue = 0 },

For v2 this will be correctly marked RO.


r~
