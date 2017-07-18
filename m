Received: from eggs.gnu.org ([2001:4830:134:3::10]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG1b-0005Nm-Ll
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG1Y-0004T0-E1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:03 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXG1Y-0004Sq-8R
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:00 -0400
Received: by mail-qt0-x230.google.com with SMTP id n42so4133215qtn.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:06:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-30-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ce1f7b7a-e0ae-c1df-58ee-c03c9f1939f1@twiddle.net>
Date: Mon, 17 Jul 2017 14:05:55 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-30-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 29/45] exec-all: rename tb_free to
 tb_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> We don't really free anything in this function anymore; we just remove
> the TB from the binary search tree.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/exec-all.h   | 2 +-
>   accel/tcg/cpu-exec.c      | 2 +-
>   accel/tcg/translate-all.c | 6 +++---
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
