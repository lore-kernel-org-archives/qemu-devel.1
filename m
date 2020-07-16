Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD90207F9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD90207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzqd-0003HD-Hj
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvzpi-00023h-QJ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:05:38 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:45861)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jvzpe-0003jQ-MP
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:05:38 -0400
Received: from player696.ha.ovh.net (unknown [10.110.171.136])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id CAFA61D0A66
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 11:05:24 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-1163-216.w90-76.abo.wanadoo.fr
 [90.76.222.216]) (Authenticated sender: clg@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id C434A146F937B;
 Thu, 16 Jul 2020 09:05:07 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0057fe97b6c-7dff-48ac-8a1d-18a5fa079438,2A9D1999911B15737EB689736E4AAE1772229697)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
 <20200701124836.GD2030@perard.uk.xensource.com>
 <20200702063310-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0a9c7f42-c6e3-4103-febc-3811319341d9@kaod.org>
Date: Thu, 16 Jul 2020 11:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702063310-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1753026158128892848
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeggdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhephfffgeelfeejudevuedvvdeigeduteetveffhfffudeggfegleeljeeuieefuedvnecukfhppedtrddtrddtrddtpdeltddrjeeirddvvddvrddvudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=87.98.179.142; envelope-from=clg@kaod.org;
 helo=17.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 05:05:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 1:12 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 01, 2020 at 01:48:36PM +0100, Anthony PERARD wrote:
>> On Wed, Jul 01, 2020 at 08:01:55AM -0400, Michael S. Tsirkin wrote:
>>> On Wed, Jul 01, 2020 at 12:05:49PM +0100, Anthony PERARD wrote:
>>>> The ACPI spec state that "Accesses to PM1 control registers are
>>>> accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
>>>> Control Registers of my old spec copy rev 4.0a).
>>>>
>>>> With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
>>>> sizes in memory_region_access_valid""), it wasn't possible anymore to
>>>> access the pm1_cnt register by reading a single byte, and that is use
>>>> by at least a Xen firmware called "hvmloader".
>>>>
>>>> Also, take care of the PM1 Status Registers which also have "Accesses
>>>> to the PM1 status registers are done through byte or word accesses"
>>>> (In section 4.7.3.1.1 PM1 Status Registers).
>>>>
>>>> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
>>>
>>>
>>> Can't we set impl.min_access_size to convert byte accesses
>>> to word accesses?
>>
>> I actually tried, but when reading `addr` or `addr+1` I had the same
>> value. So I guess `addr` wasn't taken into account.
>>
>> I've checked again, with `.impl.min_access_size = 2`, the width that the
>> function acpi_pm_cnt_read() get is 2, but addr isn't changed so the
>> function is still supposed to shift the result (or the value to write)
>> based on addr, I guess.
> 
> True address is misaligned.  I think memory core should just align it -
> this is what devices seem to expect.
> However result is shifted properly so just align addr and be done with
> it.
> 
> 
> In fact I have a couple more questions. Paolo - maybe you can answer some of these?
> 
> 
> 
>     if (!access_size_min) {
>         access_size_min = 1;
>     }
>     if (!access_size_max) {
>         access_size_max = 4;
>     }
> 
>>>>>
> 
> So 8 byte accesses are split up unless one requests 8 bytes.
> Undocumented right?  Why are we doing this?
> 
>>>>>
> 
> 
>     /* FIXME: support unaligned access? */
> 
>>>>>
> 
> Shouldn't we document impl.unaligned is ignored right now?
> Shouldn't we do something to make sure callbacks do not get
> unaligned accesses they don't expect?
> 
> 
> In fact, there are just 2 devices which set valid.unaligned but
> not impl.unaligned:
>     aspeed_smc_ops
>     raven_io_ops
> 
> 
> Is this intentional? 

I think it is a leftover from the initial implementation. The model works fine 
without valid.unaligned being set and with your patch.

C. 
 

> Do these in fact expect memory core to
> provide aligned addresses to the callbacks?
> Given impl.unaligned is not implemented, can we drop it completely?
> Cc a bunch of people who might know.
> 
> Can relevant maintainers please comment? Thanks a lot!
> 
>>>>>
> 
> 
>     access_size = MAX(MIN(size, access_size_max), access_size_min);
>     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
> 
>>>>>
> 
> 
> So with a 1 byte access at address 1, with impl.min_access_size = 2, we get:
>     access_size = 2
>     access_mask = 0xffff
>     addr = 1
> 
> 
> 
> <<<<
> 
> 
>     if (memory_region_big_endian(mr)) {
>         for (i = 0; i < size; i += access_size) {
>             r |= access_fn(mr, addr + i, value, access_size,
>                         (size - access_size - i) * 8, access_mask, attrs);
> 
>>>>
> 
> now shift is -8.
> 
> <<<<
> 
> 
>         }
>     } else {
>         for (i = 0; i < size; i += access_size) {
>             r |= access_fn(mr, addr + i, value, access_size, i * 8,
>                         access_mask, attrs);
>         }
>     }
> 
> 
> <<<<
> 
> callback is invoked with addr 1 and size 2:
> 
>>>>>
> 
> 
>     uint64_t tmp;
> 
>     tmp = mr->ops->read(mr->opaque, addr, size);
>     if (mr->subpage) {
>         trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
>     } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
>         hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
>         trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
>     }
>     memory_region_shift_read_access(value, shift, mask, tmp);
>     return MEMTX_OK;
> 
> <<<<
> 
> let's assume callback returned 0xabcd
> 
> this is where we are shifting the return value:
> 
>>>>>
> 
> 
> static inline void memory_region_shift_read_access(uint64_t *value,
>                                                    signed shift,
>                                                    uint64_t mask,
>                                                    uint64_t tmp)
> {
>     if (shift >= 0) {
>         *value |= (tmp & mask) << shift;
>     } else {
>         *value |= (tmp & mask) >> -shift;
>     }
> }
> 
> 
> So we do 0xabcd & 0xffff >> 8, and we get 0xab.
> 
>>>>
> 
> How about aligning address for now? Paolo?
> 
> -->
> 
> memory: align to min access size
> 
> If impl.min_access_size > valid.min_access_size access callbacks
> can get a misaligned access as size is increased.
> They don't expect that, let's fix it in the memory core.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ---
> 
> 
> diff --git a/memory.c b/memory.c
> index 9200b20130..ea489ce405 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -532,6 +532,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
>      }
>  
>      /* FIXME: support unaligned access? */
> +    addr &= ~(access_size_min - 1);
>      access_size = MAX(MIN(size, access_size_max), access_size_min);
>      access_mask = MAKE_64BIT_MASK(0, access_size * 8);
>      if (memory_region_big_endian(mr)) {
>> -- 
>> Anthony PERARD
> 


