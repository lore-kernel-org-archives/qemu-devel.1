Received: from eggs.gnu.org ([2001:4830:134:3::10]:42547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85uh-0000DX-NK
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d85ug-000353-Qa
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:14:55 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d85ug-00034m-MY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:14:54 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so93019qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 07:14:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170509082800.10756-1-aurelien@aurel32.net>
	<20170509082800.10756-2-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <66ec67ec-453f-4ce8-55a9-45433ffb2b18@twiddle.net>
Date: Tue, 9 May 2017 07:14:50 -0700
MIME-Version: 1.0
In-Reply-To: <20170509082800.10756-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/s390x: mask the SIGP order_code
 using SIGP_ORDER_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

On 05/09/2017 01:27 AM, Aurelien Jarno wrote:
> For that move the definition from kvm.c to cpu.h
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/cpu.h         | 3 +++
>   target/s390x/kvm.c         | 2 --
>   target/s390x/misc_helper.c | 3 +--
>   3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
