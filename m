Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE597C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AAE2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 06:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AAE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kInSm-0004zI-9s
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 02:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kInMW-00080z-Md
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:25:44 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:45371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kInMU-0002zq-7Q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 02:25:44 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.201])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 5A64D627BF82;
 Thu, 17 Sep 2020 08:25:30 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 17 Sep
 2020 08:25:29 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0058557d068-7e33-4b68-8ddb-15d7b23277e8,
 FF1720B74B3888C93CA5040C1F5ACCC945AC33B8) smtp.auth=clg@kaod.org
Subject: Re: eMMC support
To: Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <saipava@xilinx.com>
References: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
 <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6a30107a-abf1-635b-c96f-af3d63f93bc8@kaod.org>
Date: Thu, 17 Sep 2020 08:25:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 298f50fb-6e5b-4cb3-80ea-7b3bb413981a
X-Ovh-Tracer-Id: 97108870036491171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdefgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueduffdvtefhhfeujeekvedtuddtueeuveejfefgudehudejkefhteegudfhffdvnecuffhomhgrihhnpehgnhhurdhorhhgpdhoiihlrggsshdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:25:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.062,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Edgar Iglesias <edgari@xilinx.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 2:55 AM, Joel Stanley wrote:
> On Wed, 16 Sep 2020 at 18:35, Sai Pavan Boddu <saipava@xilinx.com> wrote:
>>
>> Hi Philippe,
>>
>>
>>
>> We are looking to add eMMC support, I searched the mailing list and found a series posted on eMMC by “Vincent Palatin”
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2011-07/msg02833.html
> 
> I would be interested in emmc support for the aspeed machines. Please
> cc me when you post patches.
> 
>> I would like to consider the above work and mix-up with more changes to start adding support for eMMC. Do you have any suggestions on the approach followed in above patches ?
> 
> The patches had minor review comments, but I assume the reason they
> didn't go anywhere is the author never followed up with further
> revisions. I would suggest applying them to the current tree, cleaning
> up any style changes that have happened since they were posted, and
> re-posting them for review.

It seems we only care about these three patches :

  https://patchwork.ozlabs.org/patch/106762
  https://patchwork.ozlabs.org/patch/106761
  https://patchwork.ozlabs.org/patch/106763

It should not be too complex to get something going.
>> Note: Here is the existing support available in Xilinx fork, which might require some work
>> https://github.com/Xilinx/qemu/blob/master/hw/sd/sd.c

What are the relevant patches ? 

Thanks,

C. 

