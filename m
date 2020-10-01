Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6835C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A474206C1
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A474206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO0ct-0005Nt-FH
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 11:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kO0Vh-0006JF-ER
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:28:49 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kO0Vb-0001gw-UX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:28:43 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.95])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id A428667AE732;
 Thu,  1 Oct 2020 17:28:34 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 1 Oct 2020
 17:28:33 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004a7bdb1ee-9f33-4b8f-a548-6bf85f7ed5d2,
 2FD1C644E9D11323632A639817FC6AC7C89AF497) smtp.auth=clg@kaod.org
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
To: Havard Skinnemoen <hskinnemoen@google.com>
References: <20200929003916.4183696-1-hskinnemoen@google.com>
 <c6d40849-7c80-9cd1-0a31-696f1175d463@kaod.org>
 <CAFQmdRZbhF+BpLK8YVHLOL=Hu-JxcMEoDskidtT8t_j+fHtG6Q@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3c3334cf-1edc-d399-fd63-92ea7835b2a9@kaod.org>
Date: Thu, 1 Oct 2020 17:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFQmdRZbhF+BpLK8YVHLOL=Hu-JxcMEoDskidtT8t_j+fHtG6Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: f072312b-ec1e-4df6-9366-08ecc285a938
X-Ovh-Tracer-Id: 17699709489456843567
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrfeeggdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehuedtheeghfdvhedtueelteegvdefueektdefiefhffffieduuddtudfhgfevtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehhshhkihhnnhgvmhhovghnsehgohhoghhlvgdrtghomh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 10:56:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.26,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, minyard@acm.org,
 Patrick Venture <venture@google.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Hao Wu <wuhaotsh@google.com>, CS20 KFTing <kfting@nuvoton.com>,
 Joel Stanley <joel@jms.id.au>, IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 6:28 PM, Havard Skinnemoen wrote:
> On Mon, Sep 28, 2020 at 10:27 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 9/29/20 2:39 AM, Havard Skinnemoen wrote:
>>> This series briefly documents the existing IPMI device support for main
>>> processor emulation, and goes on to propose a similar device structure to
>>> emulate IPMI responder devices in BMC machines. This would allow a qemu
>>> instance running BMC firmware to serve as an external BMC for a qemu instance
>>> running server software.
>>
>> Great idea !
>>
>> I started working on this topic some years ago with the QEMU PowerNV machine
>> and the Aspeed machine. They can communicate over network with this iBT device
>> patch :
>>
>>   https://github.com/legoater/qemu/commit/3677ee52f75065b0f65f36382a62f080ac74d683
> 
> Oh, cool, if we split that into an Aspeed part and a VM protocol part,
> it's basically what I had in mind. Are you planning to submit that, or
> would it be OK if we base our work on it?

I had no plan to send it any time soon. You can base your work on this patch.

>> This is good enough for the IPMI needs of OpenPOWER systems but the overall
>> system lacks a few bus. An important one being the LPC bus which we use for
>> PNOR mappings.
> 
> Right. Perhaps the next step should be an out-of-process flash protocol?

OpenPOWER systems use the hiomap protocol for that :

  https://github.com/openbmc/hiomapd/blob/master/Documentation/protocol.md#create_read_window-command

It's based on IPMI but the reads are still done from the LPC bus. We would
need a way to transfer the mem ops between processes.  

>> So, we added a little PNOR device in the QEMU PowerNV machine and mapped
>> its contents in the FW address space of the LPC bus. With the internal IPMI
>> BMC simulator, it mimics well enough an OpenPOWER system from the host
>> perspective.
> 
> Cool.
> 
>> All this to say, that if the goal is full system emulation, we should may
>> be take another approach and work on the QEMU internals to run multiple
>> architectures in the same QEMU binary.
> 
> Interesting. Will it be too slow to run the server and BMC in separate
> processes?

No. It will be much simpler to run in a single process I think. Memory
operation, gpio lines can cross borders between architectures.
 
> We might actually be more interested in going the other way and move
> more things out of process, as we start to tackle larger, more complex
> systems.
>
>> According to Peter, this is mostly a configure/build issue and cleanups
>> are needed to remove the assumptions that were done with single arch
>> binaries. A big task but not necessarily difficult. I will help for
>> ARM and PPC !
> 
> It sounds great to have the option to simulate multiple architectures
> in the same process, and getting rid of single-arch assumptions seems
> like a nice cleanup. However, I'm hoping we'll still support
> multi-process system emulation (and the MultiProcessQEMU work seems to
> be moving in that direction as well).

I haven't been following that closely enough but it looked promising.
Having a way to offload mem operations and interrupts should help
modeling in some areas, such as interconnecting external simulators. 
But that might raise some other issues like time control.  

>> Anyhow, the IPMI documentation you provided is good to have.
> 
> If you like, I can split off patch 1-2 (or just 2) and post them
> separately while we work on the BMC-side device emulation. If we
> decide to keep patch 1 and the block diagrams, we probably need to do
> something better for the font path.

These looked good as they were. Were there any objections ? 

Thanks,

C. 


