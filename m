Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74B5CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1C9222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1C9222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNq1-0001nG-Qa
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iLNp8-0000kg-9k
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:41:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iLNp6-0006ar-IU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iLNp6-0006a0-A3; Fri, 18 Oct 2019 04:41:24 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC0B9307B19B;
 Fri, 18 Oct 2019 08:41:22 +0000 (UTC)
Received: from gondolin (dhcp-192-202.str.redhat.com [10.33.192.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 321631001B0B;
 Fri, 18 Oct 2019 08:41:19 +0000 (UTC)
Date: Fri, 18 Oct 2019 10:41:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
Message-ID: <20191018104116.341e0cd0.cohuck@redhat.com>
In-Reply-To: <620c3bfe-2163-6bb4-cdc9-689dcd74dcac@redhat.com>
References: <20191017142123.1236-1-thuth@redhat.com>
 <20191017163402.43437191.cohuck@redhat.com>
 <2e689f2b-9bed-e40e-c761-6f38efaae635@redhat.com>
 <181d44b3-3333-91a3-0003-d312e8ab4805@redhat.com>
 <620c3bfe-2163-6bb4-cdc9-689dcd74dcac@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 08:41:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 08:35:17 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17/10/2019 20.18, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/17/19 4:40 PM, Thomas Huth wrote: =20
> >> On 17/10/2019 16.34, Cornelia Huck wrote: =20
> >>> On Thu, 17 Oct 2019 16:21:23 +0200
> >>> Thomas Huth <thuth@redhat.com> wrote:
> >>> =20
> >>>> There is no USB on s390x, so running qemu-system-s390x with
> >>>> "-machine ...,usb=3Don" is certainly wrong. Emit a warning to make
> >>>> the users aware of their misconfiguration.
> >>>>
> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>> ---
> >>>> =C2=A0 After a year or two, we could finally turn this into a hard e=
rror,
> >>>> =C2=A0 but I think we should give the users some time to fix their c=
ommand
> >>>> =C2=A0 lines first, so I'm initially only emitting a warning here.
> >>>>
> >>>> =C2=A0 hw/s390x/s390-virtio-ccw.c | 4 ++++
> >>>> =C2=A0 1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >>>> index d3edeef0ad..af8c4c0daf 100644
> >>>> --- a/hw/s390x/s390-virtio-ccw.c
> >>>> +++ b/hw/s390x/s390-virtio-ccw.c
> >>>> @@ -243,6 +243,10 @@ static void ccw_init(MachineState *machine)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtualCssBus *css_bus;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev;
> >>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (machine->usb) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("This machin=
e does not support USB"); =20
> >>>
> >>> I'm wondering if this is the only machine type not supporting usb...
> >>> if not, how are others handling it? =20
> >>
> >> I think most machines are silently ignoring it, like we did on s390x
> >> until now, too.
> >> =20
> >>> The usb parsing code in machine.c does not care if usb is even
> >>> configured (CONFIG_USB). =20
> >>
> >> machine.c is common code, so you can not use CONFIG_USB there. =20
> >=20
> > We already have:
> >=20
> > bool target_words_bigendian(void)
> > {
> > #if defined(TARGET_WORDS_BIGENDIAN)
> > =C2=A0=C2=A0=C2=A0 return true;
> > #else
> > =C2=A0=C2=A0=C2=A0 return false;
> > #endif
> > } =20
>=20
> ... and kvm_available() and xen_available() ...
>=20
> > diff --git a/hw/usb/machine.c b/hw/usb/machine.c
> > new file mode 100644
> > index 0000000000..5381928479
> > --- /dev/null
> > +++ b/hw/usb/machine.c
> > @@ -0,0 +1,12 @@
> > +#include "qemu/osdep.h"
> > +#include "hw/boards.h"
> > +#include "config-devices.h"
> > +
> > +bool machine_has_usb(void)
> > +{
> > +#if defined(CONFIG_USB)
> > +=C2=A0=C2=A0=C2=A0 return true;
> > +#else
> > +=C2=A0=C2=A0=C2=A0 return false;
> > +#endif
> > +} =20
>=20
> I think I'd rather call it usb_available() (like the other _available()
> functions) and put it into arch_init.c (and rename that file to arch.c
> or target.c or something like that).

I like 'usb_available()'.

Maybe we should also warn for igd_passthru if not xen_available()? Not
sure how helpful that is, though. Even if we warn and put it in the
deprecation notes, I'm not sure how much we'd gain if we were to make
it an actual error.

