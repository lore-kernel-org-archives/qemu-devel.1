Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23EDC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C247621738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C247621738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIezT-0005TN-7D
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:52:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexa-000472-U2
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIexZ-00080P-QM
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:50:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hIexZ-00080D-L2; Mon, 22 Apr 2019 15:50:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 825B785A03;
	Mon, 22 Apr 2019 19:50:36 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-61.brq.redhat.com [10.40.204.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7995D5D71E;
	Mon, 22 Apr 2019 19:50:23 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 21:50:13 +0200
Message-Id: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Mon, 22 Apr 2019 19:50:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/7] fw_cfg: Improve tracing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Laszlo Ersek <lersek@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422195013.baZZVlL-lnfdi8UnyMJLNHJFmsRqjA9pV5iNKJHutAs@z>

Trivial series to improve fw_cfg tracing.

Regards,

Phil.

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02522.=
html
- Split arch-specific code (1 patch per arch) (requested by Laszlo)

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01598.=
html
- Added arch-specific keys

Philippe Mathieu-Daud=C3=A9 (7):
  hw/nvram/fw_cfg: Add trace events
  hw/nvram/fw_cfg: Add fw_cfg_arch_key_name()
  hw/i386: Extract fw_cfg definitions to local "fw_cfg.h"
  hw/i386: Implement fw_cfg_arch_key_name()
  hw/ppc: Implement fw_cfg_arch_key_name()
  hw/sparc: Implement fw_cfg_arch_key_name()
  hw/sparc64: Implement fw_cfg_arch_key_name()

 MAINTAINERS               |  1 +
 hw/i386/Makefile.objs     |  2 +-
 hw/i386/fw_cfg.c          | 38 +++++++++++++++++++++++
 hw/i386/fw_cfg.h          | 20 +++++++++++++
 hw/i386/pc.c              |  7 +----
 hw/nvram/fw_cfg.c         | 63 ++++++++++++++++++++++++++++++++++++++-
 hw/nvram/trace-events     |  7 ++++-
 hw/ppc/Makefile.objs      |  2 +-
 hw/ppc/fw_cfg.c           | 45 ++++++++++++++++++++++++++++
 hw/sparc/sun4m.c          | 19 ++++++++++++
 hw/sparc64/sun4u.c        | 19 ++++++++++++
 include/hw/nvram/fw_cfg.h | 11 +++++++
 stubs/Makefile.objs       |  1 +
 stubs/fw_cfg.c            | 21 +++++++++++++
 14 files changed, 246 insertions(+), 10 deletions(-)
 create mode 100644 hw/i386/fw_cfg.c
 create mode 100644 hw/i386/fw_cfg.h
 create mode 100644 hw/ppc/fw_cfg.c
 create mode 100644 stubs/fw_cfg.c

--=20
2.20.1


