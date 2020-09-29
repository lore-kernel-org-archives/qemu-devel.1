Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF39CC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C117D20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 05:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C117D20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN8BG-0003vr-OU
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 01:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kN8AX-0003TN-16
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:27:17 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:46277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kN8AT-0001dd-NT
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 01:27:16 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.87])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 38BC75FDCC34;
 Tue, 29 Sep 2020 07:27:09 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 29 Sep
 2020 07:27:08 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004bb8b70bf-f44d-47fb-b353-81286667e787,
 4428530637A136A7CA2568ACF4520F889EBAB627) smtp.auth=clg@kaod.org
Subject: Re: [RFC 0/3] QEMU as IPMI BMC emulator
To: Havard Skinnemoen <hskinnemoen@google.com>, <qemu-devel@nongnu.org>
References: <20200929003916.4183696-1-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c6d40849-7c80-9cd1-0a31-696f1175d463@kaod.org>
Date: Tue, 29 Sep 2020 07:27:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200929003916.4183696-1-hskinnemoen@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 46d928fa-8646-405b-8626-eac1cad598e3
X-Ovh-Tracer-Id: 14243759724226972463
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrvdejgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefggeehhfdtkefhteeghfeghefgudfhteevteeltefgffevhfeggeffhfevleelfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehhshhkihhnnhgvmhhovghnsehgohhoghhlvgdrtghomh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 01:27:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 venture@google.com, wuhaotsh@google.com, kfting@nuvoton.com,
 Avi.Fishman@nuvoton.com, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 2:39 AM, Havard Skinnemoen wrote:
> This series briefly documents the existing IPMI device support for main
> processor emulation, and goes on to propose a similar device structure to
> emulate IPMI responder devices in BMC machines. This would allow a qemu
> instance running BMC firmware to serve as an external BMC for a qemu instance
> running server software.

Great idea ! 

I started working on this topic some years ago with the QEMU PowerNV machine 
and the Aspeed machine. They can communicate over network with this iBT device 
patch :

  https://github.com/legoater/qemu/commit/3677ee52f75065b0f65f36382a62f080ac74d683

This is good enough for the IPMI needs of OpenPOWER systems but the overall
system lacks a few bus. An important one being the LPC bus which we use for 
PNOR mappings.

So, we added a little PNOR device in the QEMU PowerNV machine and mapped
its contents in the FW address space of the LPC bus. With the internal IPMI 
BMC simulator, it mimics well enough an OpenPOWER system from the host 
perspective.

All this to say, that if the goal is full system emulation, we should may 
be take another approach and work on the QEMU internals to run multiple 
architectures in the same QEMU binary. 

According to Peter, this is mostly a configure/build issue and cleanups
are needed to remove the assumptions that were done with single arch
binaries. A big task but not necessarily difficult. I will help for 
ARM and PPC ! 


Anyhow, the IPMI documentation you provided is good to have. 

Thanks,

C. 



> RFC only at this point because the series does not include actual code to
> implement this. I'd appreciate some initial feedback on
> 
> 1. Whether anyone else is interested in something like this.
> 2. Completeness (i.e. anything that could be explained in more detail in the
>    docs).
> 3. Naming, and whether 'specs' is the right place to put this.
> 4. Whether it's OK to enable the blockdiag sphinx extension (if not, I'll just
>    toss the block diagrams and turn the docs into walls of text).
> 
> If this seems reasonable, I'll start working with one of my team mates on
> implementing the common part, as well as the Nuvoton-specific responder device.
> Possibly also an Aspeed device.
> 
> Havard Skinnemoen (3):
>   docs: enable sphinx blockdiag extension
>   docs/specs: IPMI device emulation: main processor
>   docs/specs: IPMI device emulation: BMC
> 
>  docs/conf.py         |   5 +-
>  docs/specs/index.rst |   1 +
>  docs/specs/ipmi.rst  | 183 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 docs/specs/ipmi.rst
> 


