Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB29C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEB124686
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEB124686
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBeAb-0002kh-F9
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBeA0-0002Jm-8N
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBe9y-000694-Fz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:38:59 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:43954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jBe9y-0005no-9t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:38:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8967E746383;
 Tue, 10 Mar 2020 13:38:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5600E746381; Tue, 10 Mar 2020 13:38:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5410974637D;
 Tue, 10 Mar 2020 13:38:49 +0100 (CET)
Date: Tue, 10 Mar 2020 13:38:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
In-Reply-To: <871rq08tn9.fsf@dusky.pond.sub.org>
Message-ID: <alpine.BSF.2.22.395.2003101334220.33922@zero.eik.bme.hu>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020, Markus Armbruster wrote:
> Root cause of this issue: nobody knows how to use QOM correctly (first
> order approximation).  In particular, people are perenially confused on
> how to split work between .instance_init() and .realize().  We really,
> really, really need to provide some guidance there!  Right now, all we
> provide are hundreds of examples, many of them bad.

Agreed, it's hard to find consise and useful docs on this. The best I've 
found was this: 
https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html but 
not sure how relevant is it still. Maybe should be more prominently linked 
or put on the wiki.

Also renaming init to alloc might help to clear some confusion. (Alloc and 
realize are still a bit confusing but less so than also renaming realize 
to init.)

Regards,
BALATON Zoltan

