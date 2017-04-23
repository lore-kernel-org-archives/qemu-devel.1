Received: from eggs.gnu.org ([2001:4830:134:3::10]:33520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Qd1-0000yH-Uq
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 19:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Qcy-0003WD-09
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 19:09:15 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2Qcx-0003Vp-Qu
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 19:09:11 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so1649106qka.1
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 16:09:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170423223240.17917-1-aurelien@aurel32.net>
	<ae985b05-a8ad-adb8-0e7a-1ec6ba631402@amsat.org>
	<20170423224720.lbqt7tw5tzy2yuyl@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8d85594d-ab87-a747-ff24-0841fe47988f@amsat.org>
Date: Sun, 23 Apr 2017 20:09:08 -0300
MIME-Version: 1.0
In-Reply-To: <20170423224720.lbqt7tw5tzy2yuyl@aurel32.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 04/23/2017 07:47 PM, Aurelien Jarno wrote:
> On 2017-04-23 19:38, Philippe Mathieu-Daudé wrote:
>> Hi Aurelien!
>>
>> Why don't lock inside s390_virtio_hypercall() directly round the diag500
>> dispatch call?
>
> s390_virtio_hypercall is shared between TCG and KVM. For KVM the lock is
> already done before calling s390_virtio_hypercall in kvm_arch_handle_exit.

Fair enough!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
