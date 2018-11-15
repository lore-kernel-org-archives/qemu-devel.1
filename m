Received: from eggs.gnu.org ([2001:4830:134:3::10]:37649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNKUL-0006KE-2N
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNKUF-0005Q8-Ty
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:27:29 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNKUD-0005Oq-Di
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:27:23 -0500
Received: by mail-wr1-x444.google.com with SMTP id b13so21853251wrx.6
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 08:27:19 -0800 (PST)
References: <20181115143535.5885-1-peter.maydell@linaro.org>
	<20181115143535.5885-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee5b3393-fc6f-5ed3-194a-4b3ad91623ea@linaro.org>
Date: Thu, 15 Nov 2018 17:27:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181115143535.5885-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] hw/block/onenand: Fix
 off-by-one error allowing out-of-bounds read
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
> An off-by-one error in a switch case in onenand_read() allowed
> a misbehaving guest to read off the end of a block of memory.
> 
> NB: the onenand device is used only by the "n800" and "n810"
> machines, which are usable only with TCG, not KVM, so this is
> not a security issue.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I tweaked RTH's suggested fix to use an 0xbffe offset so
> we don't overrun on an access to 0xbfff either.
> 
>  hw/block/onenand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
