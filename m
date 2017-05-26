Received: from eggs.gnu.org ([2001:4830:134:3::10]:51804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFg8-0008Tz-OB
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEFg8-0004tP-1a
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:53:20 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEFg7-0004tL-Tw
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:53:19 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so1340487qtb.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 06:53:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-3-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <013ef9ff-679c-80fa-ef20-b26400ede1b8@twiddle.net>
Date: Fri, 26 May 2017 06:53:16 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/26] target/s390x: make IPTE SMP aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
>       /* XXX we exploit the fact that Linux passes the exact virtual
>          address here - it's not obliged to! */
> -    tlb_flush_page(cs, page);
> +    tlb_flush_page_all_cpus_synced(cs, page);
>   
>       /* XXX 31-bit hack */
>       if (page & 0x80000000) {
> -        tlb_flush_page(cs, page & ~0x80000000);
> +        tlb_flush_page_all_cpus_synced(cs, page & ~0x80000000);
>       } else {
> -        tlb_flush_page(cs, page | 0x80000000);
> +        tlb_flush_page_all_cpus_synced(cs, page | 0x80000000);
>       }

Ideally we would, at the same time, implement the local-pte facility, which 
examines a bit in the M4 field to *not* do this.  That said,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
