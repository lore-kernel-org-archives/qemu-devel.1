Received: from eggs.gnu.org ([2001:4830:134:3::10]:43153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2RO-0002kA-Bx
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fY2RL-0007E3-Ct
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:52:26 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:41649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fY2RL-0007D7-7C
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 00:52:23 -0400
Received: by mail-pl0-x243.google.com with SMTP id w8-v6so432791ply.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 21:52:23 -0700 (PDT)
References: <20180625160009.17437-1-alex.bennee@linaro.org>
	<20180625160009.17437-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d50f4ce2-6219-d9d1-34a2-e4246f20e927@linaro.org>
Date: Tue, 26 Jun 2018 21:52:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180625160009.17437-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] target/arm: support reading of
 CNT[VCT|FRQ]_EL0 from user-space
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
> Since kernel commit a86bd139f2 (arm64: arch_timer: Enable CNTVCT_EL0
> trap..) user-space has been able to read these system registers. As we
> can't use QEMUTimer's in linux-user mode we just directly call
> cpu_get_clock().
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - include CNTFRQ_EL0 for PL0_R only
> v3
>   - use NANOSECONDS_PER_SECOND / GTIMER_SCALE
> ---
>  target/arm/helper.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
