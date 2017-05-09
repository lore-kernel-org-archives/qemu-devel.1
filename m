Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d86j7-0007ie-PP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d86j6-0008W2-Vc
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:07:01 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:33009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d86j6-0008VM-Re
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:07:00 -0400
Received: by mail-qk0-x22d.google.com with SMTP id y201so3459719qka.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 08:07:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170508151707.5434-1-rth@twiddle.net>
	<20170508151707.5434-2-rth@twiddle.net>
	<20170509081457.zcxvzd5spv7n4stj@aurel32.net>
	<d8108b48-619f-181f-57ef-95a831608998@twiddle.net>
Message-ID: <25e744fb-a174-15f2-df6d-0e9db27debfb@twiddle.net>
Date: Tue, 9 May 2017 08:06:57 -0700
MIME-Version: 1.0
In-Reply-To: <d8108b48-619f-181f-57ef-95a831608998@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/6] target/s390x: Implement STORE
 FACILITIES LIST EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org

On 05/09/2017 07:51 AM, Richard Henderson wrote:
> I'm pleased to see this appears to have been dropped at some point; I cannot 
> see it present in linux 4.11.  However, this still applies to the kernels 
> supplied by the shipping distributions.

More accurately, it has been moved to arch/s390/kernel/als.c.

But from what I can see from arch/s390/tools/gen_facilities.c, they have now 
properly pruned the required list to those that are *really* required.


r~
