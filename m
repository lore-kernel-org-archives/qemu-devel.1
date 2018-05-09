Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fGG42-0004Dl-SZ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1fGG3z-0001Y8-S5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:46:50 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1fGG3z-0001VQ-He
	for qemu-devel@nongnu.org; Tue, 08 May 2018 23:46:47 -0400
Received: by mail-pg0-x242.google.com with SMTP id k11-v6so20937928pgo.10
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 20:46:47 -0700 (PDT)
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180508144608.4c4e8180.cohuck@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <974f865e-c3c0-c810-e177-2f02f4f29a34@ozlabs.ru>
Date: Wed, 9 May 2018 13:46:37 +1000
MIME-Version: 1.0
In-Reply-To: <20180508144608.4c4e8180.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] MAINTAINERS: add entries for AP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, peter.maydell@linaro.org, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 8/5/18 10:46 pm, Cornelia Huck wrote:
> On Tue,  8 May 2018 08:25:03 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> 
>> Added entries for the s390 adjunct processor (AP) support.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  MAINTAINERS |   14 ++++++++++++++
>>  1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 459e359..c9e8d7b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -82,6 +82,7 @@ S390
>>  M: Cornelia Huck <cohuck@redhat.com>
>>  S: Supported
>>  F: default-configs/s390x-softmmu.mak
>> +F: docs/vfio-ap.txt
>>  F: gdb-xml/s390*.xml
>>  F: hw/char/sclp*.[hc]
>>  F: hw/char/terminal3270.c
>> @@ -89,6 +90,7 @@ F: hw/intc/s390_flic.c
>>  F: hw/intc/s390_flic_kvm.c
>>  F: hw/s390x/
>>  F: hw/vfio/ccw.c
>> +F: hw/vfio/ap.c
>>  F: hw/watchdog/wdt_diag288.c
>>  F: include/hw/s390x/
>>  F: include/hw/watchdog/wdt_diag288.h
>> @@ -1152,6 +1154,18 @@ F: include/hw/s390x/s390-ccw.h
>>  T: git git://github.com/cohuck/qemu.git s390-next
>>  L: qemu-s390x@nongnu.org
>>  
>> +vfio-ap
>> +M: Christian Borntraeger <borntraeger@de.ibm.com>
>> +M: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> +M: Halil Pasic <pasic@linux.vnet.ibm.com>
>> +M: Pierre Morel <pmorel@linux.vnet.ibm.com>
> 
> Dumb question: Aren't you folks dropping the 'vnet' part in the future?


They should keep working for quite some time though, it has been spread way
too much.


> 
>> +S: Maintained
>> +F: hw/vfio/ap.c
>> +F: hw/s390x/ap-device.c
>> +F: include/hw/s390x/ap-device.h
>> +F: docs/vfio-ap.txt
>> +L: qemu-s390x@nongnu.org
>> +
>>  vhost
>>  M: Michael S. Tsirkin <mst@redhat.com>
>>  S: Supported
> 
> 


-- 
Alexey
