Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4160DC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 06:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EB32168B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 06:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EB32168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4ff9-0007W6-8O
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 02:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i4fdq-0006sM-M6
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 02:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i4fdp-0003I8-F8
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 02:16:42 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:40907)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i4fdp-0003Dt-9h
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 02:16:41 -0400
Received: from player793.ha.ovh.net (unknown [10.108.54.217])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 8F5AF1DDE50
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 08:16:31 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 3A568963F1AB;
 Mon,  2 Sep 2019 06:16:25 +0000 (UTC)
To: Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org
References: <1566327765-2003-1-git-send-email-eajames@linux.ibm.com>
 <c2a58f33-e4cf-0033-37bf-420cc665d949@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6cf5b737-ed1b-2380-bbd8-e2e0f4134b91@kaod.org>
Date: Mon, 2 Sep 2019 08:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c2a58f33-e4cf-0033-37bf-420cc665d949@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 12951789579048749841
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeiledguddthecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.177.69
Subject: Re: [Qemu-devel] [RFC v3] hw/sd/aspeed_sdhci: New device
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/08/2019 11:17, C=C3=A9dric Le Goater wrote:
> On 20/08/2019 21:02, Eddie James wrote:
>> The Aspeed SOCs have two SD/MMC controllers. Add a device that
>> encapsulates both of these controllers and models the Aspeed-specific
>> registers and behavior.
>>
>> Tested by reading from mmcblk0 in Linux:
>> qemu-system-arm -machine romulus-bmc -nographic \
>>  -drive file=3Dflash-romulus,format=3Draw,if=3Dmtd \
>>  -device sd-card,drive=3Dsd0 -drive file=3D_tmp/kernel,format=3Draw,if=
=3Dsd
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
>> ---
>> This patch applies on top of Cedric's set of recent Aspeed changes.
>> Therefore, I'm sending as an RFC rather than a patch for review.
>=20
> I merged this patch in aspeed-4.2 and made the adjustments to move
> it to the top of the patchset after the GPIO model.=20

Hello,

What would be required to the model under linux-5.2 ?=20

Thanks,

C.=20

