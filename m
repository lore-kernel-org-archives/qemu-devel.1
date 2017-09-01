Received: from eggs.gnu.org ([2001:4830:134:3::10]:54058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dno7p-0006I3-4P
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dno7m-0004IN-1O
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:44:53 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dno7l-0004HV-Sd
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:44:49 -0400
Received: by mail-qt0-x243.google.com with SMTP id v20so442215qtg.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 08:44:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170901151850.GD17184@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e5407d61-b21c-8ff5-1051-f75a6221e222@amsat.org>
Date: Fri, 1 Sep 2017 12:44:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170901151850.GD17184@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

On 09/01/2017 12:18 PM, Eduardo Habkost wrote:
> On Wed, Aug 30, 2017 at 07:52:18PM -0300, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> This series is based on Igor's "complete cpu QOMification" [1] but only modify
>> the MIPS part. Igor posted an updated series [2], both series should apply
>> separately.
>>
>> Igor suggested on IRC this series could enter via the Machine core tree, so
>> I added Eduardo and Marcel.
> 
> I would do that only if the MIPS maintainers (CCed) aren't
> willing to merge the series themselves.

Aurelien told me he looked at the series but isn't comfortable with 
reviewing QOM code. Anyway since all patches are reviewed/tested and 
this is MIPS only series it also makes sens to me this enters via their 
tree.

Eduardo can you Ack this series from the QOM part to help Aurelien?

Thanks,

Phil.

> 
>>
>> Regards,
>>
>> Phil.
>>
>> [1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04414.html
>> [2]: http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03364.html
>>
>> v2:
>> - added Igor and James Tested-by
>> - squashed "!fixup mips: now than MIPSCPU is QOMified, mark it abstract"
>>
>> PS: code movement somehow triggers a "binary vs unary operators" confusion
>>      in checkpatch: "ERROR: space prohibited after that '&' (ctx:WxW)"
>>
>> Igor Mammedov (2):
>>    mips: MIPSCPU model subclasses
>>    mips: replace cpu_mips_init() with cpu_generic_init()
>>
>> Philippe Mathieu-Daudé (5):
>>    mips: move hw/mips/cputimer.c to target/mips/
>>    mips: introduce internal.h and cleanup cpu.h
>>    mips: split cpu_mips_realize_env() out of cpu_mips_init()
>>    mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
>>    mips: update mips_cpu_list() to use object_class_get_list()
>>
>>   target/mips/cpu-qom.h                         |   1 +
>>   target/mips/cpu.h                             | 357 +---------------------
>>   target/mips/internal.h                        | 422 ++++++++++++++++++++++++++
>>   hw/mips/cps.c                                 |   2 +-
>>   hw/mips/mips_fulong2e.c                       |   2 +-
>>   hw/mips/mips_jazz.c                           |   2 +-
>>   hw/mips/mips_malta.c                          |   2 +-
>>   hw/mips/mips_mipssim.c                        |   2 +-
>>   hw/mips/mips_r4k.c                            |   2 +-
>>   hw/mips/cputimer.c => target/mips/cp0_timer.c |   2 +-
>>   target/mips/cpu.c                             |  57 +++-
>>   target/mips/gdbstub.c                         |   1 +
>>   target/mips/helper.c                          |  47 +++
>>   target/mips/kvm.c                             |   1 +
>>   target/mips/machine.c                         |   1 +
>>   target/mips/msa_helper.c                      |   1 +
>>   target/mips/op_helper.c                       |   1 +
>>   target/mips/translate.c                       |  23 +-
>>   target/mips/translate_init.c                  |  68 +----
>>   hw/mips/Makefile.objs                         |   2 +-
>>   target/mips/Makefile.objs                     |   2 +-
>>   21 files changed, 549 insertions(+), 449 deletions(-)
>>   create mode 100644 target/mips/internal.h
>>   rename hw/mips/cputimer.c => target/mips/cp0_timer.c (99%)
>>
>> -- 
>> 2.14.1
>>
>>
> 
