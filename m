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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F32C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F85206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BlL1wmIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F85206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03Wn-0006ow-Nm
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03VZ-00051d-TS
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23828
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03VX-0001qY-3a
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595857773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=m2PsRC//5vgJjyVPB3KiOOROlaZO3891ckHlDm7bJRc=;
 b=BlL1wmIb35FmFkPwrRZzizUqnIfprjfyh7/GovWD+nIgBf2mInFTmkUpYEbABqXOCKssyt
 Ogh599GaOMP91HKaRPCBTW/0c9xbGq7WmwU8oAeF6C4fUVu0eLm6/oxnFDPZSVHQ68uHpE
 4o/fjyz9nYlfduilzEl8741orgtZvro=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-vsN3PBx5PxOA_jbo97yIfA-1; Mon, 27 Jul 2020 09:49:31 -0400
X-MC-Unique: vsN3PBx5PxOA_jbo97yIfA-1
Received: by mail-wm1-f69.google.com with SMTP id s12so6537185wmc.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:content-transfer-encoding;
 bh=m2PsRC//5vgJjyVPB3KiOOROlaZO3891ckHlDm7bJRc=;
 b=jaXMGw2WjZgzQJaIsobG3dD01F9BGvsTSqZf6/tJ9q8f6WRb5/89QU+uQX5Jerl6SP
 8C0QgoKJUo8yUx95vPwTu1WUj8PAGDheObTlhNtrwfyjtGS89fRqwixlbbvY+SJfOAmL
 Cd1lbo/Wt5v1zKoxJJH4aq6byGJL37eQntoiIunmvQlmapstG4wksgWgfnVGXvV2VM8G
 nJ6HT+WdXrIJhGtTu2DIbu3heBFcfSCIbS6gNJ+9hyLJsSGcSY36nJ0ltFg6vzKR95NN
 A9RQwe2fvKvy/XlQTlRsxkY1io3YGlmJJPXqOmk6gR4N8UXUdR4uNGrEtKECPjBYXHc6
 zECw==
X-Gm-Message-State: AOAM531yEKKpEHUU5aw/+WhfaWeDpoFBUrjdnsTyXi2LT3liuvXqBgiS
 +nDDqIuKInyerQdg/YLJxyAyJIsZR2QRIwW6Q213mm6F4+yuplVsWCg5UqDn6D4kZj+0RkCM+YJ
 fm248iNbgJ+5OD/w=
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr15954222wru.170.1595857769772; 
 Mon, 27 Jul 2020 06:49:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGBdcpPFqRuhxH63Kqq0O3KH7KwQ9K3BrGKpvI0neaQqXhNArv6Tyh1NnkntZxa/dxsR6zsg==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr15954204wru.170.1595857769511; 
 Mon, 27 Jul 2020 06:49:29 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id r11sm17398203wmh.1.2020.07.27.06.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:49:28 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:49:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] virtio,pci: bugfixes
Message-ID: <20200727134614.96376-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
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

The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to e8863bd99030562ebe37cec917fa6e7bf4d746c9:

  MAINTAINERS: Cover the firmware JSON schema (2020-07-27 09:40:22 -0400)

----------------------------------------------------------------
virtio,pci: bugfixes

Minor bugfixes all over the places, including one CVE.

Additionally, a fix for an ancient bug in migration -
one has to wonder how come no one noticed.

The fix is also non-trivial since we dare not break all
existing machine types with pci.

Great job by Hogan Wang noticing, debugging and fixing it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Cindy Lu (1):
      vhost-vdpa :Fix Coverity CID 1430270 / CID 1420267

David Hildenbrand (1):
      virtio-mem-pci: force virtio version 1

Hogan Wang (2):
      hw/pci-host: save/restore pci host config register
      hw/pci-host: save/restore pci host config register for old ones

Philippe Mathieu-Daudé (2):
      libvhost-user: Report descriptor index on panic
      MAINTAINERS: Cover the firmware JSON schema

Raphael Norwitz (1):
      Fix vhost-user buffer over-read on ram hot-unplug

 include/hw/pci/pci_host.h             |  1 +
 contrib/libvhost-user/libvhost-user.c |  4 ++--
 hw/i386/pc.c                          |  4 +++-
 hw/pci-host/i440fx.c                  | 31 +++++++++++++++++++++++++++++++
 hw/pci-host/q35.c                     | 30 ++++++++++++++++++++++++++++++
 hw/pci/pci_host.c                     | 33 +++++++++++++++++++++++++++++++++
 hw/virtio/vhost-user.c                |  2 +-
 hw/virtio/vhost-vdpa.c                |  4 ++--
 hw/virtio/virtio-mem-pci.c            |  4 ++--
 MAINTAINERS                           |  8 ++++++++
 10 files changed, 113 insertions(+), 8 deletions(-)


