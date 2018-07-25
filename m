Received: from eggs.gnu.org ([2001:4830:134:3::10]:47557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fiHL0-0001MT-GZ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fiHKx-0008V1-Ic
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:48:10 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fiHKx-0008Sg-9u
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:48:07 -0400
Received: by mail-wm0-x243.google.com with SMTP id o11-v6so5541760wmh.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 03:48:07 -0700 (PDT)
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
Date: Wed, 25 Jul 2018 13:48:03 +0300
MIME-Version: 1.0
In-Reply-To: <d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>

Hi,

On 07/25/2018 10:32 AM, Thomas Huth wrote:
> On 25.07.2018 06:47, Rebecca Cran wrote:
>> In commit 18a398f6a39df4b08ff86ac0d38384193ca5f4cc, ./configure on
>> FreeBSD incorrectly detects RDMA support,

configure is looking for the rdma related libraries,  if they are there,
the rdma code will be compiled into QEMU.

You can try and run configure with --disable-rdma flag until we find
a solution.

>>   with the build subsequently
>> failing with:
>>
>> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:19:10: fatal error:
>> 'linux/types.h' file not found
>> #include <linux/types.h>
>>           ^~~~~~~~~~~~~~~
Do you have the kernel-headers package installed?

>> 1 error generated.
>> gmake[1]: *** [/home/bcran/workspace/qemu/rules.mak:69:
>> hw/rdma/vmw/pvrdma_cmd.o] Error 1
>> gmake[1]: *** Waiting for unfinished jobs....
>> gmake: *** [Makefile:481: subdir-x86_64-softmmu] Error 2
> When was it still working for you the last time? Was it still working
> with v3.0-rc1 ? Or just with v2.12 ? Any chance that you could bisect
> the problem to determine when it has been introduced?

Good idea.

Thanks,
Marcel

>   Thomas
