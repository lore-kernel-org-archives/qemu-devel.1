Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8222C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3616B20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 21:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3616B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOU30-0001Jw-92
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 17:24:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hOU1i-0000hs-Co
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:23:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hOU1e-00081c-FL
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hOU1d-00080g-RM
	for qemu-devel@nongnu.org; Wed, 08 May 2019 17:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 077B389C48;
	Wed,  8 May 2019 21:22:50 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37A3C5D717;
	Wed,  8 May 2019 21:22:43 +0000 (UTC)
Date: Wed, 8 May 2019 15:22:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190508152242.4b54a5e7@x1.home>
In-Reply-To: <20190508112740.GA24397@joy-OptiPlex-7040>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190508112740.GA24397@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 08 May 2019 21:22:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio/mdev: add version attribute
 for mdev device
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
	Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 07:27:40 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Wed, May 08, 2019 at 05:18:26AM +0800, Alex Williamson wrote:
> > On Sun,  5 May 2019 21:49:04 -0400
> > Yan Zhao <yan.y.zhao@intel.com> wrote:
> >  =20
> > > version attribute is used to check two mdev devices' compatibility.
> > >=20
> > > The key point of this version attribute is that it's rw.
> > > User space has no need to understand internal of device version and no
> > > need to compare versions by itself.
> > > Compared to reading version strings from both two mdev devices being
> > > checked, user space only reads from one mdev device's version attribu=
te.
> > > After getting its version string, user space writes this string into =
the
> > > other mdev device's version attribute. Vendor driver of mdev device
> > > whose version attribute being written will check device compatibility=
 of
> > > the two mdev devices for user space and return success for compatibil=
ity
> > > or errno for incompatibility.
> > > So two readings of version attributes + checking in user space are now
> > > changed to one reading + one writing of version attributes + checking=
 in
> > > vendor driver.
> > > Format and length of version strings are now private to vendor driver
> > > who can define them freely.
> > >=20
> > >              __ user space
> > >               /\          \
> > >              /             \write
> > >             / read          \
> > >      ______/__           ___\|/___
> > >     | version |         | version |-->check compatibility
> > >     -----------         -----------
> > >     mdev device A       mdev device B
> > >=20
> > > This version attribute is optional. If a mdev device does not provide
> > > with a version attribute, this mdev device is incompatible to all oth=
er
> > > mdev devices.
> > >=20
> > > Live migration is able to take advantage of this version attribute.
> > > Before user space actually starts live migration, it can first check
> > > whether two mdev devices are compatible.
> > >=20
> > > v2:
> > > 1. added detailed intent and usage
> > > 2. made definition of version string completely private to vendor dri=
ver
> > >    (Alex Williamson)
> > > 3. abandoned changes to sample mdev drivers (Alex Williamson)
> > > 4. mandatory --> optional (Cornelia Huck)
> > > 5. added description for errno (Cornelia Huck)
> > >=20
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Erik Skultety <eskultet@redhat.com>
> > > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > Cc: Cornelia Huck <cohuck@redhat.com>
> > > Cc: "Tian, Kevin" <kevin.tian@intel.com>
> > > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > > Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> > > Cc: Neo Jia <cjia@nvidia.com>
> > > Cc: Kirti Wankhede <kwankhede@nvidia.com>
> > > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Cc: Christophe de Dinechin <dinechin@redhat.com>
> > >=20
> > > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > > ---
> > >  Documentation/vfio-mediated-device.txt | 140 +++++++++++++++++++++++=
++
> > >  1 file changed, 140 insertions(+)
> > >=20
> > > diff --git a/Documentation/vfio-mediated-device.txt b/Documentation/v=
fio-mediated-device.txt
> > > index c3f69bcaf96e..013a764968eb 100644
> > > --- a/Documentation/vfio-mediated-device.txt
> > > +++ b/Documentation/vfio-mediated-device.txt
> > > @@ -202,6 +202,7 @@ Directories and files under the sysfs for Each Ph=
ysical Device
> > >    |     |   |--- available_instances
> > >    |     |   |--- device_api
> > >    |     |   |--- description
> > > +  |     |   |--- version
> > >    |     |   |--- [devices]
> > >    |     |--- [<type-id>]
> > >    |     |   |--- create
> > > @@ -209,6 +210,7 @@ Directories and files under the sysfs for Each Ph=
ysical Device
> > >    |     |   |--- available_instances
> > >    |     |   |--- device_api
> > >    |     |   |--- description
> > > +  |     |   |--- version
> > >    |     |   |--- [devices]
> > >    |     |--- [<type-id>]
> > >    |          |--- create
> > > @@ -216,6 +218,7 @@ Directories and files under the sysfs for Each Ph=
ysical Device
> > >    |          |--- available_instances
> > >    |          |--- device_api
> > >    |          |--- description
> > > +  |          |--- version
> > >    |          |--- [devices] =20
> >=20
> > I thought there was a request to make this more specific to migration
> > by renaming it to something like migration_version.  Also, as an
> > =20
> so this attribute may not only include a mdev device's parent device info=
 and
> mdev type, but also include numeric software version of vendor specific
> migration code, right?

It's a vendor defined string, it should be considered opaque to the
user, the vendor can include whatever they feel is relevant.

> This actually makes sense.
> So, do I need to add a disclaimer in this doc like:
> vendor driver should be responsible by itself for a mdev device's migrati=
on
> compatibility.=20

I thought that was the purpose of this attribute.

> During migration setup phase, general migration code in user space VFIO o=
nly
> checks this version of VFIO migration region, and will not check software=
 version
> of vendor specific migration code.

What is "software version of vendor specific migration code"?  If
you're asking whether anything will check for parent device
compatibility or parent vendor driver compatibility, the answer is no,
that's what this interface is meant to provide.  Userspace should need
to do nothing more than verify the mdev types match and then use the
version attribute to confirm source to target compatibility.

> It is suggested to incorporate at least parent device info and software v=
ersion
> of vendor specific migration code into this migration_version attribute.

We can make recommendations as "best practices", but ultimately it's an
opaque string defined by the vendor driver.

But you never addressed my comment that previous reviews asked for the
attribute to be named something more specific to migration.

> > optional attribute, it seems the example should perhaps not add it to
> > all types to illustrate that it is not required. =20
> ok. got it.
>=20
>=20
> > > =20
> > >  * [mdev_supported_types]
> > > @@ -246,6 +249,143 @@ Directories and files under the sysfs for Each =
Physical Device
> > >    This attribute should show the number of devices of type <type-id>=
 that can be
> > >    created.
> > > =20
> > > +* version
> > > +
> > > +  This attribute is rw, and is optional.
> > > +  It is used to check device compatibility between two mdev devices =
and is =20
> >=20
> > between two mdev devices of the same type.
> > =20
> ok. got it.
> But I have a question about aggregation proposed earlier.
> Do we also have to assume the two mdev devices are of the same aggregation
> count?
> However, aggregation count is not available before a mdev device is creat=
ed. :(

We don't support aggregation yet, but yes, that's going to introduce
issues here.  Any configuration beyond the base mdev type would imply
that the base type could be compatible for migration, but the specific
instances might not.  Resolving that would imply that our version
information needs to be relative to an instance, not just the base type.

How would we extend this interface to support that?  We could have a
version attribute on each device instance, which might report something
like:

  0123456789,aggregate=3D2

IOW the device instance of version concatenates the mdev type version
with the additional create parameters for that device.  Writing this to
the type attribute should be parsed by the vendor driver as support for
given base device with specified additional create parameters.

I'm afraid this also bring us around to treacherous questions around
who is responsible for creating that device on the migration target and
where is this meta information about the device exposed.  Maybe instead
of a per instance version attribute we would instead expose the create
parameters as an attribute per instance and it would be userspace's
responsibility to create a version string from the mdev type and create
parameters similar to above.  This would also make it possible to
create a compatible instance on the target without pre-knowledge of how
the device was created.

Also, this issue exists already, but compatibility and capacity are two
separate things, I think we want to limit this interface to the
former.  For instance, if I want to migrate an i915-GVTg_V5_1 device to
another system where available_instances for that type is zero, the
version attribute should strictly report the device compatibility, it's
not responsible for returning an errno due to lack of resources.
Similarly if we were to do something with aggregation, the version
attribute would strictly report if the target supports creating that
device with those parameters, not whether it has capacity to create
such as device at that instant in time.
 =20
> > > +  accessed in pairs between the two mdev devices being checked. =20
> >=20
> > "in pairs"? =20
> I meant, user space needs to access version attributes from two mdev devi=
ce.
> but seems that it's needless to mention that... I'll remove it :)
>=20
>=20
> > > +  The intent of this attribute is to make an mdev device's version o=
paque to
> > > +  user space, so instead of reading two mdev devices' version string=
s and =20
> >=20
> > perhaps "...instead of reading the version string of two mdev devices
> > and comparing them in userspace..." =20
> yes, better, thanks:)
>=20
> > > +  comparing in userspace, user space should only read one mdev devic=
e's version
> > > +  attribute, and writes this version string into the other mdev devi=
ce's version
> > > +  attribute. Then vendor driver of mdev device whose version attribu=
te being
> > > +  written would check the incoming version string and tell user spac=
e whether
> > > +  the two mdev devices are compatible via return value. That's why t=
his
> > > +  attribute is writable.
> > > +
> > > +  when reading this attribute, it should show device version string =
of
> > > +  the device of type <type-id>.
> > > +
> > > +  This string is private to vendor driver itself. Vendor driver is a=
ble to
> > > +  freely define format and length of device version string.
> > > +  e.g. It can use a combination of pciid of parent device + mdev typ=
e. =20
> >=20
> > Can the user assume the data contents of the string is ascii
> > characters?  It's good that the vendor driver defines the format and
> > length, but the user probably needs some expectation bounding that
> > length.  Should we define it as no larger than PATH_MAX (4096), or maybe
> > NAME_MAX (255) might be more reasonable? =20
> I think so. I'll add those restrictions in next revision.=20

If we start adding creation parameters, PATH_MAX may actually be the
more reasonable limit.

> > > +
> > > +  When writing a string to this attribute, vendor driver should anal=
yze this
> > > +  string and check whether the mdev device being identified by this =
string is
> > > +  compatible with the mdev device for this attribute. vendor driver =
should then =20
> >=20
> > Compatible for what purpose?  I think this is where specifically
> > calling this a migration_version potentially has value. =20
> yes. if it also covers version of vendor specific migration code, calling=
 it
> migration_version is more appropriate.

I think we're discussing an interface that validates "I [the vendor
driver] am able to import the state of this version", therefore it must
include every relevant aspect of the vendor support for that.

> > > +  return written string's length if it regards the two mdev devices =
are
> > > +  compatible; vendor driver should return negative errno if it regar=
ds the two
> > > +  mdev devices are not compatible. =20
> >=20
> > IOW, the write(2) will succeed if the version is determined to be
> > compatible and otherwise fail with vendor specific errno.
> > =20
> thanks:)
>=20
> > > +
> > > +  User space should treat ANY of below conditions as two mdev device=
s not
> > > +  compatible: =20
> >=20
> > (0) The mdev devices are not of the same type.
> > =20
> the same as above. do we also need to take aggregation count into conside=
ration?
>=20
> > > +  (1) any one of the two mdev devices does not have a version attrib=
ute
> > > +  (2) error when read from one mdev device's version attribute =20
> >=20
> > Is this intended to support that the vendor driver can supply a version
> > attribute but not support migration?  TBH, this sounds like a vendor
> > driver bug, but maybe it's necessary if the vendor driver could have
> > some types that support migration and others that do not?  IOW, we're
> > supplying the same attribute groups to all devices from a vendor, in
> > which case my comment above regarding an example type without a version
> > attribute might be invalid. =20
> hmm, this is to make life easier for vendor driver to have some types that
> support migration and others that do not. while we can get rid of returni=
ng
> errno by providing different attribute groups to different devices, the w=
ay of
> returning errno gives a simpler choice to vendors.

Yes, I think it might be overly complicated to provide different
attribute groups for different devices, we have more flexibility if the
user does not make any assumptions based only on the presence of a
version attribute.

> > > +  (3) error when write one mdev device's version string to the other=
 mdev
> > > +  device's version attribute
> > > +
> > > +  User space should regard two mdev devices compatible when ALL of b=
elow
> > > +  conditions are met: =20
> >=20
> > (0) The mdev devices are of the same type
> >  =20
> > > +  (1) success when read from one mdev device's version attribute.
> > > +  (2) success when write one mdev device's version string to the oth=
er mdev
> > > +  device's version attribute
> > > +
> > > +  Errno:
> > > +  If vendor driver wants to claim a mdev device incompatible to all =
other mdev
> > > +  devices, it should not register version attribute for this mdev de=
vice. But if
> > > +  a vendor driver has already registered version attribute and it wa=
nts to claim
> > > +  a mdev device incompatible to all other mdev devices, it needs to =
return
> > > +  -ENODEV on access to this mdev device's version attribute.
> > > +  If a mdev device is only incompatible to certain mdev devices, wri=
te of
> > > +  incompatible mdev devices's version strings to its version attribu=
te should
> > > +  return -EINVAL; =20
> >=20
> > I think it's best not to define the specific errno returned for a
> > specific situation, let the vendor driver decide, userspace simply
> > needs to know that an errno on read indicates the device does not
> > support migration version comparison and that an errno on write
> > indicates the devices are incompatible or the target doesn't support
> > migration versions.
> > =20
> yes, user space only gets 0 or 1 as return code, not those errno.=20
> maybe I only need to describe errno in patch 2/2.
>=20
> > > +
> > > +  This attribute can be taken advantage of by live migration.
> > > +  If user space detects two mdev devices are compatible through vers=
ion
> > > +  attribute, it can start migration between the two mdev devices, ot=
herwise it
> > > +  should abort its migration attempts between the two mdev devices.
> > > +
> > > +  Example Usage:
> > > +  case 1:
> > > +  source side mdev device is of uuid 5ac1fb20-2bbf-4842-bb7e-36c58c3=
be9cd,
> > > +  its mdev type is i915-GVTg_V5_4. pci id of parent device is 8086-1=
93b.
> > > +  target side mdev device is if of uuid 882cc4da-dede-11e7-9180-078a=
62063ab1,
> > > +  its mdev type is i915-GVTg_V5_4. pci id of parent device is 8086-1=
93b.
> > > +
> > > +  # readlink /sys/bus/pci/devices/0000\:00\:02.0/\
> > > +  5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type
> > > +  ../mdev_supported_types/i915-GVTg_V5_4
> > > +
> > > +  # readlink /sys/bus/pci/devices/0000\:00\:02.0/\
> > > +  882cc4da-dede-11e7-9180-078a62063ab1/mdev_type
> > > +  ../mdev_supported_types/i915-GVTg_V5_4
> > > +
> > > +  (1) read source side mdev device's version.
> > > +  #cat \
> > > +    /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c5=
8c3be9cd/\
> > > +    mdev_type/version
> > > +  8086-193b-i915-GVTg_V5_4 =20
> >=20
> > Is this really the version information exposed in 2/2?  This is opaque,
> > so of course you can add things later, but it seems short sighted not
> > to even append a version 0 tag to account for software compatibility
> > differences since the above only represents a parent and mdev type
> > based version.
> >  =20
> yes, currently in 2/2, the version only includes <vendor id> + <device id=
> +
> <mdev type>. but you are right, it's better to include software migration
> version number.
> so vendor drivers have below 3 ways to designate a mdev device has no mig=
ration
> capability.
> 1. not registering migration_version attribute
> 2. on reading migration_version, returning errno
> 3. on reading migration_version, returning string indicating non-migratab=
le.
>=20
> The reason of not giving up way 2 is that maybe it can accelerate user sp=
ace
> getting information of device incompatible. if we only keep way 3, it wou=
ld not
> know this info until writing this string to target attribute.
>=20
> do you agree?

The string is opaque to the user, so if you're asking in (3) that the
user read and parse some information in the string that indicates the
device is non-migratable then no, I don't agree with that policy.  If
reading the version attribute produces a result, the only thing the
user can do with that result is to test it by writing it to another
version attribute.  Thanks,

Alex

> > > +  (2) write source side mdev device's version string into target sid=
e mdev
> > > +  device's version attribute.
> > > +  # echo 8086-193b-i915-GVTg_V5_4 >
> > > +   /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a6=
2063ab1/\
> > > +  mdev_type/version
> > > +  # echo $?
> > > +  0 =20
> >=20
> > TBH, there's a lot of superfluous information in this example that can
> > be stripped out.  For example:
> >=20
> > "
> > (1) Compare mdev types:
> >=20
> > The mdev type of an instantiated device can be read from the mdev_type
> > link within the device instance in sysfs, for example:
> >=20
> >   # basename $(readlink -f /sys/bus/mdev/devices/$MDEV_UUID/mdev_type/)
> >=20
> > The mdev types available on a given host system can also be found
> > through /sys/class/mdev_bus, for example:
> >=20
> >   # ls /sys/class/mdev_bus/*/mdev_supported_types/
> >=20
> > Migration is only possible between devices of the same mdev type.
> >=20
> > (2) Retrieve the mdev source version:
> >=20
> > The migration version information can either be read from the mdev_type
> > link on an instantiated device:
> >=20
> >   # cat /sys/bus/mdev/devices/$UUID1/mdev_type/version
> >=20
> > Or it can be read from the mdev type definition, for example:
> >=20
> >   # cat /sys/class/mdev_bus/*/mdev_supported_types/$MDEV_TYPE/version
> >=20
> > If reading the source version generates an error, migration is not
> > possible.  NB, there might be several parent devices for a given mdev
> > type on a host system, each may support or expose different versions.
> > Matching the specific mdev type to a parent may become important in
> > such configurations.
> >=20
> > (3) Test source version at target:
> >=20
> > Given a version as outlined above, its compatibility to an instantiated
> > device of the same mdev type can be tested as:
> >=20
> >   # echo $VERSION > /sys/bus/mdev/devices/$UUID2/mdev_type/version
> >=20
> > If this write fails, the source and target versions are not compatible
> > or the target does not support migration.
> >=20
> > Compatibility can also be tested prior to target device creation using
> > the mdev type definition for a parent device with a previously found
> > matching mdev type, for example:
> >=20
> >   # echo $VERSION > /sys/class/mdev_bus/$PARENT/mdev_supported_types/$M=
DEV_TYPE/version
> >=20
> > Again, an error writing the version indicates that an instance of this
> > mdev type would not support a migration from the provided version.
> > "
> >=20
> > In particular from the provided example, the specific UUIDs, mdev
> > types, parent information, and contents of the version attribute do not
> > contribute to illustrating the protocol.  In fact, displaying the
> > contents of the version attribute may tempt users to do comparison on
> > their own, especially given how easy it is to decide the GVT-g version
> > string.
> > =20
> got it!
> great thanks!
> I'll update it to the next revision.
> >  =20
> > > +
> > > +  in this case, user space's write to target side mdev device's vers=
ion
> > > +  attribute returns success to indicate the two mdev devices are com=
patible.
> > > +
> > > +  case 2:
> > > +  source side mdev device is of uuid 5ac1fb20-2bbf-4842-bb7e-36c58c3=
be9cd,
> > > +  its mdev type is i915-GVTg_V5_4. pci id of parent device is 8086-1=
93b.
> > > +  target side mdev device is if of uuid 882cc4da-dede-11e7-9180-078a=
62063ab1,
> > > +  its mdev type is i915-GVTg_V5_4. pci id of parent device is 8086-1=
91b.
> > > +
> > > +  # readlink /sys/bus/pci/devices/0000\:00\:02.0/\
> > > +  5ac1fb20-2bbf-4842-bb7e-36c58c3be9cd/mdev_type
> > > +  ../mdev_supported_types/i915-GVTg_V5_4
> > > +
> > > +  # readlink /sys/bus/pci/devices/0000\:00\:02.0/\
> > > +  882cc4da-dede-11e7-9180-078a62063ab1/mdev_type
> > > +  ../mdev_supported_types/i915-GVTg_V5_4
> > > +
> > > +  (1) read source side mdev device's version.
> > > +  #cat \
> > > +    /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c5=
8c3be9cd/\
> > > +    mdev_type/version
> > > +  8086-193b-i915-GVTg_V5_4
> > > +
> > > +  (2) write source side mdev device's version string into target sid=
e mdev
> > > +  device's version attribute.
> > > +  # echo 8086-193b-i915-GVTg_V5_4 >
> > > +   /sys/bus/pci/devices/0000\:00\:02.0/882cc4da-dede-11e7-9180-078a6=
2063ab1/\
> > > +  mdev_type/version
> > > +  -bash: echo: write error: Invalid argument
> > > +
> > > +  in this case, user space's write to target side mdev device's vers=
ion
> > > +  attribute returns error to indicate the two mdev devices are incom=
patible.
> > > +  (incompatible because pci ids of the two mdev devices' parent devi=
ces are
> > > +  different).
> > > +
> > > +  case 3:
> > > +  source side mdev device is of uuid 5ac1fb20-2bbf-4842-bb7e-36c58c3=
be9cd,
> > > +  its mdev type is i915-GVTg_V5_4. pci id of parent device is 8086-1=
93b.
> > > +  But vendor driver does not provide version attribute for this devi=
ce.
> > > +
> > > +  (1) read source side mdev device's version.
> > > +  #cat \
> > > +    /sys/bus/pci/devices/0000\:00\:02.0/5ac1fb20-2bbf-4842-bb7e-36c5=
8c3be9cd/\
> > > +    mdev_type/version
> > > +  cat: '/sys/bus/pci/devices/0000:00:02.0/5ac1fb20-2bbf-4842-bb7e-36=
c58c3be9cd/\
> > > +  mdev_type/version': No such file or directory
> > > +
> > > +  in this case, user space reads source side mdev device's version a=
ttribute
> > > +  which does not exist however. user space regards the two mdev devi=
ces as not
> > > +  compatible and will not start migration between the two mdev devic=
es.
> > > +
> > > + =20
> >=20
> > This is far too long for description and examples, it's not this
> > complicated.  Thanks,
> > =20
> got it. I'll follow your above example :)
>=20
> thanks
> Yan=20
> > >  * [device]
> > > =20
> > >    This directory contains links to the devices of type <type-id> tha=
t have been =20
> >  =20


