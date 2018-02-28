Received: from eggs.gnu.org ([2001:4830:134:3::10]:55998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA2Q-00040a-PU
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA2C-0004EW-6Q
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:17:26 -0500
Received: from mail-pl0-x234.google.com ([2607:f8b0:400e:c01::234]:36607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erA2B-0004D0-Gx
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:17:11 -0500
Received: by mail-pl0-x234.google.com with SMTP id 61-v6so2389986plf.3
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:17:11 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-8-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8f712ae-5a7b-be7d-54c3-861eeb62919f@linaro.org>
Date: Wed, 28 Feb 2018 14:17:07 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/16] translate-all: remove hole in
 PageDesc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 02/26/2018 09:39 PM, Emilio G. Cota wrote:
> Groundwork for supporting parallel TCG generation.
> 
> Move the hole to the end of the struct, so that a u32
> field can be added there without bloating the struct.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
