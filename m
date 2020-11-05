Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1CBC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD31F20715
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzTYHOcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD31F20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaguN-0001PA-99
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kagt8-0000gB-7Z
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:09:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kagt5-00024Q-Iw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604588958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=OjxGY/NDD8MNDkaPW2bxHLz9xVROLLjTDFFFdMuzLTU=;
 b=TzTYHOcqK+LF4xY6E26huVQ8tAI4OgxzaBX/mZm+yg8erfclw/MSiUtaRoJTaAbhq9lwXc
 S+Pdn/hZfKzzwaakuZd4e5rkr/M0SsOTEUuHJLcpnN+hBt23YOX666E8spfhYEbzNkAMyt
 sqmv9YqQI5oPM/akBr0I12521HTUCR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-nw9wkAFMNlqFcQYMYQuZWg-1; Thu, 05 Nov 2020 10:09:14 -0500
X-MC-Unique: nw9wkAFMNlqFcQYMYQuZWg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8C12106B201;
 Thu,  5 Nov 2020 15:09:12 +0000 (UTC)
Received: from localhost (ovpn-115-101.ams2.redhat.com [10.36.115.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D63A5D9D5;
 Thu,  5 Nov 2020 15:09:03 +0000 (UTC)
Date: Thu, 5 Nov 2020 15:09:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC v2] VFIO Migration
Message-ID: <20201105150902.GA472489@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: John G Johnson <john.g.johnson@oracle.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, mtsirkin@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>, "Zeng,
 Xin" <xin.zeng@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2 (big change, please reread everything):
* Replace URIs with Go-style <domain>/<path> strings
* Replace configuration parameters with migration parameters. The semantics are
  different; they only describe migration compatibility and do not capture all
  device configuration. This makes it easier to explain the purpose of
  parameters and also logically separates device instantiation from migration
  compatibility checking.
* Describe how to achieve subsection semantics
* Add hint that device internal state should be as general as possible to allow
  different device implementations
* Drop versions, they added complexity and aren't necessary for the migration
  compatibility check
* Add first draft VFIO/mdev sysfs attr interface

VFIO Migration
==============
This document describes how to ensure migration compatibility for VFIO devices,
including VFIO/mdev and vfio-user devices.

Overview
--------
VFIO devices can save and load a *device state*. Saving a device state produces
a snapshot of a VFIO device's state that can be loaded again at a later point
in time to resume the device from the snapshot.

The process of saving a device state and loading it later is called
*migration*. The device state may be loaded by the same device instance that
saved it or by a new instance, possibly running on a different machine.

A VFIO/mdev driver together with the physical device provides the functionality
of a device. Alternatively, a vfio-user device emulation program can provide
the functionality of a device. These are called *device implementations*.

The device implementation where a migration originates is called the *source*
and the device implementation that a migration targets is called the
*destination*.

This document describes how to establish whether or not migration compatibility
exists between the source and destination. When compatibility has been
established, the probability of migrating successfully is high and a successful
migration does not leave the device inoperable due to silent migration
problems.

Migration Parameters
--------------------
*Migration parameters* are used to describe characteristics that must match
between source and destination to achieve migration compatibility.

The first implementation of a simple device may not require migration
parameters if the source and destination are always compatible. As the device
evolves, the source and destination may differ and migration parameters are
required to express this variation. More complex devices may require migration
parameters from the start due to optional functionality that is not guaranteed
to be present in both source and destination.

A migration parameter consists of a name and a value. The name is a UTF-8
string that does not contain equals ('='), backslash ('/'), or whitespace
characters. The value is a UTF-8 string that does not contain whitespace
characters.

The meaning of the migration parameter and its possible values are specific to
the device, but values are generally based on one of the following types:
* Boolean (on/off)
* Integers (0, 1, 2, ...)
* Enumerations (red, green, blue, ...)
* Character strings

Migration parameters are conventionally formatted as <name>=<value> strings.
Examples include my-feature=on and num-queues=4.

The absence of a migration parameter must have the same effect as before the
migration parameter was introduced. For example, if my-feature=on|off is added
to control the availability of a new device feature, then my-feature=off is
equivalent to omitting the migration parameter.

Hardware Interface Compatibility
--------------------------------
VFIO devices have a *hardware interface* consisting of device regions and
interrupts. Aspects of the hardware interface can vary between device
implementations and require migration parameters to express migration
compatibility requirements.

Examples of migration parameters include:
* Feature availability - feature bitmasks, hardware revision numbers, etc. If
  the destination may lack support for optional features or hardware interface
  revisions, then migration parameters are required.
* Functionality - hardware register blocks that are only present on certain
  device instances. If there are multiple devices sub-models that have
  different hardware interfaces then migration parameters are required.

These examples demonstrate aspects of the hardware interface that must not
change unexpectedly. Were they to differ between source and destination, the
chance of device driver malfunction would be high because the layout of the
hardware interface would change or assumptions the device driver makes about
available functionality would be violated. Migration parameters are used to
preserve the hardware interface across migration and explicitly represent
variations between device implementations.

Hardware interfaces sometimes support reporting an event when a change occurs.
In those cases it may be possible to support visible changes in the hardware
interface across migration. In most other cases migration must not result in a
visible change in the hardware interface.

Migration parameters are not necessary for read-only values exposed through the
hardware interface, such as MAC address EEPROMs or serial numbers, so long as
all device implementations can be configured with the same range of input
values for these read-only values. This is possible because migration
parameters do not capture the full configuration of the device, only aspects
that affect migration compatibility.

Device configuration that is not visible through the hardware interface, such
as a host file system path of a disk image file or the physical network port
assigned to a network card, usually does not require migration parameters
because those values are not visible through the hardware interface and can be
changed without breaking migration compatibility.

The disk image file may indirectly affect the hardware interface, for example
by constraining the device's block size. In this case a block-size=N migration
parameter is required to ensure migration compatibility, but the host file
system path of the disk image file still does not require a migration
parameter.

Device State Representation
---------------------------
Device state contains both data accessible through the device's hardware
interface and device-internal state needed to restore device operation.

The contents of hardware registers are usually included in the device state if
they can change at runtime. Hardware registers with constant or computed data
may not need to be part of the device state provided that device
implementations can produce the necessary data.

Device-internal state includes the portion of the device's state that cannot be
reconstructed from the hardware interface alone. Defining device-internal state
in the most general way instead of exposing device implementation details
allows for flexibility in the future. For example, device implementations often
maintain a ring index, which is not available through the hardware interface,
to keep track of which ring elements have already been consumed. The ring index
must be included in the device state so that the destination can resume
processing from the correct point in the ring. Representing this as an index
into the ring in the hardware interface is more general than adding device
implementation-specific request tracking data structures into the device state.

The *device state representation* defines the binary data layout of the device
state. The device state representation is specific to each device and is beyond
the scope of this document, but aspects pertaining to migration compatibility
are discussed here.

Each change to the device state representation that affects migration
compatibility requires a migration parameter. When a new field is added to the
device state representation then a new migration parameter must be added to
reflect this change. Often a single migration parameter expresses both a change
to the hardware interface and the device state representation. It is also
possible to change the device state representation without changing the
hardware interface, for example when some state was forgotten while designing
the previous device state representation.

The device state representation may support extra data that can be safely
ignored by old device implementations. In this case migration compatibility is
unaffected and a migration parameter is not required to indicate such extra
data has been added.

Device Models
-------------
The combination of the hardware interface, device state representation, and
migration parameter definitions is called a *device model*. Device models are
identified by a unique UTF-8 string starting with a domain name and followed by
path components separated with backslashes ('/'). Examples include
vendor-a.com/my-nic, gitlab.com/user/my-device, virtio-spec.org/pci/virtio-net,
and qemu.org/pci/10ec/8139.

The unique device model string is not changed as the device evolves. Instead,
migration parameters are added to express variations in a device.

The device model is not tied to a specific device implementation. The same
device model could be implemented as a VFIO/dev driver or as a vfio-user device
emulation program.

Multiple device implementations can support the same device model. Doing so
means that the device implementations can offer migration compatiblity because
they support the same hardware interface, device state representation, and
migration parameters.

Multiple device models can exist for the same hardware interface, each with a
different device state representation and migration parameters. This makes it
possible to fork and independently develop device models.

Device models can evolve over time as the hardware interface and device state
representation change. The corresponding migration parameters ensure that
migration compatibility can be established between device implementations.

Orchestrating Migrations
------------------------
The following steps must be followed to migrate devices:

1. Check that the source and destination support the same device model.

2. Check that the destination supports the migration parameter list from the
   source.

3. Configure the destination so it is prepared to load the device state. This
   may involve instantiating a new device instance or resetting an existing
   device instance to a configuration that is compatible with the source.

   The migration parameter list may be used as part of this configuration, but
   note that not all of the configuration is captured in the migration
   parameter list. For example, the physical network port for a network card or
   the host file system path for a disk image file is typically not captured in
   the migration parameters and must be provided through other means.

4. Save the device state on the source and load it on the destination.

5. If migration succeeds then the destination resumes operation and the source
   must not resume operation. If the migration fails then the source resumes
   operation and the destination must not resume operation.

Note that these steps impose a conservative bound on device states that can be
migrated successfully. Not all configuration parameters may be strictly
required to match on the source and destination devices. For example, if the
device's hardware interface has not yet been initialized then changes to the
advertised features may not yet affect the device driver. However, accurately
representing runtime constraints is complex and risks introducing migration
bugs, so no attempt is made to support them.

VFIO/mdev Devices
-----------------
TODO this is a first draft, more thought needed around enumerating supported
parameters, representing default values, etc

The following mdev type sysfs attrs are available for managing device
instances:

  /sys/.../<parent-device>/mdev_supported_types/<type-id>/
      create - writing a UUID to this file instantiates a device
      migration/ - migration related files
          model - unique device model string, e.g. vendor-a.com/my-nic

Device models supported by an mdev driver can be enumerated by reading the
migration/model attr for each <type-id>.

The following mdev device sysfs attrs relate to a specific device instance:

  /sys/.../<parent-device>/<uuid>/
      mdev_type/ - symlink to mdev type sysfs attrs, e.g. to fetch migration/model
      migration/ - migration related files
          applied - Write "1" to apply current migration parameter values or
                    "0" to reset migration parameter values to their defaults.
                    Parameters can only be applied or reset while the mdev is
                    not opened.
          params/ - migration parameters
              <my-param> - read/write migration parameter "my-param"
              ...

When the device is created the migration/applied attr is "0". Migration
parameters are accessible in migration/params/ and read 0 bytes because they
are at their default values.  At the point opening the mdev device will fail
because migration parameters must be applied first. Migration parameters can be
set to the desired values or left at their defaults. "1" must be written to
migration/applied before opening the mdev device.

If writing to a migration/params/<param> attr or setting migration/applied to
"1" fails, then the device implementation does not support the migration
parameters.

An open mdev device typically does not allow migration parameters to be changed
at runtime. However, certain migration/params attrs may allow writes at
runtime. Usually these migration parameters only affect the device state
representation and not the hardware interface. This makes it possible to
upgrade or downgrade the device state representation at runtime so that
migration is possible to newer or older device implementations.

An existing mdev device instance can be reused by closing the mdev device and
writing "0" to migration/applied. This resets parameters to their defaults so
that a new list of migration parameters can be applied.

The migration parameter list for an mdev device that is in operation can be
read from migration/params/. Parameters that read 0 bytes are at their default
value.

vfio-user Devices
-----------------
TODO use FUSE to mimic VFIO/mdev sysfs (probably can't due to security
concerns, use UNIX domain socket RPC instead)?

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+kFY4ACgkQnKSrs4Gr
c8ixNQgAlFXzfaVpWoeM8if/9ZP0ZRQKuKe24qnY6+4mM7oOlAyW49yfGHywRGEC
o/7mxolFU15nhU6FTe/w2BvqgMVsV4I+3jf+sL3ZDXA94yhSZdXauXqLubiutvoo
0OILYmIVA3bjwaI7pGuVnEDinEOYUHBAAE8rwlt0oihzYqWC2pwbbSipmcdxwWDF
PuGT1yh4zEgBPa2+OwmZgki00mLRzhu2jqQ2surhNpP0MqqksokEcKCXEiEY9APM
zJ2ew1n5uJj8o8LC58385qPka4ftY8xlvb76oirfhUIP3XPeyKsaAEv6Zim4/UBO
0yZEk0nLAoXsIYTeRo6zwaZ2pZLFkg==
=xwgx
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--


