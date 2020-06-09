Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61114C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C1F5206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1F5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiibP-0003FI-H1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jiiYT-0001A1-Dm; Tue, 09 Jun 2020 14:00:57 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jiiYR-0001ir-Vk; Tue, 09 Jun 2020 14:00:56 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MV5rK-1jYE9b3JTi-00S3Yi; Tue, 09 Jun 2020 20:00:46 +0200
Subject: Re: [PATCH v2] hw/vfio/common: Trace in which mode an IOMMU is opened
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200527155555.6833-1-philmd@redhat.com>
 <b687dd06-490d-dde9-53cc-aa05f38f769e@vivier.eu>
 <20200609113326.100e74fe@w520.home>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <96157697-54d8-bd66-8212-67225069efaf@vivier.eu>
Date: Tue, 9 Jun 2020 20:00:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609113326.100e74fe@w520.home>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Us/mdpKiTsowUFsgrbBBUx4fbsqslKnI5APIKrteeuT75SZqnyJ
 ynBoNRF0Xy3fmvGm4jqLl9gzI510vSXMaujbcIxQj7U7BpLJzfX2eduH6nCBTFn456uLHUk
 lGpeDHq+Cc7ukSeX3OKwKU9EYkIxZFnqr2xNuZ8gwi/RoYXKnYHrm7Wj0pHHHnapDU/1gXU
 VUDAEb62Uc2wEC1kuf2Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Czjl+PpuvE=:pLE8O2L2Sfkm5lCME3n0JA
 w9ngtPJ3ua2G0Bo+P5SvKhRvfzQQNfQB+p8ktev3zyQP797nbKuVX+wndnPQGhRcWUFyB09OH
 FzxGx54ajCe2r3PRo0O73sxdbEuy9Mpk16VBKJg077RUFxinqZ309vKP33eviqYCtjtP4XiJW
 vlhoc7xA/qKafL+/rSkJ2L2Nml6L8HD2FzYnqGMK/6tSdNPbJE9DvGKPwd+0uGUW4oEYfpmxb
 eZaJu3ZdeLw8QZ97Xhsfo/MGb7xWdQFs2VO6eGoDXdgoHtHTv+YoaJTYxM4A6ZMrLa8EiAeFA
 JhhXq3YmU0irA1jSWEbjr1j3dLF1TQHJsdT2ARqwVMitVs4lCZP4Hyf7Td4gulh9MYq9EI3A6
 Fs4V/2pLY3JKinPQWwtQiKySUfUnlmqsGPeaHJFg4hkB6gU3zy+YBZcKn8jsp+bIEe+xu4Dlw
 8+3dsLW8KJHP18n3YHymN8KhWfCxFUx4wML3Wd2w2BsLbJc0j53cf3GNVwN3tRRzWhM+zmEUD
 JMIAJuGKeeuU4H7J/gOT4o/F6//D86r20C5qYEvGkl6xzBrCoxOE3IH1YbZTXNqUy6i7xOE1+
 htjc2bybrtu0giSy81/YKsCWdd/yHJ7R6hkorBOPyZgugPsCuyDb10j3ahsQkFakyGty5G9Wp
 f/20uvwyIxPQ4DWMj8oKOjOeq8nhYf84PI+0atSPKHMMtwa1H0d8PODukITAalHbkMJCZWY00
 xCqtWdlkgh06deVFWhM8dWv9ezboj87Mip///2iKmT0PzrMFvsM03j077WRtdAaJTGWeKFmWf
 t5wCTpRXiHrGx9KjfT1ppNNo0cxenERzqq7bCQpTyTvF44AZZU=
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 13:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/06/2020 à 19:33, Alex Williamson a écrit :
> On Tue, 9 Jun 2020 19:23:32 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> Le 27/05/2020 à 17:55, Philippe Mathieu-Daudé a écrit :
>>> One might want to check which IOMMU version the host kernel
>>> provide. Add a trace event to see in which mode we opened
>>> our container.
>>>
>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>> v2: Only display string description (Eric)
>>>
>>> Supersedes: <20200526173542.28710-1-philmd@redhat.com>
>>> ---
>>>  hw/vfio/common.c     | 19 ++++++++++++++-----
>>>  hw/vfio/trace-events |  1 +
>>>  2 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index 0b3593b3c0..f24450472e 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -1157,15 +1157,24 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
>>>  static int vfio_get_iommu_type(VFIOContainer *container,
>>>                                 Error **errp)
>>>  {
>>> -    int iommu_types[] = { VFIO_TYPE1v2_IOMMU, VFIO_TYPE1_IOMMU,
>>> -                          VFIO_SPAPR_TCE_v2_IOMMU, VFIO_SPAPR_TCE_IOMMU };
>>> +    static const struct {
>>> +        int type;
>>> +        const char *name;
>>> +    } iommu[] = {
>>> +        {VFIO_TYPE1v2_IOMMU, "Type1 (v2)"},
>>> +        {VFIO_TYPE1_IOMMU, "Type1 (v1)"},
>>> +        {VFIO_SPAPR_TCE_v2_IOMMU, "sPAPR TCE (v2)"},
>>> +        {VFIO_SPAPR_TCE_IOMMU, "sPAPR TCE (v1)"}
>>> +    };
>>>      int i;
>>>  
>>> -    for (i = 0; i < ARRAY_SIZE(iommu_types); i++) {
>>> -        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu_types[i])) {
>>> -            return iommu_types[i];
>>> +    for (i = 0; i < ARRAY_SIZE(iommu); i++) {
>>> +        if (ioctl(container->fd, VFIO_CHECK_EXTENSION, iommu[i].type)) {
>>> +            trace_vfio_get_iommu_type(iommu[i].name);
>>> +            return iommu[i].type;
>>>          }
>>>      }
>>> +    trace_vfio_get_iommu_type("Not available or not supported");
>>>      error_setg(errp, "No available IOMMU models");
>>>      return -EINVAL;
>>>  }
>>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>>> index b1ef55a33f..d3f1e48618 100644
>>> --- a/hw/vfio/trace-events
>>> +++ b/hw/vfio/trace-events
>>> @@ -115,6 +115,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>>>  vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>>>  vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%0x8"
>>>  vfio_dma_unmap_overflow_workaround(void) ""
>>> +vfio_get_iommu_type(const char *type) "IOMMU type: %s"
>>>  
>>>  # platform.c
>>>  vfio_platform_base_device_init(char *name, int groupid) "%s belongs to group #%d"
>>>   
>>
>> Applied to my trivial-patches branch.
> 
> I was not actually a fan of this patch:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08144.html

I missed it as v1 was not sent to qemu-trivial.

> I don't think the convenience to the trace user to avoid looking up the
> type string in the header is worth the bloat to the non-trace user to
> declare these strings in the code.  Thanks,
> 

Understood. Removed.

Thanks,
Laurent


