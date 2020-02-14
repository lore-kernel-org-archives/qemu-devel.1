Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370CAC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090782468A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 16:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090782468A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2eBT-0002Jv-7r
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 11:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2eAN-00019N-QB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2eAM-0008Uk-BG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 11:50:11 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58955)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j2eAJ-0008MZ-7B; Fri, 14 Feb 2020 11:50:07 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MTiDV-1ivAqy4B5h-00TyPz; Fri, 14 Feb 2020 17:50:02 +0100
Subject: Re: [PATCH v2] Report stringified errno in VFIO related errors
To: Alex Williamson <alex.williamson@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <4949c3ecf1a32189b8a4b5eb4b0fd04c1122501d.1581674006.git.mprivozn@redhat.com>
 <20200214083515.15b94be8@x1.home>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3ffa0f2f-eb74-381f-e76d-ae49ff091e61@vivier.eu>
Date: Fri, 14 Feb 2020 17:50:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214083515.15b94be8@x1.home>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b7sSJCTzU+dYJwgchA16OKWtdGDGXTLSR4w5QmvysWdDeTHe1Gp
 iIdZufY0EuWFkah4t3SqpqsGwyknZZL1PmzirJQADnjzreuzDJ+t8JaZHbI+v4rcnQUFw08
 rnsBT0bi3wM0YW5QI3gttcGhQdgLFDb7sl9WaTMikmwNqfa1WDCMgcn3i1qa7ZH0wrmvSsF
 8A6/qZ9YIIdiBE52l/y1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KVirG8aMmc0=:rBACIVGmhAx+hUDBbbyay9
 6eMUai4KIIVagd6kG5CkZGvYJW/w2WeHr4zclH+5zmKoqrTe+EOJcl+EjRbePkTnaOVftN3MY
 9JA3ltLCVC8AI7H32aCLwp+7fAS8VQVglOf7Rprn2pR+qj5KQDI6UNZEF66EOVsrmFMUggcxk
 l8BHQ5kEb7jul9DZVtqMquCMJSE9AzOL4fjJ+m+D6D6ZaNoc/HohkzscvEdsimdHlW8BlMZJr
 nZQrlOLN5Rfqykjz9GWawH1QSFitqremaintvCG+H9j0uVALIe61g5MApIt4whuSyYbw0vWQN
 HimKyMYUdXkqHtdWL4qLI8hvxahSFy7Js/9Fa4XhqyNHsMxr4cOXAfMJi33uAYcgDqKcgBAGW
 nMA3RbKgkyTAVBkqk+Huyoiq6m3o1BGdqLI3g1xZHmxUhDDfrMbUf47SYFnZmrCQTzThug+iH
 59VEEWWMJxDpd0DS/Q4ZBSk7NsR+nRCWPflGrSS76el6HRA/JgMzqDs6ieA4zI5Pg/gHJcyBC
 ZGcpX9jbmLhxRTGHlWoYRnCUMIUBDqrL6p8w2o7SnGwPZEzsTA5O0GinewetTWBaB+bKXIB88
 4lZyLGAvFNAtDov8vCeI0SA5ouSaDDPp/8J2+OtWPgWaJKuJbxFARUFKrPfCEiUNkirtfBlDv
 6bBUVya4MuoBMbH1MhwPmxoDUIEtvRJHpa1HsJOUx4A8eCc4PXY7MoeeHrReY3ribJeQ4T6r8
 33hjcKNpsZZ0yg9fR8/5ypJ+9KMTf6A7QWxrV1trDcZafmPrbI3eEjXUU1leLBR+kDs24mKgr
 jBX/6/bRuBFgqLIGW2GavwNiCom3iPBAGGZ4b5tuT5GrsftHQoYY3WavXqyXOTRUzupKZmk
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/02/2020 à 16:35, Alex Williamson a écrit :
> On Fri, 14 Feb 2020 10:55:19 +0100
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>> In a few places we report errno formatted as a negative integer.
>> This is not as user friendly as it can be. Use strerror() and/or
>> error_setg_errno() instead.
>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>> ---
>>
>> v1 posted here:
>>
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-02/msg03623.html
>>
>> diff to v1:
>>  - Change error reporting in vfio_dma_unmap() too as I missed it in v1.
>>
>>  hw/vfio/common.c    | 4 ++--
>>  util/vfio-helpers.c | 6 +++---
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 5ca11488d6..0b3593b3c0 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -319,7 +319,7 @@ static int vfio_dma_unmap(VFIOContainer *container,
>>              unmap.size -= 1ULL << ctz64(container->pgsizes);
>>              continue;
>>          }
>> -        error_report("VFIO_UNMAP_DMA: %d", -errno);
>> +        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>>          return -errno;
>>      }
>>  
>> @@ -352,7 +352,7 @@ static int vfio_dma_map(VFIOContainer *container, hwaddr iova,
>>          return 0;
>>      }
>>  
>> -    error_report("VFIO_MAP_DMA: %d", -errno);
>> +    error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>>      return -errno;
>>  }
>>  
>> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
>> index 813f7ec564..ddd9a96e76 100644
>> --- a/util/vfio-helpers.c
>> +++ b/util/vfio-helpers.c
>> @@ -545,7 +545,7 @@ static int qemu_vfio_do_mapping(QEMUVFIOState *s, void *host, size_t size,
>>      trace_qemu_vfio_do_mapping(s, host, size, iova);
>>  
>>      if (ioctl(s->container, VFIO_IOMMU_MAP_DMA, &dma_map)) {
>> -        error_report("VFIO_MAP_DMA: %d", -errno);
>> +        error_report("VFIO_MAP_DMA failed: %s", strerror(errno));
>>          return -errno;
>>      }
>>      return 0;
>> @@ -570,7 +570,7 @@ static void qemu_vfio_undo_mapping(QEMUVFIOState *s, IOVAMapping *mapping,
>>      assert(QEMU_IS_ALIGNED(mapping->size, qemu_real_host_page_size));
>>      assert(index >= 0 && index < s->nr_mappings);
>>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>> -        error_setg(errp, "VFIO_UNMAP_DMA failed: %d", -errno);
>> +        error_setg_errno(errp, errno, "VFIO_UNMAP_DMA failed");
>>      }
>>      memmove(mapping, &s->mappings[index + 1],
>>              sizeof(s->mappings[0]) * (s->nr_mappings - index - 1));
>> @@ -669,7 +669,7 @@ int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s)
>>      trace_qemu_vfio_dma_reset_temporary(s);
>>      qemu_mutex_lock(&s->lock);
>>      if (ioctl(s->container, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
>> -        error_report("VFIO_UNMAP_DMA: %d", -errno);
>> +        error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
>>          qemu_mutex_unlock(&s->lock);
>>          return -errno;
>>      }
> 
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> 
> (hoping this gets grabbed by trivial)
> 

Applied to my trivial patches branch.

Thanks,
Laurent


