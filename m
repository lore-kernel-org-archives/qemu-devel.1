Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7D5C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:11:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DE62078E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1lAW6Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DE62078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXlt-0001XR-GR
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkL-00088w-Lb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkH-0007Kv-5k
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601932208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vw4zCSrS4U5/JK3O9rHiZHdu8K4xPDfCEJomri/dtB8=;
 b=U1lAW6OdgiGqH01D0b3Z4yU2eHoaYzTcp2J9gxhv00Dtpjgl0j2dsTFtzlLEAOJQRPXbrM
 QAuYnL3JOC5PyrQTXtOA+Ar1rdKwPEkx/U3CkGRWortEUe8AoyJjwTjfT5fG64j61zPUhr
 s46LrEnQ4ZTp0Rl4XTxtGAN6RP04BD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-vQDR30IdM42BKRg8r65EiA-1; Mon, 05 Oct 2020 17:10:04 -0400
X-MC-Unique: vQDR30IdM42BKRg8r65EiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3017D104D3E0;
 Mon,  5 Oct 2020 21:10:03 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07C7F55778;
 Mon,  5 Oct 2020 21:10:01 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/21] machine + QOM queue, 2020-10-05
Date: Mon,  5 Oct 2020 17:09:39 -0400
Message-Id: <20201005211000.710404-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36d9c2883e55c863b622b99f0ebb5143f0001401=
:=0D
=0D
  readthedocs: build with Python 3.6 (2020-10-05 16:30:45 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to fec5c4b6d3b7f3ffcfcbe1714e0405df6de2a222:=0D
=0D
  kernel-doc: Remove $decl_type=3D'type name' hack (2020-10-05 12:48:11 -04=
00)=0D
=0D
----------------------------------------------------------------=0D
machine + QOM queue, 2020-10-05=0D
=0D
* QOM documentation fixes and cleanups (Eduardo Habkost)=0D
* user-mode: Prune build dependencies (Philippe Mathieu-Daud=C3=A9)=0D
* qom: Improve error message (Philippe Mathieu-Daud=C3=A9)=0D
* numa: hmat: require parent cache description before the next=0D
  level one (Igor Mammedov)=0D
=0D
----------------------------------------------------------------=0D
=0D
Eduardo Habkost (11):=0D
  qom: Fix DECLARE_*CHECKER documentation=0D
  docs/devel/qom: Fix indentation of bulleted list=0D
  docs/devel/qom: Fix indentation of code blocks=0D
  docs/devel/qom: Use *emphasis* for emphasis=0D
  docs/devel/qom: Remove usage of <code>=0D
  docs/devel/qom: Avoid long lines=0D
  kernel-doc: Handle function typedefs that return pointers=0D
  kernel-doc: Handle function typedefs without asterisks=0D
  qom: Explicitly tag doc comments for typedefs and structs=0D
  memory: Explicitly tag doc comments for structs=0D
  kernel-doc: Remove $decl_type=3D'type name' hack=0D
=0D
Igor Mammedov (1):=0D
  numa: hmat: require parent cache description before the next level one=0D
=0D
Philippe Mathieu-Daud=C3=A9 (9):=0D
  hw/core/qdev-properties: Use qemu_strtol() in set_mac() handler=0D
  hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()=0D
  hw/core/qdev-properties: Fix code style=0D
  hw/core/qdev-properties: Export enum-related functions=0D
  hw/core/qdev-properties: Export qdev_prop_enum=0D
  hw/core/qdev-properties: Export some integer-related functions=0D
  hw/core/qdev-properties: Extract system-mode specific properties=0D
  hw/core/cpu: Add missing 'exec/cpu-common.h' include=0D
  qom: Improve error message displayed with missing object properties=0D
=0D
 docs/devel/qom.rst               |  91 ++--=0D
 hw/core/qdev-prop-internal.h     |  30 ++=0D
 include/exec/memory.h            |   6 +-=0D
 include/hw/qdev-properties.h     |   1 +=0D
 include/qom/object.h             |  38 +-=0D
 hw/core/cpu.c                    |   1 +=0D
 hw/core/numa.c                   |   8 +-=0D
 hw/core/qdev-properties-system.c | 687 ++++++++++++++++++++++++++++-=0D
 hw/core/qdev-properties.c        | 735 ++-----------------------------=0D
 qom/object.c                     |   3 +-=0D
 scripts/kernel-doc               |  16 +-=0D
 11 files changed, 831 insertions(+), 785 deletions(-)=0D
 create mode 100644 hw/core/qdev-prop-internal.h=0D
=0D
--=20=0D
2.26.2=0D
=0D


