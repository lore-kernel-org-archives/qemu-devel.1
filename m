Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A10FC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF24215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 08:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF24215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iAo-0006Kc-4Z
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 04:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i4i9h-0005XY-HX
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i4i9f-0001RC-Kx
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 04:57:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i4i9f-0001Od-FG; Mon, 02 Sep 2019 04:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6FFEF3084212;
 Mon,  2 Sep 2019 08:57:41 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0052A6012E;
 Mon,  2 Sep 2019 08:57:39 +0000 (UTC)
Date: Mon, 2 Sep 2019 09:57:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190902085736.GB30123@redhat.com>
References: <20190830161345.22436-1-lvivier@redhat.com>
 <20190830163413.GH4674@redhat.com>
 <20190830194543.6c1f5776@bahia.lan>
 <20190902062718.GG415@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190902062718.GG415@umbus.fritz.box>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 02 Sep 2019 08:57:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] pseries: do not allow
 memory-less/cpu-less NUMA node
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 02, 2019 at 04:27:18PM +1000, David Gibson wrote:
> On Fri, Aug 30, 2019 at 07:45:43PM +0200, Greg Kurz wrote:
> > On Fri, 30 Aug 2019 17:34:13 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Fri, Aug 30, 2019 at 06:13:45PM +0200, Laurent Vivier wrote:
> > > > When we hotplug a CPU on memory-less/cpu-less node, the linux ker=
nel
> > > > crashes.
> > > >=20
> > > > This happens because linux kernel needs to know the NUMA topology=
 at
> > > > start to be able to initialize the distance lookup table.
> > > >=20
> > > > On pseries, the topology is provided by the firmware via the exis=
ting
> > > > CPUs and memory information. Thus a node without memory and CPU c=
annot be
> > > > discovered by the kernel.
> > > >=20
> > > > To avoid the kernel crash, do not allow to start pseries with emp=
ty
> > > > nodes.
> > >=20
> > > This describes one possible guest OS. Is there any reasonable chanc=
e
> > > that a non-Linux guest might be able to handle this situation corre=
ctly,
> > > or do you expect any guest to have the same restriction ?
>=20
> That's... a more complicated question than you'd think.
>=20
> The problem here is it's not really obvious in PAPR how topology
> information for nodes without memory should be described in the device
> tree (which is the only way we given that information to the guest).
>=20
> It's possible there's some way to encode this information that would
> make AIX happy and we just need to fix Linux to cope with that, but
> it's not really clear what it would be.
>=20
> > I can try to grab an AIX image and give a try, but anyway this looks =
like
> > a very big hammer to me... :-\
>=20
> I'm not really sure why everyone seems to think losing zero-memory
> node capability is such a big deal.  It's never worked in practice on
> POWER and we can always put it back if we figure out a sensible way to
> do it.

I'm not that bothered - I just wanted to double check that we were not
intentionally breaking a non-Linux guest OS that was known to work today.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

