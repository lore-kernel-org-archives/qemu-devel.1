Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE57C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:44:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED9B20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED9B20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyYM-0007B7-Gh
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iZyWe-0006ZM-2z
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iZyWc-0005xM-9S
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:42:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:52904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iZyWb-0005uc-K8
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:42:38 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BCCD3745957;
 Wed, 27 Nov 2019 15:42:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D6D474594E; Wed, 27 Nov 2019 15:42:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9C17D745953;
 Wed, 27 Nov 2019 15:42:28 +0100 (CET)
Date: Wed, 27 Nov 2019 15:42:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "aaron.zakhrov@gmail.com" <aaron.zakhrov@gmail.com>
Subject: Re: [RFC 09/10] Clean up Radeon Header files
In-Reply-To: <CAL1e-=hY5b73ocsG9xiUFVuJYL36ch4=AyqjPvmtaXRUi730pQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.99999.352.1911271505300.80933@zero.eik.bme.hu>
References: <20191126124433.860-1-aaron.zakhrov@gmail.com>
 <20191126124433.860-6-aaron.zakhrov@gmail.com>
 <CAL1e-=hY5b73ocsG9xiUFVuJYL36ch4=AyqjPvmtaXRUi730pQ@mail.gmail.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019, Aleksandar Markovic wrote:
> On Tuesday, November 26, 2019, <aaron.zakhrov@gmail.com> wrote:
>
>> From: Aaron Dominick <aaron.zakhrov@gmail.com>
>>
>> ---
>
>
> Your commit message is poor. You should have clearly explained what do you
> do in this cleanup, and why.

That the commit message is not helpful is the smallest problem. Clearly 
there are more to improve in this series but please bear with new 
contributors who may need to get used to the workflow with git and QEMU 
patch submission and don't scare them away by criticising small problems 
without helping them.

This whole series is RFC and was stated in the original cover letter of 
the v1 series that this is work in progress submitted for enquiring about 
the direction taken not meant to be finished. That said it's still hard to 
review in this state so some improvements are needed. This v1 was an 
attempt for that but looks like it's not correct yet. I've found at least 
these problems:

- Series says it has 10 patches but I've only got 5-9 so it may have been 
edited by hand instead of properly using git format-patch.

- Patch 9 added to remove unneded headers at the end but that does not 
help to make Patch 5 more clear so this should be squashed into patch 5 
instead (try git rebase -i and squash patches 5 and 9 so we end up with 
only the necessary files added instead of one patch adding them and 
another removing them later).

- The resulting patch 5 (that should really be 1) should be split into 
two: one copying existing files without modifying them and another patch 
adding new headers to make it clear what changes are made that is hard to 
find if copying and modifying files are done in the same patch.

As for the original question if this is the right direction I can't really 
tell but I think it may be but to make it work we will need to implement 
Microengine (aka. command processor/CCE/PM4) that reads packets from a 
shared memory buffer and converts them to register accesses but it's not 
documented so either we can get some info about it from somewhere (maybe 
AMD) or manage to reverse engineer the microcode or just implement its 
functionality not modeling the actual microengine the real card has but 
only do packet parsing that it should do.

There was another question about GART which I can't answer not knowing 
much about it but maybe we only need the addresses and then the device can 
access system memory directly so we don't need to model the whole 
IOMMU/DMA but I'm not sure what GART is used for so I may be wrong. 
Comments from those who know more about ATI GPUs are welcome.

Regards,
BALATON Zoltan

