Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80999C3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439C72173E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439C72173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i51y4-0004ge-AU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kevin.tian@intel.com>) id 1i51x9-0003yU-1Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kevin.tian@intel.com>) id 1i51x5-0005RS-34
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:06:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:6694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kevin.tian@intel.com>)
 id 1i51x4-0005OH-4K
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:06:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Sep 2019 23:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,462,1559545200"; d="scan'208";a="176483762"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by orsmga008.jf.intel.com with ESMTP; 02 Sep 2019 23:05:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 23:05:52 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Sep 2019 23:05:49 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Sep 2019 23:05:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.32]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.53]) with mapi id 14.03.0439.000;
 Tue, 3 Sep 2019 14:05:47 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Thread-Topic: [PATCH v8 01/13] vfio: KABI for migration interface
Thread-Index: AQHVXEPM6Ds11z4g1kGhkyVJXk+n4qcQheKAgAKxOUCAACZ6gIAGGWQQ
Date: Tue, 3 Sep 2019 06:05:46 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D560CE1@SHSMSX104.ccr.corp.intel.com>
References: <1566845753-18993-1-git-send-email-kwankhede@nvidia.com>
 <1566845753-18993-2-git-send-email-kwankhede@nvidia.com>
 <20190828145045.20f2a7b3@x1.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D55312B@SHSMSX104.ccr.corp.intel.com>
 <20190830101517.6b42df0a@x1.home>
In-Reply-To: <20190830101517.6b42df0a@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmRkZDBhZTEtZTIxOC00YWRjLWE1ZmMtM2Y5YjcwOTg2MTNmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic21URkVjeHJFMHJ2ZFZHXC9ieHNreUNjc2UycnVkOW1rQ2xMWFUwXC9vUURHcnYwTDAxSlFPSyszajl0ZEx1MHBQIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH v8 01/13] vfio: KABI for migration interface
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
Cc: "Zhengxiao.zx@Alibaba-inc.com" <Zhengxiao.zx@Alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
 Ziye" <ziye.yang@intel.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "Wang, 
 Zhi A" <zhi.a.wang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "felipe@nutanix.com" <felipe@nutanix.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "Zhao,
 Yan Y" <yan.y.zhao@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "Ken.Xue@amd.com" <Ken.Xue@amd.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Saturday, August 31, 2019 12:15 AM
>=20
> On Fri, 30 Aug 2019 07:25:59 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
>=20
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Thursday, August 29, 2019 4:51 AM
> > >
> > > On Tue, 27 Aug 2019 00:25:41 +0530
> > > Kirti Wankhede <kwankhede@nvidia.com> wrote:
> > >
> > > > - Defined MIGRATION region type and sub-type.
> > > > - Used 3 bits to define VFIO device states.
> > > >     Bit 0 =3D> _RUNNING
> > > >     Bit 1 =3D> _SAVING
> > > >     Bit 2 =3D> _RESUMING
> > > >     Combination of these bits defines VFIO device's state during mi=
gration
> > > >     _STOPPED =3D> All bits 0 indicates VFIO device stopped.
> > > >     _RUNNING =3D> Normal VFIO device running state.
> > > >     _SAVING | _RUNNING =3D> vCPUs are running, VFIO device is runni=
ng
> but
> > > start
> > > >                           saving state of device i.e. pre-copy stat=
e
> > > >     _SAVING  =3D> vCPUs are stoppped, VFIO device should be stopped=
, and
> > > >                           save device state,i.e. stop-n-copy state
> > > >     _RESUMING =3D> VFIO device resuming state.
> > > >     _SAVING | _RESUMING =3D> Invalid state if _SAVING and _RESUMING
> bits
> > > are set
> > > >     Bits 3 - 31 are reserved for future use. User should perform
> > > >     read-modify-write operation on this field.
> > > > - Defined vfio_device_migration_info structure which will be placed=
 at
> 0th
> > > >   offset of migration region to get/set VFIO device related informa=
tion.
> > > >   Defined members of structure and usage on read/write access:
> > > >     * device_state: (read/write)
> > > >         To convey VFIO device state to be transitioned to. Only 3 b=
its are
> used
> > > >         as of now, Bits 3 - 31 are reserved for future use.
> > > >     * pending bytes: (read only)
> > > >         To get pending bytes yet to be migrated for VFIO device.
> > > >     * data_offset: (read only)
> > > >         To get data offset in migration region from where data exis=
t during
> > > >         _SAVING, from where data should be written by user space
> application
> > > >         during _RESUMING state and while read dirty pages bitmap.
> > > >     * data_size: (read/write)
> > > >         To get and set size of data copied in migration region duri=
ng
> _SAVING
> > > >         and _RESUMING state.
> > > >     * start_pfn, page_size, total_pfns: (write only)
> > > >         To get bitmap of dirty pages from vendor driver from given
> > > >         start address for total_pfns.
> > > >     * copied_pfns: (read only)
> > > >         To get number of pfns bitmap copied in migration region.
> > > >         Vendor driver should copy the bitmap with bits set only for
> > > >         pages to be marked dirty in migration region. Vendor driver
> > > >         should return VFIO_DEVICE_DIRTY_PFNS_NONE if there are 0 pa=
ges
> > > dirty in
> > > >         requested range. Vendor driver should return
> > > VFIO_DEVICE_DIRTY_PFNS_ALL
> > > >         to mark all pages in the section as dirty.
> > > >
> > > > Migration region looks like:
> > > >  ------------------------------------------------------------------
> > > > |vfio_device_migration_info|    data section                      |
> > > > |                          |     ///////////////////////////////  |
> > > >  ------------------------------------------------------------------
> > > >  ^                              ^                              ^
> > > >  offset 0-trapped part        data_offset                 data_size
> > > >
> > > > Data section is always followed by vfio_device_migration_info
> > > > structure in the region, so data_offset will always be non-0.
> > > > Offset from where data is copied is decided by kernel driver, data
> > > > section can be trapped or mapped depending on how kernel driver
> > > > defines data section. If mmapped, then data_offset should be page
> > > > aligned, where as initial section which contain
> vfio_device_migration_info
> > > > structure might not end at offset which is page aligned.
> > > > Data_offset can be same or different for device data and dirty page=
s
> bitmap.
> > > > Vendor driver should decide whether to partition data section and h=
ow
> to
> > > > partition the data section. Vendor driver should return data_offset
> > > > accordingly.
> > > >
> > > > For user application, data is opaque. User should write data in the=
 same
> > > > order as received.
> > > >
> > > > Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> > > > Reviewed-by: Neo Jia <cjia@nvidia.com>
> > > > ---
> > > >  linux-headers/linux/vfio.h | 148
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 148 insertions(+)
> > > >
> > > > diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.=
h
> > > > index 24f505199f83..4bc0236b0898 100644
> > > > --- a/linux-headers/linux/vfio.h
> > > > +++ b/linux-headers/linux/vfio.h
> > > > @@ -372,6 +372,154 @@ struct vfio_region_gfx_edid {
> > > >   */
> > > >  #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
> > > >
> > > > +/* Migration region type and sub-type */
> > > > +#define VFIO_REGION_TYPE_MIGRATION	        (3)
> > > > +#define VFIO_REGION_SUBTYPE_MIGRATION	        (1)
> > > > +
> > > > +/**
> > > > + * Structure vfio_device_migration_info is placed at 0th offset of
> > > > + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device
> > > related migration
> > > > + * information. Field accesses from this structure are only suppor=
ted at
> > > their
> > > > + * native width and alignment, otherwise the result is undefined a=
nd
> > > vendor
> > > > + * drivers should return an error.
> > > > + *
> > > > + * device_state: (read/write)
> > > > + *      To indicate vendor driver the state VFIO device should be
> > > transitioned
> > > > + *      to. If device state transition fails, write on this field =
return error.
> > > > + *      It consists of 3 bits:
> > > > + *      - If bit 0 set, indicates _RUNNING state. When its reset, =
that
> indicates
> > > > + *        _STOPPED state. When device is changed to _STOPPED, driv=
er
> should
> > > stop
> > > > + *        device before write() returns.
> > > > + *      - If bit 1 set, indicates _SAVING state.
> > > > + *      - If bit 2 set, indicates _RESUMING state.
> >
> > please add a few words to explain _SAVING and _RESUMING, similar to
> > what you did for _RUNNING.
> >
> > > > + *      Bits 3 - 31 are reserved for future use. User should perfo=
rm
> > > > + *      read-modify-write operation on this field.
> > > > + *      _SAVING and _RESUMING bits set at the same time is invalid=
 state.
> >
> > what about _RUNNING | _RESUMING? Is it allowed?
>=20
> I think this would be post-copy migration, which I assume is
> theoretically supportable, but not necessarily (and not currently)
> supported by vendor drivers.  I'm not sure how a vendor driver reports
> the lack of this support though.

Yan is working on post-copy now. I talked to her about this open.
She will respond later after some thinking. Ideally we need a way
that user space can use to verify which combinations are available=20
before starting the post-copy process. It's not good to blindly start
post-copy and then fail due to failure to switch to desired state on
the dest machine.

>=20
> > > > + *
> > > > + * pending bytes: (read only)
> > > > + *      Number of pending bytes yet to be migrated from vendor dri=
ver
> > > > + *
> > > > + * data_offset: (read only)
> > > > + *      User application should read data_offset in migration regi=
on from
> > > where
> > > > + *      user application should read device data during _SAVING st=
ate or
> > > write
> > > > + *      device data during _RESUMING state or read dirty pages bit=
map.
> See
> > > below
> > > > + *      for detail of sequence to be followed.
> > > > + *
> > > > + * data_size: (read/write)
> > > > + *      User application should read data_size to get size of data=
 copied
> in
> > > > + *      migration region during _SAVING state and write size of da=
ta
> copied
> > > in
> > > > + *      migration region during _RESUMING state.
> > > > + *
> > > > + * start_pfn: (write only)
> > > > + *      Start address pfn to get bitmap of dirty pages from vendor=
 driver
> > > duing
> > > > + *      _SAVING state.
> > > > + *
> > > > + * page_size: (write only)
> > > > + *      User application should write the page_size of pfn.
> > > > + *
> > > > + * total_pfns: (write only)
> > > > + *      Total pfn count from start_pfn for which dirty bitmap is r=
equested.
> > > > + *
> > > > + * copied_pfns: (read only)
> >
> > 'copied' gives the impression as if the page content is copied. what ab=
out
> > 'dirty_pfns'? btw can this field merge with total_pfns?
>=20
> I don't agree with the implication that copied implies page content,
> we're working with a bitmap, so this is easily disproved.  I think the
> intent of 'copied' is to differentiate that 'total' is how many the
> user asked for, and 'copied' is how many they got.  It's not obvious to
> me whether there's anything that would prevent duplicate use of one
> register, ie. write total, read copied.  I'm not sure I see a huge
> advantage to it either though.

It's fine. I just had the impression that many kernel interfaces are=20
designed in such way, i.e., having the same field to carry-in user
requested number and then carry-out actually handled number.

>=20
> > > > + *      pfn count for which dirty bitmap is copied to migration re=
gion.
> > > > + *      Vendor driver should copy the bitmap with bits set only fo=
r pages
> to
> > > be
> > > > + *      marked dirty in migration region.
> > > > + *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE =
if
> > > none of the
> > > > + *        pages are dirty in requested range or rest of the range.
> > > > + *      - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL t=
o
> mark
> > > all
> > > > + *        pages dirty in the given range or rest of the range.
> > > > + *      - Vendor driver should return pfn count for which bitmap i=
s
> written in
> > > > + *        the region.
> > > > + *
> > > > + * Migration region looks like:
> > > > + *  --------------------------------------------------------------=
----
> > > > + * |vfio_device_migration_info|    data section                   =
   |
> > > > + * |                          |     //////////////////////////////=
/  |
> > > > + * ---------------------------------------------------------------=
---
> > > > + *   ^                              ^                             =
^
> > > > + *  offset 0-trapped part        data_offset                 data_=
size
> >
> > 'data_size' -> "data_offset + data_size"
>=20
> The diagram sort of implies that, but I don't think this is correct.  I
> believe it's more like:
>=20
> data_offset =3D data_start_offset
> data_size =3D data_end_offset - data_start_offset

I'm fine with replacing data_offset & data_size with data_start_
offset & data_end_offset.

>=20
> > > > + *
> > > > + * Data section is always followed by vfio_device_migration_info
> structure
> >
> > Data section is always following ..., or ... structure is always follow=
ed by
> > data section.
>=20
> The vfio_device_migration struct is always at the zero'th offset of the
> region, the data section is theoretically the remainder, but the used
> range of the data section is defined by the vendor driver via
> data_offset.

Isn't original description incorrect here? It implied data section sits at
offset zero, and then migration info...

>=20
> > > > + * in the region, so data_offset will always be non-0. Offset from=
 where
> > > data
> > > > + * is copied is decided by kernel driver, data section can be trap=
ped or
> > > > + * mapped or partitioned, depending on how kernel driver defines d=
ata
> > > section.
> > > > + * Data section partition can be defined as mapped by sparse mmap
> > > capability.
> > > > + * If mmapped, then data_offset should be page aligned, where as
> initial
> > > section
> > > > + * which contain vfio_device_migration_info structure might not en=
d at
> > > offset
> > > > + * which is page aligned.
> > > > + * Data_offset can be same or different for device data and dirty =
pages
> > > bitmap.
> > > > + * Vendor driver should decide whether to partition data section a=
nd
> how
> > > to
> > > > + * partition the data section. Vendor driver should return data_of=
fset
> > > > + * accordingly.
> >
> > Here lacks of high-level summary about how to differentiate reading dev=
ice
> > state from reading dirty page bitmap, when both use the same interface
> > (data_offset) to convey information to user space.
> >
> > From below sequence example, looks reading device state is initiated by
> > reading pending_bytes, while reading dirty bitmap is marked by writing
> > start_pfn. In case of shared data region between two operations, they h=
ave
> > to be mutually-exclusive i.e. one must wait for the other to complete. =
Even
> > when the region is partitioned, data_offset itself could be raced if pe=
nding_
> > bytes and start_pfn are accessed at the same time. How do we expect the
> > application to cope with it? Isn't it too limiting with such design?
> >
> > Since you anyway invent different sets of fields for two operations, wh=
y not
> > forcing partitioned flavor and then introduce two data_offset fields fo=
r each
> > other? This way the application is free to intermix device state and di=
rty
> > page collection for whatever needs.
>=20
> AIUI, it's the user's responsibility to consume the data they've
> asked to be provided before they perform the next operation, but the
> user can alternate between device state and dirty pages at will.  I
> agree though that the lifecycle of the data with regard to the vendor
> driver is lacking.  Nothing seems to indicate to the vendor driver that
> the data is consumed other than starting the next operation or turning
> off _SAVING.
>=20
> > > > + *
> > > > + * Sequence to be followed for _SAVING|_RUNNING device state or
> pre-
> > > copy phase
> > > > + * and for _SAVING device state or stop-and-copy phase:
> > > > + * a. read pending_bytes. If pending_bytes > 0, go through below s=
teps.
> > > > + * b. read data_offset, indicates kernel driver to write data to s=
taging
> > > buffer.
> > > > + * c. read data_size, amount of data in bytes written by vendor dr=
iver in
> > > > + *    migration region.
> > > > + * d. read data_size bytes of data from data_offset in the migrati=
on
> region.
> > > > + * e. process data.
> > > > + * f. Loop through a to e.
> > >
> > > Something needs to be said here about the availability of the data, f=
or
> > > example, what indicates to the vendor driver that the above operation=
 is
> > > complete?  Is the data immutable?
> >
> > I guess the vendor driver just continues to track pending_bytes for dir=
tied
> > device state, until exiting _SAVING state. Data is copied only when
> > pending_bytes is read by userspace. Copied data is immutable if data
> region
> > is mmapped. But yes, this part needs clarification.
> >
> > >
> > > > + *
> > > > + * To copy system memory content during migration, vendor driver
> should
> > > be able
> > > > + * to report system memory pages which are dirtied by that driver.=
 For
> such
> > > > + * dirty page reporting, user application should query for a range=
 of
> GFNs
> > > > + * relative to device address space (IOVA), then vendor driver sho=
uld
> > > provide
> > > > + * the bitmap of pages from this range which are dirtied by him th=
rough
> > > > + * migration region where each bit represents a page and bit set t=
o 1
> > > represents
> > > > + * that the page is dirty.
> > > > + * User space application should take care of copying content of s=
ystem
> > > memory
> > > > + * for those pages.
> > >
> > > Can we say that device state and dirty pfn operations on the data
> > > area may be intermixed in any order the user chooses?
> >
> > this part is very opaque from previous description. Now I'm inclined to
> > vote for no-intermix design. There is really no good to force some
> > dependency between retrieving device state and dirty page bitmap.
>=20
> I'm confused, the state of the device continues to change so long as it
> is _RUNNING.  The device may also continue to dirty pages in the
> _RUNNING state.  So how could we not have both occurring at the same
> time and therefore must support the user deciding which to sample in
> each iteration?

I may not make it clear. Actually I'm with you on that device state and
dirty pages are changed in parallel in the _RUNNING state. and two are
irrelevant by definition. Then why did we design an interface, as this
patch suggested, having two states sharing the same region thus forcing=20
the application to manage unnecessary contention in-between? For
example, if the application creates two threads, with one to collect=20
dirty page bitmaps and the other to dump device state, such design=20
requires the application to protect the data region between two=20
threads - one thread has to wait until the other drains the new state=20
reported by kernel driver, otherwise the data region will be messed.

On the other hand, if we explicitly design two sub-regions for device
state and dirty bitmap and split the control interface, two can
be enquired simultaneously. As earlier discussed, two states already
have most of their control fields separate except data_offset. Now=20
just move one step further to have two data_offset, then two states
are completely decoupled and the application is lock-free to access=20
any sub-region at any time.

>=20
> > > Should we specify that bits accumulate since EITHER a) _SAVING state =
is
> > > enabled or b) a given pfn was last reported via the below sequence (i=
e.
> > > dirty bits are cleared once reported)?
> > >
> > > How does QEMU handle the fact that IOVAs are potentially dynamic whil=
e
> > > performing the live portion of a migration?  For example, each time a
> > > guest driver calls dma_map_page() or dma_unmap_page(), a
> > > MemoryRegionSection pops in or out of the AddressSpace for the device
> > > (I'm assuming a vIOMMU where the device AddressSpace is not
> > > system_memory).  I don't see any QEMU code that intercepts that chang=
e
> > > in the AddressSpace such that the IOVA dirty pfns could be recorded a=
nd
> > > translated to GFNs.  The vendor driver can't track these beyond getti=
ng
> > > an unmap notification since it only knows the IOVA pfns, which can be
> > > re-used with different GFN backing.  Once the DMA mapping is torn dow=
n,
> > > it seems those dirty pfns are lost in the ether.  If this works in QE=
MU,
> > > please help me find the code that handles it.
> >
> > I'm curious about this part too. Interestingly, I didn't find any log_s=
ync
> > callback registered by emulated devices in Qemu. Looks dirty pages
> > by emulated DMAs are recorded in some implicit way. But KVM always
> > reports dirty page in GFN instead of IOVA, regardless of the presence o=
f
> > vIOMMU. If Qemu also tracks dirty pages in GFN for emulated DMAs
> >  (translation can be done when DMA happens), then we don't need
> > worry about transient mapping from IOVA to GFN. Along this way we
> > also want GFN-based dirty bitmap being reported through VFIO,
> > similar to what KVM does. For vendor drivers, it needs to translate
> > from IOVA to HVA to GFN when tracking DMA activities on VFIO
> > devices. IOVA->HVA is provided by VFIO. for HVA->GFN, it can be
> > provided by KVM but I'm not sure whether it's exposed now.
> >
> > >
> > > > + *
> > > > + * Steps to get dirty page bitmap:
> > > > + * a. write start_pfn, page_size and total_pfns.
> > >
> > > This is not well specified.  Is it intended that the user write all
> > > three of these on every iteration, or could they write start_pfn=3D0,
> > > page_size=3D4K, total_pfns=3D1, complete the steps below, then write
> > > start_pfn=3D1 and immediately begin the next iteration?  They've writ=
ten
> > > all three, though not all on the current iteration, does that count?
> > > Furthermore, could the user simple re-read copied_pfns to determine i=
f
> > > anything in the previously setup range has been re-dirtied?
> > >
> > > IOW, are these three "registers" sticky or do the below operations
> > > invalidate them?  If they're invalidated, then there needs to be a
> > > mechanism to generate an error, such as below.
> > >
> > > > + * b. read copied_pfns. Vendor driver should take one of the below
> action:
> > > > + *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_NONE i=
f
> > > driver
> > > > + *       doesn't have any page to report dirty in given range or r=
est of the
> > > > + *       range. Exit the loop.
> > > > + *     - Vendor driver should return VFIO_DEVICE_DIRTY_PFNS_ALL to
> mark
> > > all
> > > > + *       pages dirty for given range or rest of the range. User sp=
ace
> > > > + *       application mark all pages in the range as dirty and exit=
 the loop.
> > > > + *     - Vendor driver should return copied_pfns and provide bitma=
p for
> > > > + *       copied_pfn in migration region.
> > >
> > > Read returns errno if the pre-requisite registers are not valid?
> > >
> > > > + * c. read data_offset, where vendor driver has written bitmap.
> > > > + * d. read bitmap from the migration region from data_offset.
> > > > + * e. Iterate through steps a to d while (total copied_pfns < tota=
l_pfns)
> > >
> > > It seems like the intent here is that the user effectively does:
> > >
> > > start_pfn +=3D copied_pfns
> > > total_pfns -=3D copied_pfns
> > > page_size =3D page_size?
> > >
> > > But are they under any obligation to do so?
> > >
> > > Also same question above regarding data availability/life-cycle.  Is
> > > the vendor driver responsible for making the data available
> > > indefinitely?  Seems it's only released at the next iteration, or
> > > re-use of the data area for another operation, or clearing of the
> > > _SAVING state bit.
> > >
> > > > + * Sequence to be followed while _RESUMING device state:
> > > > + * While data for this device is available, repeat below steps:
> > > > + * a. read data_offset from where user application should write da=
ta.
> > > > + * b. write data of data_size to migration region from data_offset=
.
> > > > + * c. write data_size which indicates vendor driver that data is w=
ritten
> in
> > > > + *    staging buffer.
> > > > + *
> > > > + * For user application, data is opaque. User should write data in=
 the
> same
> > > > + * order as received.
> > >
> > > Additionally, implicit synchronization between _SAVING and _RESUMING
> > > ends within the vendor driver is assumed.
> > >
> > > Are there any assumptions we haven't covered with respect to mmaps?
> > > For instance, can the user setup mmaps at any time or only during
> > > certain device states?  Are there recommended best practices for user=
s
> > > to only setup mmaps during _SAVING or _RESUMING?  If we had a revoke
> > > mechanism, it might be nice to use it when either of these bits are
> > > cleared.  Thanks,
> >
> > another open for mmaps is how many pages to map. copied_pfns
> > carries only the number of copied pages. They scatter in the bitmap
> > while application doesn't know how long the bitmap is. Do we
> > expect the application to map pages one-by-one, until scanned
> > dirty pages is equal to copied_pfns?
>=20
> I think we expect userspace to mmap according to the sparse mmap
> capability of the region.  The vendor driver then chooses whether to
> expose the current data set within the mmap region, outside the mmap
> region, or some mix of both, depending on their requirements.  Thanks,

Thanks, it makes sense.

>=20
> Alex
>=20
> > > > + */
> > > > +
> > > > +struct vfio_device_migration_info {
> > > > +        __u32 device_state;         /* VFIO device state */
> > > > +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> > > > +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> > > > +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
> > > > +#define VFIO_DEVICE_STATE_MASK
> (VFIO_DEVICE_STATE_RUNNING | \
> > > > +                                     VFIO_DEVICE_STATE_SAVING | \
> > > > +                                     VFIO_DEVICE_STATE_RESUMING)
> > > > +#define VFIO_DEVICE_STATE_INVALID   (VFIO_DEVICE_STATE_SAVING
> | \
> > > > +                                     VFIO_DEVICE_STATE_RESUMING)
> > > > +        __u32 reserved;
> > > > +        __u64 pending_bytes;
> > > > +        __u64 data_offset;
> > > > +        __u64 data_size;
> > > > +        __u64 start_pfn;
> > > > +        __u64 page_size;
> > > > +        __u64 total_pfns;
> > > > +        __u64 copied_pfns;
> > > > +#define VFIO_DEVICE_DIRTY_PFNS_NONE     (0)
> > > > +#define VFIO_DEVICE_DIRTY_PFNS_ALL      (~0ULL)
> > > > +} __attribute__((packed));
> > > > +
> > > >  /*
> > > >   * The MSIX mappable capability informs that MSIX data of a BAR ca=
n
> be
> > > mmapped
> > > >   * which allows direct access to non-MSIX registers which happened=
 to
> be
> > > within
> >


