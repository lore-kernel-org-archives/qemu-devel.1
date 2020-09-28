Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3624BC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D205208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cuX8185p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D205208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtVm-0004u0-NJ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMtJb-0000Xe-E2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:35:39 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kMtJT-0004py-Np
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=Vjl2y5hmP0OR0/obOCmJkeUf/SHoy5w4FKtOsO4BFgY=; b=cuX8185pvNKPZReQH43EUZBtbC
 BpXYgMQ21uTWilEfy1fGYen9z0jYJ2L+6jcy99CVZMdegpaSpvgmqLgza6y4tHh/py6PHutHxBBkM
 HbTFHYh/WX6ZIvwE3kbGoYoIG6OYaVRxw2UKxYMlq0MBtNTDoULM1CnQKfc7abzBzs0i7FdBaJ1Gh
 4vlx9XduUfJ0yzNCf9n0L+pVJANt47S/agpreROpxPUFktAoBcP3SIx7P+DKeURkocFAK8I5+POrl
 gnsmKwgJiYdHuC8PrIc9iH+fIRjJmEplY9W8jagWkHir7yeqTWgZmLkkPNVcDgHTBOfMXkMV9HXs8
 9HHa8enA==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 08/12] tests/9pfs: refactor test names and test devices
Date: Mon, 28 Sep 2020 15:35:26 +0200
Message-ID: <9648157.mzsJ5Dm3EP@silver>
In-Reply-To: <95ef57d0-b35e-f16a-f957-06bc3692cb7c@redhat.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
 <3365834.oEZqtqHOuS@silver> <95ef57d0-b35e-f16a-f957-06bc3692cb7c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 07:56:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 28. September 2020 14:42:48 CEST Paolo Bonzini wrote:
> On 28/09/20 13:56, Christian Schoenebeck wrote:
> >> The implementation in patches 1 and 2 is reasonable, but what is the
> >> advantage of this as opposed to specifying the fsdev in the edge options
> >> for the test (similar to virtio-net)?  I was expecting both
> >> virtio-9p-device-synth and virtio-9p-device-local to produce virtio-9p,
> >> so that the existing tests would be reused automatically by the qos
> >> graph walk.
> >> 
> >> As things stand, I don't see any reason to have separate devices for
> >> different backends.
> > 
> > I thought to fix the problem at its root, by removing that singular device
> > limitation in qos. That would also allow to cleanly separate tests suites
> > that are not related to each other instead of having to depend on each
> > other, taking care about other one's command line skeleton and more.
> 
> As I said, the first two patches make total sense.  They would be useful
> for testing both packed and split virtqueues, for example.  However, I
> think the (useful) feature is being misused here.

I haven't understood why my suggested mult-device use case imposes a misusage, 
but okay, unless I hear different opinions, I'll prepare a v2 with that (IMO 
hackish) CL fiddling instead in couple days or so.

@Greg: If that's the way to go, then I probably change the test names, e.g.

	"fs/version/basic" -> "synth/version/basic"
	...
	"fs/create_dir" -> "local/create_dir"

to be able to easily distinguish 'synth' driver tests from 'local' driver 
tests, as they would then popup with the same device name in v2, unlike in 
this v1 where they have separate device names.

> > So your suggested solution is fine for appending extra arguments past the
> > command line. However I would not be able to prepend something (easily) in
> > front of '-device virtio-9p-pci'.
> > 
> > So I would be forced to parse the existing command line in modifycmdline()
> > callback and then insert the required arguments appropriately. I would not
> > find that very clean.
> 
> IIRC -fsdev can be added to the end of the command line and it still
> works.  But if you think that is ugly, you can also use g_string_prepend.

Yes, "-fsdev ..." and "-device ..." sequence could theoretically be flipped, 
qemu would accept it that is.

> Also, looking at future plans for qgraph, adding a generic "plug/socket"
> mechanism to QOSGraph was an idea that we couldn't do in time for GSoC.
> With that model, virtio-9p would provide a "socket" of type fsdev and
> the tests would have to provide a "plug" of the same type.  Likewise
> there would be sockets of type disk or network.  QOSGraphEdgeOpts fits
> better with that plan, compared to duplicating the devices.

Sounds like that would require huge changes for all existing qtests on initial 
thought at least.

I find the suggested multi-device approach much simpler, as it does not 
require changes to existing tests, nor people having to get used to a new 
qtest model.

Best regards,
Christian Schoenebeck



