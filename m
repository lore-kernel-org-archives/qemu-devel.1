Received: from eggs.gnu.org ([2001:4830:134:3::10]:53788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2xf-0001dL-SU
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2xc-00070w-PQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:25:47 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY2xc-00070k-Ha
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 01:25:44 -0400
Received: by mail-pl0-x244.google.com with SMTP id d10-v6so478944plo.5
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 22:25:44 -0700 (PDT)
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <945dc7c9-98aa-0238-1db2-8b5c9bf2aa1c@linaro.org>
Date: Tue, 26 Jun 2018 22:25:40 -0700
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: relax permission checks
 for HWCAP_CPUID registers
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
> +#ifdef CONFIG_USER_ONLY
> +            /* Some AArch64 CPU ID/feature are exported to userspace
> +             * by the kernel (see HWCAP_CPUID) */
> +            if (r->opc0 == 3 && r->crn == 0 &&
> +                (r->crm == 0 ||
> +                 (r->crm >= 4 && r->crm <= 7))) {
> +                mask = PL0_R;
> +                break;
> +            }
> +#endif

Why not just set mask to PL0U_R | PL1_RW?
This mask doesn't affect the actual permissions, just the check.

Then of course merge with the next patch.


r~
