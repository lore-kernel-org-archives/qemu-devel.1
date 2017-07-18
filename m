Received: from eggs.gnu.org ([2001:4830:134:3::10]:51514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG3g-00072U-P7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG3c-0005Rv-4Z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:08:12 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32818)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXG3b-0005Rk-VB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:08:08 -0400
Received: by mail-qk0-x242.google.com with SMTP id a66so681643qkb.0
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:08:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-32-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <514dba99-a79c-fd44-9b39-8381ae5dde17@twiddle.net>
Date: Mon, 17 Jul 2017 14:08:02 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-32-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 31/45] tci: move tci_regs to
 tcg_qemu_tb_exec's stack
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
> Groundwork for supporting multiple TCG contexts.
> 
> Compile-tested for all targets on an x86_64 host.
> 
> Suggested-by: Richard Henderson<rth@twiddle.net>
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/tci.c | 552 +++++++++++++++++++++++++++++++-------------------------------
>   1 file changed, 279 insertions(+), 273 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
