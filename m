Received: from eggs.gnu.org ([2001:4830:134:3::10]:37372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqn3a-00038F-GW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqn3X-0008Dk-As
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:45:06 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:42285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqn3X-0008DN-4z
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 16:45:03 -0500
Received: by mail-pg0-x230.google.com with SMTP id y8so121380pgr.9
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:45:02 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-16-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b95391b-2ef8-b664-5d23-15db04841e6b@linaro.org>
Date: Tue, 27 Feb 2018 13:44:59 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/19] hw/misc/iotkit-secctl: Arm IoT Kit
 security controller initial skeleton
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
> +        r >>= 8 * (addr & 3);
> +        r &= (1 << (size * 8)) - 1;

extract32(r, (addr & 3) * 8, size * 8) ?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
