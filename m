Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C542C20776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C542C20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyHl-0007xQ-PW
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdyGN-0006pw-UC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:46:39 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:46852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdyGM-0002t2-IO
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:46:39 -0400
Received: from player787.ha.ovh.net (unknown [10.108.35.210])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id E36561687C4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 17:46:34 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 7B4AD12F3CB20;
 Wed, 27 May 2020 15:46:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00189d38435-8926-46dd-8a79-012d20428b63,A19C442F5A36D79893466B97850BD964E95F9B50)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v3] arm/aspeed: Rework NIC attachment
To: Markus Armbruster <armbru@redhat.com>
References: <20200527124406.329503-1-clg@kaod.org>
 <87lfldzehq.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d862f70c-aebd-c1f0-ded6-79a85fbc82f2@kaod.org>
Date: Wed, 27 May 2020 17:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87lfldzehq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10041338322796055331
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeffhfffudegjeeggedugeefgeeifffhueethefhfeekkedvkefggfelteefuddvteenucffohhmrghinhepohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.118; envelope-from=clg@kaod.org;
 helo=19.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 11:46:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:36 PM, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> The number of MACs supported by an Aspeed SoC is defined by "macs_num"
>> under the SoC model, that is two for the AST2400 and AST2500 and four
>> for the AST2600. The model initializes the maximum number of supported
>> MACs but the number of realized devices is capped by the number of
>> network device back-ends defined on the command line. This can leave
>> unrealized devices hanging around in the QOM composition tree.
>>
>> Modify the machine initialization to define which MACs are attached to
>> a network device back-end using a bit-field property "macs-mask" and
>> let the SoC realize all network devices.
>>
>> The default setting of "macs-mask" is "use MAC0" only, which works for
>> all our AST2400 and AST2500 machines. The AST2600 machines have
>> different configurations. The AST2600 EVB machine activates MAC1, MAC2
>> and MAC3 and the Tacoma BMC machine activates MAC2.
> 
> Let's be more clear on what this means, and "This is actually a device
> modelling fix for these two machines."  Okay?

Well, I guess so. It's a fix in the way we attach network backends to 
the MACs of the machines. 

On the tacoma-bmc, we had to use '-nic <foo> -nic <bar> -nic <good one>' 
to configure the MAC2 in use by the machine. Which was dubious.

Now, a single -nic is enough.

>> Inactive MACs will have no peer and QEMU may warn the user with :
>>
>>     qemu-system-arm: warning: nic ftgmac100.0 has no peer
>>     qemu-system-arm: warning: nic ftgmac100.1 has no peer
>>     qemu-system-arm: warning: nic ftgmac100.3 has no peer
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Here's the "info qom-tree" change for tacoma-bmc:
> 
>      /machine (tacoma-bmc-machine)
>        /peripheral (container)
>        /peripheral-anon (container)
>        /soc (ast2600-a1)
>          [...]
>          /ftgmac100[0] (ftgmac100)
>            /ftgmac100[0] (qemu:memory-region)
>          /ftgmac100[1] (ftgmac100)
>     +      /ftgmac100[0] (qemu:memory-region)
>          /ftgmac100[2] (ftgmac100)
>     +      /ftgmac100[0] (qemu:memory-region)
>          /ftgmac100[3] (ftgmac100)
>     +      /ftgmac100[0] (qemu:memory-region)

Yes. All are realized now.

>          [...]
>          /mii[0] (aspeed-mmi)
>            /aspeed-mmi[0] (qemu:memory-region)
>          /mii[1] (aspeed-mmi)
>     +      /aspeed-mmi[0] (qemu:memory-region)
>          /mii[2] (aspeed-mmi)
>     +      /aspeed-mmi[0] (qemu:memory-region)
>          /mii[3] (aspeed-mmi)
>     +      /aspeed-mmi[0] (qemu:memory-region)

Same for the MMI interfaces on AST2600.

> These changes are due to realizing MAC1, MAC2, MAC3.  Looks good.
> 
> Here's "info qtree":
> 
>        dev: ftgmac100, id ""
>          gpio-out "sysbus-irq" 1
>          aspeed = true
>     -    mac = "52:54:00:12:34:56"
>     -    netdev = "hub0port0"
>     +    mac = "52:54:00:12:34:57"
>     +    netdev = ""
>          mmio 000000001e660000/0000000000002000
>        dev: ftgmac100, id ""
>     -    aspeed = false
>     -    mac = "00:00:00:00:00:00"
>     +    gpio-out "sysbus-irq" 1
>     +    aspeed = true
>     +    mac = "52:54:00:12:34:58"
>          netdev = ""
>     +    mmio 000000001e680000/0000000000002000
>        dev: ftgmac100, id ""
>     -    aspeed = false
>     -    mac = "00:00:00:00:00:00"
>     -    netdev = ""
>     +    gpio-out "sysbus-irq" 1
>     +    aspeed = true
>     +    mac = "52:54:00:12:34:56"
>     +    netdev = "hub0port0"
>     +    mmio 000000001e670000/0000000000002000
>        dev: ftgmac100, id ""
>     -    aspeed = false
>     -    mac = "00:00:00:00:00:00"
>     +    gpio-out "sysbus-irq" 1
>     +    aspeed = true
>     +    mac = "52:54:00:12:34:59"
>          netdev = ""
>     +    mmio 000000001e690000/0000000000002000
>        [...]
>        dev: aspeed-mmi, id ""
>          mmio 000000001e650000/0000000000000008
>        dev: aspeed-mmi, id ""
>     +    mmio 000000001e650008/0000000000000008
>        dev: aspeed-mmi, id ""
>     +    mmio 000000001e650010/0000000000000008
>        dev: aspeed-mmi, id ""
>     +    mmio 000000001e650018/0000000000000008
> 
> Here we can see the network backend now gets connected to MAC2 instead
> of MAC0.

yes.

With only one nic on the command line, the backend was attached to the 
first (unused) MAC0 of the machine and now it is attached to the first 
active MAC2 of the machine.

> 
> This is without any networking-related options, i.e. we get just the
> single default network backend.
> 
>> ---
>>
>>  To be applied on top of patch :
>>
>>  "arm/aspeed: Compute the number of CPUs from the SoC definition" 
>>  http://patchwork.ozlabs.org/project/qemu-devel/patch/20200519091631.1006073-1-clg@kaod.org/
>>
>>  Markus, do you mind taking this patch in your QOM series also ?
> 
> On the contrary!
> 
> I'll work my "info qom-tree" and "info qtree" diffs into the commit
> message, if you don't mind.

Sure. 

Thanks,

C. 

