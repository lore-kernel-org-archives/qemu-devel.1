Received: from eggs.gnu.org ([2001:4830:134:3::10]:37966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNKVH-0007P1-Gs
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:28:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNKVC-00066f-6t
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:28:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNKVC-00065j-0E
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:28:22 -0500
Received: by mail-wm1-x341.google.com with SMTP id r11-v6so19374439wmb.2
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 08:28:21 -0800 (PST)
References: <20181115143535.5885-1-peter.maydell@linaro.org>
	<20181115143535.5885-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9a177b12-9618-a108-08bb-b78e71bc7b3d@linaro.org>
Date: Thu, 15 Nov 2018 17:28:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143535.5885-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 2/2] hw/block/onenand: use
 qemu_log_mask() for reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Thomas Huth <thuth@redhat.com>

On 11/15/18 3:35 PM, Peter Maydell wrote:
> Update the onenand device to use qemu_log_mask() for reporting
> guest errors and unimplemented features, rather than plain
> fprintf() and hw_error().
> 
> (We leave the hw_error() in onenand_reset(), as that is
> triggered by a failure to read the underlying block device
> for the bootRAM, not by guest action.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/block/onenand.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
