Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A63AC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45F9F208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F9F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59143 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXZ3-0004Mb-Ks
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:34:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVXXv-0003nq-0R
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVXXt-0006R5-SC
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hVXXt-0006O4-LH; Tue, 28 May 2019 04:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD2CE7F746;
	Tue, 28 May 2019 08:33:19 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB40910027D2;
	Tue, 28 May 2019 08:33:13 +0000 (UTC)
Date: Tue, 28 May 2019 10:33:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190528103311.5d660c27.cohuck@redhat.com>
In-Reply-To: <573cd34d-fc70-b26f-92f1-4eafd7126e87@redhat.com>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<573cd34d-fc70-b26f-92f1-4eafd7126e87@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 28 May 2019 08:33:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
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
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 May 2019 10:29:09 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.05.19 21:45, Christian Borntraeger wrote:
> >=20
> >=20
> > On 24.05.19 21:00, David Hildenbrand wrote: =20
> >> On 24.05.19 20:36, David Hildenbrand wrote: =20
> >>> On 24.05.19 20:28, Christian Borntraeger wrote: =20
> >>>>
> >>>>
> >>>> On 24.05.19 20:04, David Hildenbrand wrote: =20
> >>>>> On 24.05.19 19:54, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>>>>> Hi Christian,
> >>>>>>
> >>>>>> I'm having hard time to understand why the S390_IPL object calls
> >>>>>> qemu_register_reset(qdev_reset_all_fn) in its realize() method, wh=
ile
> >>>>>> being QOM'ified (it has a reset method).
> >>>>>>
> >>>>>> It doesn't seem to have a qdev children added explicitly to it.
> >>>>>> I see it is used as a singleton, what else am I missing?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>> Phil.
> >>>>>> =20
> >>>>>
> >>>>> Looks like I added it back then (~4 years ago) when converting it i=
nto a
> >>>>> TYPE_DEVICE.
> >>>>>
> >>>>> I could imagine that - back then - this was needed because only
> >>>>> TYPE_SYS_BUS_DEVICE would recursively get reset. =20
> >>>>
> >>>> Yes, back then singleton devices were not recursively resetted. Has =
that changed? =20
> >>>
> >>> Hacking that call out, I don't see it getting called anymore. So it is
> >>> still required. The question is if it can be reworked.
> >>> =20
> >>
> >> Yes, as it is not a sysbus device, it won't get reset.
> >> The owner (machine) has to take care of this. The following works:
> >>
> >>
> >> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> >> index b93750c14e..91a31c2cd0 100644
> >> --- a/hw/s390x/ipl.c
> >> +++ b/hw/s390x/ipl.c
> >> @@ -232,7 +232,6 @@ static void s390_ipl_realize(DeviceState *dev, Err=
or **errp)
> >>       */
> >>      ipl->compat_start_addr =3D ipl->start_addr;
> >>      ipl->compat_bios_start_addr =3D ipl->bios_start_addr;
> >> -    qemu_register_reset(qdev_reset_all_fn, dev);
> >>  error:
> >>      error_propagate(errp, err);
> >>  }
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index bbc6e8fa0b..658ab529a1 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -338,6 +338,11 @@ static inline void s390_do_cpu_ipl(CPUState *cs, =
run_on_cpu_data arg)
> >>      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> >>  }
> >> =20
> >> +static void s390_ipl_reset(void)
> >> +{
> >> +    qdev_reset_all(DEVICE(object_resolve_path_type("", TYPE_S390_IPL,=
 NULL)));
> >> +}
> >> +
> >>  static void s390_machine_reset(void)
> >>  {
> >>      enum s390_reset reset_type;
> >> @@ -353,6 +358,7 @@ static void s390_machine_reset(void)
> >>      case S390_RESET_EXTERNAL:
> >>      case S390_RESET_REIPL:
> >>          qemu_devices_reset();
> >> +        s390_ipl_reset();
> >>          s390_crypto_reset();
> >> =20
> >>          /* configure and start the ipl CPU only */
> >> =20
> >=20
> > While this patch is certainly ok, I find it disturbing that qdev device=
s are being resetted,
> > but qom devices not.
> >  =20
>=20
> Shall I send that as a proper patch, or do we want to stick to the
> existing approach until we have improved the general reset approach?

I don't think the current code is really broken, so personally I'd
prefer to just leave it alone until we figured out how the reset should
work in general.

