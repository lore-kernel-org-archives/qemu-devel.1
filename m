Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DACAC4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16034216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16034216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQzD-0003sK-DT
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hjQxH-00024T-DC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hjQx5-0002bN-6O
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:20:49 -0400
Received: from charlie.dont.surf ([128.199.63.193]:51918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hjQwe-0000jw-6T; Fri, 05 Jul 2019 12:20:20 -0400
Received: from bogfinke (ip-5-186-120-196.cgn.fibianet.dk [5.186.120.196])
 by charlie.dont.surf (Postfix) with ESMTPSA id 46527BF607;
 Fri,  5 Jul 2019 16:20:15 +0000 (UTC)
Date: Fri, 5 Jul 2019 18:20:14 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190705162013.GB4707@bogfinke>
Mail-Followup-To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=
 <berrange@redhat.com>, 
 qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com,
 lersek@redhat.com
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <20190705133616.GA4707@bogfinke>
 <20190705134929.GM32473@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190705134929.GM32473@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multiple
 namespaces
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 02:49:29PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jul 05, 2019 at 03:36:17PM +0200, Klaus Birkelund wrote:
> > On Fri, Jul 05, 2019 at 09:23:33AM +0200, Klaus Birkelund Jensen wrot=
e:
> > > This adds support for multiple namespaces by introducing a new 'nvm=
e-ns'
> > > device model. The nvme device creates a bus named from the device n=
ame
> > > ('id'). The nvme-ns devices then connect to this and registers
> > > themselves with the nvme device.
> > >=20
> > > This changes how an nvme device is created. Example with two namesp=
aces:
> > >=20
> > >   -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
> > >   -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
> > >   -device nvme,serial=3Ddeadbeef,id=3Dnvme0
> > >   -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
> > >   -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2
> > >=20
> > > A maximum of 256 namespaces can be configured.
> > >=20
> > =20
> > Well that was embarrasing.
> >=20
> > This patch breaks nvme-test.c. Which I obviously did not run.
> >=20
> > In my defense, the test doesn't do much currently, but I'll of course
> > fix the test for v2.
>=20
> That highlights a more serious problem.  This series changes the syntx
> for configuring the nvme device in a way that is not backwards compatib=
le.
> So anyone who is using QEMU with NVME will be broken when they upgrade
> to the next QEMU release.
>=20
> I understand why you wanted to restructure things to have a separate
> nvme-ns device, but there needs to be some backcompat support in there
> for the existing syntax to avoid breaking current users IMHO.
>=20
=20
Hi Daniel,

I raised this issue previously. I suggested that we keep the drive
property for the nvme device and only accept either that or an nvme-ns
device to be configured (but not both).

That would keep backward compatibilty, but enforce the use of nvme-ns
for any setup that requires multiple namespaces.

Would that work?

Cheers,
Klaus

