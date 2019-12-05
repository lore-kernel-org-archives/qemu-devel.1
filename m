Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BITCOIN_SPAM_02,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22EFC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC5320659
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 13:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNUCHv1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC5320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrGp-0003ta-IC
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 08:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1icrFx-0002zt-E6
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1icrFv-0001jd-NW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29804
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1icrFv-0001h2-Gf
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575552799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D3My4n5FCVT71EMVHzreUlmPV5Dd/HMMgUVw6CtMiok=;
 b=jNUCHv1CDM6Es90CnDP4rm0/Rs0dL/a+Vh4XumN4uIQAyQFfUBa3fsG8dKBIiY15wgWgvK
 eRhFL2svQN23PLAb9EQ8BBKSfNkC5s4pvTQH6laEHckdpOhPhCMUur1kywJ+oQ/RxoE5hM
 gYpdjCMpBiXrvCCH6VelJtJEoIhrMTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-GswEV7yDPzajnI836AvRqw-1; Thu, 05 Dec 2019 08:03:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C22A19007EF
 for <qemu-devel@nongnu.org>; Thu,  5 Dec 2019 13:03:04 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-62.ams2.redhat.com
 [10.36.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 851C7600F0;
 Thu,  5 Dec 2019 13:03:02 +0000 (UTC)
Subject: Re: [PATCH for-5.0 7/8] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-8-git-send-email-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <34d3e078-f4e5-149e-a8ef-798d524f53a5@redhat.com>
Date: Thu, 5 Dec 2019 14:03:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1575479147-6641-8-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GswEV7yDPzajnI836AvRqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, philmd@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/04/19 18:05, Igor Mammedov wrote:
> Extend CPU hotplug interface to return architecture specific
> identifier for current CPU in 2 registers:
>  - lower 32 bits existing ACPI_CPU_CMD_DATA_OFFSET_RW
>  - upper 32 bits in new ACPI_CPU_CMD_DATA2_OFFSET_R at
>    offset 0.

OK.

> Target user is UEFI firmware, which needs a way to enumerate
> all CPUs (including possible CPUs) to allocate and initialize
> CPU structures on boot.

(1) This is correct in general, but if we want to keep this description,
then it should be moved to the commit message of the previous patch.
CPHP_GET_CPU_ID_CMD is not needed for the purpose described above -- it
will be necessary for handling the hotplug SMI.

For the boot time allocation / initialization, the "enumerating present
and possible CPUs" workflow is necessary, and that is documented in the
previous patch in this series.

So if we want to keep this paragraph, we should move it to the previous
patch's commit message.

> (for x86: it needs APIC ID and later command will be used to
> retrieve ARM's MPIDR which serves the similar to APIC ID purpose)

(2) I would suggest some punctuation, to make this clearer. How about:

> On x86, guest UEFI firmware will use CPHP_GET_CPU_ID_CMD for fetching
> the APIC ID when handling the hotplug SMI.
>
> Later, CPHP_GET_CPU_ID_CMD will be used on ARM to retrieve MPIDR,
> which serves a purpose similar to the x86 APIC ID.

Back to the patch:

On 12/04/19 18:05, Igor Mammedov wrote:
>
> The new ACPI_CPU_CMD_DATA2_OFFSET_R register will also be used
> to detect presence of modern CPU hotplug, which will be described
> in follow up patch.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v1:
>  - s/ACPI_CPU_CMD_DATA2_OFFSET_RW/ACPI_CPU_CMD_DATA2_OFFSET_R/.
> ---
>  docs/specs/acpi_cpu_hotplug.txt | 10 ++++++++--
>  hw/acpi/cpu.c                   | 15 +++++++++++++++
>  hw/acpi/trace-events            |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> index 58c16c6..bb33144 100644
> --- a/docs/specs/acpi_cpu_hotplug.txt
> +++ b/docs/specs/acpi_cpu_hotplug.txt
> @@ -44,7 +44,11 @@ keeps the current value.
>
>  read access:
>      offset:
> -    [0x0-0x3] reserved
> +    [0x0-0x3] Command data 2: (DWORD access)
> +              if last stored 'Command field' value:
> +                  3: upper 32 bits of architecture specific identifying CPU value
> +                     (n x86 case: 0x0)
> +                  other values: reserved
>      [0x4] CPU device status fields: (1 byte access)
>          bits:
>             0: Device is enabled and may be used by guest

OK.

> @@ -96,7 +100,9 @@ write access:
>                2: stores value into OST status register, triggers
>                   ACPI_DEVICE_OST QMP event from QEMU to external applications
>                   with current values of OST event and status registers.
> -            other values: reserved
> +              3: lower 32 bit of architecture specific identifier
> +                 (in x86 case: APIC ID)
> +              other values: reserved
>
>      Typical usecases:
>          - Get a cpu with pending event

(3) This fragment has been pasted in the wrong spot. We should add this
under:

> read access:
> ...
>     [0x8] Command data: (DWORD access)
>           contains 0 unless last stored in 'Command field' value is one of:
>               0: contains 'CPU selector' value of a CPU with pending event[s]

But right now, the addition is in the context of:

> write access:
> ...
>     [0x8] Command data: (DWORD access)
>           if last stored 'Command field' value:
>               1: stores value into OST event register
>               2: stores value into OST status register, triggers
>                  ACPI_DEVICE_OST QMP event from QEMU to external applications
>                  with current values of OST event and status registers.
>               3: lower 32 bit of architecture specific identifier
>                  (in x86 case: APIC ID)
>               other values: reserved

and it does not make sense there.

(4) Furthermore, for consistency, please write "32 bits" (plural).

Back to the patch:

On 12/04/19 18:05, Igor Mammedov wrote:
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 87f30a3..87813ce 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -12,11 +12,13 @@
>  #define ACPI_CPU_FLAGS_OFFSET_RW 4
>  #define ACPI_CPU_CMD_OFFSET_WR 5
>  #define ACPI_CPU_CMD_DATA_OFFSET_RW 8
> +#define ACPI_CPU_CMD_DATA2_OFFSET_R 0
>
>  enum {
>      CPHP_GET_NEXT_CPU_WITH_EVENT_CMD = 0,
>      CPHP_OST_EVENT_CMD = 1,
>      CPHP_OST_STATUS_CMD = 2,
> +    CPHP_GET_CPU_ID_CMD = 3,
>      CPHP_CMD_MAX
>  };
>
> @@ -74,11 +76,24 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
>          case CPHP_GET_NEXT_CPU_WITH_EVENT_CMD:
>             val = cpu_st->selector;
>             break;
> +        case CPHP_GET_CPU_ID_CMD:
> +           val = cdev->arch_id & 0xFFFFFFFF;
> +           break;
>          default:
>             break;
>          }
>          trace_cpuhp_acpi_read_cmd_data(cpu_st->selector, val);
>          break;
> +    case ACPI_CPU_CMD_DATA2_OFFSET_R:
> +        switch (cpu_st->command) {
> +        case CPHP_GET_CPU_ID_CMD:
> +           val = cdev->arch_id >> 32;
> +           break;
> +        default:
> +           break;
> +        }
> +        trace_cpuhp_acpi_read_cmd_data2(cpu_st->selector, val);
> +        break;
>      default:
>          break;
>      }
> diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
> index 96b8273..afbc77d 100644
> --- a/hw/acpi/trace-events
> +++ b/hw/acpi/trace-events
> @@ -23,6 +23,7 @@ cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0x%"PRIx32"] flags: 0x%"
>  cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: 0x%"PRIx32
>  cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[0x%"PRIx32"] cmd: 0x%"PRIx8
>  cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
> +cpuhp_acpi_read_cmd_data2(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
>  cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[0x%"PRIx32"] inserting: %d, removing: %d"
>  cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[0x%"PRIx32"]"
>  cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[0x%"PRIx32"]"
>

The code looks good to me.

Thanks!
Laszlo


