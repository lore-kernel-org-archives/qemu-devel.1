Received: from eggs.gnu.org ([2001:4830:134:3::10]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcCGk-0002Z7-A1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dcCGf-0004Wh-8m
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:06:06 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:18179 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dcCGe-0004TR-Oe
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:06:01 -0400
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-5-vsementsov@virtuozzo.com>
	<20170731114949.5edc8b1f@gondolin>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2f00b91b-a6dc-5b3a-c631-97e600891d6b@virtuozzo.com>
Date: Mon, 31 Jul 2017 18:05:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170731114949.5edc8b1f@gondolin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/4] trace-events: fix code style: print
 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, stefanha@gmail.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

31.07.2017 12:49, Cornelia Huck wrote:
> On Sat, 29 Jul 2017 16:11:59 +0300
> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
>
>> The only exception are groups of numers separated by symbols
>> '.', ' ', ':', '/', like 'ab.09.7d'.
>>
> (...)
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   accel/tcg/trace-events    |   2 +-
>>   block/trace-events        |  22 +++----
>>   hw/audio/trace-events     |   4 +-
>>   hw/char/trace-events      |  12 ++--
>>   hw/display/trace-events   |  12 ++--
>>   hw/dma/trace-events       |  20 +++---
>>   hw/i386/xen/trace-events  |   4 +-
>>   hw/input/trace-events     |   4 +-
>>   hw/intc/trace-events      | 156 +++++++++++++++++++++++-----------------------
>>   hw/isa/trace-events       |   4 +-
>>   hw/misc/trace-events      |  78 +++++++++++------------
>>   hw/net/trace-events       |  34 +++++-----
>>   hw/nvram/trace-events     |   2 +-
>>   hw/ppc/trace-events       |  64 +++++++++----------
>>   hw/s390x/trace-events     |  20 +++---
>>   hw/scsi/trace-events      | 112 ++++++++++++++++-----------------
>>   hw/sd/trace-events        |   4 +-
>>   hw/timer/trace-events     |  20 +++---
>>   hw/usb/trace-events       |  56 ++++++++---------
>>   hw/vfio/trace-events      |  44 ++++++-------
>>   hw/virtio/trace-events    |   6 +-
>>   linux-user/trace-events   |  10 +--
>>   migration/trace-events    |  36 +++++------
>>   nbd/trace-events          |  18 +++---
>>   net/trace-events          |   4 +-
>>   target/arm/trace-events   |  10 +--
>>   target/s390x/trace-events |   2 +-
>>   target/sparc/trace-events |  30 ++++-----
>>   28 files changed, 395 insertions(+), 395 deletions(-)
>>
>> @@ -74,8 +74,8 @@ flic_no_device_api(int err) "flic: no Device Contral API support %d"
>>   flic_reset_failed(int err) "flic: reset failed %d"
>>   
>>   # hw/intc/s390_flic.c
>> -qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type %x isc %x)"
>> -qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc %x, suppress airq by modifying ais mode from %s to %s"
>> +qemu_s390_airq_suppressed(uint8_t type, uint8_t isc) "flic: adapter I/O interrupt suppressed (type 0x%x isc 0x%x)"
>> +qemu_s390_suppress_airq(uint8_t isc, const char *from, const char *to) "flic: for isc 0x%x, suppress airq by modifying ais mode from %s to %s"
>>   
>>   # hw/intc/aspeed_vic.c
>>   aspeed_vic_set_irq(int irq, int level) "Enabling IRQ %d: %d"
>> diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
>> index f07e974678..eb9d349bfa 100644
>> --- a/hw/s390x/trace-events
>> +++ b/hw/s390x/trace-events
>> @@ -2,15 +2,15 @@
>>   
>>   # hw/s390x/css.c
>>   css_enable_facility(const char *facility) "CSS: enable %s"
>> -css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=%x, erc=%x, rsid=%x %s"
>> -css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type %02x)"
>> -css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image %02x %s"
>> -css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
>> -css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm %08x, isc %x) %s"
>> -css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x)"
>> -css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x on isc %x"
>> +css_crw(uint8_t rsc, uint8_t erc, uint16_t rsid, const char *chained) "CSS: queueing crw: rsc=0x%x, erc=0x%x, rsid=0x%x %s"
>> +css_chpid_add(uint8_t cssid, uint8_t chpid, uint8_t type) "CSS: add chpid %x.%02x (type 0x%02x)"
>> +css_new_image(uint8_t cssid, const char *default_cssid) "CSS: add css image 0x%02x %s"
>> +css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno 0x%04x)"
>> +css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm 0x%08x, isc 0x%x) %s"
>> +css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc 0x%x)"
>> +css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode 0x%x on isc 0x%x"
>>   
>>   # hw/s390x/virtio-ccw.c
>> -virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
>> -virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno %04x (%s)"
>> -virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": %x->%x"
>> +virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command 0x%x"
>> +virtio_ccw_new_device(int cssid, int ssid, int schid, int devno, const char *devno_mode) "VIRTIO-CCW: add subchannel %x.%x.%04x, devno 0x%04x (%s)"
>> +virtio_ccw_set_ind(uint64_t ind_loc, uint8_t ind_old, uint8_t ind_new) "VIRTIO-CCW: indicator at %" PRIu64 ": 0x%x->0x%x"
>> diff --git a/target/s390x/trace-events b/target/s390x/trace-events
>> index 1574033e31..290fa5a820 100644
>> --- a/target/s390x/trace-events
>> +++ b/target/s390x/trace-events
>> @@ -8,7 +8,7 @@ set_skeys_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
>>   ioinst(const char *insn) "IOINST: %s"
>>   ioinst_sch_id(const char *insn, int cssid, int ssid, int schid) "IOINST: %s (%x.%x.%04x)"
>>   ioinst_chp_id(const char *insn, int cssid, int chpid) "IOINST: %s (%x.%02x)"
>> -ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command %04x, len %04x"
>> +ioinst_chsc_cmd(uint16_t cmd, uint16_t len) "IOINST: chsc command 0x%04x, len 0x%04x"
>>   
>>   # target/s390x/kvm.c
>>   kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
> s390x related changes above:
>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Thank you!

Don't know, should I add 'Acked-by's into commit message for the next 
version?


-- 
Best regards,
Vladimir
