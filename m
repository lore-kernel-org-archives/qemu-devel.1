Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34525C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B817B2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2LFNMpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B817B2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7QU-0008As-M9
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo7P5-0006Lq-BU
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:33:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo7P3-00015d-3A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593012812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2IY4kfAazOamsJ2rglgbr9uUCx26PGHw/nCbFA0J9aU=;
 b=Q2LFNMpxgjtQqMT43hgpQsbHEWZ7WiTIvGq1jxdFxbBSYMmVqz2Uncoq/GvKlo+HGOEydK
 GtbCK4ijbsOMJn2tJ5eF9wqeSbcwNUhexQ+qshuY5HCsFf8CpB07pcADalEQipl7FTaGht
 gt6q0CNzOgs08/KgZsrta3MrCLc2tDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-y0A-_DF8O5KqPMXdfTajbQ-1; Wed, 24 Jun 2020 11:33:27 -0400
X-MC-Unique: y0A-_DF8O5KqPMXdfTajbQ-1
Received: by mail-wr1-f72.google.com with SMTP id p9so3133702wrx.10
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2IY4kfAazOamsJ2rglgbr9uUCx26PGHw/nCbFA0J9aU=;
 b=jgpDEEALGvddw3cp3z0Dtex9MZaof+m8v1TcGYJ3Rq2sod5Puk7UpINTfkWMjVusXy
 pN2go0O1fROzOGhF2tvFADZOBWFXJh3PJ9WX5eV4zp3ooXiecOshjbXGq+KxdqFS972G
 cggD389Lzk03s7uxDmP4YE01YAySRUbWz7Oyc9VT43tNlH+kN8+5U7MG9c6jR/2AsfxD
 t1ootTFkkWmcyBwiAyy0TCJAg6Wl/XCQ0BJiB/yi72RGDTKSESJnVWOfeQVLTkAgWoWU
 L4skEnI47+RzfCw0Fhyh0U2pOxPyyBRobMu+6MeQSF8k5lOJz3uGY3t1dTm4aVTi7Ou0
 ldnw==
X-Gm-Message-State: AOAM530BSATNOeMXmCJ8pLEaXhAloYyW8fewRT3MJTQFqPCPLs/SwrF+
 oPBdf1gzAJ1MMhKGzmnMVWd8gg1z8wcq6/7jDLB/yuBchMnrHQxE4Nkn2com+JgeVT8+1EYL8Z4
 5TnNC9QLW/AKCBMc=
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr11687499wrm.169.1593012806272; 
 Wed, 24 Jun 2020 08:33:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySnKVbQKJhBaTK/KwtMP21zCfT+mDQq5XbAceQ8gdEtymFRJRySSqyc91p8UVlZToDj9zmpw==
X-Received: by 2002:adf:dd4a:: with SMTP id u10mr11687457wrm.169.1593012806015; 
 Wed, 24 Jun 2020 08:33:26 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id c70sm8302514wme.32.2020.06.24.08.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:33:25 -0700 (PDT)
Date: Wed, 24 Jun 2020 11:33:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 00/21] virtio-mem: Paravirtualized memory hot(un)plug
Message-ID: <20200624113157-mutt-send-email-mst@kernel.org>
References: <20200610115419.51688-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610115419.51688-1-david@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, teawater <teawaterz@linux.alibaba.com>,
 Alex Shi <alex.shi@linux.alibaba.com>, Janosch Frank <frankja@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <ehabkost@redhat.com>,
 Sergio Lopez <slp@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 10, 2020 at 01:53:58PM +0200, David Hildenbrand wrote:
> This is the very basic, initial version of virtio-mem. More info on
> virtio-mem in general can be found in the Linux kernel driver v2 posting
> [1] and in patch #10. The Linux driver is currently on its way upstream.
> 
> This series is based on [3]:
>     "[PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices on all
>      buses"
> And [4]:
>     "[PATCH v2] hmp: Make json format optional for qom-set"
> 
> The patches can be found at:
>     https://github.com/davidhildenbrand/qemu.git virtio-mem-v4


OK so looks sane to me.
IIUC there are a couple of minor tweaks still so I'm expecting v5
of this.
You want me to merge this, right?


> "The basic idea of virtio-mem is to provide a flexible,
> cross-architecture memory hot(un)plug solution that avoids many limitations
> imposed by existing technologies, architectures, and interfaces."
> 
> There are a lot of addons in the works (esp. protection of unplugged
> memory, better hugepage support (esp. when reading unplugged memory),
> resizeable memory backends, support for more architectures, ...), this is
> the very basic version to get the ball rolling.
> 
> The first 8 patches make sure we don't have any sudden surprises e.g., if
> somebody tries to pin all memory in RAM blocks, resulting in a higher
> memory consumption than desired. The remaining patches add basic virtio-mem
> along with support for x86-64. The last patch indicates to the guest OS
> the maximum possible PFN using ACPI SRAT, such that Linux can properly
> enable the swiotlb when booting only with DMA memory.
> 
> [1] https://lkml.kernel.org/r/20200311171422.10484-1-david@redhat.com
> [2] https://lkml.kernel.org/r/20200507140139.17083-1-david@redhat.com
> [3] https://lkml.kernel.org/r/20200525084511.51379-1-david@redhat.com
> [3] https://lkml.kernel.org/r/20200610075153.33892-1-david@redhat.com
> 
> Based-on: <20200525084511.51379-1-david@redhat.com>
> Based-on: <20200610075153.33892-1-david@redhat.com>
> Cc: teawater <teawaterz@linux.alibaba.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> 
> v3 -> v4
> - Adapt to virtio-mem config layout change (block size now is 64bit)
> - Added "numa: Auto-enable NUMA when any memory devices are possible"
> 
> v2 -> v3:
> - Rebased on upstream/[3]
> - "virtio-mem: Exclude unplugged memory during migration"
> -- Added
> - "virtio-mem: Paravirtualized memory hot(un)plug"
> -- Simplify bitmap operations, find consecutive areas
> -- Tweak error messages
> -- Reshuffle some checks
> -- Minor cleanups
> - "accel/kvm: Convert to ram_block_discard_disable()"
> - "target/i386: sev: Use ram_block_discard_disable()"
> -- Keep asserts clean of functional things
> 
> v1 -> v2:
> - Rebased to object_property_*() changes
> - "exec: Introduce ram_block_discard_(disable|require)()"
> -- Change the function names and rephrase/add comments
> - "virtio-balloon: Rip out qemu_balloon_inhibit()"
> -- Add and use "migration_in_incoming_postcopy()"
> - "migration/rdma: Use ram_block_discard_disable()"
> -- Add a comment regarding pin_all vs. !pin_all
> - "virtio-mem: Paravirtualized memory hot(un)plug"
> -- Replace virtio_mem_discard_inhibited() by
>    migration_in_incoming_postcopy()
> -- Drop some asserts
> -- Drop virtio_mem_bad_request(), use virtio_error() directly, printing
>    more information
> -- Replace "Note: Discarding should never fail ..." comments by
>    error_report()
> -- Replace virtio_stw_p() by cpu_to_le16()
> -- Drop migration_addr and migration_block_size
> -- Minor cleanups
> - "linux-headers: update to contain virtio-mem"
> -- Updated to latest v4 in Linux
> - General changes
> -- Fixup the users of the renamed ram_block_discard_(disable|require)
> -- Use "X: cannot disable RAM discard"-styled error messages
> - Added
> -- "virtio-mem: Migration sanity checks"
> -- "virtio-mem: Add trace events"
> 
> David Hildenbrand (21):
>   exec: Introduce ram_block_discard_(disable|require)()
>   vfio: Convert to ram_block_discard_disable()
>   accel/kvm: Convert to ram_block_discard_disable()
>   s390x/pv: Convert to ram_block_discard_disable()
>   virtio-balloon: Rip out qemu_balloon_inhibit()
>   target/i386: sev: Use ram_block_discard_disable()
>   migration/rdma: Use ram_block_discard_disable()
>   migration/colo: Use ram_block_discard_disable()
>   linux-headers: update to contain virtio-mem
>   virtio-mem: Paravirtualized memory hot(un)plug
>   virtio-pci: Proxy for virtio-mem
>   MAINTAINERS: Add myself as virtio-mem maintainer
>   hmp: Handle virtio-mem when printing memory device info
>   numa: Handle virtio-mem in NUMA stats
>   pc: Support for virtio-mem-pci
>   virtio-mem: Allow notifiers for size changes
>   virtio-pci: Send qapi events when the virtio-mem size changes
>   virtio-mem: Migration sanity checks
>   virtio-mem: Add trace events
>   virtio-mem: Exclude unplugged memory during migration
>   numa: Auto-enable NUMA when any memory devices are possible
> 
>  MAINTAINERS                                 |   8 +
>  accel/kvm/kvm-all.c                         |   4 +-
>  balloon.c                                   |  17 -
>  exec.c                                      |  52 ++
>  hw/arm/virt.c                               |   2 +
>  hw/core/numa.c                              |  17 +-
>  hw/i386/Kconfig                             |   1 +
>  hw/i386/microvm.c                           |   1 +
>  hw/i386/pc.c                                |  50 +-
>  hw/i386/pc_piix.c                           |   1 +
>  hw/i386/pc_q35.c                            |   1 +
>  hw/s390x/s390-virtio-ccw.c                  |  22 +-
>  hw/vfio/ap.c                                |  10 +-
>  hw/vfio/ccw.c                               |  11 +-
>  hw/vfio/common.c                            |  53 +-
>  hw/vfio/pci.c                               |   6 +-
>  hw/virtio/Kconfig                           |  11 +
>  hw/virtio/Makefile.objs                     |   2 +
>  hw/virtio/trace-events                      |  10 +
>  hw/virtio/virtio-balloon.c                  |   8 +-
>  hw/virtio/virtio-mem-pci.c                  | 157 ++++
>  hw/virtio/virtio-mem-pci.h                  |  34 +
>  hw/virtio/virtio-mem.c                      | 872 ++++++++++++++++++++
>  include/exec/memory.h                       |  41 +
>  include/hw/boards.h                         |   1 +
>  include/hw/pci/pci.h                        |   1 +
>  include/hw/vfio/vfio-common.h               |   4 +-
>  include/hw/virtio/virtio-mem.h              |  86 ++
>  include/migration/colo.h                    |   2 +-
>  include/migration/misc.h                    |   2 +
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  include/standard-headers/linux/virtio_mem.h | 211 +++++
>  include/sysemu/balloon.h                    |   2 -
>  migration/migration.c                       |  15 +-
>  migration/postcopy-ram.c                    |  23 -
>  migration/rdma.c                            |  18 +-
>  migration/savevm.c                          |  11 +-
>  monitor/hmp-cmds.c                          |  16 +
>  monitor/monitor.c                           |   1 +
>  qapi/misc.json                              |  64 +-
>  target/i386/sev.c                           |   7 +
>  41 files changed, 1730 insertions(+), 126 deletions(-)
>  create mode 100644 hw/virtio/virtio-mem-pci.c
>  create mode 100644 hw/virtio/virtio-mem-pci.h
>  create mode 100644 hw/virtio/virtio-mem.c
>  create mode 100644 include/hw/virtio/virtio-mem.h
>  create mode 100644 include/standard-headers/linux/virtio_mem.h
> 
> -- 
> 2.26.2


