Received: from eggs.gnu.org ([2001:4830:134:3::10]:56211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZVAO-0005t8-O9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZVAK-0005P3-Li
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:40:24 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZVAK-0005Ow-FE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:40:20 -0400
Received: by mail-pg0-x243.google.com with SMTP id y129so10650352pgy.3
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 21:40:20 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170721125609.11117-1-david@redhat.com>
	<20170721125609.11117-5-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f1c1a29b-c249-0cb1-98a4-78c91147c405@twiddle.net>
Date: Sun, 23 Jul 2017 21:40:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170721125609.11117-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] target/s390x: move wrap_address to
 cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 07/21/2017 05:56 AM, David Hildenbrand wrote:
> Signed-off-by: David Hildenbrand<david@redhat.com>
> ---
>   target/s390x/cpu.h        | 14 ++++++++++++++
>   target/s390x/mem_helper.c | 14 --------------
>   2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>

Although another header, private to the helpers, might be better...


r~
