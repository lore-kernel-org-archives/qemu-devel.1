Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3898DCA9EBD
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10BFE20578
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BFE20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOMFh-00045k-4k
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 09:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iOMCk-0007r0-Bk
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:34:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iOMCj-0002bA-0l
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 09:34:06 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iOMCZ-0002RX-Fd; Sat, 26 Oct 2019 09:33:55 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MKKd7-1ihnwh12sx-00LjPm; Sat, 26 Oct 2019 15:33:00 +0200
Subject: Re: [PATCH 00/20] hw: Clean up hw/i386 headers (and few alpha/hppa)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20191014142246.4538-1-philmd@redhat.com>
 <dacba192-0a1e-9801-3e6f-02583bd8b994@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <fe8ef9e8-d8d2-e92c-cde3-13a11fa1a5bf@vivier.eu>
Date: Sat, 26 Oct 2019 15:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <dacba192-0a1e-9801-3e6f-02583bd8b994@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AfH0JSrsQ7+6IREPNux+I86yleQstGdiOfFgdWcmW2iM6kTzKqX
 yN7J5lA/ATJjarOqxxXxi5jhpSy/ZYVjR2d/86Q+vY2ucFsLNVIzm3nygeLzru3JcOLmCSu
 TxqJgkXFuCSDjZ6HcaxdbTnf7n9yPzF9KCt3taj5KO6OI0FjZCXLnebanyi56/0K7LVE5VX
 cYSjjTQfVEevHZPjrtcxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JB65cC2/0K4=:zubs51sgA7OgkzO1EQAX7T
 nwKJdGsUQE8/ZQJssjE84YDLY2EdPT8+y9bflYl/9fENMmt5wFFk3OEAPzDQDxfI9HZzK0cIe
 50WgreLUlatCyr0g27LwipmFSN5b+8D6sWt7DrTk3/KL7rkCGXDWb0sTeKbQccBQLucylT+3A
 zntPsfQS+RM8GErVuLUN/35mvag1Hcgk6C2rORlgdSL3LZXMaiPNlAkYo4lfnutYgAF3dB1xZ
 jEZt0UJqD595c9Ib08ZiKLnRqeOlikBQ7aZAr8O698nomuak811qEe/XlaAX+I5yN/oESkh9S
 BpcCztTKdBn524aoiRvwC5y2tZScdA9ya2zWR05wjBg6kv9GLQxR/FAfm+paNhBYTZ+tCWMom
 TzxDCgAbzrrwljLDhfTMfi9dbdPkRqFRbHYLHjHBp/lIWHZPIjAAUHS6O8vWbQFw+o9XgtV7x
 ILg/9rZ0IGEoc8PzdHYit50O2vFnD8LVRjcdAviB22G+2JyvlXjY9EgDwH+P7EmJuq01bUYC1
 B2bP1gq0wLThi/PK84NdPGpWG60i1NmGLIArxPpTMU7mx7LuYvci5BBGLP29vxbMZL3Vq7MQ5
 06RVgkyEvB0/xtiWeA5eOJRL/ssUiVv7NLdN5vwjLzRlgkWg2ac6136IURxQby/6BIFTekg3P
 ADrPZFD9JMmn/xvzHvIrPeU47ffrW50wzFT1TqFAltQ9P6o8At5GHrb976U1UcRZtdS+Z1vqN
 rSI9NNhLuFWBqbYZy/3yTkio9YSFIk19v6oXAJtURYPxPJnio5Ttr9wiydhrdM4fdubNneBd9
 1ClwCgTcxrz6HACpHqrySPSgC225f8iJysJSGNNXydoImJ8+EvhZQBrZ2TjOjAm87O+cOl8kb
 cuH21ROTQq4/0qUSrhJiqHJdjtHuEGIfvQEvDynNk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Paul Durrant <paul@xen.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-block@nongnu.org, Helge Deller <deller@gmx.de>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/10/2019 à 14:20, Philippe Mathieu-Daudé a écrit :
> Hi,
> 
> On 10/14/19 4:22 PM, Philippe Mathieu-Daudé wrote:
>> This is a follow-up of Markus's cleanup series:
>> Tame a few "touch this, recompile the world"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg635748.html
>>
>> This part is mostly restricted to X86, but since some file from the
>> Alpha/PA-RISC machines include "hw/i386/pc.h" I had to fix them
>> too.
>>
>> Eventually I'll succeed at removing hw/i386/ dependency on non-X86
>> platforms (Quest I started 2 years ago...).
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (20):
>>    vl: Add missing "hw/boards.h" include
>>    hw/southbridge/ich9: Removed unused headers
>>    hw/input/pckbd: Remove unused "hw/i386/pc.h" header
>>    hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
>>    hw/timer: Remove unused "ui/console.h" header
>>    hw/usb/dev-storage: Remove unused "ui/console.h" header
>>    hw/i386/intel_iommu: Remove unused includes
>>    hw/xen/xen_pt_load_rom: Remove unused includes
>>    hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
>>    hw/alpha/dp264: Include "net/net.h"
>>    hw/hppa/machine: Include "net/net.h"
>>    hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
>>    hw/timer/hpet: Include "exec/address-spaces.h"
>>    hw/pci-host/q35: Include "qemu/range.h"
>>    hw/i2c/smbus_ich9: Include "qemu/range.h"
>>    hw/pci-host/piix: Include "qemu/range.h"
>>    hw/acpi: Include "hw/mem/nvdimm.h"
>>    hw/i386: Include "hw/mem/nvdimm.h"
>>    hw/pci-host/q35: Remove unused includes
>>    hw/i386/pc: Clean up includes
> Laurent, since this series is fully reviewed, can it go via
> your qemu-trivial tree?

I'll try but I'm not sure to have the time to do that before the softfreeze.

Thanks,
Laurent

