Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE05C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:07:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37DD208DB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37DD208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzSJ-00024l-6V
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kCzRj-0001YD-AH; Tue, 01 Sep 2020 02:07:07 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42279)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kCzRh-0007nO-EL; Tue, 01 Sep 2020 02:07:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.240])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3C275560BF6A;
 Tue,  1 Sep 2020 08:06:54 +0200 (CEST)
Received: from kaod.org (37.59.142.97) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 08:06:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0023bea5ab4-41a8-4ffd-8413-c90ac3e25650,
 38EE1E9FF4E34D4C85F4190D418CEE501B878519) smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 1/3] adb: Correct class size on TYPE_ADB_DEVICE
To: David Gibson <david@gibson.dropbear.id.au>, <ehabkost@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200831235146.36045-1-david@gibson.dropbear.id.au>
 <20200831235146.36045-2-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5cec6d67-7e34-0a0e-c586-5f87007961ef@kaod.org>
Date: Tue, 1 Sep 2020 08:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831235146.36045-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: e148b3a6-5915-4d6c-99a9-5095b43d1cc4
X-Ovh-Tracer-Id: 16500344613091249059
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefiedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeejkeduueduveelgeduueegkeelffevledujeetffeivdelvdfgkeeufeduheehfeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:06:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.13,
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 1:51 AM, David Gibson wrote:
> The TypeInfo incorrectly just lets the class size be inherited.  It won't
> actually break things, since the class is abstract, but we should get it
> right.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  hw/input/adb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index 013fcc9c54..84331b9fce 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -309,6 +309,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo adb_device_type_info = {
>      .name = TYPE_ADB_DEVICE,
>      .parent = TYPE_DEVICE,
> +    .class_size = sizeof(ADBDeviceClass),
>      .instance_size = sizeof(ADBDevice),
>      .abstract = true,
>      .class_init = adb_device_class_init,
> 


