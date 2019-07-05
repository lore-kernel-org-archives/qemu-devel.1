Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63B1C4649E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCF5216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCF5216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjR5f-0000sl-Tv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hjR2O-0007N2-Ew
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hjR2M-0004xf-0H
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 12:26:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59108)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hjR2H-0004RO-9r; Fri, 05 Jul 2019 12:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59FD23082135;
 Fri,  5 Jul 2019 16:25:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A78C772AF;
 Fri,  5 Jul 2019 16:25:52 +0000 (UTC)
Date: Fri, 5 Jul 2019 17:25:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, keith.busch@intel.com, mreitz@redhat.com,
 lersek@redhat.com
Message-ID: <20190705162549.GP32473@redhat.com>
References: <20190705072333.17171-1-klaus@birkelund.eu>
 <20190705072333.17171-17-klaus@birkelund.eu>
 <20190705133616.GA4707@bogfinke>
 <20190705134929.GM32473@redhat.com>
 <20190705162013.GB4707@bogfinke>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190705162013.GB4707@bogfinke>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 05 Jul 2019 16:25:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 06:20:14PM +0200, Klaus Birkelund wrote:
> On Fri, Jul 05, 2019 at 02:49:29PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, Jul 05, 2019 at 03:36:17PM +0200, Klaus Birkelund wrote:
> > > On Fri, Jul 05, 2019 at 09:23:33AM +0200, Klaus Birkelund Jensen wr=
ote:
> > > > This adds support for multiple namespaces by introducing a new 'n=
vme-ns'
> > > > device model. The nvme device creates a bus named from the device=
 name
> > > > ('id'). The nvme-ns devices then connect to this and registers
> > > > themselves with the nvme device.
> > > >=20
> > > > This changes how an nvme device is created. Example with two name=
spaces:
> > > >=20
> > > >   -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
> > > >   -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
> > > >   -device nvme,serial=3Ddeadbeef,id=3Dnvme0
> > > >   -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
> > > >   -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2
> > > >=20
> > > > A maximum of 256 namespaces can be configured.
> > > >=20
> > > =20
> > > Well that was embarrasing.
> > >=20
> > > This patch breaks nvme-test.c. Which I obviously did not run.
> > >=20
> > > In my defense, the test doesn't do much currently, but I'll of cour=
se
> > > fix the test for v2.
> >=20
> > That highlights a more serious problem.  This series changes the synt=
x
> > for configuring the nvme device in a way that is not backwards compat=
ible.
> > So anyone who is using QEMU with NVME will be broken when they upgrad=
e
> > to the next QEMU release.
> >=20
> > I understand why you wanted to restructure things to have a separate
> > nvme-ns device, but there needs to be some backcompat support in ther=
e
> > for the existing syntax to avoid breaking current users IMHO.
> >=20
> =20
> Hi Daniel,
>=20
> I raised this issue previously. I suggested that we keep the drive
> property for the nvme device and only accept either that or an nvme-ns
> device to be configured (but not both).
>=20
> That would keep backward compatibilty, but enforce the use of nvme-ns
> for any setup that requires multiple namespaces.
>=20
> Would that work?

Yes, that would be viable, as an existing CLI arg usage would continue
to be supported as before.

We could also list the back compat syntax as a deprecation in the docs
(qemu-deprecated.texi) so that in a few releases in the future, we can
drop the old syntax and then use nvme-ns exclusively thereafter.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

