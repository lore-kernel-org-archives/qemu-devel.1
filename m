Received: from eggs.gnu.org ([2001:4830:134:3::10]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGo7-00055W-1i
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZGo2-00005q-ME
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 08:52:43 -0500
References: <20171201232433.25193-1-eblake@redhat.com>
	<3323b23f-ad82-fff5-26cb-bf4c9622c36d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2505bb25-2fbb-cf4d-0c79-0efe62a4df63@redhat.com>
Date: Wed, 10 Jan 2018 14:52:33 +0100
MIME-Version: 1.0
In-Reply-To: <3323b23f-ad82-fff5-26cb-bf4c9622c36d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] macro do/while (0) cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

On 09/01/2018 21:52, Eric Blake wrote:
> ping

Hmm, the actual posting of the patches wasn't CCed to qemu-trivial.

Queued now, thanks.

Paolo

> On 12/01/2017 05:24 PM, Eric Blake wrote:
>> Noticed this by chance in the tests/ directory, so I broadened
>> it to a grep of the entire code base.  I suspect^wKNOW many of
>> the bad macros were the victims of copy-and-paste from some
>> other bad location (particularly given how many bit-rotten
>> debug print macros were involved).
>>
>> https://wiki.qemu.org/BiteSizedTasks#Bitrot_prevention is still
>> left for someone else, for another day.
>>
>> In v2:
>> - add review tags
>> - audit that the maint patch has no semantic change (all callers
>> were indeed supplying ';' at the macro call-sites)
>> - improved commit messages
>> - more patches for some additional cleanups
>> - tighten the checkpatch rule to also flag 'while (false);'
>>
>> Eric Blake (7):
>>   net: Drop unusual use of do { } while (0);
>>   mips: Tweak location of ';' in macros
>>   chardev: Use goto/label instead of do/break/while(0)
>>   chardev: Clean up previous patch indentation
>>   tests: Avoid 'do/while(false);' in vhost-user-bridge
>>   maint: Fix macros with broken 'do/while(0);' usage
>>   checkpatch: Enforce proper do/while (0) style
>>
>>  tests/acpi-utils.h         |  8 ++---
>>  ui/sdl_zoom_template.h     |  8 ++---
>>  audio/paaudio.c            |  4 +--
>>  chardev/char-serial.c      | 75 ++++++++++++++++++++++++----------------------
>>  hw/adc/stm32f2xx_adc.c     |  2 +-
>>  hw/block/m25p80.c          |  2 +-
>>  hw/char/cadence_uart.c     |  2 +-
>>  hw/char/stm32f2xx_usart.c  |  2 +-
>>  hw/display/cg3.c           |  2 +-
>>  hw/display/dpcd.c          |  2 +-
>>  hw/display/xlnx_dp.c       |  2 +-
>>  hw/dma/pl330.c             |  2 +-
>>  hw/dma/xlnx-zynq-devcfg.c  |  2 +-
>>  hw/dma/xlnx_dpdma.c        |  2 +-
>>  hw/i2c/i2c-ddc.c           |  2 +-
>>  hw/misc/auxbus.c           |  2 +-
>>  hw/misc/macio/mac_dbdma.c  |  4 +--
>>  hw/misc/mmio_interface.c   |  2 +-
>>  hw/misc/stm32f2xx_syscfg.c |  2 +-
>>  hw/misc/zynq_slcr.c        |  2 +-
>>  hw/net/cadence_gem.c       |  2 +-
>>  hw/net/pcnet.c             | 20 ++++++-------
>>  hw/ssi/mss-spi.c           |  2 +-
>>  hw/ssi/stm32f2xx_spi.c     |  2 +-
>>  hw/ssi/xilinx_spi.c        |  2 +-
>>  hw/ssi/xilinx_spips.c      |  2 +-
>>  hw/timer/a9gtimer.c        |  2 +-
>>  hw/timer/cadence_ttc.c     |  2 +-
>>  hw/timer/mss-timer.c       |  2 +-
>>  hw/timer/stm32f2xx_timer.c |  2 +-
>>  hw/tpm/tpm_passthrough.c   |  2 +-
>>  hw/tpm/tpm_tis.c           |  2 +-
>>  migration/rdma.c           |  2 +-
>>  target/arm/translate-a64.c |  2 +-
>>  target/mips/msa_helper.c   | 34 +++++++++++----------
>>  target/s390x/kvm.c         |  2 +-
>>  tests/tcg/test-mmap.c      |  2 +-
>>  tests/vhost-user-bridge.c  |  6 ++--
>>  scripts/checkpatch.pl      |  5 ++++
>>  39 files changed, 119 insertions(+), 105 deletions(-)
>>
> 
