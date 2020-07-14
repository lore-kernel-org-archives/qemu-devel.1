Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C56C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7452E2256C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qc9v2eje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7452E2256C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO7Y-0001yF-NU
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvO6J-0000C3-0t
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:48:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21302
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvO6G-0007Y1-Vp
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594745292;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T2JyUvXm344iGgCnax4ZsyF6v+hYO+iw65yyDRl2VeI=;
 b=Qc9v2ejeu8dEi30hDuy83vK3LaMgt2rocrE+awjB3KnNrqO1IKDuig8QWb4+oBKNvqwUx1
 AA0dsamLnxSUVr/GsKztLyvlBAPvatMdFXis9lC/1eZttbP3Z/z/ppBJEkaIboqUQ+QE+3
 8chOHmS4wreokrY1CyYYIntSAf1dpZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-HJPZdL5PN0ieLWFL52Csnw-1; Tue, 14 Jul 2020 12:47:42 -0400
X-MC-Unique: HJPZdL5PN0ieLWFL52Csnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D510D102CC38;
 Tue, 14 Jul 2020 16:47:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97C815D9C5;
 Tue, 14 Jul 2020 16:47:25 +0000 (UTC)
Date: Tue, 14 Jul 2020 17:47:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200714164722.GL25187@redhat.com>
References: <20200713232957.GD5955@joy-OptiPlex-7040>
 <20200714102129.GD25187@redhat.com>
 <20200714101616.5d3a9e75@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714101616.5d3a9e75@x1.home>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: kvm@vger.kernel.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 kwankhede@nvidia.com, eauger@redhat.com, xin-ran.wang@intel.com,
 corbet@lwn.net, openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Yan Zhao <yan.y.zhao@intel.com>, eskultet@redhat.com,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn, smooney@redhat.com,
 intel-gvt-dev@lists.freedesktop.org, cohuck@redhat.com, dinechin@redhat.com,
 devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 10:16:16AM -0600, Alex Williamson wrote:
> On Tue, 14 Jul 2020 11:21:29 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Tue, Jul 14, 2020 at 07:29:57AM +0800, Yan Zhao wrote:
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

If I'm interpreting your reply & the quoted text orrectly, the version
string isn't really a version string in any normal sense of the word
"version".

Instead it sounds like string encoding a set of features in some arbitrary
vendor specific format, which they parse and do compatibility checks on
individual pieces ? One or more parts may contain a version number, but
its much more than just a version.

If that's correct, then I'd prefer we didn't call it a version string,
instead call it a "capability string" to make it clear it is expressing
a much more general concept, but...

> We'd also need to consider devices that we could create, for instance
> providing the same interface enumeration prior to creating an mdev
> device to have a confidence level that the new device would be a valid
> target.
> 
> We defined the string as opaque to allow vendor flexibility and because
> defining a common format is hard.  Do we need to revisit this part of
> the discussion to define the version string as non-opaque with parsing
> rules, probably with separate incoming vs outgoing interfaces?  Thanks,

..even if the huge amount of flexibility is technically relevant from the
POV of the hardware/drivers, we should consider whether management apps
actually want, or can use, that level of flexibility.

The task of picking which host to place a VM on has alot of factors to
consider, and when there are a large number of hosts, the total amount
of information to check gets correspondingly large.  The placement
process is also fairly performance critical.

Running complex algorithmic logic to check compatibility of devices
based on a arbitrary set of rules is likely to be a performance
challenge. A flat list of supported strings is a much simpler
thing to check as it reduces down to a simple set membership test.

IOW, even if there's some complex set of device type / vendor specific
rules to check for compatibility, I fear apps will ignore them and
just define a very simplified list of compatible string, and ignore
all the extra flexibility.

I'm sure OpenStack maintainers can speak to this more, as they've put
alot of work into their scheduling engine to optimize the way it places
VMs largely driven from simple structured data reported from hosts.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


