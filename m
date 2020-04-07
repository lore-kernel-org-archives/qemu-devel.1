Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E3BC2D0EC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F32F20748
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 19:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F32F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLtWD-0007pf-5i
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 15:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mail@maciej.szmigiero.name>) id 1jLtVT-0007OT-Vi
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mail@maciej.szmigiero.name>) id 1jLtVS-0005iJ-On
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:03:31 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:55222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mail@maciej.szmigiero.name>)
 id 1jLtVS-0005dU-IW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 15:03:30 -0400
Received: from MUA
 by vps-vb.mhejs.net with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.93.0.4) (envelope-from <mail@maciej.szmigiero.name>)
 id 1jLtV8-0004qy-IY; Tue, 07 Apr 2020 21:03:10 +0200
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
To: Roman Kagan <rvkagan@yandex-team.ru>
References: <20200403142308.82990-1-arilou@gmail.com>
 <20200403142308.82990-6-arilou@gmail.com>
 <76017793-735b-4bb5-0e69-ecded78af54d@maciej.szmigiero.name>
 <CAP7QCog_EmLJ=O8Xi9Tc4Jst1=z62DXim9ScCyoPv7WugrSyOw@mail.gmail.com>
 <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 sg==
Message-ID: <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
Date: Tue, 7 Apr 2020 21:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407185608.GA178651@rvkaganb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 37.28.154.113
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
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Jon Doron <arilou@gmail.com>,
 QEMU <qemu-devel@nongnu.org>, Liran Alon <liran.alon@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07.04.2020 20:56, Roman Kagan wrote:
> On Mon, Apr 06, 2020 at 11:20:39AM +0300, Jon Doron wrote:
>> Well I want it to be merged in :-)
> 
> Hmm I'm curious why, it has little to offer over virtio.
> 
> Anyway the series you've posted seems to be based on a fairly old
> version.
> 
> The one in openvz repo is more recent.  It's still in need for
> improvement, too, but should be testable at least.

Isn't the one at 
https://src.openvz.org/projects/UP/repos/qemu/commits?until=refs%2Fheads%2Fvmbus
the latest one?

It seems to be last changed in October 2019 - is there a
later one?

> Thanks,
> Roman.

Thanks,
Maciej

