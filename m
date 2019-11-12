Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5B5C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE9F2196E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+s/plHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE9F2196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUelW-0007YC-Pb
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 17:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iUeh9-00045z-NT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iUeh6-0007lE-VS
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31005
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iUeh6-0007kr-QN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:31:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573597888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtmTTQCv9c1AhUySjiMayZZFRJ9C503NUGsOmC+w/mA=;
 b=Z+s/plHUkWjMLNxtFz9J6w6u4AXNXMxFvxwPPL6DBp+reA8o1QRdfVZsJJsUwCnTy5Mpjs
 g9n2ejp8s8hEQNrbac2UC/NabzvlR6kIxYfqp4w6L+WHBOUhPeHX1OhunXr7oI509L+fU1
 stwE558iL9Utlxfo92CqNFFJwNm3eJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-2SGjyYvdOzCly_iBXyZUzw-1; Tue, 12 Nov 2019 17:30:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8592D1005502;
 Tue, 12 Nov 2019 22:30:11 +0000 (UTC)
Received: from x1.home (ovpn-116-138.phx2.redhat.com [10.3.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E235A6018C;
 Tue, 12 Nov 2019 22:30:05 +0000 (UTC)
Date: Tue, 12 Nov 2019 15:30:05 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v9 Kernel 1/5] vfio: KABI for migration interface for
 device state
Message-ID: <20191112153005.53bf324c@x1.home>
In-Reply-To: <1573578220-7530-2-git-send-email-kwankhede@nvidia.com>
References: <1573578220-7530-1-git-send-email-kwankhede@nvidia.com>
 <1573578220-7530-2-git-send-email-kwankhede@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2SGjyYvdOzCly_iBXyZUzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Zhengxiao.zx@Alibaba-inc.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 cjia@nvidia.com, kvm@vger.kernel.org, eskultet@redhat.com, ziye.yang@intel.com,
 qemu-devel@nongnu.org, cohuck@redhat.com, shuangtai.tst@alibaba-inc.com,
 dgilbert@redhat.com, zhi.a.wang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, aik@ozlabs.ru, eauger@redhat.com, felipe@nutanix.com,
 jonathan.davies@nutanix.com, yan.y.zhao@intel.com, changpeng.liu@intel.com,
 Ken.Xue@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 Nov 2019 22:33:36 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> - Defined MIGRATION region type and sub-type.
> - Used 3 bits to define VFIO device states.
>     Bit 0 =3D> _RUNNING
>     Bit 1 =3D> _SAVING
>     Bit 2 =3D> _RESUMING
>     Combination of these bits defines VFIO device's state during migratio=
n
>     _RUNNING =3D> Normal VFIO device running state. When its reset, it
> =09=09indicates _STOPPED state. when device is changed to
> =09=09_STOPPED, driver should stop device before write()
> =09=09returns.
>     _SAVING | _RUNNING =3D> vCPUs are running, VFIO device is running but
>                           start saving state of device i.e. pre-copy stat=
e
>     _SAVING  =3D> vCPUs are stopped, VFIO device should be stopped, and

s/should/must/

>                 save device state,i.e. stop-n-copy state
>     _RESUMING =3D> VFIO device resuming state.
>     _SAVING | _RESUMING and _RUNNING | _RESUMING =3D> Invalid states

A table might be useful here and in the uapi header to indicate valid
states:

| _RESUMING | _SAVING | _RUNNING | Description
+-----------+---------+----------+-----------------------------------------=
-
|     0     |    0    |     0    | Stopped, not saving or resuming (a)
+-----------+---------+----------+-----------------------------------------=
-
|     0     |    0    |     1    | Running, default state
+-----------+---------+----------+-----------------------------------------=
-
|     0     |    1    |     0    | Stopped, migration interface in save mod=
e
+-----------+---------+----------+-----------------------------------------=
-
|     0     |    1    |     1    | Running, save mode interface, iterative
+-----------+---------+----------+-----------------------------------------=
-
|     1     |    0    |     0    | Stopped, migration resume interface acti=
ve
+-----------+---------+----------+-----------------------------------------=
-
|     1     |    0    |     1    | Invalid (b)
+-----------+---------+----------+-----------------------------------------=
-
|     1     |    1    |     0    | Invalid (c)
+-----------+---------+----------+-----------------------------------------=
-
|     1     |    1    |     1    | Invalid (d)

I think we need to consider whether we define (a) as generally
available, for instance we might want to use it for diagnostics or a
fatal error condition outside of migration.

Are there hidden assumptions between state transitions here or are
there specific next possible state diagrams that we need to include as
well?

I'm curious if Intel agrees with the states marked invalid with their
push for post-copy support.

>     Bits 3 - 31 are reserved for future use. User should perform
>     read-modify-write operation on this field.
> - Defined vfio_device_migration_info structure which will be placed at 0t=
h
>   offset of migration region to get/set VFIO device related information.
>   Defined members of structure and usage on read/write access:
>     * device_state: (read/write)
>         To convey VFIO device state to be transitioned to. Only 3 bits ar=
e
> =09used as of now, Bits 3 - 31 are reserved for future use.
>     * pending bytes: (read only)
>         To get pending bytes yet to be migrated for VFIO device.
>     * data_offset: (read only)
>         To get data offset in migration region from where data exist
> =09during _SAVING and from where data should be written by user space
> =09application during _RESUMING state.
>     * data_size: (read/write)
>         To get and set size in bytes of data copied in migration region
> =09during _SAVING and _RESUMING state.
>=20
> Migration region looks like:
>  ------------------------------------------------------------------
> |vfio_device_migration_info|    data section                      |
> |                          |     ///////////////////////////////  |
>  ------------------------------------------------------------------
>  ^                              ^
>  offset 0-trapped part        data_offset
>=20
> Structure vfio_device_migration_info is always followed by data section
> in the region, so data_offset will always be non-0. Offset from where dat=
a
> to be copied is decided by kernel driver, data section can be trapped or
> mapped depending on how kernel driver defines data section.
> Data section partition can be defined as mapped by sparse mmap capability=
.
> If mmapped, then data_offset should be page aligned, where as initial
> section which contain vfio_device_migration_info structure might not end
> at offset which is page aligned.
> Vendor driver should decide whether to partition data section and how to
> partition the data section. Vendor driver should return data_offset
> accordingly.
>=20
> For user application, data is opaque. User should write data in the same
> order as received.
>=20
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
> Reviewed-by: Neo Jia <cjia@nvidia.com>
> ---
>  include/uapi/linux/vfio.h | 108 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 108 insertions(+)
>=20
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 9e843a147ead..35b09427ad9f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -305,6 +305,7 @@ struct vfio_region_info_cap_type {
>  #define VFIO_REGION_TYPE_PCI_VENDOR_MASK=09(0xffff)
>  #define VFIO_REGION_TYPE_GFX                    (1)
>  #define VFIO_REGION_TYPE_CCW=09=09=09(2)
> +#define VFIO_REGION_TYPE_MIGRATION              (3)
> =20
>  /* sub-types for VFIO_REGION_TYPE_PCI_* */
> =20
> @@ -379,6 +380,113 @@ struct vfio_region_gfx_edid {
>  /* sub-types for VFIO_REGION_TYPE_CCW */
>  #define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD=09(1)
> =20
> +/* sub-types for VFIO_REGION_TYPE_MIGRATION */
> +#define VFIO_REGION_SUBTYPE_MIGRATION           (1)
> +
> +/*
> + * Structure vfio_device_migration_info is placed at 0th offset of
> + * VFIO_REGION_SUBTYPE_MIGRATION region to get/set VFIO device related m=
igration
> + * information. Field accesses from this structure are only supported at=
 their
> + * native width and alignment, otherwise the result is undefined and ven=
dor
> + * drivers should return an error.
> + *
> + * device_state: (read/write)
> + *      To indicate vendor driver the state VFIO device should be transi=
tioned
> + *      to. If device state transition fails, write on this field return=
 error.
> + *      It consists of 3 bits:
> + *      - If bit 0 set, indicates _RUNNING state. When its reset, that i=
ndicates

Let's use set/cleared or 1/0 to indicate bit values, 'reset' is somewhat
ambiguous.

> + *        _STOPPED state. When device is changed to _STOPPED, driver sho=
uld stop
> + *        device before write() returns.
> + *      - If bit 1 set, indicates _SAVING state. When set, that indicate=
s driver
> + *        should start gathering device state information which will be =
provided
> + *        to VFIO user space application to save device's state.
> + *      - If bit 2 set, indicates _RESUMING state. When set, that indica=
tes
> + *        prepare to resume device, data provided through migration regi=
on
> + *        should be used to resume device.
> + *      Bits 3 - 31 are reserved for future use. User should perform
> + *      read-modify-write operation on this field.
> + *      _SAVING and _RESUMING bits set at the same time is invalid state=
.
> + *=09Similarly _RUNNING and _RESUMING bits set is invalid state.
> + *
> + * pending bytes: (read only)
> + *      Number of pending bytes yet to be migrated from vendor driver
> + *
> + * data_offset: (read only)
> + *      User application should read data_offset in migration region fro=
m where
> + *      user application should read device data during _SAVING state or=
 write
> + *      device data during _RESUMING state. See below for detail of sequ=
ence to
> + *      be followed.
> + *
> + * data_size: (read/write)
> + *      User application should read data_size to get size of data copie=
d in
> + *      bytes in migration region during _SAVING state and write size of=
 data
> + *      copied in bytes in migration region during _RESUMING state.
> + *
> + * Migration region looks like:
> + *  ------------------------------------------------------------------
> + * |vfio_device_migration_info|    data section                      |
> + * |                          |     ///////////////////////////////  |
> + * ------------------------------------------------------------------
> + *   ^                              ^
> + *  offset 0-trapped part        data_offset
> + *
> + * Structure vfio_device_migration_info is always followed by data secti=
on in
> + * the region, so data_offset will always be non-0. Offset from where da=
ta is
> + * copied is decided by kernel driver, data section can be trapped or ma=
pped
> + * or partitioned, depending on how kernel driver defines data section.
> + * Data section partition can be defined as mapped by sparse mmap capabi=
lity.
> + * If mmapped, then data_offset should be page aligned, where as initial=
 section
> + * which contain vfio_device_migration_info structure might not end at o=
ffset
> + * which is page aligned.

"The user is not required to to access via mmap regardless of the
region mmap capabilities."

> + * Vendor driver should decide whether to partition data section and how=
 to
> + * partition the data section. Vendor driver should return data_offset
> + * accordingly.
> + *
> + * Sequence to be followed for _SAVING|_RUNNING device state or pre-copy=
 phase
> + * and for _SAVING device state or stop-and-copy phase:
> + * a. read pending_bytes. If pending_bytes > 0, go through below steps.
> + * b. read data_offset, indicates kernel driver to write data to staging=
 buffer.
> + *    Kernel driver should return this read operation only after writing=
 data to
> + *    staging buffer is done.

"staging buffer" implies a vendor driver implementation, perhaps we
could just state that data is available from (region + data_offset) to
(region + data_offset + data_size) upon return of this read operation.

> + * c. read data_size, amount of data in bytes written by vendor driver i=
n
> + *    migration region.
> + * d. read data_size bytes of data from data_offset in the migration reg=
ion.
> + * e. process data.
> + * f. Loop through a to e. Next read on pending_bytes indicates that rea=
d data
> + *    operation from migration region for previous iteration is done.

I think this indicate that step (f) should be to read pending_bytes, the
read sequence is not complete until this step.  Optionally the user can
then proceed to step (b).  There are no read side-effects of (a) afaict.

Is the use required to reach pending_bytes =3D=3D 0 before changing
device_state, particularly transitioning to !_RUNNING?  Presumably the
user can exit this sequence at any time by clearing _SAVING.

> + *
> + * Sequence to be followed while _RESUMING device state:
> + * While data for this device is available, repeat below steps:
> + * a. read data_offset from where user application should write data.
> + * b. write data of data_size to migration region from data_offset.
> + * c. write data_size which indicates vendor driver that data is written=
 in
> + *    staging buffer. Vendor driver should read this data from migration
> + *    region and resume device's state.

The device defaults to _RUNNING state, so a prerequisite is to set
_RESUMING and clear _RUNNING, right?

> + *
> + * For user application, data is opaque. User should write data in the s=
ame
> + * order as received.
> + */
> +
> +struct vfio_device_migration_info {
> +=09__u32 device_state;         /* VFIO device state */
> +#define VFIO_DEVICE_STATE_RUNNING   (1 << 0)
> +#define VFIO_DEVICE_STATE_SAVING    (1 << 1)
> +#define VFIO_DEVICE_STATE_RESUMING  (1 << 2)
> +#define VFIO_DEVICE_STATE_MASK      (VFIO_DEVICE_STATE_RUNNING | \
> +=09=09=09=09     VFIO_DEVICE_STATE_SAVING |  \
> +=09=09=09=09     VFIO_DEVICE_STATE_RESUMING)
> +
> +#define VFIO_DEVICE_STATE_INVALID_CASE1    (VFIO_DEVICE_STATE_SAVING | \
> +=09=09=09=09=09    VFIO_DEVICE_STATE_RESUMING)
> +
> +#define VFIO_DEVICE_STATE_INVALID_CASE2    (VFIO_DEVICE_STATE_RUNNING | =
\
> +=09=09=09=09=09    VFIO_DEVICE_STATE_RESUMING)

These seem difficult to use, maybe we just need a
VFIO_DEVICE_STATE_VALID macro?

#define VFIO_DEVICE_STATE_VALID(state) \
  (state & VFIO_DEVICE_STATE_RESUMING ? \
  (state & VFIO_DEVICE_STATE_MASK) =3D=3D VFIO_DEVICE_STATE_RESUMING : 1)

Thanks,
Alex

> +=09__u32 reserved;
> +=09__u64 pending_bytes;
> +=09__u64 data_offset;
> +=09__u64 data_size;
> +} __attribute__((packed));
> +
>  /*
>   * The MSIX mappable capability informs that MSIX data of a BAR can be m=
mapped
>   * which allows direct access to non-MSIX registers which happened to be=
 within


