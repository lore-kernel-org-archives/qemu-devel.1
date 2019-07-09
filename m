Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D55C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611F9216C4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611F9216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkjwD-0002rp-92
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 02:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hkjsd-00028L-Bj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hkjsb-0005Km-Su
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:45:35 -0400
Received: from charlie.dont.surf ([128.199.63.193]:34892)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hkjsY-0005Fx-7t; Tue, 09 Jul 2019 02:45:30 -0400
Received: from bogfinke (ip-5-186-120-196.cgn.fibianet.dk [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id C7835BF6BC;
 Tue,  9 Jul 2019 06:45:27 +0000 (UTC)
Date: Tue, 9 Jul 2019 08:45:24 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: kwolf@redhat.com
Message-ID: <20190709064523.GA27395@bogfinke>
References: <8115eb18-38c0-2bd9-b7d7-2d0c96a106e7@oakgatetech.com>
 <20190705075000.GA17345@bogfinke>
 <3157dd16-4caa-2242-c568-c9a267f274ac@oakgatetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3157dd16-4caa-2242-c568-c9a267f274ac@oakgatetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [Qemu-block]   [RFC,
 v1] Namespace Management Support
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
Cc: keith.busch@intel.com, Matt Fitzpatrick <matt.fitzpatrick@oakgatetech.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 08, 2019 at 03:52:29PM -0700, Matt Fitzpatrick wrote:
> Hey Klaus,
>=20
> Sorry for the late reply!=A0 I finally found this message amid the pile=
 of
> emails Qemu dumped on me.
>=20
> I don't know what the right answer is here... NVMe is designed in a way
> where you *do* "carve up" the flash into logical groupings and the nvme
> firmware decides on how that's done. Those logical groupings can be att=
ached
> to different controllers(which we don't have here yet?) after init, but
> that's a problem for future us I guess?But that's all stuff you already
> know.
>=20

Yeah, I havn't started worrying about that ;)

> The "nvme-nvm" solution might be the right approach, but I'm a bit hesi=
tant
> on the idea of growing tnvmcap...
>=20
> I can't think of any way to create namespaces on the fly and not have i=
t use
> some single existing block backend, unless we defined a range of block
> images on qemu start and namespace create/attach only uses one image up=
 to
> and including it's max size per namespace? That might work, and I think
> that's what you suggested (or at least is similar to), though it could =
be
> pretty wasteful. It wouldn't offer a "true" namespace management suppor=
t,
> but could be close enough.
>=20

Having an emulated device that supports namespace management would be
very useful for testing software, but yeah, I have a hard time seeing
how we can make that fit with the current "QEMU model".

> I'm in the middle of going through the patch you posted. Nice job!=A0 I=
'm glad
> to see more people adding enhancements. It was pretty stale for years.
>=20

Thanks for looking at it, I know it's a lot to go through ;)

> -Matt
> On 7/5/19 12:50 AM, Klaus Birkelund wrote:
> > On Tue, Jul 02, 2019 at 10:39:36AM -0700, Matt Fitzpatrick wrote:
> > > Adding namespace management support to the nvme device. Namespace c=
reation
> > > requires contiguous block space for a simple method of allocation.
> > >=20
> > > I wrote this a few years ago based on Keith's fork and nvmeqemu for=
k and
> > > have recently re-synced with the latest trunk.=A0 Some data structu=
res in
> > > nvme.h are a bit more filled out that strictly necessary as this is=
 also the
> > > base for sr-iov and IOD patched to be submitted later.
> > >=20
> > Hi Matt,
> >=20
> > Nice! I'm always happy when new features for the nvme device is poste=
d!
> >=20
> > I'll be happy to review it, but I won't start going through it in
> > details because I believe the approach to supporting multiple namespa=
ces
> > is flawed. We had a recent discussion on this and I also got some
> > unrelated patches rejected due to implementing it similarly by carvin=
g
> > up the image.
> >=20
> > I have posted a long series that includes a patch for multiple
> > namespaces. It is implemented by introducing a fresh `nvme-ns` device
> > model that represents a namespace and attaches to a bus created by th=
e
> > parent `nvme` controller device.
> >=20
> > The core issue is that a qemu image /should/ be attachable to other
> > devices (say ide) and not strictly tied to the one device model. Thus=
,
> > we cannot just shove a bunch of namespaces into a single image.
> >=20
> > But, in light of your patch, I'm not convinced that my implementation=
 is
> > the correct solution. Maybe the abstraction should not be an `nvme-ns=
`
> > device, but a `nvme-nvm` device that when attached changes TNVMCAP an=
d
> > UNVMCAP? Maybe you have some input for this? Or we could have both an=
d
> > dynamically create the nvme-ns devices on top of nvme-nvm devices. I
> > think it would still require a 1-to-1 mapping, but it could be a way =
to
> > support the namespace management capability.
> >=20
> >=20
> > Cheers,
> > Klaus
> >=20
>=20

Hi Kevin,

This highlights another situation where the "1 image to 1 block device"
model doesn't fit that well with NVMe. Especially with the introduction
of "NVM Sets" in NVMe 1.4. It would be very nice to introduce a
'nvme-nvmset' device model that adds an NVM Set which the controller can
then create namespaces in.

Is it completely unacceptable for a device to use the image in such a
way that it would not make sense (aka present the same block device)
when attached to another device (ide, ...)?

I really have a hard time seeing how we could support these features
without violating the '1 image to 1 block device" model.


Cheers,
Klaus

