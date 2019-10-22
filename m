Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC16CA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5358121920
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5358121920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpWP-0006H4-0f
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45345)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iMpQk-0006xt-Pl
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iMpQi-000277-Ki
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:22:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:9373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iMpQi-00025e-CA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:22:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2019 01:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; d="scan'208";a="227619923"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.6])
 ([10.239.197.6])
 by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2019 01:22:07 -0700
Subject: Re: [PATCH v13 06/12] numa: Extend CLI to provide memory latency and
 bandwidth information
To: Igor Mammedov <imammedo@redhat.com>
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-7-tao3.xu@intel.com>
 <20191022090803.51731313@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <14c72140-7006-d306-81cd-ae71d0331f22@intel.com>
Date: Tue, 22 Oct 2019 16:22:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022090803.51731313@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
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
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/2019 3:08 PM, Igor Mammedov wrote:
> On Sun, 20 Oct 2019 19:11:19 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
>> From: Liu Jingqi <jingqi.liu@intel.com>
>>
>> Add -numa hmat-lb option to provide System Locality Latency and
>> Bandwidth Information. These memory attributes help to build
>> System Locality Latency and Bandwidth Information Structure(s)
>> in ACPI Heterogeneous Memory Attribute Table (HMAT).
>>
>> Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
[...]
>> +void parse_numa_hmat_lb(NumaState *numa_state, NumaHmatLBOptions *node,
>> +                        Error **errp)
>> +{
>> +    int first_bit, last_bit;
>> +    uint64_t temp_latency;
>> +    NodeInfo *numa_info = numa_state->nodes;
>> +    HMAT_LB_Info *hmat_lb =
>> +        numa_state->hmat_lb[node->hierarchy][node->data_type];
>> +    HMAT_LB_Data lb_data;
>> +
>> +    /* Error checking */
>> +    if (node->initiator >= numa_state->num_nodes) {
>> +        error_setg(errp, "Invalid initiator=%d, it should be less than %d.",
>> +                   node->initiator, numa_state->num_nodes);
>> +        return;
>> +    }
>> +    if (node->target >= numa_state->num_nodes) {
>> +        error_setg(errp, "Invalid target=%d, it should be less than %d.",
>> +                   node->target, numa_state->num_nodes);
>> +        return;
>> +    }
>> +    if (!numa_info[node->initiator].has_cpu) {
>> +        error_setg(errp, "Invalid initiator=%d, it isn't an "
>> +                   "initiator proximity domain.", node->initiator);
>> +        return;
>> +    }
>> +    if (!numa_info[node->target].present) {
>> +        error_setg(errp, "Invalid target=%d, it hasn't a valid NUMA node.",
>> +                   node->target);
>> +        return;
>> +    }
>> +
>> +    if (!hmat_lb) {
>> +        hmat_lb = g_malloc0(sizeof(*hmat_lb));
>> +        numa_state->hmat_lb[node->hierarchy][node->data_type] = hmat_lb;
>> +        hmat_lb->latency = g_array_new(false, true, sizeof(HMAT_LB_Data));
>> +        hmat_lb->bandwidth = g_array_new(false, true, sizeof(HMAT_LB_Data));
>> +    }
>> +    hmat_lb->hierarchy = node->hierarchy;
>> +    hmat_lb->data_type = node->data_type;
>> +    lb_data.initiator = node->initiator;
>> +    lb_data.target = node->target;
>> +
>> +    /* Input latency data */
>> +    if (node->data_type <= HMATLB_DATA_TYPE_WRITE_LATENCY) {
>> +        if (!node->has_latency) {
>> +            error_setg(errp, "Missing 'latency' option.");
>> +            return;
>> +        }
>> +        if (node->has_bandwidth) {
>> +            error_setg(errp, "Invalid option 'bandwidth' since "
>> +                       "the data type is latency.");
>> +            return;
>> +        }
>> +
>> +        temp_latency = node->latency;
>> +        hmat_lb->base_latency = 1;
>> +        while (QEMU_IS_ALIGNED(temp_latency, 10)) {
>> +            temp_latency /= 10;
>> +            hmat_lb->base_latency *= 10;
>> +        }
>> +
>> +        if (temp_latency >= UINT64_MAX) {
>                              ^  ^^^^ doesn't make sense
> 
> can't you use range bitmap here as well?
> 
Because the time unit is decimal. For example, if latency are 
1ns(1000ps, bit 0011 1110 1000) and 65534ns(0011 1110 0111 1111 1000 
0011 0000)

0000 0000 0000 0000 0011 1110 1000
0011 1110 0111 1111 1000 0011 0000

Then we can get the first_bit is 3 and last_bit is 25, 25 - 3 > 16.

But if we use 10 to find base, we can find the base is 1000ps, 
compressed latency are 1 and 65534(< UINT16_MAX).


