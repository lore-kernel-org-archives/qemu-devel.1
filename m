Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60CFC06511
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C0921479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C0921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiDn6-0000wd-MV
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49514)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hiDjr-00087w-T0
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hiDjk-0007HQ-Lz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:02:02 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:58916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hiDjg-00077K-DW
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:01:57 -0400
Received: from player715.ha.ovh.net (unknown [10.109.159.90])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 487A910AC1B
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:01:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 95FD2768BCAA;
 Tue,  2 Jul 2019 08:01:28 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:01:27 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190702100127.4bb017a1@bahia.lan>
In-Reply-To: <10483682.05G6IJrOKK@silver>
References: <cover.1561575449.git.qemu_oss@crudebyte.com>
 <4068711.1y5nem0Q7a@silver> <20190628162308.40ec742c@bahia.lan>
 <10483682.05G6IJrOKK@silver>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1107041086806792512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdejgdduvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.148
Subject: Re: [Qemu-devel] [PATCH v4 3/5] 9p: Added virtfs option
 "remap_inodes"
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 29 Jun 2019 12:20:49 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 28. Juni 2019 16:23:08 CEST Greg Kurz wrote:
> > > > This feature applies to all backends IIUC. We don't really care for the
> > > > synth backend since it generates non-colliding inode numbers by design,
> > > > but the proxy backend has the same issue as local. So...
> > > 
> > > Yeah, I was not sure about these, because I did not even know what these
> > > two were for exactly. :)  [ lazyness disclaimer end]
> > 
> > "proxy" is a backend where all I/O accesses are performed by a separate
> > process running the virtfs-proxy-helper command. It runs with root
> > privileges, which provides the same level of functionality as "local"
> > with security_model=passthrough. It also chroot() into the shared
> > folder for extra security. But it is slower since it all requests
> > still go through the virtio-9p device in QEMU. This would call
> > for a vhost-9p implementation, but it's yet another story.
> > 
> > "synth" is a software pseudo-backend, currently used to test 9pfs
> > with QTest (see tests/virtio-9p-test.c).
> 
> Thanks for the clarification!
> 
> So the proxy backend sounds like an idea that has not been implemented fully 
> to its end. I guess it is not really used in production environments, right? 

I don't have any feedback unfortunately... The biggest problem with proxy is
likely it's poor performance : every request needs to go through many hops.

guest->QEMU->proxy->QEMU->guest 

> What is the actual motivation for this proxy backend?
> 

The motivation is security: only the proxy helper runs with privileges (we
generally don't want to run QEMU as root), the helper can chroot() and thus
prevent the guest to access anything outside the shared folder.

> And now that I look at it, I am a bit surprised that there is this pure Unix 
> pipe socket based proxy variant, but no TCPIP network socket variant. I mean 

The Unix socket is required in order to pass open file descriptors between
QEMU and the proxy, using SCM_RIGHTS ancillary messages. There's no such
thing with TCPIP sockets.

> the latter is AFAIK the original idea behind the 9p protocol and IMO might be 
> interesting to physical separate pure storage backends that way.
> 

The right thing to do would be to have the "proxy" process to directly
access the rings of the virtio-9p device (ie, vhost), so that requests
only go through:

guest->proxy->guest

> Best regards,
> Christian Schoenebeck


