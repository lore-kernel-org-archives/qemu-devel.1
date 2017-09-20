Received: from eggs.gnu.org ([2001:4830:134:3::10]:47282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum8e-0000hF-60
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum8b-00017F-2p
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:32 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:55801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dum8a-00016x-Ub
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 17:02:29 -0400
Received: by mail-io0-x22a.google.com with SMTP id z187so6522256ioz.12
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 14:02:28 -0700 (PDT)
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
	<1505580378-9044-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9481c523-ff48-2c78-9e02-9feb9f2a5e90@linaro.org>
Date: Wed, 20 Sep 2017 16:02:24 -0500
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/6] hw/timer/omap_synctimer.c: Don't use
 old_mmio
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
> Don't use the old_mmio in the memory region ops struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/omap_synctimer.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
