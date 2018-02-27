Received: from eggs.gnu.org ([2001:4830:134:3::10]:35161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmvI-0000Ew-EO
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmvF-0003SH-Cs
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:36:32 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmvF-0003Rn-6Z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:36:29 -0500
Received: by mail-pg0-x241.google.com with SMTP id q27so113143pgn.8
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:36:29 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c3257e8f-8709-7388-3bce-38f61c45935d@linaro.org>
Date: Tue, 27 Feb 2018 13:36:25 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/19] hw/misc/tz-ppc: Model TrustZone
 peripheral protection controller
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Add a model of the TrustZone peripheral protection controller (PPC),
> which is used to gate transactions to non-TZ-aware peripherals so
> that secure software can configure them to not be accessible to
> non-secure software.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/Makefile.objs           |   2 +
>  include/hw/misc/tz-ppc.h        | 101 ++++++++++++++
>  hw/misc/tz-ppc.c                | 302 ++++++++++++++++++++++++++++++++++++++++
>  default-configs/arm-softmmu.mak |   2 +
>  hw/misc/trace-events            |  11 ++
>  5 files changed, 418 insertions(+)
>  create mode 100644 include/hw/misc/tz-ppc.h
>  create mode 100644 hw/misc/tz-ppc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
