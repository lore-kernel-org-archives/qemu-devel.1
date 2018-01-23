Received: from eggs.gnu.org ([2001:4830:134:3::10]:47209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee1Ls-000432-HD
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ee1Lp-000460-TT
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:23:12 -0500
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:40887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ee1Lp-00044G-N1
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:23:09 -0500
Received: by mail-pf0-x231.google.com with SMTP id i66so693005pfd.7
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 08:23:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180123035349.24538-1-richard.henderson@linaro.org>
	<20180123035349.24538-5-richard.henderson@linaro.org>
Message-ID: <a3625e43-0a8c-b63d-12a9-f955ba2a8b23@linaro.org>
Date: Tue, 23 Jan 2018 08:23:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180123035349.24538-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/arm: Add ZCR_ELx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

On 01/22/2018 07:53 PM, Richard Henderson wrote:
> +static const ARMCPRegInfo zcr_el1_reginfo = {
> +    .name = "ZCR_EL1", .state = ARM_CP_STATE_AA64,
> +    .opc0 = 3, .opc1 = 0, .crn = 1, .crm = 2, .opc2 = 0,
> +    .access = PL1_RW, .accessfn = zcr_access, .type = ARM_CP_64BIT,
> +    .fieldoffset = offsetof(CPUARMState, vfp.zcr_el[1]),
> +    .writefn = zcr_write, .raw_writefn = raw_write
> +};

Ho hum.  Got far enough in the rest of my rebasing to see that .type must be
dropped -- there's an assert saying STATE_AA64 implies 64BIT and shouldn't be
repeated.


r~
