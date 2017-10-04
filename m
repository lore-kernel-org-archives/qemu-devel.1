Received: from eggs.gnu.org ([2001:4830:134:3::10]:45573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dznTd-00019N-6T
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:28:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dznTc-0008Co-9L
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:28:57 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dznTc-0008C3-4H
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 13:28:56 -0400
Received: by mail-qt0-x242.google.com with SMTP id p15so996826qtp.2
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 10:28:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171004162543.12233-1-cohuck@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <54891ace-9077-67da-9d65-095ec3b2f211@twiddle.net>
Date: Wed, 4 Oct 2017 13:28:52 -0400
MIME-Version: 1.0
In-Reply-To: <20171004162543.12233-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/tcg: initialize machine check queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com

On 10/04/2017 12:25 PM, Cornelia Huck wrote:
> Just as for external interrupts and I/O interrupts, we need to
> initialize mchk_index during cpu reset.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Trying a device_add with a ccw device under tcg currently insta-crashes
> qemu. Probably nobody ever tried the crw machine check support that I
> hacked in...
> 
> Needs more work to avoid a guest kernel panic next; but let's pick the
> low-hanging fruit first.
> 
> ---
>  target/s390x/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
