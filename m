Received: from eggs.gnu.org ([2001:4830:134:3::10]:41834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA9Z-0001v8-Ft
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erA9H-0006ag-Ms
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:24:49 -0500
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:32830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erA9H-0006Z3-4f
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 17:24:31 -0500
Received: by mail-pg0-x22a.google.com with SMTP id g12so1509191pgs.0
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:24:31 -0800 (PST)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-10-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <83e41cca-e0cc-4cda-720e-89f320d7b333@linaro.org>
Date: Wed, 28 Feb 2018 14:24:27 -0800
MIME-Version: 1.0
In-Reply-To: <1519709965-29833-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/16] translate-all: move
 tb_invalidate_phys_page_range up in the file
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
> This greatly simplifies next commit's diff.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 77 ++++++++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
