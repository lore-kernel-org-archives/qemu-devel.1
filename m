Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82FC43446
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 21:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1562064C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 21:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVrNrLxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1562064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvS3x-0006iW-35
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 17:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jvS2M-0005jL-QG
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 17:00:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27433
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jvS2J-0004e3-6h
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 17:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594760421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSM5fxb0uVcO9SHCvJ1b0FiIX2VVoi8pq0fYNwpoFkw=;
 b=HVrNrLxbLswJwFhfp3/lfBw8E6Qf9MMWuB9okMw5m88QBratG9EajfAMye0aAwxNKvVGoQ
 oTB6MynKn4I0JZTncLLc0cYtE8cmciKDb2EvWD52y6kNf4B8MpuR/PbVO9PrhEhrZcBzor
 M8sbxbPPzEAwl/K8rewbdLu3eRyD5XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-CagJpU0GMwKjZGZf3TfEbQ-1; Tue, 14 Jul 2020 17:00:18 -0400
X-MC-Unique: CagJpU0GMwKjZGZf3TfEbQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B450A4D15;
 Tue, 14 Jul 2020 21:00:12 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8DB610013C3;
 Tue, 14 Jul 2020 20:59:48 +0000 (UTC)
Date: Tue, 14 Jul 2020 14:59:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200714145948.17b95eb3@x1.home>
In-Reply-To: <20200714171946.GL2728@work-vm>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <20200714102129.GD25187@redhat.com>
 <20200714101616.5d3a9e75@x1.home> <20200714171946.GL2728@work-vm>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, eskultet@redhat.com,
 jian-feng.ding@intel.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, cohuck@redhat.com,
 dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 18:19:46 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Alex Williamson (alex.williamson@redhat.com) wrote:
> > On Tue, 14 Jul 2020 11:21:29 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Tue, Jul 14, 2020 at 07:29:57AM +0800, Yan Zhao wrote: =20
> > > > hi folks,
> > > > we are defining a device migration compatibility interface that hel=
ps upper
> > > > layer stack like openstack/ovirt/libvirt to check if two devices are
> > > > live migration compatible.
> > > > The "devices" here could be MDEVs, physical devices, or hybrid of t=
he two.
> > > > e.g. we could use it to check whether
> > > > - a src MDEV can migrate to a target MDEV,
> > > > - a src VF in SRIOV can migrate to a target VF in SRIOV,
> > > > - a src MDEV can migration to a target VF in SRIOV.
> > > >   (e.g. SIOV/SRIOV backward compatibility case)
> > > >=20
> > > > The upper layer stack could use this interface as the last step to =
check
> > > > if one device is able to migrate to another device before triggerin=
g a real
> > > > live migration procedure.
> > > > we are not sure if this interface is of value or help to you. pleas=
e don't
> > > > hesitate to drop your valuable comments.
> > > >=20
> > > >=20
> > > > (1) interface definition
> > > > The interface is defined in below way:
> > > >=20
> > > >              __    userspace
> > > >               /\              \
> > > >              /                 \write
> > > >             / read              \
> > > >    ________/__________       ___\|/_____________
> > > >   | migration_version |     | migration_version |-->check migration
> > > >   ---------------------     ---------------------   compatibility
> > > >      device A                    device B
> > > >=20
> > > >=20
> > > > a device attribute named migration_version is defined under each de=
vice's
> > > > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/mi=
gration_version).
> > > > userspace tools read the migration_version as a string from the sou=
rce device,
> > > > and write it to the migration_version sysfs attribute in the target=
 device.
> > > >=20
> > > > The userspace should treat ANY of below conditions as two devices n=
ot compatible:
> > > > - any one of the two devices does not have a migration_version attr=
ibute
> > > > - error when reading from migration_version attribute of one device
> > > > - error when writing migration_version string of one device to
> > > >   migration_version attribute of the other device
> > > >=20
> > > > The string read from migration_version attribute is defined by devi=
ce vendor
> > > > driver and is completely opaque to the userspace.
> > > > for a Intel vGPU, string format can be defined like
> > > > "parent device PCI ID" + "version of gvt driver" + "mdev type" + "a=
ggregator count".
> > > >=20
> > > > for an NVMe VF connecting to a remote storage. it could be
> > > > "PCI ID" + "driver version" + "configured remote storage URL"
> > > >=20
> > > > for a QAT VF, it may be
> > > > "PCI ID" + "driver version" + "supported encryption set".
> > > >=20
> > > > (to avoid namespace confliction from each vendor, we may prefix a d=
river name to
> > > > each migration_version string. e.g. i915-v1-8086-591d-i915-GVTg_V5_=
8-1) =20
> >=20
> > It's very strange to define it as opaque and then proceed to describe
> > the contents of that opaque string.  The point is that its contents
> > are defined by the vendor driver to describe the device, driver version,
> > and possibly metadata about the configuration of the device.  One
> > instance of a device might generate a different string from another.
> > The string that a device produces is not necessarily the only string
> > the vendor driver will accept, for example the driver might support
> > backwards compatible migrations. =20
>=20
> (As I've said in the previous discussion, off one of the patch series)
>=20
> My view is it makes sense to have a half-way house on the opaqueness of
> this string; I'd expect to have an ID and version that are human
> readable, maybe a device ID/name that's human interpretable and then a
> bunch of other cruft that maybe device/vendor/version specific.
>=20
> I'm thinking that we want to be able to report problems and include the
> string and the user to be able to easily identify the device that was
> complaining and notice a difference in versions, and perhaps also use
> it in compatibility patterns to find compatible hosts; but that does
> get tricky when it's a 'ask the device if it's compatible'.

In the reply I just sent to Dan, I gave this example of what a
"compatibility string" might look like represented as json:

{
  "device_api": "vfio-pci",
  "vendor": "vendor-driver-name",
  "version": {
    "major": 0,
    "minor": 1
  },
  "vfio-pci": { // Based on above device_api
    "vendor": 0x1234, // Values for the exposed device
    "device": 0x5678,
      // Possibly further parameters for a more specific match
  },
  "mdev_attrs": [
    { "attribute0": "VALUE" }
  ]
}

Are you thinking that we might allow the vendor to include a vendor
specific array where we'd simply require that both sides have matching
fields and values?  ie.

  "vendor_fields": [
    { "unknown_field0": "unknown_value0" },
    { "unknown_field1": "unknown_value1" },
  ]

We could certainly make that part of the spec, but I can't really
figure the value of it other than to severely restrict compatibility,
which the vendor could already do via the version.major value.  Maybe
they'd want to put a build timestamp, random uuid, or source sha1 into
such a field to make absolutely certain compatibility is only determined
between identical builds?  Thanks,

Alex


