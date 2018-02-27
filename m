Received: from eggs.gnu.org ([2001:4830:134:3::10]:55062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmDS-0001H1-9l
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmDN-0006N3-EZ
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:51:14 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:46396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmDN-0006Mv-8S
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:51:09 -0500
Received: by mail-pf0-x243.google.com with SMTP id z10so62869pfh.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:51:09 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc12081c-d5d1-558f-4901-cb074f00893b@linaro.org>
Date: Tue, 27 Feb 2018 12:51:05 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/19] include/hw/or-irq.h: Add missing
 include guard
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
> The or-irq.h header file is missing the customary guard against
> multiple inclusion, which means compilation fails if it gets
> included twice. Fix the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/or-irq.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
