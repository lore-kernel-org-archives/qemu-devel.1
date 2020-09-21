Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D6FC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3605420773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWW4NE50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3605420773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHil-0000CS-Ah
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKHgv-0007HS-1R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:00:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKHgq-0006Ne-2l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600678847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Guop7/bFvjx1o2CDPR4q58Gv8t+UFud2DhDQ7/Txj/A=;
 b=YWW4NE50gxo5ePEFeK8ptvRQdAM9NetiFFFR8X1sKu9qCQUFJWwp6IR4EJG371eLHnJwf0
 AlNEmj1LD/VziqnjvOAq7fNxIPOfY8M1Dm+ekGjZE7F73FAymypQCxZuMJg9sbPJjZilrY
 6AKVNQoyhOV26/4pFOJaj+1LEmu9Uog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-1dG7J8J_MV6jlMGSIPVRIw-1; Mon, 21 Sep 2020 05:00:31 -0400
X-MC-Unique: 1dG7J8J_MV6jlMGSIPVRIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94D30802B62;
 Mon, 21 Sep 2020 09:00:30 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4ACBA5C1DC;
 Mon, 21 Sep 2020 09:00:25 +0000 (UTC)
Date: Mon, 21 Sep 2020 11:00:23 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 0/3] Hyper-V Dynamic Memory Protocol driver (hv-balloon)
Message-ID: <20200921110023.10f6d01c@redhat.com>
In-Reply-To: <cover.1600556526.git.maciej.szmigiero@oracle.com>
References: <cover.1600556526.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 20 Sep 2020 15:25:19 +0200
"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> wrote:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

From description it sounds like an alternative of virtio-mem,
CCing David.

> This series adds a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
> and its protocol definitions.
> Also included is a driver providing backing devices for memory hot-add
> protocols ("haprots").
>=20
> A haprot device works like a virtual DIMM stick: it allows inserting
> extra RAM into the guest at run time.
>=20
> The main differences from the ACPI-based PC DIMM hotplug are:
> * Notifying the guest about the new memory range is not done via ACPI but
> via a protocol handler that registers with the haprot framework.
> This means that the ACPI DIMM slot limit does not apply.
>=20
> * A protocol handler can prevent removal of a haprot device when it is
> still in use by setting its "busy" field.
>=20
> * A protocol handler can also register an "unplug" callback so it gets
> notified when an user decides to remove the haprot device.
> This way the protocol handler can inform the guest about this fact and / =
or
> do its own cleanup.
>=20
> The hv-balloon driver is like virtio-balloon on steroids: it allows both
> changing the guest memory allocation via ballooning and inserting extra
> RAM into it by adding haprot virtual DIMM sticks.
> One of advantages of these over ACPI-based PC DIMM hotplug is that such
> memory can be hotplugged in much smaller granularity because the ACPI DIM=
M
> slot limit does not apply.
>=20
> In contrast with ACPI DIMM hotplug where one can only request to unplug a
> whole DIMM stick this driver allows removing memory from guest in single
> page (4k) units via ballooning.
> Then, once the guest has released the whole memory backed by a haprot
> virtual DIMM stick such device is marked "unused" and can be removed from
> the VM, if one wants so.
> A "HV_BALLOON_HAPROT_UNUSED" QMP event is emitted in this case so the
> software controlling QEMU knows that this operation is now possible.
>=20
> The haprot devices are also marked unused after a VM reboot (with a
> corresponding "HV_BALLOON_HAPROT_UNUSED" QMP event).
> They are automatically reinserted (if still present) after the guest
> reconnects to this protocol (a "HV_BALLOON_HAPROT_INUSE" QMP event is the=
n
> emitted).
>=20
> For performance reasons, the guest-released memory is tracked in few rang=
e
> trees, as a series of (start, count) ranges.
> Each time a new page range is inserted into such tree its neighbors are
> checked as candidates for possible merging with it.
>=20
> Besides performance reasons, the Dynamic Memory protocol itself uses page
> ranges as the data structure in its messages, so relevant pages need to b=
e
> merged into such ranges anyway.
>=20
> One has to be careful when tracking the guest-released pages, since the
> guest can maliciously report returning pages outside its current address
> space, which later clash with the address range of newly added memory.
> Similarly, the guest can report freeing the same page twice.
>=20
> The above design results in much better ballooning performance than when
> using virtio-balloon with the same guest: 230 GB / minute with this drive=
r
> versus 70 GB / minute with virtio-balloon.
>=20
> During a ballooning operation most of time is spent waiting for the guest
> to come up with newly freed page ranges, processing the received ranges o=
n
> the host side (in QEMU / KVM) is nearly instantaneous.
>=20
> The unballoon operation is also pretty much instantaneous:
> thanks to the merging of the ballooned out page ranges 200 GB of memory c=
an
> be returned to the guest in about 1 second.
> With virtio-balloon this operation takes about 2.5 minutes.
>=20
> These tests were done against a Windows Server 2019 guest running on a
> Xeon E5-2699, after dirtying the whole memory inside guest before each
> balloon operation.
>=20
> Using a range tree instead of a bitmap to track the removed memory also
> means that the solution scales well with the guest size: even a 1 TB rang=
e
> takes just few bytes of memory.
>=20
> The required GTree operations are available at
> https://gitlab.gnome.org/maciejsszmigiero/glib/-/tree/gtree-add-iterators
> Since they are not yet in the upstream Glib a check for them was added to
> "configure" script, together with new "--enable-hv-balloon" and
> "--disable-hv-balloon" arguments.
> If these GTree operations are missing in the system Glib this driver will
> be skipped during QEMU build.
>=20
> An optional "status-report=3Don" device parameter requests memory status
> events from the guest (typically sent every second), which allow the host
> to learn both the guest memory available and the guest memory in use
> counts.
> They are emitted externally as "HV_BALLOON_STATUS_REPORT" QMP events.
>=20
> The driver is named hv-balloon since the Linux kernel client driver for
> the Dynamic Memory Protocol is named as such and to follow the naming
> pattern established by the virtio-balloon driver.
> The whole protocol runs over Hyper-V VMBus that has its implementation
> recently merged in.
>=20
> The driver was tested against Windows Server 2012 R2, Windows Server 2016
> and Windows Server 2016 guests and obeys the guest alignment requirements
> reported to the host via DM_CAPABILITIES_REPORT message.
> Extensive event tracing is available under 'hv_balloon_*' prefix.
>=20
> Example usage:
> * Add "-device vmbus-bridge,id=3Dvmbus-bridge -device hv-balloon,id=3Dhvb=
"
>   to the QEMU command line and set "maxmem" value to something large,
>   like 1T.
>=20
> * Use QEMU monitor commands to add a haprot virtual DIMM stick, together
>   with its memory backend:
>   object_add memory-backend-ram,id=3Dmem1,size=3D200G
>   device_add mem-haprot,id=3Dha1,memdev=3Dmem1
>   The first command is actually the same as for ACPI-based DIMM hotplug.
>=20
> * Use the ballooning interface monitor commands to force the guest to giv=
e
>   out as much memory as possible:
>   balloon 1
>   The ballooning interface monitor commands can also be used to resize
>   the guest up and down appropriately.
>=20
> * One can check the current guest size by issuing a "info balloon" comman=
d.
>   This is useful to know what is happening, since large ballooning or
>   unballooning operations take some time to complete.
>=20
> * Once the guest releases the whole memory backed by a haprot device
>   (or is restarted) a "HV_BALLOON_HAPROT_UNUSED" QMP event will be
>   generated.
>   The haprot device then can be removed, together with its memory backend=
:
>   device_del ha1
>   object_del mem1
>=20
> Future directions:
> * Allow sharing the ballooning QEMU interface between hv-balloon and
>   virtio-balloon drivers.
>   Currently, only one of them can be added to the VM at the same time.
>=20
> * Allow new haport devices to reuse the same address range as the ones
>   that were previously deleted via device_del monitor command without
>   having to restart the VM.
>=20
> * Add vmstate / live migration support to the hv-balloon driver.
>=20
> * Use haprot device to also add memory via virtio interface (this require=
s
>   defining a new operation in virtio-balloon protocol and appropriate
>   support from the client virtio-balloon driver in the Linux kernel).
>=20
>  Kconfig.host                     |    3 +
>  configure                        |   35 +
>  hw/hyperv/Kconfig                |    5 +
>  hw/hyperv/hv-balloon.c           | 2172 ++++++++++++++++++++++++++++++
>  hw/hyperv/meson.build            |    1 +
>  hw/hyperv/trace-events           |   17 +
>  hw/i386/Kconfig                  |    2 +
>  hw/i386/pc.c                     |   18 +-
>  hw/mem/Kconfig                   |    4 +
>  hw/mem/haprot.c                  |  263 ++++
>  hw/mem/meson.build               |    1 +
>  include/hw/hyperv/dynmem-proto.h |  425 ++++++
>  include/hw/mem/haprot.h          |   72 +
>  meson.build                      |    2 +
>  qapi/misc.json                   |   74 +
>  15 files changed, 3093 insertions(+), 1 deletion(-)
>  create mode 100644 hw/hyperv/hv-balloon.c
>  create mode 100644 hw/mem/haprot.c
>  create mode 100644 include/hw/hyperv/dynmem-proto.h
>  create mode 100644 include/hw/mem/haprot.h
>=20
>=20


