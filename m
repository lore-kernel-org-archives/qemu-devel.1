Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF38C433EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A37F208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKicx5Oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A37F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04Bu-0004RW-Nm
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Ah-00030P-3b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k04Af-0001Dj-9Z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zqZu/dVpjpDVfSU+yU9e3tfmVk/LDwiD0RK5VWAec2c=;
 b=XKicx5OcfC3639zkvHfF1QGO/h0IWR4ykG+hYVt6C5pfmD/3ZtNI8pSq88OR8ASJlObbub
 PL71FtJigaCPDaCi38jgJpy8nyuYqvh2aOKxaCqmXQ1uhoatIwllCB4aB0pZ67+ktncCN+
 Lb1XEUcewCSDvsfYNgYanVDqyYXyAZk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-43XusiwoN-ihUk7HU7VATQ-1; Mon, 27 Jul 2020 10:32:03 -0400
X-MC-Unique: 43XusiwoN-ihUk7HU7VATQ-1
Received: by mail-wr1-f69.google.com with SMTP id e14so571293wrr.7
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=zqZu/dVpjpDVfSU+yU9e3tfmVk/LDwiD0RK5VWAec2c=;
 b=K5SEocgsEoyu4QrnAm34CKAPsiK6pJAdwUw2gwzt6eF2a/YxbWjIQkBm1YvCelqapJ
 g6rdVFeCqsDxpDCQ56jkvcNr6v61cpoatU53LLR30ecO02+iuwFcswB08A5E2GoBdMWn
 BkeMp2AiHrvs0kHdU+I9QdGGLDZvng7NBq99hda7CiNdsd5erD9RlIpMIacljPvi8OMK
 kFtbdzzTNjk8lTxJkwd9vj2W1jckW+50UkT9NwOtaTa+eED0EZX0hxSKDFZ4kHVQX9le
 U69P9TLY7q3VTYMt6yuMmORwJdGjLUktG9JwopUt+bUtM3e3JaNwh9VSTSYKTB1rHQkX
 wo+w==
X-Gm-Message-State: AOAM532t/revurfeUvHDe7MU7Mj7lCXbOQ5V9GUMe5uyDRHz9TQqPuIH
 W5HwkxkiMQyNdIUsFxK1hsg/Qpzmv55Asj/DS6Oa3zH4lWEpbd3RUJRlbwiRoakGH7Z6yFvQF7T
 GGeM2V0Ys39C1kVQ=
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr15566207wmf.92.1595860321263; 
 Mon, 27 Jul 2020 07:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVFifHV+bwjIGdj2ekWrWgOmvZfc//ztoETrz8lkLOokaFa+i3+p2h8zZnqGPYefm+bQMiyQ==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr15566183wmf.92.1595860320953; 
 Mon, 27 Jul 2020 07:32:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id r11sm17525408wmh.1.2020.07.27.07.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 07:32:00 -0700 (PDT)
Date: Mon, 27 Jul 2020 10:31:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/6] virtio,pci: bugfixes
Message-ID: <20200727143104.97776-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2 due to issues noticed by dgilbert in v1.
Changes from v1:
    dropped a work around for pci migration for old machine types.


The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to d0d89526f70ded5ac41a4c6bb071c0d919b772db:

  MAINTAINERS: Cover the firmware JSON schema (2020-07-27 10:28:28 -0400)

----------------------------------------------------------------
virtio,pci: bugfixes

Minor bugfixes all over the places, including one CVE.

Additionally, a fix for an ancient bug in migration -
one has to wonder how come no one noticed.

The fix is also non-trivial since we dare not break all
existing machine types with pci - we have a work around
in the works, for now we just skip the work-around for
old machine types.

Great job by Hogan Wang noticing, debugging and fixing it,
and thanks to Dr. David Alan Gilbert for reviewing the patches.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267

David Hildenbrand (1):
      virtio-mem-pci: force virtio version 1

Hogan Wang (1):
      hw/pci-host: save/restore pci host config register

Philippe Mathieu-Daudé (2):
      libvhost-user: Report descriptor index on panic
      MAINTAINERS: Cover the firmware JSON schema

Raphael Norwitz (1):
      Fix vhost-user buffer over-read on ram hot-unplug

 include/hw/pci/pci_host.h             |  1 +
 contrib/libvhost-user/libvhost-user.c |  4 ++--
 hw/core/machine.c                     |  1 +
 hw/i386/pc.c                          |  3 ++-
 hw/pci/pci_host.c                     | 33 +++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c                |  2 +-
 hw/virtio/vhost-vdpa.c                |  4 ++--
 hw/virtio/virtio-mem-pci.c            |  4 ++--
 MAINTAINERS                           |  8 ++++++++
 9 files changed, 52 insertions(+), 8 deletions(-)


