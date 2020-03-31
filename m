Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1F1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7304620675
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCUl0cja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7304620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJILF-0001bO-Iu
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jJIK9-0007tT-MB
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jJIK8-0004yr-Jh
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45934
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jJIK8-0004xW-FR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eI7h3HrqQofMJ3tqdEd4AybxOVit8Q3Jo4m5bdyl3uA=;
 b=iCUl0cjad+bgPbKsCcAHmiy9ri+kKJv7mxgHiphia89+vzyAfTjZsEc2N+rocNWF/2o+nB
 4prtXgZxOqwhjxgxDQpeXwDzUz8rvP4vCGBydkDpIxMj5mt6bNz6ABVJGJRxLtSPCT/UsB
 yu1NQPR6pq6oOVquKtJPCp/kcnhBrWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-LnMkYaxVMJ2DVWRIuoqufg-1; Tue, 31 Mar 2020 10:57:02 -0400
X-MC-Unique: LnMkYaxVMJ2DVWRIuoqufg-1
Received: by mail-wm1-f71.google.com with SMTP id s15so802296wmc.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=MTHke4CHukD3SSbL6gWMTXramsTo39KLg0o5XWSaYns=;
 b=HWYOl9BTKlCPwyZJPXozH7sf6tkjj3YI7RGl8yy5okLU9D9rIlT+hlWzgf2pFg8ZOb
 3B8ImGw5bxTVIKVKfLkE1i6nYl/abY56WbjqFJG32qcHqNejIeHX7vHyAMZZLp+iYX8c
 1kQgezDKLddMvQowrK5IcmtUBv6naJ24ZqsexYE7Q7iJBbxhxKMohR9KDZUmcdv1hJA0
 176i3qThzHv7SkzFpJAXcFJ1z5sG1OFZjFen67XW7N7g6ch7Zz1oU1Ny8SRYbSZTWKBg
 8q4F7bRRJ8KfKP+78gWI40pNCDFX5FIu7cFZlC8Sx1eEOBIg42nVeV3iqexUGjy31wKB
 zdMA==
X-Gm-Message-State: ANhLgQ1DA5TNfmCL6xPagy86zhkuW9hfa8RMLgfli8B8C1FlO3FFQxdB
 lLJTdwusXXMQ9oJ6umVSw83U5RoW4oYC5bYD3G+IiCf/ZMw4Rx+CiNMERmmPKdkpmSXqKiWxbQF
 sUPz1KvvnHjhomOg=
X-Received: by 2002:a1c:418b:: with SMTP id o133mr3975038wma.165.1585666620579; 
 Tue, 31 Mar 2020 07:57:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuGjT7lh6JE6GdxB1pwDo0nWwFSXdJ7cQtxoB8zB/+Hb1ge/9jLVXoac0PC9LxawMRb/2zbkA==
X-Received: by 2002:a1c:418b:: with SMTP id o133mr3975023wma.165.1585666620317; 
 Tue, 31 Mar 2020 07:57:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
 by smtp.gmail.com with ESMTPSA id x206sm4260701wmg.17.2020.03.31.07.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:56:59 -0700 (PDT)
Date: Tue, 31 Mar 2020 10:56:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] virtio, pci, pc: bugfixes, checkpatch, maintainers
Message-ID: <20200331145631.135630-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

The following changes since commit 5acad5bf480321f178866dc28e38eeda5a3f19bb=
:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into =
staging (2020-03-28 00:27:04 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e82cdba3945340f524ba153170d52800dbd55ca4:

  vhost-vsock: fix double close() in the realize() error path (2020-03-31 1=
0:54:28 -0400)

----------------------------------------------------------------
virtio, pci, pc: bugfixes, checkpatch, maintainers

Bugfixes all over the place.
Add a new balloon maintainer.
A checkpatch enhancement to enforce ACPI change rules.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
David Hildenbrand (1):
      MAINTAINERS: Add myself as virtio-balloon co-maintainer

Gerd Hoffmann (1):
      acpi: add acpi=3DOnOffAuto machine property to x86 and arm virt

Igor Mammedov (1):
      acpi: pcihp: fix left shift undefined behavior in acpi_pcihp_eject_sl=
ot()

Li Feng (1):
      fix vhost_user_blk_watch crash

Michael S. Tsirkin (1):
      checkpatch: enforce process for expected files

Pan Nengyuan (3):
      virtio-serial-bus: Plug memory leak on realize() error paths
      virtio-blk: delete vqs on the error path in realize()
      virtio-iommu: avoid memleak in the unrealize

Peter Maydell (1):
      hw/i386/amd_iommu.c: Fix corruption of log events passed to guest

Stefano Garzarella (1):
      vhost-vsock: fix double close() in the realize() error path

 include/hw/acpi/acpi.h             |  1 -
 include/hw/arm/virt.h              |  2 ++
 include/hw/i386/x86.h              |  3 +++
 include/hw/virtio/vhost-user-blk.h |  1 -
 hw/acpi/pcihp.c                    |  2 +-
 hw/arm/virt-acpi-build.c           |  2 +-
 hw/arm/virt.c                      | 36 ++++++++++++++++++++++++++++++++++=
--
 hw/block/vhost-user-blk.c          | 19 -------------------
 hw/block/virtio-blk.c              |  3 +++
 hw/char/virtio-serial-bus.c        |  2 +-
 hw/i386/acpi-build.c               |  2 +-
 hw/i386/amd_iommu.c                |  2 +-
 hw/i386/pc.c                       |  4 ++--
 hw/i386/pc_piix.c                  |  2 +-
 hw/i386/x86.c                      | 32 ++++++++++++++++++++++++++++++++
 hw/virtio/vhost-vsock.c            |  6 +++++-
 hw/virtio/virtio-iommu.c           |  3 +++
 softmmu/vl.c                       |  4 ++--
 MAINTAINERS                        |  9 +++++++++
 scripts/checkpatch.pl              | 25 +++++++++++++++++++++++++
 20 files changed, 126 insertions(+), 34 deletions(-)


