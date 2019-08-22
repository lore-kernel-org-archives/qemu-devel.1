Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B198C3A5A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24628233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24628233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0orE-0006eN-2C
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1i0onX-000524-BF
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1i0onT-00069E-I1
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1i0onN-00062p-PX; Thu, 22 Aug 2019 11:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0557310576D9;
 Thu, 22 Aug 2019 15:14:37 +0000 (UTC)
Received: from [10.36.116.105] (ovpn-116-105.ams2.redhat.com [10.36.116.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 005EB5D9D3;
 Thu, 22 Aug 2019 15:14:30 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190711061857.13086-1-eric.auger@redhat.com>
 <20190711061857.13086-6-eric.auger@redhat.com>
 <CAFEAcA_N=7w6XHU4H3uJhLFZuiFgpQhN--=ixUV7z6bvzkwqfQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cb5509f4-7bb3-6092-87f6-68610bab13c8@redhat.com>
Date: Thu, 22 Aug 2019 17:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_N=7w6XHU4H3uJhLFZuiFgpQhN--=ixUV7z6bvzkwqfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 22 Aug 2019 15:14:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v3 5/5] hw/arm/smmuv3: Remove
 spurious error messages on IOVA invalidations
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 8/5/19 4:39 PM, Peter Maydell wrote:
> On Thu, 11 Jul 2019 at 07:19, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
>> through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.
>>
>> When the notification occurs it is possible that some of the
>> PCIe devices associated to the notified regions do not have a
>> valid stream table entry. In that case we output a LOG_GUEST_ERROR
>> message, for example:
>>
>> invalid sid=<SID> (L1STD span=0)
>> "smmuv3_notify_iova error decoding the configuration for iommu mr=<MR>
>>
>> This is unfortunate as the user gets the impression that there
>> are some translation decoding errors whereas there are not.
>>
>> This patch adds a new field in SMMUEventInfo that tells whether
>> the detection of an invalid STE must lead to an error report.
>> invalid_ste_allowed is set before doing the invalidations and
>> kept unset on actual translation.
>>
>> The other configuration decoding error messages are kept since if the
>> STE is valid then the rest of the config must be correct.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/smmuv3-internal.h |  1 +
>>  hw/arm/smmuv3.c          | 15 ++++++++-------
>>  2 files changed, 9 insertions(+), 7 deletions(-)
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
>> index 2e270a0f07..517755aed5 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -320,7 +320,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>      uint32_t config;
>>
>>      if (!STE_VALID(ste)) {
>> -        qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
>> +        if (!event->inval_ste_allowed) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "invalid STE\n");
>> +        }
> 
> Here the new flag check just suppresses the error log...
> 
>>          goto bad_ste;
>>      }
>>
>> @@ -405,7 +407,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>
>>          span = L1STD_SPAN(&l1std);
>>
>> -        if (!span) {
>> +        if (!span && !event->inval_ste_allowed) {
>>              /* l2ptr is not valid */
>>              qemu_log_mask(LOG_GUEST_ERROR,
>>                            "invalid sid=%d (L1STD span=0)\n", sid);
> 
> ...but here it suppresses both the error logging and also
> the setting of event->type and returning -EINVAL. Instead
> we'll fall through to the following code. Is that really OK?
Sorry for the delay, I was off.

Yes it's wrong I should only suppress the log. Curiously it had no other
impact on the execution while testing.

Thanks

Eric
> 
> thanks
> -- PMM
> 

