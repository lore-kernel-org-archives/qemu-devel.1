Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E3C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C1622370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXtLjZk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C1622370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyB5-0004uT-4j
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZy9i-0002tz-Qr
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZy9g-0005vX-76
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604417005;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTiL/NmJGnU7GQxJqEckIaMoJKNoOqq9FRmIjUimQUE=;
 b=JXtLjZk2ru+LI3oKUUTnmXCVIFy4Tj3keJhDrek1TRGkGQYnvs9UrmaRvUhYmxMADL6itq
 6ze7cvTdTvgV7p3aQv+zzsqUO6F59iSpjol1Bi+VnFxKWFwvTt+vP1K1gqTAmXP71kQLTI
 /en6Pfy0OX5QefhF6A8aaWpjviiyUyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-1Ih7px6INBa_yhSPm6MQAg-1; Tue, 03 Nov 2020 10:23:20 -0500
X-MC-Unique: 1Ih7px6INBa_yhSPm6MQAg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 150B81009E2D;
 Tue,  3 Nov 2020 15:23:18 +0000 (UTC)
Received: from redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB56F1002391;
 Tue,  3 Nov 2020 15:23:06 +0000 (UTC)
Date: Tue, 3 Nov 2020 15:23:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103152303.GN205187@redhat.com>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201103113929.GH205187@redhat.com>
 <20201103150508.GB253848@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201103150508.GB253848@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 03:05:08PM +0000, Stefan Hajnoczi wrote:
> On Tue, Nov 03, 2020 at 11:39:29AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
> > > Overview
> > > --------
> > > The purpose of device states is to save the device at a point in time and then
> > > restore the device back to the saved state later. This is more challenging than
> > > it first appears.
> > > 
> > > The process of saving a device state and loading it later is called
> > > *migration*. The state may be loaded by the same device that saved it or by a
> > > new instance of the device, possibly running on a different computer.
> > > 
> > > It must be possible to migrate to a newer implementation of the device
> > > as well as to an older implementation of the device. This allows users
> > > to upgrade and roll back their systems.
> > > 
> > > Migration can fail if loading the device state is not possible. It should fail
> > > early with a clear error message. It must not appear to complete but leave the
> > > device inoperable due to a migration problem.
> > 
> > I think there needs to be an addition requirement.
> > 
> >  It must be possible for a management application to query the supported
> >  versions, independantly of execution of a migration  operation.
> > 
> > This is important to large scale data center / cloud management applications
> > because before initiating a migration they need to *automatically* select
> > a target host with high level of confidence that is will be compatible with
> > the source host.
> > 
> > Today QEMU migration compatibility is largely determined by the machine
> > type version. Apps can query the supported machine types for host to
> > check whether it is compatible. Similarly they will query CPU model
> > features to check compatiblity.
> > 
> > Validation and error checking at time of migration is of course still
> > required, but the goal should be that an mgmt application will *NEVER*
> > hit these errors because they will have pre-selected a host that is
> > known to be compatible based on reported versions that are supported.
> 
> Okay. What do you think of the following?
> 
>   [
>     {
>       "model": "https://qemu.org/devices/e1000e",
>       "params": [
>         "rss",
> 	...more configuration parameters...
>       ],
>       "versions": [
>         {
> 	  "name": "1",
> 	  "params": [],
> 	},
> 	{
> 	  "name": "2",
> 	  "params": ["rss=on"],
> 	},
> 	...more versions...
>       ]
>     },
>     ...more device models...
>   ]
> 
> The management tool can generate the configuration parameter list by
> expanding a version into its params.
> 
> Configuration parameter types and input ranges need more thought. For
> example, version 1 of the device might not have rx-table-size (it's
> effectively 0). Version 2 introduces rx-table-size and sets it to 32.
> Version 3 raises the value to 64. In addition, the user can set a custom
> value like rx-table-size=48. I haven't defined the rules for this yet,
> but it's clear there needs to be a way to extend configuration
> parameters.
> 
> To check migration compatibility:
> 1. Verify that the device model URL matches the JSON data[n].model
>    field.
> 2. For every configuration parameter name from the source device,
>    check that it is contained within the JSON data[n].params list.

I'm not convinced that this makes sense. A matching set of parameter
names + values does not imply that the migration data stream is
actually compatible.

ie implementations may need to change the internal migration data
stream to fix bugs, without adding/removing a config parameter.
The migration version string alone expresses data stream compatibility.

This is similar to how 2 QEMU command lines can have identical set
of configuration parameters, aside from the machine type version,
and thus be migration *incompatible.

Basically the version string should be considered an opaque blob
that expresses compatibility on its own.

> > > VFIO Implementation
> > > -------------------
> > > The following applies both to kernel VFIO/mdev drivers and vfio-user device
> > > backends.
> > > 
> > > Devices are instantiated based on a version and/or configuration parameters:
> > > * ``version=1`` - use the device configuration aliased by version 1
> > > * ``version=2,rx-filter-size=64`` - use version 1 and override ``rx-filter-size``
> > > * ``rx-filter-size=0`` - directly set configuration parameters without using a version
> > > 
> > > Device creation fails if the version and/or configuration parameters are not
> > > supported.
> > > 
> > > There must be a mechanism to query the "latest" configuration for a device
> > > model. It may simply report the ``version=5`` where 5 is the latest version but
> > > it could also report all configuration parameters instead of using a version
> > > alias.
> > 
> > The mechanism needs to be able to report all supported versions strings,
> > not simple the latest version string. I think we need to specify the
> > actual mechanism todo this query too, because we can't end up in a place
> > where there's a different approach to queries for each device type.
> 
> Makes sense.
> 
> Stefan



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


