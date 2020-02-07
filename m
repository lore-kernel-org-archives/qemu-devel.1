Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C5C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2C320838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2C320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04Yq-0005P2-4P
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j04Xy-0004Lh-Cc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j04Xx-0000Tz-8m
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:23:54 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:37387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j04Xo-00009P-3C; Fri, 07 Feb 2020 09:23:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N0Fl9-1jlhN910r9-00xLTT; Fri, 07 Feb 2020 15:22:32 +0100
Subject: Re: [PATCH v3 2/3] hw: Make MachineClass::is_default a boolean type
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200207130453.16666-1-philmd@redhat.com>
 <20200207130453.16666-3-philmd@redhat.com>
 <20200207091138-mutt-send-email-mst@kernel.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <16ec9b38-94e4-bd2d-a47f-83a27289ab47@vivier.eu>
Date: Fri, 7 Feb 2020 15:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200207091138-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SLszv5/lBkzkU6taQGb1HuSAJXlmyVmFi7QPgrx4E+0rytpwtUT
 NhX3zwVdLGoF0FxJe15rQgHJzSQlmsPwBgB0OT6tCszVMNGcKlrmX8a9JsTTD1Jowr8wMoi
 NdAyDPhth9L8X6VSROnsna/gzO5G1+T7VK2vPM/tTfw1CcMTfs1bRs2qhs3SEojBdvfnzES
 GYwiObb/DlNbByWZNhbfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cIMV1YNA9Wo=:2zOMshWlJNXINTaF4BKHNy
 DA7+dZbLwmC7u7tktKDRypAO9RRRshw8VdQZ7rYYYFWfxRHcWr6tykpEKCnUi5cVVk+iuoP2C
 yHT+jWZv1IPt+p2m7lHwY30wfWhJ7BgLiEmfnzVP4cWmNMI623AsuVMI8nD77c1Ql4mwnrmJI
 IchHHzlHvA5cnEr/B6AoP01Z8Ud1p7DcSXKQSfJGMNGE7kOHfrpaXBe3+MT3gutjS5tk7Q9PA
 28TVzfjCqSHFpgXXZCy2tomg7J1MdQlM1bUszxAX7aeXBmYMtwAakzA6CjcxP4a31YRhMVn4m
 yz9vUlNXrpy0no8CZ3y7wyEDnZ4TCkaKUnD/9gePe/xXWy4foYD2zd7k9dQO1sLIX5XRIanBN
 KmYMSNN43CewSFVH1N/zXpndZZWGr+UU6z9k3wHlRdRVpm+ejvhJJsP0zbciFhxoqtf2fjP9K
 8zb7TrtPMv7cYOQR5ZgtexgBFUbu7RRsE0BqmFW+ZbcyGgABAaT/j4TzP4Kjm2GIZcpYw0KCH
 ZUMxJ7PFPFx21apLK1p/FIEX1ra0h41OloCtVcQKA590SkO8+md0X79ifivkLnAWU4Ospao21
 jZ3AcH2FYJRjFwm79f27jS9ZnzC/nx0AZwAOVX/bv6Gm2jlGKAvc36D5QYkEyZwHwciH4BuGO
 k8wxr5YvCSbkg3MM5vU0JKQBZSI3SG7R/R04rfoVxtZ4ZkmNQQMKraDEnYnPJIgdRtvNcF1U7
 wYgXMoGm+TCaO5zhrdU1+KCznO/IAq1ZZ/g0xrjD2vkaoqu09dy7T++TgUlTw7+Kvxm6Q4LYG
 K5QUiKVJLAGUcAg5qHyLVHnPVZrTHtJ4z7evGvINg+j6LB+gz33PDV4xJ8lupIQCYxrHrbQ
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>, Anthony Green <green@moxielogic.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Helge Deller <deller@gmx.de>, Magnus Damm <magnus.damm@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 07/02/2020 à 15:11, Michael S. Tsirkin a écrit :
> On Fri, Feb 07, 2020 at 02:04:52PM +0100, Philippe Mathieu-Daudé wrote:
>> There's no good reason for it to be type int, change it to bool.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
>> ---
>> v3: new patch
>> ---
>>  include/hw/boards.h                      |  2 +-
>>  hw/alpha/dp264.c                         |  2 +-
>>  hw/cris/axis_dev88.c                     |  2 +-
>>  hw/hppa/machine.c                        |  2 +-
>>  hw/i386/pc_piix.c                        | 10 +++++-----
>>  hw/lm32/lm32_boards.c                    |  2 +-
>>  hw/m68k/mcf5208.c                        |  2 +-
>>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
>>  hw/mips/mips_malta.c                     |  2 +-
>>  hw/moxie/moxiesim.c                      |  2 +-
>>  hw/nios2/10m50_devboard.c                |  2 +-
>>  hw/openrisc/openrisc_sim.c               |  2 +-
>>  hw/ppc/mac_oldworld.c                    |  2 +-
>>  hw/ppc/spapr.c                           |  2 +-
>>  hw/riscv/spike.c                         |  2 +-
>>  hw/s390x/s390-virtio-ccw.c               |  2 +-
>>  hw/sh4/shix.c                            |  2 +-
>>  hw/sparc/sun4m.c                         |  2 +-
>>  hw/sparc64/niagara.c                     |  2 +-
>>  hw/sparc64/sun4u.c                       |  4 ++--
>>  hw/unicore32/puv3.c                      |  2 +-
>>  21 files changed, 26 insertions(+), 26 deletions(-)
>>
...
>> diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
>> index 5eb2d097b9..81a1748fad 100644
>> --- a/hw/sparc64/niagara.c
>> +++ b/hw/sparc64/niagara.c
>> @@ -170,7 +170,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
>>  
>>      mc->desc = "Sun4v platform, Niagara";
>>      mc->init = niagara_init;
>> -    mc->max_cpus = 1; /* XXX for now */
>> +    mc->max_cpus = true; /* XXX for now */

what happened here ^^^

>>      mc->default_boot_order = "c";
>>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
>>  }
>> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
>> index b7ac42f7a5..3c2c9d2eb0 100644
>> --- a/hw/sparc64/sun4u.c
>> +++ b/hw/sparc64/sun4u.c
>> @@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
>>      mc->init = sun4u_init;
>>      mc->block_default_type = IF_IDE;
>>      mc->max_cpus = 1; /* XXX for now */
>> -    mc->is_default = 1;
>> +    mc->is_default = true;
>>      mc->default_boot_order = "c";
>>      mc->default_cpu_type = SPARC_CPU_TYPE_NAME("TI-UltraSparc-IIi");
>>      mc->ignore_boot_device_suffixes = true;
>> @@ -841,7 +841,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
>>      mc->desc = "Sun4v platform";
>>      mc->init = sun4v_init;
>>      mc->block_default_type = IF_IDE;
>> -    mc->max_cpus = 1; /* XXX for now */
>> +    mc->max_cpus = true; /* XXX for now */

and here ^^

Thanks,
Laurent


