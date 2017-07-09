Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ5f-0006h2-QL
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ5c-0003Xk-P6
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:46:03 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:35106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJ5c-0003XV-Ii
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:46:00 -0400
Received: by mail-pf0-x232.google.com with SMTP id c73so39809335pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:46:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-18-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7e81eceb-2a5e-b5cf-6385-4aff70ecc1b2@twiddle.net>
Date: Sun, 9 Jul 2017 10:45:55 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-18-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/22] tcg: distribute profiling counters
 across TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> +    /* includes aborted translations because of exceptions */
> +    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);

Again, atomic_set without atomic_read is pointless.
Either you're trying to give the compiler extra information, or you aren't.

As always, it won't ever matter in practice because aligned native types never 
tear.  This is all about markup for compiler tools.


r~
