Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3224C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D21920722
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="X95fGuhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D21920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYVYw-0002On-IK
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jYVXf-0000y8-0w
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:05:55 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:49458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jYVXa-0008RO-VC
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:05:52 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D010A2E14E7;
 Tue, 12 May 2020 17:05:44 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net
 (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 sZWgbv3eBU-5hX4q67j; Tue, 12 May 2020 17:05:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589292344; bh=hZis8KXcrzwcwYBQt0FChaxuFL6nzqWSPixpYi/5kcw=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=X95fGuhyiq5/HP1dypBr8n6BKCaGnSjew0plejLKmpXfD1zAc4rw30a9oXQoYXTua
 n5sniEiGOPVCu3pym1lTFzDTe/DnThc2COmgDOri9DH0VUfvm05llJrN5LmZ4z9r87
 dlk6Mx7Eow/JI9UjTa/qfYEbzT2xqJoh1UBhRlXo=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1303::1:e])
 by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 2oRSSAJCBf-5hXWDbMi; Tue, 12 May 2020 17:05:43 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
Date: Tue, 12 May 2020 17:05:42 +0300
From: Roman Kagan <rvkagan@yandex-team.ru>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200512140542.GA9944@rvkaganb.lan>
Mail-Followup-To: Roman Kagan <rvkagan@yandex-team.ru>,
 Jon Doron <arilou@gmail.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Liran Alon <liran.alon@oracle.com>
References: <CAP7QCogMdUis-=KsC--0ar2Zt2Vwcpn4HS+qCxPn5khtDTu+mA@mail.gmail.com>
 <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
 <20200408041639.GA7606@jondnuc> <20200408204742.GA709224@rvkaganb>
 <20200409033518.GC7606@jondnuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409033518.GC7606@jondnuc>
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Liran Alon <liran.alon@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 09, 2020 at 06:35:18AM +0300, Jon Doron wrote:
> On 08/04/2020, Roman Kagan wrote:
> > On Wed, Apr 08, 2020 at 07:16:39AM +0300, Jon Doron wrote:
> > > Well I have implemented the hyperv synthetic kernel debugger interface, but
> > > on Windows 10 it requires to have a working VMBus (it's not really using it,
> > > but without a function vmbus that will answer to the initiate contact then
> > > the kdnet will simply be stuck in a loop.

I tried to google for this interface but the only thing I managed to
find was this

https://withinrafael.com/2015/02/01/how-to-set-up-synthetic-kernel-debugging-for-hyper-v-virtual-machines/

Is this what you're trying to implement?  Are there any more
authoritative descriptions of the feature?

The document doesn't quite explain the inner workings of the feature,
but it looks like the regular network debugging interface, except that
IP is forwarded by the hypervisor app, so that the debugger has to
connect to the host and avoid setting up full-fledged network
connectivity to the guest.  That would be essentially hv-net + slirp.
OTOH you say it doesn't use VMBus so I'm confused...

Thanks,
Roman.

> > > In addition to that Michael Kelley from Microsoft has informed us that
> > > Microsoft might be dropped the synthetic kernel debugger interface sometime
> > > in the future, and it seems like the new mode is simply to use hvnet device
> > > for the communication (which is again much faster).

