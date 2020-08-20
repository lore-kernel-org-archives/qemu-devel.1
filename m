Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202ABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2A5720738
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 12:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UalDptFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A5720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8jgj-0008FH-Ub
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 08:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8jfr-0007dV-Ve
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:28:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52997
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k8jfp-0001bJ-6w
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 08:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597926483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+EKqHWsk01YkJj3wPmRDZ+g8oOUui84dZ5XwbpxkVc=;
 b=UalDptFrh+TBWDp2290KHkZPDH0Cr9HtIHwilUMbCwYHSt27Ox1Qayr7UjMtpeDE2EiF7i
 X3cV6uxRwCtk/GpwEU8JFiRHjGX8+Z4GhwKjXn1fmkjzbCzvvK2s7WUavyBSy3UFMduTJ8
 QzjUfeijdNkqkYJvbztvzDjzIvX8Jlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-D72bZbJcN-iK6OAgEc8XzQ-1; Thu, 20 Aug 2020 08:27:59 -0400
X-MC-Unique: D72bZbJcN-iK6OAgEc8XzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B651074643;
 Thu, 20 Aug 2020 12:27:57 +0000 (UTC)
Received: from gondolin (ovpn-112-251.ams2.redhat.com [10.36.112.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 383C974E2A;
 Thu, 20 Aug 2020 12:27:43 +0000 (UTC)
Date: Thu, 20 Aug 2020 14:27:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [ovirt-devel] Re: device compatibility interface for live
 migration with assigned devices
Message-ID: <20200820142740.6513884d.cohuck@redhat.com>
In-Reply-To: <c1d580dd-5c0c-21bc-19a6-f776617d4ec2@redhat.com>
References: <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <BY5PR12MB4322C9D1A66C4657776A1383DC5C0@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20200819033035.GA21172@joy-OptiPlex-7040>
 <e20812b7-994b-b7f9-2df4-a78c4d116c7f@redhat.com>
 <20200819065951.GB21172@joy-OptiPlex-7040>
 <d6f9a51e-80b3-44c5-2656-614b327dc080@redhat.com>
 <20200819081338.GC21172@joy-OptiPlex-7040>
 <c1d580dd-5c0c-21bc-19a6-f776617d4ec2@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 08:28:03
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, "eauger@redhat.com" <eauger@redhat.com>,
 "xin-ran.wang@intel.com" <xin-ran.wang@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "openstack-discuss@lists.openstack.org"
 <openstack-discuss@lists.openstack.org>,
 "shaohe.feng@intel.com" <shaohe.feng@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, Yan Zhao <yan.y.zhao@intel.com>,
 Parav Pandit <parav@mellanox.com>,
 "jian-feng.ding@intel.com" <jian-feng.ding@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "hejie.xu@intel.com" <hejie.xu@intel.com>,
 "bao.yumeng@zte.com.cn" <bao.yumeng@zte.com.cn>,
 Alex Williamson <alex.williamson@redhat.com>, Parav Pandit <parav@nvidia.com>,
 "sm ooney@redhat.com" <smooney@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>, Jiri Pirko <jiri@mellanox.com>,
 "dinechin@redhat.com" <dinechin@redhat.com>,
 "devel@ovirt.org" <devel@ovirt.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 17:28:38 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/8/19 =E4=B8=8B=E5=8D=884:13, Yan Zhao wrote:
> > On Wed, Aug 19, 2020 at 03:39:50PM +0800, Jason Wang wrote: =20
> >> On 2020/8/19 =E4=B8=8B=E5=8D=882:59, Yan Zhao wrote: =20
> >>> On Wed, Aug 19, 2020 at 02:57:34PM +0800, Jason Wang wrote: =20
> >>>> On 2020/8/19 =E4=B8=8A=E5=8D=8811:30, Yan Zhao wrote: =20
> >>>>> hi All,
> >>>>> could we decide that sysfs is the interface that every VFIO vendor =
driver
> >>>>> needs to provide in order to support vfio live migration, otherwise=
 the
> >>>>> userspace management tool would not list the device into the compat=
ible
> >>>>> list?
> >>>>>
> >>>>> if that's true, let's move to the standardizing of the sysfs interf=
ace.
> >>>>> (1) content
> >>>>> common part: (must)
> >>>>>       - software_version: (in major.minor.bugfix scheme) =20
> >>>> This can not work for devices whose features can be negotiated/adver=
tised
> >>>> independently. (E.g virtio devices)

I thought the 'software_version' was supposed to describe kind of a
'protocol version' for the data we transmit? I.e., you add a new field,
you bump the version number.

> >>>> =20
> >>> sorry, I don't understand here, why virtio devices need to use vfio i=
nterface? =20
> >>
> >> I don't see any reason that virtio devices can't be used by VFIO. Do y=
ou?
> >>
> >> Actually, virtio devices have been used by VFIO for many years:
> >>
> >> - passthrough a hardware virtio devices to userspace(VM) drivers
> >> - using virtio PMD inside guest
> >> =20
> > So, what's different for it vs passing through a physical hardware via =
VFIO? =20
>=20
>=20
> The difference is in the guest, the device could be either real hardware=
=20
> or emulated ones.
>=20
>=20
> > even though the features are negotiated dynamically, could you explain
> > why it would cause software_version not work? =20
>=20
>=20
> Virtio device 1 supports feature A, B, C
> Virtio device 2 supports feature B, C, D
>=20
> So you can't migrate a guest from device 1 to device 2. And it's=20
> impossible to model the features with versions.

We're talking about the features offered by the device, right? Would it
be sufficient to mandate that the target device supports the same
features or a superset of the features supported by the source device?

>=20
>=20
> >
> > =20
> >>> I think this thread is discussing about vfio related devices.
> >>> =20
> >>>>>       - device_api: vfio-pci or vfio-ccw ...
> >>>>>       - type: mdev type for mdev device or
> >>>>>               a signature for physical device which is a counterpar=
t for
> >>>>> 	   mdev type.
> >>>>>
> >>>>> device api specific part: (must)
> >>>>>      - pci id: pci id of mdev parent device or pci id of physical p=
ci
> >>>>>        device (device_api is vfio-pci)API here. =20
> >>>> So this assumes a PCI device which is probably not true.
> >>>> =20
> >>> for device_api of vfio-pci, why it's not true?
> >>>
> >>> for vfio-ccw, it's subchannel_type. =20
> >>
> >> Ok but having two different attributes for the same file is not good i=
dea.
> >> How mgmt know there will be a 3rd type? =20
> > that's why some attributes need to be common. e.g.
> > device_api: it's common because mgmt need to know it's a pci device or a
> >              ccw device. and the api type is already defined vfio.h.
> > 	    (The field is agreed by and actually suggested by Alex in previous=
 mail)
> > type: mdev_type for mdev. if mgmt does not understand it, it would not
> >        be able to create one compatible mdev device.
> > software_version: mgmt can compare the major and minor if it understands
> >        this fields. =20
>=20
>=20
> I think it would be helpful if you can describe how mgmt is expected to=20
> work step by step with the proposed sysfs API. This can help people to=20
> understand.

My proposal would be:
- check that device_api matches
- check possible device_api specific attributes
- check that type matches [I don't think the combination of mdev types
  and another attribute to determine compatibility is a good idea;
  actually, the current proposal confuses me every time I look at it]
- check that software_version is compatible, assuming semantic
  versioning
- check possible type-specific attributes

>=20
> Thanks for the patience. Since sysfs is uABI, when accepted, we need=20
> support it forever. That's why we need to be careful.

Nod.

(...)


