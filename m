Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23061C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB053218A3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 07:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB053218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjIzr-0004kH-82
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 03:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49315)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjIz6-0004G1-G5
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjIz4-000495-GK
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 03:50:20 -0400
Received: from charlie.dont.surf ([128.199.63.193]:50722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjIyx-00043i-0E; Fri, 05 Jul 2019 03:50:12 -0400
Received: from bogfinke (ip-5-186-120-196.cgn.fibianet.dk [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 04192BF607;
 Fri,  5 Jul 2019 07:50:03 +0000 (UTC)
Date: Fri, 5 Jul 2019 09:50:00 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Matt Fitzpatrick <matt.fitzpatrick@oakgatetech.com>
Message-ID: <20190705075000.GA17345@bogfinke>
Mail-Followup-To: Matt Fitzpatrick <matt.fitzpatrick@oakgatetech.com>,
 keith.busch@intel.com, kwolf@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <8115eb18-38c0-2bd9-b7d7-2d0c96a106e7@oakgatetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8115eb18-38c0-2bd9-b7d7-2d0c96a106e7@oakgatetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [Qemu-block] [RFC, v1] Namespace Management Support
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
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:39:36AM -0700, Matt Fitzpatrick wrote:
> Adding namespace management support to the nvme device. Namespace creat=
ion
> requires contiguous block space for a simple method of allocation.
>=20
> I wrote this a few years ago based on Keith's fork and nvmeqemu fork an=
d
> have recently re-synced with the latest trunk.=A0 Some data structures =
in
> nvme.h are a bit more filled out that strictly necessary as this is als=
o the
> base for sr-iov and IOD patched to be submitted later.
>=20

Hi Matt,

Nice! I'm always happy when new features for the nvme device is posted!

I'll be happy to review it, but I won't start going through it in
details because I believe the approach to supporting multiple namespaces
is flawed. We had a recent discussion on this and I also got some
unrelated patches rejected due to implementing it similarly by carving
up the image.

I have posted a long series that includes a patch for multiple
namespaces. It is implemented by introducing a fresh `nvme-ns` device
model that represents a namespace and attaches to a bus created by the
parent `nvme` controller device.

The core issue is that a qemu image /should/ be attachable to other
devices (say ide) and not strictly tied to the one device model. Thus,
we cannot just shove a bunch of namespaces into a single image.

But, in light of your patch, I'm not convinced that my implementation is
the correct solution. Maybe the abstraction should not be an `nvme-ns`
device, but a `nvme-nvm` device that when attached changes TNVMCAP and
UNVMCAP? Maybe you have some input for this? Or we could have both and
dynamically create the nvme-ns devices on top of nvme-nvm devices. I
think it would still require a 1-to-1 mapping, but it could be a way to
support the namespace management capability.


Cheers,
Klaus

