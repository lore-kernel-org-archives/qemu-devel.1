Received: from eggs.gnu.org ([2001:4830:134:3::10]:50760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIOE-0001OS-Qn
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIOA-0000zr-Ur
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:10 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIOA-0000zj-Pe
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:01:06 -0400
Received: by mail-pf0-f175.google.com with SMTP id e7so39567483pfk.0
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:01:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-4-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7eacd6bc-88e3-84de-30df-5c30bd2b8fe8@twiddle.net>
Date: Sun, 9 Jul 2017 10:00:01 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-4-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/22] cputlb: bring back tlb_flush_count
 under !TLB_DEBUG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:49 PM, Emilio G. Cota wrote:
> +    atomic_set(&env->tlb_flush_count, env->tlb_flush_count + 1);

Want atomic_read here, so they're all the same.

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
