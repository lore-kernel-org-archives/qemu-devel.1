Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E5C072AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173E521783
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 09:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173E521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50047 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT12T-0001Gv-6H
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 05:26:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT0ze-0008Iz-LJ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hT0zd-0000uD-B2
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:23:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hT0zd-0000tA-2x
	for qemu-devel@nongnu.org; Tue, 21 May 2019 05:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 661BE87642;
	Tue, 21 May 2019 09:23:32 +0000 (UTC)
Received: from redhat.com (ovpn-112-26.ams2.redhat.com [10.36.112.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 493B8100200D;
	Tue, 21 May 2019 09:23:26 +0000 (UTC)
Date: Tue, 21 May 2019 10:23:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190521092322.GG25835@redhat.com>
References: <20190215103239.28640-1-berrange@redhat.com>
	<20190215103239.28640-2-berrange@redhat.com>
	<20190517190129.GA17245@habkost.net>
	<20190520095611.GD21976@redhat.com>
	<20190520205959.GC10764@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190520205959.GC10764@habkost.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 21 May 2019 09:23:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw: report invalid
 disable-legacy|modern usage for virtio-1-only devs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 05:59:59PM -0300, Eduardo Habkost wrote:
> On Mon, May 20, 2019 at 10:56:11AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Fri, May 17, 2019 at 04:01:29PM -0300, Eduardo Habkost wrote:
> > > Hi,
> > >=20
> > > Sorry for taking so long to look at this more closely:
> > >=20
> > > On Fri, Feb 15, 2019 at 10:32:38AM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > > > A number of virtio devices (gpu, crypto, mouse, keyboard, tablet)=
 only
> > > > support the virtio-1 (aka modern) mode. Currently if the user lau=
nches
> > > > QEMU, setting those devices to enable legacy mode, QEMU will sile=
ntly
> > > > create them in modern mode, ignoring the user's (mistaken) reques=
t.
> > > >=20
> > > > This patch introduces proper data validation so that an attempt t=
o
> > > > configure a virtio-1-only devices in legacy mode gets reported as=
 an
> > > > error to the user.
> > > >=20
> > > > Checking this required introduction of a new field to explicitly =
track
> > > > what operating model is to be used for a device, separately from =
the
> > > > disable_modern and disable_legacy fields that record the user's
> > > > requested configuration.
> > >=20
> > > I'm still trying to understand why we need to add a new field.
> > >=20
> > > If disable_modern, disable_legacy and mode are always expected to
> > > be consistent with each other, why do we need another field?
> > >=20
> > > If they are not always consistent with each other, when exactly
> > > do we want them to be inconsistent, and why?
> >=20
> > The pain point is that we're using the existing variables to record
> > two distinct pieces of information
> >=20
> >  - The user's request for modern vs legacy
> >  - The PCI bus requirements for modern vs legacy
> >=20
> > The existing code would overwrite the user's setting for
> > "disable_legacy" when deciding whether the device is in
> > a PCI or PCIe port. This happens in virtio_pci_realize.
> >=20
> > We can only report errors with the user's requested config
> > after the sub-classes call virtio_pci_force_virtio_1, but
> > this doesn't happen until virtio_${subclass}_pci_release.
> >=20
> > So by the time we're able to report errors, virtio_pci_realize
> > has already overwritten the user's disable_legacy setting, so
> > we've lost the very piece of info we need to check to report
> > errors with.
>=20
> Oh, that's the information I was missing.  Thanks!
>=20
> >=20
> > Given the ordering of virtio_pci_realize vs the calls
> > to virtio_pci_force_virtio_1 by subclasses, I don't see any
> > option other than to use separate variables for the two
> > distinct pieces of information.
>=20
> We could replace the virtio_pci_force_virtio_1() calls with a new
> VirtioDeviceClass::virtio_1_only boolean field, to be handled by
> virtio_pci_realize() before overriding disable_legacy.

Yes, that would be a desirable thing todo in future to get the error
checking done sooner in virtio_pci_realize() only.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

