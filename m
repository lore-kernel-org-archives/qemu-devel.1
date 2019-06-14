Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC8C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E9C21537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9C21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnXY-0007z1-BE
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51694)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hbmhI-0006VE-HN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hbmhG-0001aJ-FD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:56:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hbmh8-0001Po-J3; Fri, 14 Jun 2019 09:56:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C64F8C049E23;
 Fri, 14 Jun 2019 13:56:32 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B98A7AB54;
 Fri, 14 Jun 2019 13:56:25 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-2-eric.auger@redhat.com>
 <CAFEAcA8N_uaq9kbS2MWDtdy1wz-j33OVo4wQbFZxvc-2uyMd0A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b7d5155a-08e2-33c4-8550-4b0821b11585@redhat.com>
Date: Fri, 14 Jun 2019 15:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8N_uaq9kbS2MWDtdy1wz-j33OVo4wQbFZxvc-2uyMd0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 14 Jun 2019 13:56:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/smmuv3: Remove spurious error
 messages on IOVA invalidations
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 6/14/19 3:23 PM, Peter Maydell wrote:
> On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
>> through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.
>>
>> When the notification occurs it is possible that some of the
>> PCIe devices associated to the notified regions do not have a
>> valid stream table entry. In that case we output a LOG_GUEST_ERROR
>> message.
>>
>> invalid sid=<SID> (L1STD span=0)
>> "smmuv3_notify_iova error decoding the configuration for iommu mr=<MR>
>>
>> This is unfortunate as the user gets the impression that there
>> are some translation decoding errors whereas there are not.
>>
>> This patch adds a new field in SMMUEventInfo that tells whether
>> the detction of an invalid STE msut lead to an error report.
>> invalid_ste_allowed is set before doing the invalidations and
>> kept unset on actual translation.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I also experimented to pass Error handles to all the subfunctions
>> and handle the Error at top level but that's intricate to sort
>> out the various kinds of errors, whether they need to be logged,
>> and if so if they match LOG_GUEST_ERRoR mask or unimplemented
>> mask. So I think just passing this boolean has a lesser impact on
>> the code base.
>> ---
>>  hw/arm/smmuv3-internal.h |  1 +
>>  hw/arm/smmuv3.c          | 11 +++++------
>>  2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index b160289cd1..d190181ef1 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -381,6 +381,7 @@ typedef struct SMMUEventInfo {
>>      uint32_t sid;
>>      bool recorded;
>>      bool record_trans_faults;
>> +    bool inval_ste_allowed;
>>      union {
>>          struct {
>>              uint32_t ssid;
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index fd8ec7860e..e2f07d2864 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -404,7 +404,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>
>>          span = L1STD_SPAN(&l1std);
>>
>> -        if (!span) {
>> +        if (!span && !event->inval_ste_allowed) {
>>              /* l2ptr is not valid */
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "invalid sid=%d (L1STD span=0)\n", sid);
> 
> Why is this specific qemu_log_mask() the only one we need
> to suppress ?

I focused on messages related to STE invalidity. This one corresponds to
the 2-level stream table case where the top-level entry is invalid.

In linear stream table case, the STE is fetched in smmu_get_ste(): this
shouldn't fail as the STE table was allocated.  Then its validity is
checked in decode_ste() but up to now there is no tracing if the STE in
not valid. I should revise this in the future though.

Then obviously the config decoding is not over but I considered that if
the STE is valid, the rest of the config should be valid as well. If we
were to detect any error afterwards, those would deserve to be reported.

Thanks

Eric

> 
> thanks
> -- PMM
> 

