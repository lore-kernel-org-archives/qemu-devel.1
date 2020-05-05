Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24103C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7857215A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei9KMxLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7857215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyOH-0008I0-2f
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyMs-0007EP-II
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:16:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVyMr-0004Wd-DD
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJd1jec+ZNh3ujpHFbkXizyc4+NuEXkJrL0D//4Ob30=;
 b=Ei9KMxLQe2Hqh1PYrx0wCiYSmCfP6DDzJz8PcQWr43DTFL4DQUELS8SV0xYuNdkPFWL71V
 Ot4BFFTbpePqafx0Umc1V0c9SDByMO/z09VPAjmfjsIZLYhRzYFM30Kihz1D9uP+pLXg0L
 rrILzOyAg8Prpr26jCDBdeKPwC1QNIs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-oT6EMLBiPfS8W0sMWygZvw-1; Tue, 05 May 2020 10:16:04 -0400
X-MC-Unique: oT6EMLBiPfS8W0sMWygZvw-1
Received: by mail-wr1-f71.google.com with SMTP id f2so1274586wrm.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MJd1jec+ZNh3ujpHFbkXizyc4+NuEXkJrL0D//4Ob30=;
 b=j2Emh+kdhuBnoWL8Y/f+lLoAK2JaJLOIEI4+6siKHA/xMppRuhTiPbAaF6eA9o4WrW
 Zh7laTw3PDLojTIvMMfp/IN6T+thRvfYU9frvHRIxQasQRQ+yiq2CgN4bI9osOg1SKl2
 7uGixl0Yzn4E1HV2jKMWv4Watc7lYTH9UX8+GUdyxny92vPKQl31vfAHQlYxWnWdS4Ji
 vYTzWcsK+cm1FhRiii4DjWTLJ0RH+T1UrY/1Dg+AXIkzAGoSvAN4QJ/p6HUVUoRUINjq
 iUr8d7p5aKusYGkHP/R7kYb6dIdIwzlgK+21aiY8OWLCnXPRfzSSHdo0NsZi7SHwSeiK
 EK3Q==
X-Gm-Message-State: AGi0PuaQwyS2Iaa33/C6LwziFRtgO5yx6fIHSNqokaetQwztOZdlf/Eq
 yS3F90VnCc7MShDB/sZGPiD3aK2lPjBDrR4TvloxhfcE/NhtEdZGzg7YP9POhoLzu9tpWNcHh/j
 b4fFthNNPhZlhdVA=
X-Received: by 2002:a5d:5047:: with SMTP id h7mr2693579wrt.7.1588688162735;
 Tue, 05 May 2020 07:16:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEk2qgYDb26JGHvtgpFHAC4Xa6D8aiPxtenQxmaBV2UR8JbnlhZ6XJBj/XiMLRQktLc5eh7Q==
X-Received: by 2002:a5d:5047:: with SMTP id h7mr2693553wrt.7.1588688162498;
 Tue, 05 May 2020 07:16:02 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id q8sm3806448wrp.58.2020.05.05.07.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 07:16:01 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] microvm: add acpi support
To: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505100010-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <aedc8f5e-b348-1c30-95eb-75a748ccafa1@redhat.com>
Date: Tue, 5 May 2020 16:16:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505100010-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 4:04 PM, Michael S. Tsirkin wrote:
> On Tue, May 05, 2020 at 03:42:52PM +0200, Gerd Hoffmann wrote:
>> I know that not supporting ACPI in microvm is intentional.  If you still
>> don't want ACPI this is perfectly fine, you can use the usual -no-acpi
>> switch to toggle ACPI support.
>>
>> These are the advantages you are going to loose then:
>>
>>    (1) virtio-mmio device discovery without command line hacks (tweaking
>>        the command line is a problem when not using direct kernel boot).
>>    (2) Better IO-APIC support, we can use IRQ lines 16-23.
>>    (3) ACPI power button (aka powerdown request) works.
>>    (4) machine poweroff (aka S5 state) works.
> 
> Questions
> 
> - what's the tradeoff in startup time?
> - what should be the default?
> 
> Based on above I'd be inclined to say default should stay no acpi and
> users should enable acpi with an option.

As this machine was added to have the least minimum hardware required, 
I'd keep the default with no ACPI and have user requiring it to use an 
option. My 2 cents obviously.

> 
>> Together with seabios patches for virtio-mmio support this allows to
>> boot standard fedora images (cloud, coreos, workstation live) with the
>> microvm machine type.
>>
>> git branch for testing (including updated seabios):
>> 	https://git.kraxel.org/cgit/qemu/log/?h=sirius/microvm
>>
>> changes in v2:
>>    * some acpi cleanups are an separate patch series now.
>>    * switched to hw reduced acpi & generic event device.
>>    * misc fixes here and there.
>>
>> cheers,
>>    Gerd
>>
>> Gerd Hoffmann (13):
>>    acpi: make build_madt() more generic.
>>    acpi: create acpi-common.c and move madt code
>>    acpi: madt: skip pci override on pci-less systems (microvm)
>>    acpi: move acpi_build_facs to acpi-common.c
>>    acpi: move acpi_init_common_fadt_data to acpi-common.c
>>    acpi: move acpi_align_size to acpi-common.h
>>    acpi: fadt: add hw-reduced sleep register support
>>    acpi: generic event device for x86
>>    microvm: add minimal acpi support
>>    microvm: disable virtio-mmio cmdline hack
>>    microvm: add acpi_dsdt_add_virtio() for x86
>>    microvm: make virtio irq base runtime configurable
>>    microvm/acpi: use GSI 16-23 for virtio
>>
>>   hw/i386/acpi-common.h                  |  38 ++++
>>   hw/i386/acpi-microvm.h                 |   6 +
>>   include/hw/acpi/acpi-defs.h            |   2 +
>>   include/hw/acpi/generic_event_device.h |  10 +
>>   include/hw/i386/microvm.h              |  10 +-
>>   hw/acpi/aml-build.c                    |   4 +-
>>   hw/i386/acpi-build.c                   | 198 +-------------------
>>   hw/i386/acpi-common.c                  | 206 ++++++++++++++++++++
>>   hw/i386/acpi-microvm.c                 | 249 +++++++++++++++++++++++++
>>   hw/i386/generic_event_device_x86.c     | 114 +++++++++++
>>   hw/i386/microvm.c                      |  36 +++-
>>   hw/i386/Kconfig                        |   1 +
>>   hw/i386/Makefile.objs                  |   3 +
>>   13 files changed, 676 insertions(+), 201 deletions(-)
>>   create mode 100644 hw/i386/acpi-common.h
>>   create mode 100644 hw/i386/acpi-microvm.h
>>   create mode 100644 hw/i386/acpi-common.c
>>   create mode 100644 hw/i386/acpi-microvm.c
>>   create mode 100644 hw/i386/generic_event_device_x86.c
>>
>> -- 
>> 2.18.4
> 
> 


