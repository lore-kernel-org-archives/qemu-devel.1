Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D1DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94990206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 11:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUo9+aiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94990206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZugY-0005Ym-It
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 06:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZufI-00052k-VF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZufG-0002iZ-7T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 06:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604403587;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=U1+XOJmZTqvluiHDj8G9YnM5MM+sUTIrL3E4RNHBmXI=;
 b=IUo9+aiMIr1fh0NTPvjKuhg4b95L5OWJyX+KLGP2AxII/q6RwG7BM3zpFdT1HSEhSgMvnB
 Eof42rKhFFZL8vd2E/zmpiN2XiMZcs4YRafEGt00DozYRxLiWCyJgS5kdHzrt2eT/wKEA5
 vBtSN/hvOAEXmhldEI/dMB52N9B6yYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-vUattP6bOweCzf2O9ZdmWQ-1; Tue, 03 Nov 2020 06:39:44 -0500
X-MC-Unique: vUattP6bOweCzf2O9ZdmWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB361107465C;
 Tue,  3 Nov 2020 11:39:42 +0000 (UTC)
Received: from redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D04B75130;
 Tue,  3 Nov 2020 11:39:32 +0000 (UTC)
Date: Tue, 3 Nov 2020 11:39:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103113929.GH205187@redhat.com>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201102111153.GC42093@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
> There is discussion about VFIO migration in the "Re: Out-of-Process
> Device Emulation session at KVM Forum 2020" thread. The current status
> is that Kirti proposed a VFIO device region type for saving and loading
> device state. There is currently no guidance on migrating between
> different device versions or device implementations from different
> vendors. This is known to be non-trivial and raised discussion about
> whether it should really be handled by VFIO or centralized in QEMU.
> 
> Below is a document that describes how to ensure migration compatibility
> in VFIO. It does not require changes to the VFIO migration interface. It
> can be used for both VFIO/mdev kernel devices and vfio-user devices.
> 
> The idea is that the device state blob is opaque to the VMM but the same
> level of migration compatibility that exists today is still available.
> 
> I hope this will help us reach consensus and let us discuss specifics.
> 
> If you followed the previous discussion, I changed the approach from
> sending a magic constant in the device state blob to identifying device
> models by URIs. Therefore the device state structure does not need to be
> defined here - the critical information for ensuring device migration
> compatibility is the device model and configuration defined below.
> 
> Stefan
> ---
> VFIO Migration
> ==============
> This document describes how to save and load VFIO device states. Saving a
> device state produces a snapshot of a VFIO device's state that can be loaded
> again at a later point in time to resume the device from the snapshot.
> 
> The data representation of the device state is outside the scope of this
> document.
> 
> Overview
> --------
> The purpose of device states is to save the device at a point in time and then
> restore the device back to the saved state later. This is more challenging than
> it first appears.
> 
> The process of saving a device state and loading it later is called
> *migration*. The state may be loaded by the same device that saved it or by a
> new instance of the device, possibly running on a different computer.
> 
> It must be possible to migrate to a newer implementation of the device
> as well as to an older implementation of the device. This allows users
> to upgrade and roll back their systems.
> 
> Migration can fail if loading the device state is not possible. It should fail
> early with a clear error message. It must not appear to complete but leave the
> device inoperable due to a migration problem.

I think there needs to be an addition requirement.

 It must be possible for a management application to query the supported
 versions, independantly of execution of a migration  operation.

This is important to large scale data center / cloud management applications
because before initiating a migration they need to *automatically* select
a target host with high level of confidence that is will be compatible with
the source host.

Today QEMU migration compatibility is largely determined by the machine
type version. Apps can query the supported machine types for host to
check whether it is compatible. Similarly they will query CPU model
features to check compatiblity.

Validation and error checking at time of migration is of course still
required, but the goal should be that an mgmt application will *NEVER*
hit these errors because they will have pre-selected a host that is
known to be compatible based on reported versions that are supported.

> Device Versions
> ---------------
> As a device evolves, the number of configuration parameters required may become
> inconvenient for users to express in full. A device configuration can be
> aliased by a *device version*, which is a shorthand for the full device
> configuration. This makes it easy to apply a standard device configuration
> without listing every configuration parameter explicitly.
> 
> For example, if address filtering support was added to a network card then
> device versions and the corresponding configurations may look like this:
> * ``version=1`` - Behaves as if ``rx-filter-size=0``
> * ``version=2`` - ``rx-filter-size=32``
> 
> Device States
> -------------
> The details of the device state representation are not covered in this document
> but the general requirements are discussed here.
> 
> The device state consists of data accessible through the device's hardware
> interface and internal state that is needed to restore device operation.
> State in the hardware interface includes the values of hardware registers.
> An example of internal state is an index value needed to avoid processing
> queued requests more than once.
> 
> Changes can be made to the device state representation as follows. Each change
> to device state must have a corresponding device configuration parameter that
> allows the change to toggled:
> 
> * When the parameter is disabled the hardware interface and device state
>   representation are unchanged. This allows old device states to be loaded.
> 
> * When the parameter is enabled the change comes into effect.
> 
> * The parameter's default value disables the change. Therefore old versions do
>   not have to explicitly specify the parameter.
> 
> The following example illustrates migration from an old device
> implementation to a new one. A version=1 network card is migrated to a
> new device implementation that is also capable of version=2 and adds the
> rx-filter-size=32 parameter. The new device is instantiated with
> version=1, which disables rx-filter-size and is capable of loading the
> version=1 device state. The migration completes successfully but note
> the device is still operating at version=1 level in the new device.
> 
> The following example illustrates migration from a new device
> implementation back to an older one. The new device implementation
> supports version=1 and version=2. The old device implementation supports
> version=1 only. Therefore the device can only be migrated when
> instantiated with version=1 or the equivalent full configuration
> parameters.
> 
> Orchestrating Migrations
> ------------------------
> The following steps must be followed to migrate devices:
> 
> 1. Check that the source and destination devices support the same device model.
> 
> 2. Check that the destination device supports the source device's
>    configuration. Each configuration parameter must be accepted by the
>    destination in order to ensure that it will be possible to load the device
>    state.
> 
> 3. The device state is saved on the source and loaded on the destination.
> 
> 4. If migration succeeds then the destination resumes operation and the source
>    must not resume operation. If the migration fails then the source resumes
>    operation and the destination must not resume operation.
> 
> VFIO Implementation
> -------------------
> The following applies both to kernel VFIO/mdev drivers and vfio-user device
> backends.
> 
> Devices are instantiated based on a version and/or configuration parameters:
> * ``version=1`` - use the device configuration aliased by version 1
> * ``version=2,rx-filter-size=64`` - use version 1 and override ``rx-filter-size``
> * ``rx-filter-size=0`` - directly set configuration parameters without using a version
> 
> Device creation fails if the version and/or configuration parameters are not
> supported.
> 
> There must be a mechanism to query the "latest" configuration for a device
> model. It may simply report the ``version=5`` where 5 is the latest version but
> it could also report all configuration parameters instead of using a version
> alias.

The mechanism needs to be able to report all supported versions strings,
not simple the latest version string. I think we need to specify the
actual mechanism todo this query too, because we can't end up in a place
where there's a different approach to queries for each device type.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


