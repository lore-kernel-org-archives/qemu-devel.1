Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E3C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F99320665
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F99320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwiM-0000e6-P6
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDwhL-0008K8-00
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDwhI-0007yS-Bb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:18:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDwhI-0007y7-26
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:18:36 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB13AC0546FB
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 20:18:34 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id f11so1571164wrt.18
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 13:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VYIARQZeSo4eqIGZ7/+Ci3Bhjf7+cEZeiTX0M8qC638=;
 b=pNKzqTeUDbEc0DLaw8pLOLw5QtlN0PlW5zaB22kb2SaV8v24vNGhXmd9mMMilGCU4y
 icTuLuCDgdC+woC392Do9gqWDB49O/wLDatpvYYDiqFHe8ClrY1wHGcJO9WBC8BsZ8l5
 8eNslKGMzN/oy4VKrfybIiGO4VjLq6KoHdDI5yZs7dSXlYpvMPYFotLAcNNP/7dl1tzj
 Xp0dnRd61s7oKAy5Ox3g8DkqPAU7FcsBP1sgeyBv/D1UQOUgUpymI7jp0OgFmNGk/3sH
 9XezQlwKkdkZTdf1XYTVJXDARQ6A9DM4htbL+Z8M2jJdlU0+N8NylI3k69Dv4EircDtH
 I32Q==
X-Gm-Message-State: APjAAAUZbuYwmNhWY2tPjJ1orbvjjrHUhsA1KIb1sn6c3/8xTQHgemGL
 Xx9QrvxqFDDMspVuLWFq0g7sV47ENUcj7N040RpE6dSGQQDXHOnJM3zqYgWiSJbGjevGDjN4HI0
 RRHGKdxTJlgPG+Ps=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr4458071wrw.170.1569615513314; 
 Fri, 27 Sep 2019 13:18:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbH5UghWOVWro60T75YWgKZmCaDaERPTUBpOQgCWMW5f2yTCQYpScQiQKGYw176J3w6wdt3g==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr4458051wrw.170.1569615513010; 
 Fri, 27 Sep 2019 13:18:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id b16sm6044423wrh.5.2019.09.27.13.18.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 13:18:32 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Allow memory_region_register_iommu_notifier() to
 fail
To: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
References: <20190924082517.13724-1-eric.auger@redhat.com>
 <20190924153144.0a656a41@x1.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e91b5121-44f9-6afb-cf0a-3016cbc7913d@redhat.com>
Date: Fri, 27 Sep 2019 22:18:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924153144.0a656a41@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, aik@ozlabs.ru, qemu-devel@nongnu.org,
 peterx@redhat.com, qemu-arm@nongnu.org, david@gibson.dropbear.id.au,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/19 23:31, Alex Williamson wrote:
> On Tue, 24 Sep 2019 10:25:15 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
>> This series allows the memory_region_register_iommu_notifier()
>> to fail. As of now, when a MAP notifier is attempted to be
>> registered along with SMMUv3 or AMD IOMMU, we exit in the IOMMU
>> MR notify_flag_changed() callback.
>>
>> In case of VFIO assigned device hotplug, this could be handled
>> more nicely directly within the VFIO code, simply rejecting
>> the hotplug without exiting. This is what the series achieves
>> by handling the memory_region_register_iommu_notifier() returned
>> value and Error object.
>>
>> To propagate errors collected during vfio_listener_region_add()
>> we now store the error handle inside the VFIO container instead
>> of a returned value.
>>
>> The message now is:
>> (QEMU) device_add id=hot0 driver=vfio-pci host=0000:89:00.0 bus=pcie.1
>> {"error": {"class": "GenericError", "desc": "vfio 0000:89:00.0: failed
>> to setup container for group 2: memory listener initialization failed:
>> Region smmuv3-iommu-memory-region-0-6: device 01.00.0 requires iommu MAP
>> notifier which is not currently supported"}}
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v4.1.0_register_iommu_notifier_fail_v4
>>
>> History:
>>
>> v3 -> v4:
>> - added Peter's R-b on 2d patch
>> - 1st patch: restore hw_error, remove useless ret assignment, improve
>>   DMA host window error message, remove local mr variable
>>
>> v2 -> v3:
>> - also pass an Error handle (suggested by Peter)
>>
>> v1 -> v2:
>> - Intel IOMMU now handles the problem differently with machine init done
>>   notifier and machine hotplug allowed hook.
>> - use assert(!ret)
>> - message rewording in SMMUv3
>>
>> Follow-up of "VFIO/SMMUv3: Fail on VFIO/HW nested paging detection"
>> https://patchew.org/QEMU/20190829090141.21821-1-eric.auger@redhat.com/
>>
>>
>> Eric Auger (2):
>>   vfio: Turn the container error into an Error handle
>>   memory: allow memory_region_register_iommu_notifier() to fail
>>
>>  exec.c                        | 10 +++++--
>>  hw/arm/smmuv3.c               | 18 ++++++------
>>  hw/i386/amd_iommu.c           | 17 +++++++-----
>>  hw/i386/intel_iommu.c         |  8 ++++--
>>  hw/ppc/spapr_iommu.c          |  8 ++++--
>>  hw/vfio/common.c              | 52 +++++++++++++++++++++++------------
>>  hw/vfio/spapr.c               |  4 ++-
>>  hw/virtio/vhost.c             |  9 ++++--
>>  include/exec/memory.h         | 21 ++++++++++----
>>  include/hw/vfio/vfio-common.h |  2 +-
>>  memory.c                      | 31 +++++++++++++--------
>>  11 files changed, 120 insertions(+), 60 deletions(-)
> 
> For series,
> 
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Paolo, would this go in through you given the memory API changes and
> greater girth in patch 2/2?  Thanks,

Fine, queued.

Paolo



