Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3FDC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ED4206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULO6/kmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ED4206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8eS-0007oK-2A
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI8cM-0005Q1-UI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI8cI-0005Yy-Vz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Nky6iiKiOmHmLCeC01KJ5tFZvJ9TZwL4JrQgzmKbUCc=;
 b=ULO6/kmzAR4Xr7IdoaagNQ9xSv/YgCQ/rN7ZvZsCgj1i8nHBEAi1UCZg10dk2r6/bL3h2b
 VCltRrDqfcgBnN2g6CESzEw6zaSR9NIt/6ME22aYRGiAzR9aeINSyPPDxQUJUVn69awOhU
 CCpOsBy68L9u8miTQcqGFKLw+p1ABec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-SRuRonewOWWcmydq1Y3_sw-1; Tue, 15 Sep 2020 06:55:12 -0400
X-MC-Unique: SRuRonewOWWcmydq1Y3_sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99DE9AD682
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:55:11 +0000 (UTC)
Received: from redhat.com (ovpn-113-234.ams2.redhat.com [10.36.113.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E72EE1002393;
 Tue, 15 Sep 2020 10:55:03 +0000 (UTC)
Date: Tue, 15 Sep 2020 11:55:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [qemu-web PATCH] Add virtio-blk and virtio-scsi configuration post
Message-ID: <20200915105501.GE1502912@redhat.com>
References: <20200915103406.684817-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915103406.684817-1-stefanha@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 11:34:06AM +0100, Stefan Hajnoczi wrote:
> The second post in the storage series covers virtio-blk and virtio-scsi.
> It compares the two and offers recommendations that users and tools
> using QEMU can use as a starting point. Graphs are included comparing
> the performance of various options.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  ...020-09-15-virtio-blk-scsi-configuration.md | 112 ++++++++++++++++++
>  screenshots/2020-09-15-scsi-devices.svg       |   1 +
>  screenshots/2020-09-15-virtio-blk-vs-scsi.svg |   1 +
>  3 files changed, 114 insertions(+)
>  create mode 100644 _posts/2020-09-15-virtio-blk-scsi-configuration.md
>  create mode 100644 screenshots/2020-09-15-scsi-devices.svg
>  create mode 100644 screenshots/2020-09-15-virtio-blk-vs-scsi.svg
> 
> diff --git a/_posts/2020-09-15-virtio-blk-scsi-configuration.md b/_posts/2020-09-15-virtio-blk-scsi-configuration.md
> new file mode 100644
> index 0000000..0ba9c87
> --- /dev/null
> +++ b/_posts/2020-09-15-virtio-blk-scsi-configuration.md
> @@ -0,0 +1,112 @@
> +---
> +layout: post
> +title:  "Configuring virtio-blk and virtio-scsi Devices"
> +date:   2020-09-15 07:00:00 +0000
> +author: Stefan Hajnoczi and Sergio Lopez
> +categories: [storage]
> +---
> +The [previous article](https://www.qemu.org/2020/09/14/qemu-storage-overview/)
> +in this series introduced QEMU storage concepts. Now we move on to look at the
> +two most popular emulated storage controllers for virtualization: virtio-blk
> +and virtio-scsi.
> +
> +This post provides recommendations for configuring virtio-blk and virtio-scsi
> +and how to choose between the two devices. The recommendations provide good
> +performance in a wide range of use cases and are suitable as default settings
> +in tools that use QEMU.
> +
> +## Virtio storage devices
> +### Key points
> +* Prefer virtio storage devices over other emulated storage controllers.
> +* Use the latest virtio drivers.
> +
> +Virtio devices are recommended over other emulated storage controllers as they
> +are generally the most performant and fully-featured storage controllers in
> +QEMU.
> +
> +Unlike emulations of hardware storage controllers, virtio-blk and virtio-scsi
> +are specifically designed and optimized for virtualization. The details of how
> +they work are published for driver and device implementors in the [VIRTIO
> +specification](https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.html).
> +
> +Virtio drivers are available for both Linux and Windows virtual machines.
> +Installing the latest version is recommended for the latest bug fixes and
> +performance enhancements.
> +
> +If virtio drivers are not available, the AHCI (SATA) device is widely supported
> +by modern operating systems and can be used as a fallback.

AHCI is only available on q35, so this talk about fallback probably needs
to be worded in a more generic fashion refering to the integrated storage
controller of the machine type.

> +
> +## Comparing virtio-blk and virtio-scsi
> +### Key points
> +* Prefer virtio-scsi for attaching more than 28 disks or for full SCSI support.
> +* Prefer virtio-blk in performance-critical use cases.
> +* With virtio-scsi, use scsi-block for SCSI passthrough and otherwise use scsi-hd.

> +Two virtio storage controllers are available: virtio-blk and virtio-scsi.
> +
> +### virtio-blk
> +The virtio-blk device presents a block device to the virtual machine. Each
> +virtio-blk device appears as a disk inside the guest. virtio-blk was available
> +before virtio-scsi and is the most widely deployed virtio storage controller.
> +
> +The virtio-blk device offers high performance thanks to a thin software stack
> +and is therefore a good choice when performance is a priority.
> +
> +Disks exposed by virtio-blk are typically read-write but can also be read-only.
> +They can be used to present read-only ISO images to the guest.

This comment about iSO images feels potentially misleading. You can expose
a volume with any filesystem type to a guest using virtio-blk, but merely
exposing an ISO image is not going to reliably make guest software do the
right thing. Something expecting a CDROM will usaully want a device that
actually looks like a CDROM (ie removable media at very least), not merely
a HDD with ISO formatted content.

I think cloud-init is probably only software example I know where exposing
ISO as HDD is ok-ish.

If anyone wants to expose CDROM to guest, AFAIK, the recommendation has
always been to either use virtio-scsi, or a machine type's built-in
storage controller (IDE, AHCI, or SCSI), never virtio-blk.

> +Applications that send SCSI commands are better served by the virtio-scsi
> +device, which has full SCSI support. SCSI passthrough was removed from the
> +Linux virtio-blk driver in v5.6 in favor of using virtio-scsi.
> +
> +Virtual machines that require access to more than 28 disks can run out of PCI
> +bus slots on i440fx-based machine types since each disk requires its own
> +virtio-blk PCI adapter slot. It is possible to add more virtio-blk devices by
> +extending the virtual machine's PCI busses, but it is simpler to use a single
> +virtio-scsi PCI adapter instead.

You can use mutli-function for virtio-bk, at cost of loosing hotplug, so
saying virtio-blk requires a slot is a little too strict.

The 28 disk image can only be reached if not using other devices, so if
many NICs are present it'll be hit before 28.  Maybe talk in slightly
more general terms, such as

 "Virtual machines that require access to many disks can hit limits
  based on availability of PCI slots, which are under contention 
  with other devices exposed to the guest such as NICs. For example
  a typical i440fx machine type default config allows for about 28
  disks. It is possible to use multi-function devices to pack multiple
  virtio-blk devies into a single PCI slot at the cost of loosing 
  hotplug, or add additional PCI busses. Generally though it is 
  simpler to use a  single virtio-scsi PCI adapter instead.

> +
> +### virtio-scsi
> +The virtio-scsi device presents a SCSI Host Bus Adapter to the virtual machine.
> +SCSI offers a richer command set than virtio-blk and supports more use cases.
> +
> +Each device supports up to 16,383 LUNs (disks) per target and up to 255
> +targets. This allows a single virtio-scsi device to handle all disks in a
> +virtual machine.

Perhaps add

  "Emulated LUNs can be exposed as HDDs or CD-ROMs".

Also while a single virtio-scsi device is sufficient if just considering
max disks, I would think can be desirable to have multiple virtio-scsi 
devices if you want to tune placement of iothreads. For example, if guest 
has multiple NUMA nodes and you want to expose disks as having affinity to
nodes.

> +
> +SCSI allows access to CD-ROM drives, tapes, and other devices besides disk
> +drives. Physical SCSI devices can be passed through into the virtual machine.


> +
> +Clustering software that uses SCSI Persistent Reservations is supported by virtio-scsi, but not by virtio-blk.
> +
> +Performance of virtio-scsi may be lower than virtio-blk due to a thicker software stack, but in many use cases, this is not a significant factor. The following graph compares 4KB random read performance at various queue depths:
> +
> +![Comparing virtio-blk and virtio-scsi performance](/screenshots/2020-09-15-virtio-blk-vs-scsi.svg)
> +
> +### virtio-scsi configuration
> +The following SCSI devices are available with virtio-scsi:
> +
> +|Device|SCSI Passthrough|Performance|
> +|------|----------------|-----------|
> +|scsi-hd|No|Highest|
> +|scsi-block|Yes|Lower|
> +|scsi-generic|Yes|Lowest|
> +
> +The scsi-hd device is suitable for disk image files and host block devices
> +when SCSI passthrough is not required.
> +
> +The scsi-block device offers SCSI passthrough and is preferred over
> +scsi-generic due to higher performance.
> +
> +The following graph compares the sequential I/O performance of these devices
> +using virtio-scsi with an iothread:
> +
> +![Comparing scsi-hd, scsi-block, and scsi-generic performance](/screenshots/2020-09-15-scsi-devices.svg)
> +
> +## Conclusion
> +The virtio-blk and virtio-scsi offer a choice between a single block device and
> +a full-fledged SCSI Host Bus Adapter. Virtualized guests typically use one or
> +both of them depending on functional and performance requirements. This post
> +compared the two and offered recommendations on how to choose between them.
> +
> +The next post in this series will discuss the iothreads feature that both
> +virtio-blk and virtio-scsi support for increased performance.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


