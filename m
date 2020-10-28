Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C7DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C120221481
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/dUga3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C120221481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXipX-0004SN-Qf
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXioZ-0003tk-Or
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kXioX-0001en-UB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603881381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5QNlPmdegRYQwB9v0jcqOrbyH84b/7edz4PBHQHFB2k=;
 b=J/dUga3BOqhExrzWNDwcoz8Eruv+TzDAQethSGVa1NG64jJCRy5J52Krv1DG5AebHSTxl8
 ZAfIule+FmPFLr3oT/KOp3qlUuMEtplL4RFcR9M21EFKjpetF58rwjWEVPK1mUh/LOxRtQ
 4YeDugik3GH0mKWANCJv4xpuRrUQ1d0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-kigi2BidOx6iIvXdq7p9NQ-1; Wed, 28 Oct 2020 06:36:19 -0400
X-MC-Unique: kigi2BidOx6iIvXdq7p9NQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01A2880B738;
 Wed, 28 Oct 2020 10:36:18 +0000 (UTC)
Received: from [10.36.112.194] (ovpn-112-194.ams2.redhat.com [10.36.112.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 914CB5B4BC;
 Wed, 28 Oct 2020 10:36:12 +0000 (UTC)
Subject: Re: [PATCH 04/25] block/nvme: Trace controller capabilities
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-5-philmd@redhat.com>
 <1d71f170-3681-e923-da32-581f90262be1@redhat.com>
 <55af0d24-a98b-840f-c60d-e290c6cbeee3@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d07d0730-311a-5026-ca39-55aba2a57a97@redhat.com>
Date: Wed, 28 Oct 2020 11:36:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <55af0d24-a98b-840f-c60d-e290c6cbeee3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,
On 10/28/20 11:25 AM, Philippe Mathieu-Daudé wrote:
> On 10/28/20 11:20 AM, Auger Eric wrote:
>> Hi Philippe,
>>
>> On 10/27/20 2:55 PM, Philippe Mathieu-Daudé wrote:
>>> Controllers have different capabilities and report them in the
>>> CAP register. We are particularly interested by the page size
>>> limits.
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  block/nvme.c       | 13 +++++++++++++
>>>  block/trace-events |  2 ++
>>>  2 files changed, 15 insertions(+)
>>>
>>> diff --git a/block/nvme.c b/block/nvme.c
>>> index 6f1d7f9b2a1..361b5772b7a 100644
>>> --- a/block/nvme.c
>>> +++ b/block/nvme.c
>>> @@ -727,6 +727,19 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>>>       * Initialization". */
>>>  
>>>      cap = le64_to_cpu(regs->cap);
>>> +    trace_nvme_controller_capability_raw(cap);
>>> +    trace_nvme_controller_capability("Maximum Queue Entries Supported",
>>> +                                     1 + NVME_CAP_MQES(cap));
>>> +    trace_nvme_controller_capability("Contiguous Queues Required",
>>> +                                     NVME_CAP_CQR(cap));
>> I think this should be +1 too (0's based value)
> 
> This is a boolean:
> 
>   Contiguous Queues Required (CQR): This field is set to ‘1’ if
>   the controller requires that I/O Submission Queues and I/O
>   Completion Queues are required to be physically contiguous.
>   This field is cleared to ‘0’ if the controller supports I/O
>   Submission Queues and I/O Completion Queues that are not
>   physically contiguous. If this field is set to ‘1’, then the
>   Physically Contiguous bit (CDW11.PC) in the Create I/O Submission
>   Queue and Create I/O Completion Queue commands shall be set to ‘1’.

Oh I mixed with NCQR :-(

sorry for the noise
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> 
>>> +    trace_nvme_controller_capability("Doorbell Stride",
>>> +                                     2 << (2 + NVME_CAP_DSTRD(cap)));
>>> +    trace_nvme_controller_capability("Subsystem Reset Supported",
>>> +                                     NVME_CAP_NSSRS(cap));
>>> +    trace_nvme_controller_capability("Memory Page Size Minimum",
>>> +                                     1 << (12 + NVME_CAP_MPSMIN(cap)));
>>> +    trace_nvme_controller_capability("Memory Page Size Maximum",
>>> +                                     1 << (12 + NVME_CAP_MPSMAX(cap)));
>>>      if (!NVME_CAP_CSS(cap)) {
>>>          error_setg(errp, "Device doesn't support NVMe command set");
>>>          ret = -EINVAL;
>>> diff --git a/block/trace-events b/block/trace-events
>>> index 0955c85c783..b90b07b15fa 100644
>>> --- a/block/trace-events
>>> +++ b/block/trace-events
>>> @@ -134,6 +134,8 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
>>>  qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
>>>  
>>>  # nvme.c
>>> +nvme_controller_capability_raw(uint64_t value) "0x%08"PRIx64
>>> +nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
>>>  nvme_kick(void *s, int queue) "s %p queue %d"
>>>  nvme_dma_flush_queue_wait(void *s) "s %p"
>>>  nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
>>>
>> Besides
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks
>>
>> Eric
>>
> 
> 


