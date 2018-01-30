Received: from eggs.gnu.org ([2001:4830:134:3::10]:60250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egbgH-0006ZL-7Y
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1egbff-0001i1-T1
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:34:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1egbff-0001h6-GF
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:34:19 -0500
References: <1516655269-1785-1-git-send-email-juterry@microsoft.com>
	<CY4PR2101MB0866914EE81498938229BA5FB6E50@CY4PR2101MB0866.namprd21.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6dfe694-1b67-46f3-7ea6-3f68cb2985e3@redhat.com>
Date: Tue, 30 Jan 2018 14:34:13 -0500
MIME-Version: 1.0
In-Reply-To: <CY4PR2101MB0866914EE81498938229BA5FB6E50@CY4PR2101MB0866.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Updates based on feedback.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Justin Terry (VM)" <juterry@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crosthwaite.peter@gmail.com" <crosthwaite.peter@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>

On 29/01/2018 14:58, Justin Terry (VM) wrote:
> Hi All,
> 
> Is there any additional feedback I can address here to help out the process? Please let me know.

Nothing specifically (it didn't help that most of last week I was
sick!).  From my point of view, I just need to review the changes you
made and include these patches in a pull request.

Thanks,

Paolo

> Thanks again,
> Justin
> 
>> -----Original Message-----
>> From: Justin Terry (VM)
>> Sent: Monday, January 22, 2018 1:08 PM
>> To: qemu-devel@nongnu.org
>> Cc: pbonzini@redhat.com; crosthwaite.peter@gmail.com; rth@twiddle.net;
>> ehabkost@redhat.com; Justin Terry (VM) <juterry@microsoft.com>
>> Subject: [PATCH v2 0/4] Updates based on feedback.
>>
>> Updates based on review feedback.
>>
>> 1. Fixes style issues and properly ran the scripts/checkpatch pre submission.
>> 2. Added migration blockers for CPUID, dirty memory tracking, and
>> XSAVE/XRSTOR.
>> 3. Fixed some bugs around register states when using bios vs efi.
>>
>> Justin Terry (VM) (4):
>>   Add the Windows Hypervisor Platform accelerator.
>>   Add the WHPX vcpu API
>>   Introduce the WHPX impl
>>   Add the WHPX acceleration enlightenments
>>
>>  accel/stubs/Makefile.objs |    9 +-
>>  accel/stubs/whpx-stub.c   |   48 ++
>>  configure                 |   48 +-
>>  cpus.c                    |   66 ++-
>>  include/sysemu/hw_accel.h |   13 +
>>  include/sysemu/whpx.h     |   40 ++
>>  qemu-options.hx           |    8 +-
>>  target/i386/Makefile.objs |    1 +
>>  target/i386/helper.c      |    2 +-
>>  target/i386/whpx-all.c    | 1366
>> +++++++++++++++++++++++++++++++++++++++++++++
>>  10 files changed, 1590 insertions(+), 11 deletions(-)  create mode 100644
>> accel/stubs/whpx-stub.c  create mode 100644 include/sysemu/whpx.h
>> create mode 100644 target/i386/whpx-all.c
>>
>> --
>> 2.7.4
> 
