Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4EFC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B60FC2467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WtGwCNRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60FC2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7EyT-0002XF-UG
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j7Ewq-0000gF-QH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j7Ewp-0005ia-9D
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j7Ewp-0005hZ-47
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582793710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jEZK8yNXE+wTsqCbhXeyQ8VOR2n8Z7HF0gh+Ky3xHo0=;
 b=WtGwCNREpYiI5avvc9KAkkMNRYoQkccYFSTVtydWrnFwAKpP1avjvIEREeKcjTAy5uQaWY
 IPvJWIRpN89szI1EM3s1Cbreb+1/pA7JNPlYe2uAuNlXGKVYHHGM3mLM+7+US8xdJFkcOh
 WTF6X3dBDnf5QL+/eq44PVFzudN8jII=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-YbGUe6oXMF2WSiPNRbGM7g-1; Thu, 27 Feb 2020 03:55:05 -0500
X-MC-Unique: YbGUe6oXMF2WSiPNRbGM7g-1
Received: by mail-qt1-f197.google.com with SMTP id f25so2658141qtp.12
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 00:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lguPzS+Ymx9VaZQ4TQOOrzS0xNq8Vcz+XX/8B96kn7w=;
 b=Rn9UEjBkUEYyahNxRaqEBIZc6O7H+nlQHETAYY5CwnvPcKuzH73ZUewjferKiDN9tr
 aozk+CAbdrIDj4rPKQX6hYeW+gI35lGExptaCE8gFd4RMq+K3cPr5JcfH7guZwjjBzTF
 d7rLwldRmvfFE5O6U8J19upcVSeBXd9CgqKqfcXYjLOZxLrkRNnVz6NZ+QXCrumxxoDA
 0Yo1AVvFYeQ6OhaDuJXoj8BlZ9rdJ0O3GyWogGZAdlcmwmUQb74JV69TE7llLmZ1kK6n
 0eHe42wz6SFY9yGcYw8HRAuIbVw5ggei9RSQ7zIuaxLj4LI9JLvuB/fV3kDLCyi4fglh
 0fSg==
X-Gm-Message-State: APjAAAVQucPOxNXYrHDkLN1grNzISit+Kd8JO6qHzMCGN4tcU/n0Dt2V
 VJPFkRfd/f4kbuCU18cz9dS3tv9D7jLEbBH+XYVU287rv/XejCLQt7oHgTZaW7HEwi1hXUFOYmx
 jS6P6UrwVsSlU5ik=
X-Received: by 2002:a05:620a:2114:: with SMTP id
 l20mr4167660qkl.214.1582793704297; 
 Thu, 27 Feb 2020 00:55:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlh4spGJnzMsbIb5pZHoUAsJlXgtJJLp2DpL1zE0p0oergLPL2jTCXcuhe8vYjRPCeLqv5yA==
X-Received: by 2002:a05:620a:2114:: with SMTP id
 l20mr4167634qkl.214.1582793703970; 
 Thu, 27 Feb 2020 00:55:03 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 n8sm2721518qke.37.2020.02.27.00.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2020 00:55:03 -0800 (PST)
Date: Thu, 27 Feb 2020 03:54:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL v2 00/30] virtio, pc: fixes, features
Message-ID: <20200227035423-mutt-send-email-mst@kernel.org>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 04:01:02AM -0500, Michael S. Tsirkin wrote:
> changes from v1:
>     dropped vhost changes, hope this fixes build on Mac OS.
>=20
> The following changes since commit 9a8abceb5f01d1066d3a1ac5a33aabcbaeec18=
60:
>=20
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-docs-20200225'=
 into staging (2020-02-25 11:03:47 +0000)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>=20
> for you to fetch changes up to deec824070e408b936e02883a1e2cb5af92448d0:

I updated one of the commit logs to include CC stable, so the new
hash is: b844a4c77b618acfba6b3f4ce12d2ad709f99279

>   Fixed assert in vhost_user_set_mem_table_postcopy (2020-02-25 16:55:32 =
-0500)
>=20
> ----------------------------------------------------------------
> virtio, pc: fixes, features
>=20
> New virtio iommu.
> Unrealize memory leaks.
> In-band kick/call support.
> Bugfixes, documentation all over the place.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> ----------------------------------------------------------------
> Adrian Moreno (1):
>       vhost-user: only set slave channel for first vq
>=20
> Eric Auger (10):
>       virtio-iommu: Add skeleton
>       virtio-iommu: Decode the command payload
>       virtio-iommu: Implement attach/detach command
>       virtio-iommu: Implement map/unmap
>       virtio-iommu: Implement translate
>       virtio-iommu: Implement fault reporting
>       virtio-iommu: Support migration
>       virtio-iommu-pci: Add virtio iommu pci support
>       hw/arm/virt: Add the virtio-iommu device tree mappings
>       MAINTAINERS: add virtio-iommu related files
>=20
> Igor Mammedov (1):
>       acpi: cpuhp: document CPHP_GET_CPU_ID_CMD command
>=20
> Johannes Berg (6):
>       libvhost-user: implement VHOST_USER_PROTOCOL_F_REPLY_ACK
>       libvhost-user-glib: fix VugDev main fd cleanup
>       libvhost-user-glib: use g_main_context_get_thread_default()
>       libvhost-user: handle NOFD flag in call/kick/err better
>       docs: vhost-user: add in-band kick/call messages
>       libvhost-user: implement in-band notifications
>=20
> Michael S. Tsirkin (4):
>       bios-tables-test: tell people how to update
>       bios-tables-test: fix up DIFF generation
>       bios-tables-test: default diff command
>       rebuild-expected-aml.sh: remind about the process
>=20
> Pan Nengyuan (6):
>       vhost-user-fs: do delete virtio_queues in unrealize
>       vhost-user-fs: convert to the new virtio_delete_queue function
>       virtio-pmem: do delete rq_vq in virtio_pmem_unrealize
>       virtio-crypto: do delete ctrl_vq in virtio_crypto_device_unrealize
>       vhost-user-blk: delete virtioqueues in unrealize to fix memleaks
>       vhost-user-blk: convert to new virtio_delete_queue
>=20
> Raphael Norwitz (1):
>       Fixed assert in vhost_user_set_mem_table_postcopy
>=20
> Stefan Hajnoczi (1):
>       virtio: gracefully handle invalid region caches
>=20
>  docs/specs/acpi_cpu_hotplug.txt            |   2 +
>  contrib/libvhost-user/libvhost-user-glib.h |   1 +
>  contrib/libvhost-user/libvhost-user.h      |  14 +
>  include/hw/arm/virt.h                      |   2 +
>  include/hw/pci/pci.h                       |   1 +
>  include/hw/virtio/vhost-user-blk.h         |   3 +-
>  include/hw/virtio/vhost-user-fs.h          |   2 +
>  include/hw/virtio/virtio-iommu.h           |  61 ++
>  contrib/libvhost-user/libvhost-user-glib.c |  17 +-
>  contrib/libvhost-user/libvhost-user.c      | 139 ++++-
>  contrib/vhost-user-input/main.c            |   6 +-
>  hw/arm/virt.c                              |  57 +-
>  hw/block/vhost-user-blk.c                  |  23 +-
>  hw/virtio/vhost-user-fs.c                  |  16 +-
>  hw/virtio/vhost-user.c                     |  10 +-
>  hw/virtio/virtio-crypto.c                  |   3 +-
>  hw/virtio/virtio-iommu-pci.c               | 104 ++++
>  hw/virtio/virtio-iommu.c                   | 890 +++++++++++++++++++++++=
++++++
>  hw/virtio/virtio-pmem.c                    |   1 +
>  hw/virtio/virtio.c                         |  99 +++-
>  qdev-monitor.c                             |   1 +
>  tests/qtest/bios-tables-test.c             |  31 +-
>  MAINTAINERS                                |   6 +
>  docs/interop/vhost-user.rst                | 122 +++-
>  hw/virtio/Kconfig                          |   5 +
>  hw/virtio/Makefile.objs                    |   2 +
>  hw/virtio/trace-events                     |  20 +
>  tests/data/acpi/rebuild-expected-aml.sh    |   7 +
>  28 files changed, 1562 insertions(+), 83 deletions(-)
>  create mode 100644 include/hw/virtio/virtio-iommu.h
>  create mode 100644 hw/virtio/virtio-iommu-pci.c
>  create mode 100644 hw/virtio/virtio-iommu.c
>=20


