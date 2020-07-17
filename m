Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB1DC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535752076A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKyPRbgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535752076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwT02-0002kB-7x
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwSzC-0002Fh-4J
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:13:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38954
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jwSz9-0007cm-GI
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 12:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595002397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svjFXgn26fzWHXoGgo8SEH2Z6m1xaJS8vMhS2ASgH5I=;
 b=SKyPRbgolYnWaJg4npbdeCYAibQUx5Kv1KcVk0EV03A5Y9buxTtmmlujm/9/7uvlBh2FU+
 DDsfBWsfVRRTHlyLgEa/8k/YqmV+w7XXVFRy5pq98m7bOQr1fsckl6WBvBkquhwk54Scxu
 xrprkvH/TXpjbBFQnijGXbl3yVMlZr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-cCJyNozhNo6RmHsRAACOJg-1; Fri, 17 Jul 2020 12:13:13 -0400
X-MC-Unique: cCJyNozhNo6RmHsRAACOJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E64180183C;
 Fri, 17 Jul 2020 16:13:11 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC56D5D9E7;
 Fri, 17 Jul 2020 16:12:58 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:12:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200717101258.65555978@x1.home>
In-Reply-To: <20200716083230.GA25316@joy-OptiPlex-7040>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <9bfa8700-91f5-ebb4-3977-6321f0487a63@redhat.com>
 <20200716083230.GA25316@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, eskultet@redhat.com, jian-feng.ding@intel.com,
 dgilbert@redhat.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 berrange@redhat.com, cohuck@redhat.com, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 16:32:30 +0800
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Thu, Jul 16, 2020 at 12:16:26PM +0800, Jason Wang wrote:
> >=20
> > On 2020/7/14 =E4=B8=8A=E5=8D=887:29, Yan Zhao wrote: =20
> > > hi folks,
> > > we are defining a device migration compatibility interface that helps=
 upper
> > > layer stack like openstack/ovirt/libvirt to check if two devices are
> > > live migration compatible.
> > > The "devices" here could be MDEVs, physical devices, or hybrid of the=
 two.
> > > e.g. we could use it to check whether
> > > - a src MDEV can migrate to a target MDEV,
> > > - a src VF in SRIOV can migrate to a target VF in SRIOV,
> > > - a src MDEV can migration to a target VF in SRIOV.
> > >    (e.g. SIOV/SRIOV backward compatibility case)
> > >=20
> > > The upper layer stack could use this interface as the last step to ch=
eck
> > > if one device is able to migrate to another device before triggering =
a real
> > > live migration procedure.
> > > we are not sure if this interface is of value or help to you. please =
don't
> > > hesitate to drop your valuable comments.
> > >=20
> > >=20
> > > (1) interface definition
> > > The interface is defined in below way:
> > >=20
> > >               __    userspace
> > >                /\              \
> > >               /                 \write
> > >              / read              \
> > >     ________/__________       ___\|/_____________
> > >    | migration_version |     | migration_version |-->check migration
> > >    ---------------------     ---------------------   compatibility
> > >       device A                    device B
> > >=20
> > >=20
> > > a device attribute named migration_version is defined under each devi=
ce's
> > > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migr=
ation_version). =20
> >=20
> >=20
> > Are you aware of the devlink based device management interface that is
> > proposed upstream? I think it has many advantages over sysfs, do you
> > consider to switch to that? =20


Advantages, such as?


> not familiar with the devlink. will do some research of it.
> >=20
> >  =20
> > > userspace tools read the migration_version as a string from the sourc=
e device,
> > > and write it to the migration_version sysfs attribute in the target d=
evice.
> > >=20
> > > The userspace should treat ANY of below conditions as two devices not=
 compatible:
> > > - any one of the two devices does not have a migration_version attrib=
ute
> > > - error when reading from migration_version attribute of one device
> > > - error when writing migration_version string of one device to
> > >    migration_version attribute of the other device
> > >=20
> > > The string read from migration_version attribute is defined by device=
 vendor
> > > driver and is completely opaque to the userspace. =20
> >=20
> >=20
> > My understanding is that something opaque to userspace is not the philo=
sophy =20
>=20
> but the VFIO live migration in itself is essentially a big opaque stream =
to userspace.
>=20
> > of Linux. Instead of having a generic API but opaque value, why not do =
in a
> > vendor specific way like:
> >=20
> > 1) exposing the device capability in a vendor specific way via sysfs/de=
vlink
> > or other API
> > 2) management read capability in both src and dst and determine whether=
 we
> > can do the migration
> >=20
> > This is the way we plan to do with vDPA.
> > =20
> yes, in another reply, Alex proposed to use an interface in json format.
> I guess we can define something like
>=20
> { "self" :
>   [
>     { "pciid" : "8086591d",
>       "driver" : "i915",
>       "gvt-version" : "v1",
>       "mdev_type"   : "i915-GVTg_V5_2",
>       "aggregator"  : "1",
>       "pv-mode"     : "none",
>     }
>   ],
>   "compatible" :
>   [
>     { "pciid" : "8086591d",
>       "driver" : "i915",
>       "gvt-version" : "v1",
>       "mdev_type"   : "i915-GVTg_V5_2",
>       "aggregator"  : "1"
>       "pv-mode"     : "none",
>     },
>     { "pciid" : "8086591d",
>       "driver" : "i915",
>       "gvt-version" : "v1",
>       "mdev_type"   : "i915-GVTg_V5_4",
>       "aggregator"  : "2"
>       "pv-mode"     : "none",
>     },
>     { "pciid" : "8086591d",
>       "driver" : "i915",
>       "gvt-version" : "v2",
>       "mdev_type"   : "i915-GVTg_V5_4",
>       "aggregator"  : "2"
>       "pv-mode"     : "none, ppgtt, context",
>     }
>     ...
>   ]
> }
>=20
> But as those fields are mostly vendor specific, the userspace can
> only do simple string comparing, I guess the list would be very long as
> it needs to enumerate all possible targets.


This ignores so much of what I tried to achieve in my example :(


> also, in some fileds like "gvt-version", is there a simple way to express
> things like v2+?


That's not a reasonable thing to express anyway, how can you be certain
that v3 won't break compatibility with v2?  Sean proposed a versioning
scheme that accounts for this, using an x.y.z version expressing the
major, minor, and bugfix versions, where there is no compatibility
across major versions, minor versions have forward compatibility (ex. 1
-> 2 is ok, 2 -> 1 is not) and bugfix version number indicates some
degree of internal improvement that is not visible to the user in terms
of features or compatibility, but provides a basis for preferring
equally compatible candidates.

=20
> If the userspace can read this interface both in src and target and
> check whether both src and target are in corresponding compatible list, I
> think it will work for us.
>=20
> But still, kernel should not rely on userspace's choice, the opaque
> compatibility string is still required in kernel. No matter whether
> it would be exposed to userspace as an compatibility checking interface,
> vendor driver would keep this part of code and embed the string into the
> migration stream. so exposing it as an interface to be used by libvirt to
> do a safety check before a real live migration is only about enabling
> the kernel part of check to happen ahead.

As you indicate, the vendor driver is responsible for checking version
information embedded within the migration stream.  Therefore a
migration should fail early if the devices are incompatible.  Is it
really libvirt's place to second guess what it has been directed to do?
Why would we even proceed to design a user parse-able version interface
if we still have a dependency on an opaque interface?  Thanks,

Alex


