Received: from eggs.gnu.org ([2001:4830:134:3::10]:55364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmEe-00028C-PP
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:52:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqmEZ-0007oq-Sw
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:52:28 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:44170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqmEZ-0007oY-N7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:52:23 -0500
Received: by mail-pl0-x241.google.com with SMTP id w21-v6so108775plp.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 12:52:23 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a71c87d5-2cc1-c2a5-6b26-19d97071ba46@linaro.org>
Date: Tue, 27 Feb 2018 12:52:20 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/19] qdev: Add new
 qdev_init_gpio_in_named_with_opaque()
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
> The function qdev_init_gpio_in_named() passes the DeviceState pointer
> as the opaque data pointor for the irq handler function.  Usually
> this is what you want, but in some cases it would be helpful to use
> some other data pointer.
> 
> Add a new function qdev_init_gpio_in_named_with_opaque() which allows
> the caller to specify the data pointer they want.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/qdev-core.h | 30 ++++++++++++++++++++++++++++--
>  hw/core/qdev.c         |  8 +++++---
>  2 files changed, 33 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
