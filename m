Received: from eggs.gnu.org ([2001:4830:134:3::10]:38982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlJo-0006yT-7N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqlJj-00071y-Bj
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:53:44 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:37169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqlJj-00071i-4H
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:53:39 -0500
Received: by mail-pf0-x22c.google.com with SMTP id s24so10732pfm.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:53:38 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e7da74d2-ee08-a000-2914-4760a371f96b@linaro.org>
Date: Tue, 27 Feb 2018 11:53:35 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/19] armv7m: Forward idau property to CPU
 object
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
> Create an "idau" property on the armv7m container object which
> we can forward to the CPU object. Annoyingly, we can't use
> object_property_add_alias() because the CPU object we want to
> forward to doesn't exist until the armv7m container is realized.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armv7m.h | 3 +++
>  hw/arm/armv7m.c         | 7 +++++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
