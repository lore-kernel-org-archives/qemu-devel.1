Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEBC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 11:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C0F2166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 11:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C0F2166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw3H2-0002PK-JL
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 07:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43457)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hw3GH-0001fu-Fi
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hw3GG-0003K1-3t
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:40:45 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:57986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hw3GF-00035o-R3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 07:40:44 -0400
Received: from player778.ha.ovh.net (unknown [10.109.160.217])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 70D97107385
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 13:40:26 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 5443D8AE3458;
 Fri,  9 Aug 2019 11:39:49 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-6-damien.hedde@greensocs.com>
 <20190731060533.GD2032@umbus.fritz.box>
 <51aa7e6d-3568-8485-4b67-a598a24a1f3d@greensocs.com>
 <20190808064810.GE5465@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4fa2ecbe-d81e-5285-822e-28f984aed77c@kaod.org>
Date: Fri, 9 Aug 2019 13:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808064810.GE5465@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6604810331389201207
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddruddujedggeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
Subject: Re: [Qemu-devel] [PATCH v3 05/33] Switch to new api in qdev/bus
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
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, edgar.iglesias@xilinx.com,
 hare@suse.com, qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com, alistair@alistair23.me, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, jsnow@redhat.com, rth@twiddle.net, berrange@redhat.com,
 cohuck@redhat.com, mark.burton@greensocs.com, qemu-ppc@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


>>> So.. is this change in the device_reset() signature really necessary?
>>> Even if there are compelling reasons to handle warm reset in the new
>>> API, that doesn't been you need to change device_reset() itself from
>>> its established meaning of a cold (i.e. as per power cycle) reset.
>>> Warm resets are generally called in rather more specific circumstances
>>> (often under guest software direction) so it seems likely that users
>>> would want to engage with the new reset API directly.  Or we could
>>> just create a device_warm_reset() wrapper.  That would also avoid the
>>> bare boolean parameter, which is not great for readability (you have
>>> to look up the signature to have any idea what it means).
>>
>> I've added device_reset_cold/warm wrapper functions to avoid having to
>> pass the boolean parameter. it seems I forgot to use them in qdev.c
>> I suppose, like you said, we could live with
>> + no function with the boolean parameter
>> + device_reset doing cold reset
>> + device_reset_warm (or device_warm_reset) for the warm version
> 
> Ok, good.
> 
> I'm afraid the whole series still makes me pretty uncomfortable,
> though, since the whole "warm reset" concept still seems way to vague
> to me.

Isn't the reset after the CAS negotiation sequence between the hypervisor
and the pseries machine some sort of warm reset driven by SW ? 


C.  

