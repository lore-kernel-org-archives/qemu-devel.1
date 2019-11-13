Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C69C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D54206ED
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 18:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XikeilaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D54206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUxNe-000168-J6
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 13:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iUxMp-0000dH-KU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iUxMn-0004Vk-3t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:27:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iUxMm-0004TM-UX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 13:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573669662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8+3VpgYMyFctHYQ4SWJKjzi6tCAATkfniPoXj3ktek=;
 b=XikeilaPqsb2gMi0QQYnKBUjQLVLpS8cbZKF8dN/3XQhxZau4eWOD+hPdgUzFxIb0U9Yr9
 TEok3xrF0+84hzTHgTEg4T5YVd7/3OvhPs16szclatWRiNu0jqhqBdsWUIotRVBnSTJWt6
 RD4ELH7njchsBjabrADG/Wl7MBGOsSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-bd9cvnmJMQ-1dcdsyELZPg-1; Wed, 13 Nov 2019 13:27:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EA4F800C77;
 Wed, 13 Nov 2019 18:27:36 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F08038DE5;
 Wed, 13 Nov 2019 18:27:34 +0000 (UTC)
Date: Wed, 13 Nov 2019 11:27:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v9 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20191113112733.49542ebc@x1.home>
In-Reply-To: <20191113112417.6e40ce96.cohuck@redhat.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-2-git-send-email-kwankhede@nvidia.com>
 <20191112153005.53bf324c@x1.home>
 <20191113112417.6e40ce96.cohuck@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bd9cvnmJMQ-1dcdsyELZPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, cjia@nvidia.com,
 kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, Zhengxiao.zx@Alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, dgilbert@redhat.com, zhi.a.wang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru,
 Kirti Wankhede <kwankhede@nvidia.com>, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 11:24:17 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 12 Nov 2019 15:30:05 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
>=20
> > On Tue, 12 Nov 2019 22:33:36 +0530
> > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> >  =20
> > > - Defined MIGRATION region type and sub-type.
> > > - Used 3 bits to define VFIO device states.
> > >     Bit 0 =3D> _RUNNING
> > >     Bit 1 =3D> _SAVING
> > >     Bit 2 =3D> _RESUMING
> > >     Combination of these bits defines VFIO device's state during migr=
ation
> > >     _RUNNING =3D> Normal VFIO device running state. When its reset, i=
t
> > > =09=09indicates _STOPPED state. when device is changed to
> > > =09=09_STOPPED, driver should stop device before write()
> > > =09=09returns.
> > >     _SAVING | _RUNNING =3D> vCPUs are running, VFIO device is running=
 but
> > >                           start saving state of device i.e. pre-copy =
state
> > >     _SAVING  =3D> vCPUs are stopped, VFIO device should be stopped, a=
nd   =20
> >=20
> > s/should/must/
> >  =20
> > >                 save device state,i.e. stop-n-copy state
> > >     _RESUMING =3D> VFIO device resuming state.
> > >     _SAVING | _RESUMING and _RUNNING | _RESUMING =3D> Invalid states =
  =20
> >=20
> > A table might be useful here and in the uapi header to indicate valid
> > states: =20
>=20
> I like that.
>=20
> >=20
> > | _RESUMING | _SAVING | _RUNNING | Description
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     0     |    0    |     0    | Stopped, not saving or resuming (a)
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     0     |    0    |     1    | Running, default state
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     0     |    1    |     0    | Stopped, migration interface in save=
 mode
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     0     |    1    |     1    | Running, save mode interface, iterat=
ive
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     1     |    0    |     0    | Stopped, migration resume interface =
active
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     1     |    0    |     1    | Invalid (b)
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     1     |    1    |     0    | Invalid (c)
> > +-----------+---------+----------+-------------------------------------=
-----
> > |     1     |    1    |     1    | Invalid (d)
> >=20
> > I think we need to consider whether we define (a) as generally
> > available, for instance we might want to use it for diagnostics or a
> > fatal error condition outside of migration.
> >=20
> > Are there hidden assumptions between state transitions here or are
> > there specific next possible state diagrams that we need to include as
> > well? =20
>=20
> Some kind of state-change diagram might be useful in addition to the
> textual description anyway. Let me try, just to make sure I understand
> this correctly:
>=20
> 1) 0/0/1 ---(trigger driver to start gathering state info)---> 0/1/1
> 2) 0/0/1 ---(tell driver to stop)---> 0/0/0
> 3) 0/1/1 ---(tell driver to stop)---> 0/1/0
> 4) 0/0/1 ---(tell driver to resume with provided info)---> 1/0/0

I think this is to switch into resuming mode, the data will follow

> 5) 1/0/0 ---(driver is ready)---> 0/0/1
> 6) 0/1/1 ---(tell driver to stop saving)---> 0/0/1

I think also:

0/0/1 --> 0/1/0 If user chooses to go directly to stop and copy

0/0/0 and 0/0/1 should be reachable from any state, though I could see
that a vendor driver could fail transition from 1/0/0 -> 0/0/1 if the
received state is incomplete.  Somehow though a user always needs to
return the device to the initial state, so how does device_state
interact with the reset ioctl?  Would this automatically manipulate
device_state back to 0/0/1?
=20
> Not sure about the usefulness of 2). Also, is 4) the only way to
> trigger resuming? And is the change in 5) performed by the driver, or
> by userspace?
>=20
> Are any other state transitions valid?
>=20
> (...)
>=20
> > > + * Sequence to be followed for _SAVING|_RUNNING device state or pre-=
copy phase
> > > + * and for _SAVING device state or stop-and-copy phase:
> > > + * a. read pending_bytes. If pending_bytes > 0, go through below ste=
ps.
> > > + * b. read data_offset, indicates kernel driver to write data to sta=
ging buffer.
> > > + *    Kernel driver should return this read operation only after wri=
ting data to
> > > + *    staging buffer is done.   =20
> >=20
> > "staging buffer" implies a vendor driver implementation, perhaps we
> > could just state that data is available from (region + data_offset) to
> > (region + data_offset + data_size) upon return of this read operation.
> >  =20
> > > + * c. read data_size, amount of data in bytes written by vendor driv=
er in
> > > + *    migration region.
> > > + * d. read data_size bytes of data from data_offset in the migration=
 region.
> > > + * e. process data.
> > > + * f. Loop through a to e. Next read on pending_bytes indicates that=
 read data
> > > + *    operation from migration region for previous iteration is done=
.   =20
> >=20
> > I think this indicate that step (f) should be to read pending_bytes, th=
e
> > read sequence is not complete until this step.  Optionally the user can
> > then proceed to step (b).  There are no read side-effects of (a) afaict=
.
> >=20
> > Is the use required to reach pending_bytes =3D=3D 0 before changing
> > device_state, particularly transitioning to !_RUNNING?  Presumably the
> > user can exit this sequence at any time by clearing _SAVING. =20
>=20
> That would be transition 6) above (abort saving and continue). I think
> it makes sense not to forbid this.
>=20
> >  =20
> > > + *
> > > + * Sequence to be followed while _RESUMING device state:
> > > + * While data for this device is available, repeat below steps:
> > > + * a. read data_offset from where user application should write data=
.
> > > + * b. write data of data_size to migration region from data_offset.
> > > + * c. write data_size which indicates vendor driver that data is wri=
tten in
> > > + *    staging buffer. Vendor driver should read this data from migra=
tion
> > > + *    region and resume device's state.   =20
> >=20
> > The device defaults to _RUNNING state, so a prerequisite is to set
> > _RESUMING and clear _RUNNING, right? =20
>=20
> Transition 4) above. Do we need
> 7) 0/0/0 ---(tell driver to resume with provided info)---> 1/0/0
> as well? (Probably depends on how sensible the 0/0/0 state is.)

I think we must unless we require the user to transition from 0/0/1 to
1/0/0 in a single operation, but I'd prefer to make 0/0/0 generally
available.  Thanks,

Alex


