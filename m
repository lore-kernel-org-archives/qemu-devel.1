Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B64C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C9502075C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 08:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9502075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVXsY-0001jN-MX
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 04:54:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVXrj-0001Qd-A2
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVXri-0001sg-3p
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hVXrh-0001sB-TR
	for qemu-devel@nongnu.org; Tue, 28 May 2019 04:53:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8118381E03;
	Tue, 28 May 2019 08:53:48 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8EAD97D580;
	Tue, 28 May 2019 08:53:34 +0000 (UTC)
Date: Tue, 28 May 2019 10:53:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190528105332.7c5a2f82.cohuck@redhat.com>
In-Reply-To: <20190527034342.31523-1-yan.y.zhao@intel.com>
References: <20190527034155.31473-1-yan.y.zhao@intel.com>
	<20190527034342.31523-1-yan.y.zhao@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Tue, 28 May 2019 08:53:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio/mdev: add migration_version
 attribute for mdev device
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
	Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
	qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com,
	yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
	mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com,
	felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
	dgilbert@redhat.com, zhenyuw@linux.intel.com,
	dinechin@redhat.com, alex.williamson@redhat.com,
	intel-gvt-dev@lists.freedesktop.org, changpeng.liu@intel.com,
	berrange@redhat.com, linux-kernel@vger.kernel.org,
	zhi.a.wang@intel.com, jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 26 May 2019 23:43:42 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> migration_version attribute is used to check migration compatibility
> between two mdev device of the same mdev type.

s/device/devices/

> The key is that it's rw and its data is opaque to userspace.
>=20
> Userspace reads migration_version of mdev device at source side and
> writes the value to migration_version attribute of mdev device at target
> side. It judges migration compatibility according to whether the read
> and write operations succeed or fail.
>=20
> As this attribute is under mdev_type node, userspace is able to know
> whether two mdev devices are compatible before a mdev device is created.
>=20
> userspace needs to check whether the two mdev devices are of the same
> mdev type before checking the migration_version attribute. It also needs
> to check device creation parameters if aggregation is supported in
> future.
>=20
>              __    userspace
>               /\              \
>              /                 \write
>             / read              \
>    ________/__________       ___\|/_____________
>   | migration_version |     | migration_version |-->check migration
>   ---------------------     ---------------------   compatibility
>     mdev device A               mdev device B
>=20
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
>=20
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
>=20
> ---
> v3:
> 1. renamed version to migration_version
> (Christophe de Dinechin, Cornelia Huck, Alex Williamson)
> 2. let errno to be freely defined by vendor driver
> (Alex Williamson, Erik Skultety, Cornelia Huck, Dr. David Alan Gilbert)
> 3. let checking mdev_type be prerequisite of migration compatibility
> check. (Alex Williamson)
> 4. reworded example usage section.
> (most of this section came from Alex Williamson)
> 5. reworded attribute intention section (Cornelia Huck)
>=20
> v2:
> 1. added detailed intent and usage
> 2. made definition of version string completely private to vendor driver
>    (Alex Williamson)
> 3. abandoned changes to sample mdev drivers (Alex Williamson)
> 4. mandatory --> optional (Cornelia Huck)
> 5. added description for errno (Cornelia Huck)
> ---
>  Documentation/vfio-mediated-device.txt | 113 +++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
>=20

While I probably would have written a more compact description, your
version is fine with me as well.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

