Received: from eggs.gnu.org ([2001:4830:134:3::10]:47046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFy7-0002Df-Iz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFy6-0001tm-RL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:27 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFy6-0001td-Nu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:02:26 -0400
Received: by mail-qt0-x236.google.com with SMTP id b40so3977764qtb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:02:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-26-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <72ecc3a5-12ff-3d20-be58-0b5d2c6cc5aa@twiddle.net>
Date: Mon, 17 Jul 2017 14:02:21 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-26-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 25/45] translate-all: define and use
 DEBUG_TB_INVALIDATE_GATE
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
> This gets rid of an ifdef check while ensuring that the debug code
> is compiled, which prevents bit rot.
> 
> Suggested-by: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
