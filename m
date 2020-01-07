Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546C0C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277B120848
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277B120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotFS-00065S-A9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iotEo-00058m-MQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iotEn-0000J4-3E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:05:53 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:54687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iotEm-00007O-TB; Tue, 07 Jan 2020 13:05:53 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 062517482CC;
 Tue,  7 Jan 2020 19:05:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 99BEB7482C9; Tue,  7 Jan 2020 19:05:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 981967482C8;
 Tue,  7 Jan 2020 19:05:41 +0100 (CET)
Date: Tue, 7 Jan 2020 19:05:41 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 02/10] ppc: Remove stub of PPC970 HID4
 implementation
In-Reply-To: <20200107183638.1c84f172@bahia.lan>
Message-ID: <alpine.BSF.2.21.99999.352.2001071900510.93471@zero.eik.bme.hu>
References: <20200107044827.471355-1-david@gibson.dropbear.id.au>
 <20200107044827.471355-3-david@gibson.dropbear.id.au>
 <20200107183215.09ce18c6@bahia.lan> <20200107183638.1c84f172@bahia.lan>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 clg@kaod.org, paulus@samba.org, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020, Greg Kurz wrote:
> On Tue, 7 Jan 2020 18:32:15 +0100
> Greg Kurz <groug@kaod.org> wrote:
>
>> On Tue,  7 Jan 2020 15:48:19 +1100
>> David Gibson <david@gibson.dropbear.id.au> wrote:
>>
>>> The PowerPC 970 CPU was a cut-down POWER4, which had hypervisor capability.
>>> However, it can be (and often was) strapped into "Apple mode", where the
>>> hypervisor capabilities were disabled (essentially putting it always in
>>> hypervisor mode).
>
> Isn't it supervisor mode instead of hypervisor mode ?

By the way, do you know if this strapping is hardware or software based? 
So is it the firmware that disables it on Apple hardware or is it some CPU 
pin connected somewhere on the motherboard or it's within the CPU and 
cannot be changed? I wonder if it's theoretically possible to re-enable it 
on an Apple G5 or we would likely never see a PowerPC 970 with HV enabled?

Regards,
BALATON Zoltan

