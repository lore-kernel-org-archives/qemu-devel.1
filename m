Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A3AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2334122518
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmFG6Eue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2334122518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOcX-0003s2-9F
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jvObI-000341-LY
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:20:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32851
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jvObC-0004ba-9H
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594747207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=77qORKYNn8vDde5yFouLQNRCTrE7aOFGmLYngxMTT6w=;
 b=LmFG6Eueup2tMh/C9tuEvb9rGy4jwrWeflqe1YKgTcPjAMzdV4DVHQjKyySlJovzJ+S0J+
 oXdGxBJn0FTKOkGP1rJinKPYEL2HUFFXwMRpF4oEokH31B0qVFqMXOrt7qckihrv7jkWeJ
 lzfGL5HH6X5fdwo53e0YpXqjojPxx74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-58lRDI6JN5iRjydGl4DMSg-1; Tue, 14 Jul 2020 13:20:05 -0400
X-MC-Unique: 58lRDI6JN5iRjydGl4DMSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B6B98027E3;
 Tue, 14 Jul 2020 17:20:02 +0000 (UTC)
Received: from work-vm (ovpn-113-100.ams2.redhat.com [10.36.113.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A75AA72E68;
 Tue, 14 Jul 2020 17:19:48 +0000 (UTC)
Date: Tue, 14 Jul 2020 18:19:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200714171946.GL2728@work-vm>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <20200714102129.GD25187@redhat.com>
 <20200714101616.5d3a9e75@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714101616.5d3a9e75@x1.home>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
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
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, eskultet@redhat.com,
 jian-feng.ding@intel.com, zhenyuw@linux.intel.com, hejie.xu@intel.com,
 bao.yumeng@zte.com.cn, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 cohuck@redhat.com, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Alex Williamson (alex.williamson@redhat.com) wrote:
> On Tue, 14 Jul 2020 11:21:29 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Tue, Jul 14, 2020 at 07:29:57AM +0800, Yan Zhao wrote:
> > > hi folks,
> > > we are defining a device migration compatibility interface that helps upper
> > > layer stack like openstack/ovirt/libvirt to check if two devices are
> > > live migration compatible.
> > > The "devices" here could be MDEVs, physical devices, or hybrid of the two.
> > > e.g. we could use it to check whether
> > > - a src MDEV can migrate to a target MDEV,
> > > - a src VF in SRIOV can migrate to a target VF in SRIOV,
> > > - a src MDEV can migration to a target VF in SRIOV.
> > >   (e.g. SIOV/SRIOV backward compatibility case)
> > > 
> > > The upper layer stack could use this interface as the last step to check
> > > if one device is able to migrate to another device before triggering a real
> > > live migration procedure.
> > > we are not sure if this interface is of value or help to you. please don't
> > > hesitate to drop your valuable comments.
> > > 
> > > 
> > > (1) interface definition
> > > The interface is defined in below way:
> > > 
> > >              __    userspace
> > >               /\              \
> > >              /                 \write
> > >             / read              \
> > >    ________/__________       ___\|/_____________
> > >   | migration_version |     | migration_version |-->check migration
> > >   ---------------------     ---------------------   compatibility
> > >      device A                    device B
> > > 
> > > 
> > > a device attribute named migration_version is defined under each device's
> > > sysfs node. e.g. (/sys/bus/pci/devices/0000\:00\:02.0/$mdev_UUID/migration_version).
> > > userspace tools read the migration_version as a string from the source device,
> > > and write it to the migration_version sysfs attribute in the target device.
> > > 
> > > The userspace should treat ANY of below conditions as two devices not compatible:
> > > - any one of the two devices does not have a migration_version attribute
> > > - error when reading from migration_version attribute of one device
> > > - error when writing migration_version string of one device to
> > >   migration_version attribute of the other device
> > > 
> > > The string read from migration_version attribute is defined by device vendor
> > > driver and is completely opaque to the userspace.
> > > for a Intel vGPU, string format can be defined like
> > > "parent device PCI ID" + "version of gvt driver" + "mdev type" + "aggregator count".
> > > 
> > > for an NVMe VF connecting to a remote storage. it could be
> > > "PCI ID" + "driver version" + "configured remote storage URL"
> > > 
> > > for a QAT VF, it may be
> > > "PCI ID" + "driver version" + "supported encryption set".
> > > 
> > > (to avoid namespace confliction from each vendor, we may prefix a driver name to
> > > each migration_version string. e.g. i915-v1-8086-591d-i915-GVTg_V5_8-1)
> 
> It's very strange to define it as opaque and then proceed to describe
> the contents of that opaque string.  The point is that its contents
> are defined by the vendor driver to describe the device, driver version,
> and possibly metadata about the configuration of the device.  One
> instance of a device might generate a different string from another.
> The string that a device produces is not necessarily the only string
> the vendor driver will accept, for example the driver might support
> backwards compatible migrations.

(As I've said in the previous discussion, off one of the patch series)

My view is it makes sense to have a half-way house on the opaqueness of
this string; I'd expect to have an ID and version that are human
readable, maybe a device ID/name that's human interpretable and then a
bunch of other cruft that maybe device/vendor/version specific.

I'm thinking that we want to be able to report problems and include the
string and the user to be able to easily identify the device that was
complaining and notice a difference in versions, and perhaps also use
it in compatibility patterns to find compatible hosts; but that does
get tricky when it's a 'ask the device if it's compatible'.

Dave

> > > (2) backgrounds
> > > 
> > > The reason we hope the migration_version string is opaque to the userspace
> > > is that it is hard to generalize standard comparing fields and comparing
> > > methods for different devices from different vendors.
> > > Though userspace now could still do a simple string compare to check if
> > > two devices are compatible, and result should also be right, it's still
> > > too limited as it excludes the possible candidate whose migration_version
> > > string fails to be equal.
> > > e.g. an MDEV with mdev_type_1, aggregator count 3 is probably compatible
> > > with another MDEV with mdev_type_3, aggregator count 1, even their
> > > migration_version strings are not equal.
> > > (assumed mdev_type_3 is of 3 times equal resources of mdev_type_1).
> > > 
> > > besides that, driver version + configured resources are all elements demanding
> > > to take into account.
> > > 
> > > So, we hope leaving the freedom to vendor driver and let it make the final decision
> > > in a simple reading from source side and writing for test in the target side way.
> > > 
> > > 
> > > we then think the device compatibility issues for live migration with assigned
> > > devices can be divided into two steps:
> > > a. management tools filter out possible migration target devices.
> > >    Tags could be created according to info from product specification.
> > >    we think openstack/ovirt may have vendor proprietary components to create
> > >    those customized tags for each product from each vendor.  
> > 
> > >    for Intel vGPU, with a vGPU(a MDEV device) in source side, the tags to
> > >    search target vGPU are like:
> > >    a tag for compatible parent PCI IDs,
> > >    a tag for a range of gvt driver versions,
> > >    a tag for a range of mdev type + aggregator count
> > > 
> > >    for NVMe VF, the tags to search target VF may be like:
> > >    a tag for compatible PCI IDs,
> > >    a tag for a range of driver versions,
> > >    a tag for URL of configured remote storage.  
> 
> I interpret this as hand waving, ie. the first step is for management
> tools to make a good guess :-\  We don't seem to be willing to say that
> a given mdev type can only migrate to a device with that same type.
> There's this aggregation discussion happening separately where a base
> mdev type might be created or later configured to be equivalent to a
> different type.  The vfio migration API we've defined is also not
> limited to mdev devices, for example we could create vendor specific
> quirks or hooks to provide migration support for a physical PF/VF
> device.  Within the realm of possibility then is that we could migrate
> between a physical device and an mdev device, which are simply
> different degrees of creating a virtualization layer in front of the
> device.
>  
> > Requiring management application developers to figure out this possible
> > compatibility based on prod specs is really unrealistic. Product specs
> > are typically as clear as mud, and with the suggestion we consider
> > different rules for different types of devices, add up to a huge amount
> > of complexity. This isn't something app developers should have to spend
> > their time figuring out.
> 
> Agreed.
> 
> > The suggestion that we make use of vendor proprietary helper components
> > is totally unacceptable. We need to be able to build a solution that
> > works with exclusively an open source software stack.
> 
> I'm surprised to see this as well, but I'm not sure if Yan was really
> suggesting proprietary software so much as just vendor specific
> knowledge.
> 
> > IMHO there needs to be a mechanism for the kernel to report via sysfs
> > what versions are supported on a given device. This puts the job of
> > reporting compatible versions directly under the responsibility of the
> > vendor who writes the kernel driver for it. They are the ones with the
> > best knowledge of the hardware they've built and the rules around its
> > compatibility.
> 
> The version string discussed previously is the version string that
> represents a given device, possibly including driver information,
> configuration, etc.  I think what you're asking for here is an
> enumeration of every possible version string that a given device could
> accept as an incoming migration stream.  If we consider the string as
> opaque, that means the vendor driver needs to generate a separate
> string for every possible version it could accept, for every possible
> configuration option.  That potentially becomes an excessive amount of
> data to either generate or manage.
> 
> Am I overestimating how vendors intend to use the version string?
> 
> We'd also need to consider devices that we could create, for instance
> providing the same interface enumeration prior to creating an mdev
> device to have a confidence level that the new device would be a valid
> target.
> 
> We defined the string as opaque to allow vendor flexibility and because
> defining a common format is hard.  Do we need to revisit this part of
> the discussion to define the version string as non-opaque with parsing
> rules, probably with separate incoming vs outgoing interfaces?  Thanks,
> 
> Alex
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


