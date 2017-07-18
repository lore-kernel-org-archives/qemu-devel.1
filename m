Received: from eggs.gnu.org ([2001:4830:134:3::10]:49712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFzy-0003qr-HO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXFzx-0003dI-Jr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:04:22 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXFzx-0003d5-G2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:04:21 -0400
Received: by mail-qk0-x242.google.com with SMTP id z22so663923qka.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:04:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-28-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3e1f6d62-0ea7-9ffa-a03a-9f5b71c8215c@twiddle.net>
Date: Mon, 17 Jul 2017 14:04:16 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-28-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 27/45] exec-all: extract tb->tc_* into a
 separate struct tc_tb
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
> In preparation for adding tc.size to be able to keep track of
> TB's using the binary search tree implementation from glib.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/exec-all.h   | 20 ++++++++++++++------
>   accel/tcg/cpu-exec.c      |  6 +++---
>   accel/tcg/translate-all.c | 20 ++++++++++----------
>   tcg/tcg-runtime.c         |  4 ++--
>   tcg/tcg.c                 |  4 ++--
>   5 files changed, 31 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
