Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5065C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 07:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A72620725
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 07:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A72620725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iglEC-0003UN-Mi
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 02:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iglDZ-0002wQ-Kq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 02:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iglDY-0004bU-ER
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 02:55:01 -0500
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:33663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iglDY-00043O-8l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 02:55:00 -0500
Received: from player699.ha.ovh.net (unknown [10.108.54.38])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 9161C14732B
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:54:49 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id CDFBAD4E73D5;
 Mon, 16 Dec 2019 07:54:41 +0000 (UTC)
Subject: Re: [PATCH 07/13] ppc/pnv: Introduce PnvChipClass::intc_print_info()
 method
To: David Gibson <david@gibson.dropbear.id.au>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
 <157623840755.360005.5002022339473369934.stgit@bahia.lan>
 <4039344f-eb1c-3ea3-1055-09aeffd28ce7@kaod.org>
 <20191216012810.GA3256@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9c117056-4bec-a217-3643-8a58b50e96af@kaod.org>
Date: Mon, 16 Dec 2019 08:54:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191216012810.GA3256@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4055772942298352467
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeehnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.218
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> May be we should introduce a helper such as : 
>>
>> int pnv_chip_cpu_foreach(PnvChip *chip,
>> 	  int (*doit)(PnvChip *chip, PowerPCCPU *cpu, void *opaque), void *opaque)
>> {
>>     int i, j;
>>     int ret = 0;
>>
>>     for (i = 0; i < chip->nr_cores; i++) {
>>         PnvCore *pc = chip->cores[i];
>>         CPUCore *cc = CPU_CORE(pc);
>>
>>         for (j = 0; j < cc->nr_threads; j++) {
>>             PowerPCCPU *cpu = pc->threads[j];
>>             ret = doit(chip, cpu, opaque);
>>             if (ret) { 
>>                 break;
>>             }
>>         }
>>     }
>>     return ret;
>> }
> 
> What I'd actually like to work towards is just having the interrupt
> controllers themselves advertize TYPE_INTERRUPT_STATS_PROVIDER and not
> needing anything specific at the machine level to locate them, just
> let the generic code in hmp_info_pic handle it.

OK. It would good to at least loop on the chips, so that the output
of the possible TYPE_INTERRUPT_STATS_PROVIDER (IC, PSIHB, PHB, NPU) 
are ordered. 

C.

