Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CBDC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3E8206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3E8206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTFZ-0001J7-0c
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTEv-0000WZ-9n; Sun, 14 Jun 2020 10:04:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:58623)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTEr-0000vS-KK; Sun, 14 Jun 2020 10:04:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6CF1F746331;
 Sun, 14 Jun 2020 16:03:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4FA29746307; Sun, 14 Jun 2020 16:03:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4E2A27456F8;
 Sun, 14 Jun 2020 16:03:41 +0200 (CEST)
Date: Sun, 14 Jun 2020 16:03:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 3/5] grackle: Set revision in PCI config to match
 hardware
In-Reply-To: <42ad2cb2-c1e7-4bb6-66e2-94b65c2c010a@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006141603120.56690@zero.eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <b80aec26effdb026b10394156d59611b47f807c6.1592055375.git.balaton@eik.bme.hu>
 <42ad2cb2-c1e7-4bb6-66e2-94b65c2c010a@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 10:03:41
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 14 Jun 2020, Mark Cave-Ayland wrote:
> On 13/06/2020 14:36, BALATON Zoltan wrote:
>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/pci-host/grackle.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
>> index 4b3af0c704..48d11f13ab 100644
>> --- a/hw/pci-host/grackle.c
>> +++ b/hw/pci-host/grackle.c
>> @@ -130,7 +130,7 @@ static void grackle_pci_class_init(ObjectClass *klass, void *data)
>>      k->realize   = grackle_pci_realize;
>>      k->vendor_id = PCI_VENDOR_ID_MOTOROLA;
>>      k->device_id = PCI_DEVICE_ID_MOTOROLA_MPC106;
>> -    k->revision  = 0x00;
>> +    k->revision  = 0x40;
>>      k->class_id  = PCI_CLASS_BRIDGE_HOST;
>>      /*
>>       * PCI-facing part of the host bridge, not usable without the
>
> Out of curiosity does the BIOS you are using require this, or is it purely for
> cosmetic purposes? I'm sure I've seen device trees with several different revisions
> here...

Don't know, got it from here:

https://github.com/dingusdev/dingusppc/blob/master/devices/mpc106.h

Regards,
BALATON Zoltan

