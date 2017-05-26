Received: from eggs.gnu.org ([2001:4830:134:3::10]:36008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIDI-0006eq-5S
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIDH-00042A-Fj
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:35:44 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEIDH-00041k-9B
	for qemu-devel@nongnu.org; Fri, 26 May 2017 12:35:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id a46so1943081qte.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 09:35:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-22-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a0ebc1e0-db39-218e-fcde-9c4563f98b0d@twiddle.net>
Date: Fri, 26 May 2017 09:35:39 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-22-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/26] target/s390x: implement PACK UNICODE
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

On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> +        } else if (srclen > ssize) {
>               b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
> -            src--;
> -            srclen--;
> +            src -= ssize;
> +            srclen -= ssize;

Surely we need to use lduw in order to correctly read the big-endian 16-bit 
value, or bias src by +1 to read the low byte of same.


r~
