Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60337C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8589206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD+JWslc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8589206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOciL-0008FX-QB
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eskultet@redhat.com>) id 1jOchf-0007Iw-Cc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:43:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eskultet@redhat.com>) id 1jOchd-0005D7-TE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:43:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1jOchd-0005Cq-PA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586936601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OHfgn9pPaDAsC+K8et0tvkSEtEL5Qfqe8kjye9uA/o=;
 b=BD+JWslc2xokOS+582PkwkI+6wM2nq/8fetaFbxuluDPhyEYYjjyT+Z0S/nYjxW5aBWRKP
 xYyLHvzln4VlPXI962yjSUCar/D2iUD0QA3rDBBRWOUj2GAfXFozdb90SeTUTC1DJYmI1m
 A1yz/YUVKCvppbw68eYgbEY68drGPgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-XK4FppVTPWSD-eyzXPObBg-1; Wed, 15 Apr 2020 03:43:17 -0400
X-MC-Unique: XK4FppVTPWSD-eyzXPObBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D3DD8017F5;
 Wed, 15 Apr 2020 07:43:14 +0000 (UTC)
Received: from sturgeon (unknown [10.40.192.200])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0F761000337;
 Wed, 15 Apr 2020 07:43:00 +0000 (UTC)
Date: Wed, 15 Apr 2020 09:42:58 +0200
From: Erik Skultety <eskultet@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: [PATCH v5 3/4] vfio/mdev: add migration_version attribute for
 mdev (under mdev device node)
Message-ID: <20200415074258.GK269314@sturgeon>
References: <20200413055201.27053-1-yan.y.zhao@intel.com>
 <20200413055504.27311-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413055504.27311-1-yan.y.zhao@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 libvir-list@redhat.com, Zhengxiao.zx@alibaba-inc.com,
 shuangtai.tst@alibaba-inc.com, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, yi.l.liu@intel.com, corbet@lwn.net, ziye.yang@intel.com,
 mlevitsk@redhat.com, pasic@linux.ibm.com, aik@ozlabs.ru, felipe@nutanix.com,
 Ken.Xue@amd.com, kevin.tian@intel.com, xin.zeng@intel.com, dgilbert@redhat.com,
 zhenyuw@linux.intel.com, jonathan.davies@nutanix.com,
 intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com,
 cohuck@redhat.com, linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
 dinechin@redhat.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Apr 13, 2020 at 01:55:04AM -0400, Yan Zhao wrote:
> migration_version attribute is used to check migration compatibility
> between two mdev devices of the same mdev type.
> The key is that it's rw and its data is opaque to userspace.
>
> Userspace reads migration_version of mdev device at source side and
> writes the value to migration_version attribute of mdev device at targe=
t
> side. It judges migration compatibility according to whether the read
> and write operations succeed or fail.
>
> Currently, it is able to read/write migration_version attribute under t=
wo
> places:
>
> (1) under mdev_type node
> userspace is able to know whether two mdev devices are compatible befor=
e
> a mdev device is created.
>
> userspace also needs to check whether the two mdev devices are of the s=
ame
> mdev type before checking the migration_version attribute. It also need=
s
> to check device creation parameters if aggregation is supported in futu=
re.
>
> (2) under mdev device node
> userspace is able to know whether two mdev devices are compatible after
> they are all created. But it does not need to check mdev type and devic=
e
> creation parameter for aggregation as device vendor driver would have
> incorporated those information into the migration_version attribute.
>
>              __    userspace
>               /\              \
>              /                 \write
>             / read              \
>    ________/__________       ___\|/_____________
>   | migration_version |     | migration_version |-->check migration
>   ---------------------     ---------------------   compatibility
>     mdev device A               mdev device B
>
> This patch is for mdev documentation about the second place (under
> mdev device node)
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Erik Skultety <eskultet@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: "Tian, Kevin" <kevin.tian@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: "Wang, Zhi A" <zhi.a.wang@intel.com>
> Cc: Neo Jia <cjia@nvidia.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Christophe de Dinechin <dinechin@redhat.com>
>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  .../driver-api/vfio-mediated-device.rst       | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Docume=
ntation/driver-api/vfio-mediated-device.rst
> index 2d1f3c0f3c8f..efbadfd51b7e 100644
> --- a/Documentation/driver-api/vfio-mediated-device.rst
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -383,6 +383,7 @@ Directories and Files Under the sysfs for Each mdev=
 Device
>           |--- remove
>           |--- mdev_type {link to its type}
>           |--- vendor-specific-attributes [optional]
> +         |--- migration_verion [optional]
>
>  * remove (write only)
>
> @@ -394,6 +395,75 @@ Example::
>
>  	# echo 1 > /sys/bus/mdev/devices/$mdev_UUID/remove
>
> +* migration_version (rw, optional)

Hmm, ^this is not consistent with how patch 1/5 reports this information,=
 but
looking at the existing docs we're not doing very well in terms of consis=
tency
there either.

I suggest we go with "(read-write)" in both patch 1/5 and here and then s=
tart
the paragraph with "This is an optional attribute."

> +  It is used to check migration compatibility between two mdev devices=
.
> +  Absence of this attribute means the mdev device does not support mig=
ration.
> +
> +  This attribute provides a way to check migration compatibility betwe=
en two
> +  mdev devices from userspace after device created. The intended usage=
 is

after the target device has been created.

side note: maybe add something like "(see the migration_version attribute=
 of
the device node if the target device already exists)" in the same section=
 in
patch 1/5.

> +  for userspace to read the migration_version attribute from one mdev =
device and
> +  then writing that value to the migration_version attribute of the ot=
her mdev
> +  device. The second mdev device indicates compatibility via the retur=
n code of
> +  the write operation. This makes compatibility between mdev devices c=
ompletely
> +  vendor-defined and opaque to userspace. Userspace should do nothing =
more
> +  than use the migration_version attribute to confirm source to target
> +  compatibility.

...

> +
> +  Reading/Writing Attribute Data:
> +  read(2) will fail if a mdev device does not support migration and ot=
herwise
> +        succeed and return migration_version string of the mdev device=
.
> +
> +        This migration_version string is vendor defined and opaque to =
the
> +        userspace. Vendor is free to include whatever they feel is rel=
evant.
> +        e.g. <pciid of parent device>-<software version>.
> +
> +        Restrictions on this migration_version string:
> +            1. It should only contain ascii characters
> +            2. MAX Length is PATH_MAX (4096)
> +
> +  write(2) expects migration_version string of source mdev device, and=
 will
> +         succeed if it is determined to be compatible and otherwise fa=
il with
> +         vendor specific errno.
> +
> +  Errno:
> +  -An errno on read(2) indicates the mdev devicedoes not support migra=
tion;

s/devicedoes/device does/

> +  -An errno on write(2) indicates the mdev devices are incompatible or=
 the
> +   target doesn't support migration.
> +  Vendor driver is free to define specific errno and is suggested to
> +  print detailed error in syslog for diagnose purpose.
> +
> +  Userspace should treat ANY of below conditions as two mdev devices n=
ot
> +  compatible:
> +  (1) any one of the two mdev devices does not have a migration_versio=
n
> +  attribute
> +  (2) error when reading from migration_version attribute of one mdev =
device
> +  (3) error when writing migration_version string of one mdev device t=
o
> +  migration_version attribute of the other mdev device
> +
> +  Userspace should regard two mdev devices compatible when ALL of belo=
w
> +  conditions are met:
> +  (1) success when reading from migration_version attribute of one mde=
v device.
> +  (2) success when writing migration_version string of one mdev device=
 to
> +  migration_version attribute of the other mdev device.
> +
> +  Example Usage:
> +  (1) Retrieve the mdev source migration_version:
> +
> +  # cat /sys/bus/mdev/devices/$mdev_UUID1/migration_version
> +
> +  If reading the source migration_version generates an error, migratio=
n is not
> +  possible.
> +
> +  (2) Test source migration_version at target:
> +
> +  Given a migration_version as outlined above, its compatibility to an
> +  instantiated device of the same mdev type can be tested as:
> +  # echo $VERSION > /sys/bus/mdev/devices/$mdev_UUID2/migration_versio=
n
> +
> +  If this write fails, the source and target migration versions are no=
t
> +  compatible or the target does not support migration.
> +
> +
>  Mediated device Hot plug
>  ------------------------

Overall, the same comments as in 1/5 apply text-wise.

Regards,
--
Erik Skultety


