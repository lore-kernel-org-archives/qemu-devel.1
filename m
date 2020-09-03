Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95DBC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DF520716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QaP4YKMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DF520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtZP-0004M9-FK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYN-0003EC-7q
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50136
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYK-0007Nd-PZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZJ51la72Am37Ui6RXPfFTUN/0eI0HygKJizCmlO0OPI=;
 b=QaP4YKMTesHeGlkmzcmvrfmBWhw4ndTpDgbI1LeTE/xyHM8MZrkDmGKaM2T3H0HY/yaFrY
 T7KMHUPydEGYhJaHgDMuWB5dKTYx0InS1iPXNp/2TgkYQKS+dyE+TDXlPPK9WqNUD3+M3V
 n4Q+4esIDw1SwO2D5aDDrs8V5aAX1z8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515--7wLLUGjMxuXdkixgfN5sw-1; Thu, 03 Sep 2020 14:01:36 -0400
X-MC-Unique: -7wLLUGjMxuXdkixgfN5sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 980761075141;
 Thu,  3 Sep 2020 18:01:35 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 827DD5C22B;
 Thu,  3 Sep 2020 18:01:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 0/8] qom: Rename macros for consistency (pass 2)
Date: Thu,  3 Sep 2020 14:01:20 -0400
Message-Id: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reducing boilerplate QOM code using the new OBJECT_DEFINE_* and=0D
OBJECT_DECLARE_* macros is quite difficult when there are=0D
multiple ways a TYPE_* constant name is written.=0D
=0D
This series renames many type checking macros and/or TYPE_*=0D
constants to make sure they are consistent.=0D
=0D
This is a second pass of cleanups, incorporating suggestions=0D
Philippe and Daniel sent when reviewing the previous series[1].=0D
=0D
This series is based on machine-next and can be fetched from:=0D
=0D
  https://github.com/ehabkost/qemu-hacks work/qom-rename-macros-pass2=0D
=0D
[1] https://lore.kernel.org/qemu-devel/20200902224311.1321159-1-ehabkost@re=
dhat.com/=0D
=0D
Eduardo Habkost (8):=0D
  i8254: Rename TYPE_I8254 to TYPE_ISA_PIT=0D
  i8254: Rename PIT to ISA_PIT=0D
  i8259: Rename TYPE_I8259 to TYPE_ISA_I8259=0D
  i8259: Rename PIC to ISA_I8259=0D
  i8259: Rename KVM_PIC to KVM_I8259=0D
  esp-pci: Rename TYPE_AM53C974_DEVICE to TYPE_AM53C974=0D
  esp-pci: Rename PCI_ESP to AM53C974=0D
  tusb6010: Rename TUSB to TUSB6010=0D
=0D
 include/hw/timer/i8254.h |  4 ++--=0D
 hw/i386/kvm/i8259.c      |  6 +++---=0D
 hw/intc/i8259.c          | 16 ++++++++--------=0D
 hw/scsi/esp-pci.c        | 16 ++++++++--------=0D
 hw/timer/i8254.c         | 10 +++++-----=0D
 hw/usb/tusb6010.c        |  6 +++---=0D
 6 files changed, 29 insertions(+), 29 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


