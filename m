Received: from eggs.gnu.org ([2001:4830:134:3::10]:48169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum9u-0001bK-Jp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum9r-0002Ct-Fn
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:50 -0400
Received: from mail-io0-x22b.google.com ([2607:f8b0:4001:c06::22b]:55817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dum9r-0002CG-BF
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:03:47 -0400
Received: by mail-io0-x22b.google.com with SMTP id z187so6530285ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:03:47 -0700 (PDT)
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
	<1505580378-9044-6-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0904d1e-9db9-ec39-02fe-eafdea3e013a@linaro.org>
Date: Wed, 20 Sep 2017 16:03:43 -0500
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-6-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] hw/i2c/omap_i2c.c: Don't use old_mmio
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

On 09/16/2017 11:46 AM, Peter Maydell wrote:
> Don't use old_mmio in the memory region ops struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/i2c/omap_i2c.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
