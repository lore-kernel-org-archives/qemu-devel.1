Received: from eggs.gnu.org ([2001:4830:134:3::10]:45523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum5S-0007dz-Ql
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:59:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dum5P-0006W7-Or
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:59:14 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:46039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dum5P-0006Vb-JT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:59:11 -0400
Received: by mail-io0-x22a.google.com with SMTP id g32so6565405ioj.2
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:59:11 -0700 (PDT)
References: <1505580378-9044-1-git-send-email-peter.maydell@linaro.org>
	<1505580378-9044-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe0bb57c-6e1a-000f-e838-ec141ff3c063@linaro.org>
Date: Wed, 20 Sep 2017 15:59:07 -0500
MIME-Version: 1.0
In-Reply-To: <1505580378-9044-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/arm/palm.c: Don't use old_mmio for
 static_ops
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
> Update the static_ops functions to use new-style mmio
> rather than the legacy old_mmio functions.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/palm.c | 30 ++++++++++--------------------
>  1 file changed, 10 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
