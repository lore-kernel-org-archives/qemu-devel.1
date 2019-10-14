Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03AC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30255207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 09:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30255207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJwF0-00071a-79
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 05:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iJwDp-0006L6-UU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iJwDn-0005SU-RS
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iJwDd-00056C-Gh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 05:00:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90090308FBA0;
 Mon, 14 Oct 2019 09:00:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CA9460A97;
 Mon, 14 Oct 2019 09:00:31 +0000 (UTC)
Date: Mon, 14 Oct 2019 11:00:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v12 09/11] hmat acpi: Build System Locality Latency and
 Bandwidth Information Structure(s)
Message-ID: <20191014110030.79fd2e18@redhat.com>
In-Reply-To: <7f431c7c-b745-3001-d0ba-d94f7230b426@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
 <20190920074349.2616-10-tao3.xu@intel.com>
 <20191003164111.078fdce4@redhat.com>
 <24a4842c-4ce4-3a7f-5032-8e74458de44c@intel.com>
 <20191011160855.6d13eb69@redhat.com>
 <7f431c7c-b745-3001-d0ba-d94f7230b426@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 14 Oct 2019 09:00:33 +0000 (UTC)
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 12 Oct 2019 11:04:03 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> On 10/11/2019 10:08 PM, Igor Mammedov wrote:
> > On Thu, 10 Oct 2019 14:53:56 +0800
> > Tao Xu <tao3.xu@intel.com> wrote:
> >   
> >> On 10/3/2019 10:41 PM, Igor Mammedov wrote:  
> >>> On Fri, 20 Sep 2019 15:43:47 +0800
> >>> Tao Xu <tao3.xu@intel.com> wrote:
> >>>      
> >>>> From: Liu Jingqi <jingqi.liu@intel.com>
> >>>>
> >>>> This structure describes the memory access latency and bandwidth
> >>>> information from various memory access initiator proximity domains.
> >>>> The latency and bandwidth numbers represented in this structure
> >>>> correspond to rated latency and bandwidth for the platform.
> >>>> The software could use this information as hint for optimization.
> >>>>
> >>>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
> >>>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> >>>> ---
> >>>>
> >>>> Changes in v12:
> >>>>       - Fix a bug that if HMAT is enabled and without hmat-lb setting,
> >>>>         QEMU will crash. (reported by Danmei Wei)
> >>>>
> >>>> Changes in v11:
> >>>>       - Calculate base in build_hmat_lb().
> >>>> ---
> >>>>    hw/acpi/hmat.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>>    hw/acpi/hmat.h |   2 +
> >>>>    2 files changed, 127 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> >>>> index 1368fce7ee..e7be849581 100644
> >>>> --- a/hw/acpi/hmat.c
> >>>> +++ b/hw/acpi/hmat.c
> >>>> @@ -27,6 +27,7 @@
> >>>>    #include "qemu/osdep.h"
> >>>>    #include "sysemu/numa.h"
> >>>>    #include "hw/acpi/hmat.h"
> >>>> +#include "qemu/error-report.h"
> >>>>    
> >>>>    /*
> >>>>     * ACPI 6.3:
> >>>> @@ -67,11 +68,105 @@ static void build_hmat_mpda(GArray *table_data, uint16_t flags, int initiator,
> >>>>        build_append_int_noprefix(table_data, 0, 8);
> >>>>    }
> >>>>    
> >>>> +static bool entry_overflow(uint64_t *lb_data, uint64_t base, int len)
> >>>> +{
> >>>> +    int i;
> >>>> +
> >>>> +    for (i = 0; i < len; i++) {
> >>>> +        if (lb_data[i] / base >= UINT16_MAX) {
> >>>> +            return true;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    return false;
> >>>> +}  
> >>> I suggest to do this check at CLI parsing time
> >>>      
> >>>> +/*
> >>>> + * ACPI 6.3: 5.2.27.4 System Locality Latency and Bandwidth Information
> >>>> + * Structure: Table 5-146
> >>>> + */
> >>>> +static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
> >>>> +                          uint32_t num_initiator, uint32_t num_target,
> >>>> +                          uint32_t *initiator_list, int type)
> >>>> +{
> >>>> +    uint8_t mask = 0x0f;
> >>>> +    uint32_t s = num_initiator;
> >>>> +    uint32_t t = num_target;  
> >>> drop this locals and use arguments directly
> >>>      
> >>>> +    uint64_t base = 1;
> >>>> +    uint64_t *lb_data;
> >>>> +    int i, unit;
> >>>> +
> >>>> +    /* Type */
> >>>> +    build_append_int_noprefix(table_data, 1, 2);
> >>>> +    /* Reserved */
> >>>> +    build_append_int_noprefix(table_data, 0, 2);
> >>>> +    /* Length */
> >>>> +    build_append_int_noprefix(table_data, 32 + 4 * s + 4 * t + 2 * s * t, 4);  
> >>>                                                ^^^^
> >>> to me above looks like /dev/random output, absolutely unreadable.
> >>> Suggest to use local var (like: lb_length) for expression with comments
> >>> beside magic numbers.
> >>>      
> >>>> +    /* Flags: Bits [3:0] Memory Hierarchy, Bits[7:4] Reserved */
> >>>> +    build_append_int_noprefix(table_data, hmat_lb->hierarchy & mask, 1);  
> >>>
> >>> why do you need to use mask here?
> >>>      
> >> Because Bits[7:4] Reserved, so I use mask to keep it reserved.  
> > 
> > these bits are not user provided and set to 0, if they get set it's
> > programming error and instead of masking problem out QEMU should abort,
> > I suggest replace masking with assert(!foo>>x).
> >   
> >>  
> >>>> +    /* Data Type */
> >>>> +    build_append_int_noprefix(table_data, hmat_lb->data_type, 1);  
> >>>
> >>> Isn't hmat_lb->data_type and passed argument 'type' the same?
> >>>      
> >> Yes, I will drop 'type'.  
> >>>      
> >>>> +    /* Reserved */
> >>>> +    build_append_int_noprefix(table_data, 0, 2);
> >>>> +    /* Number of Initiator Proximity Domains (s) */
> >>>> +    build_append_int_noprefix(table_data, s, 4);
> >>>> +    /* Number of Target Proximity Domains (t) */
> >>>> +    build_append_int_noprefix(table_data, t, 4);
> >>>> +    /* Reserved */
> >>>> +    build_append_int_noprefix(table_data, 0, 4);
> >>>> +
> >>>> +    if (HMAT_IS_LATENCY(type)) {
> >>>> +        unit = 1000;
> >>>> +        lb_data = hmat_lb->latency;
> >>>> +    } else {
> >>>> +        unit = 1024;
> >>>> +        lb_data = hmat_lb->bandwidth;
> >>>> +    }
> >>>> +
> >>>> +    while (entry_overflow(lb_data, base, s * t)) {
> >>>> +        for (i = 0; i < s * t; i++) {
> >>>> +            if (!QEMU_IS_ALIGNED(lb_data[i], unit * base)) {
> >>>> +                error_report("Invalid latency/bandwidth input, all "
> >>>> +                "latencies/bandwidths should be specified in the same units.");
> >>>> +                exit(1);
> >>>> +            }
> >>>> +        }
> >>>> +        base *= unit;
> >>>> +    }  
> >>> Can you clarify what you are trying to check here?
> >>>      
> >> This part I use entry_overflow() to check if uint16 can store entry. If
> >> can't store and the entries matrix can be divisible by unit * base, then
> >> base will be unit * base.
> >>
> >> For example, if lb_data[i] are 1048576(1TB/s) and 1024(1GB/s), unit is
> >> 1024, so 1048576 is bigger than UINT16_MAX, and can be divisible by 1024
> >> * 1, so base is 1024 and entries are 1024 and 1 (see entry =
> >> hmat_lb->latency[i] / base;). The benefit is even user input different
> >> unit(TB/s vs GB/s), we can still store the data as far as possible.  
> > 
> > Is it possible instead of doing multiple iterations over lb_data
> > until it finds valid base, just go over lb_data once to find MIN/MAX
> > and then calculate base using it. Error out with max/min offending
> > values if it's not possible to compress the range into uint16_t?
> >   
> 
> Although we tell user input same unit data, such as use 1GB/s 3GB/s. If 
> user input data such as 1048575, 1048576(1TB/s) and 1024(1GB/s), then we 
> will get 1024 * (1023 1024 1). I am wondering if it is appropriate 
> because we lose a float number(0.999020). But in our codes, it will 
> raise error. 
I do not understand what you are trying to say here, could you rephrase
it, so the problem would be more clear, please?


