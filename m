Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FAEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5672089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5672089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKHgR-0002de-FI
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 03:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKHfZ-0001f4-Mi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKHfX-0005g4-GL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKHfX-0005ev-AT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:54:59 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 09682BCFE4
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:54:57 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id e5so3966041pgm.7
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 00:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p5OozpjQAZLecBx1El1VniKk55sF6qLfTgqTQpjEB5U=;
 b=NV9b66luwUZX59ITKg0SZLEs52Y58bpeu9FAwYeKt7yip/j/Mrf5bDaKj57bhWi9ZE
 uL4AhZWrMYUFwFrlsqAm6CgvIeY2yYLLKnJGFkGZfhYrFQWMjCAF9IfDRL500bmRRIBu
 A70dOUvUHbG6D5aRFhiGU+h8kf5o+F/qLNLCDBesHWRs5gjBASkATiJYOtgosGMWOkP2
 NWnFfOXk97DZNocqnwxKOz1aUw6+tXPo5RMs2B0RXNiWwFEKXYKdm2UReMc711LEWEtS
 NpcTlPfc4kSziPZYbH1QIFkuuJECKRTMsRotJL5KsGzCtefWc391G3CKWHmbS8x6Xy7N
 WzPg==
X-Gm-Message-State: APjAAAWwaQyOtdIf32oDLpp79E0vN9okIDNeNHzXmtYLKQIba0O2Ar3s
 rULuKSTv22jdOzlKwNWdtlXqTE9207P2NxH9+khV7w3/bVwy1pBINzPBZ+IOYcsQKUGTvGiGmvH
 zbeHmVfMNBPA8H0o=
X-Received: by 2002:a63:e148:: with SMTP id h8mr36189016pgk.297.1571126096081; 
 Tue, 15 Oct 2019 00:54:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqywN6vdI4BZn2Qtj5zNSBozWgYycZNq1vYxzw2Ao6BUyY8LkaeBysIuhuIHbtwUP3R+Ovpwxw==
X-Received: by 2002:a63:e148:: with SMTP id h8mr36188989pgk.297.1571126095705; 
 Tue, 15 Oct 2019 00:54:55 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r30sm24599850pfl.42.2019.10.15.00.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 00:54:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] apic: Fix migration breakage of >255 vcpus
Date: Tue, 15 Oct 2019 15:54:42 +0800
Message-Id: <20191015075444.10955-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not very certain, but... it seems to be broken starting from when
x2apic was introduced in QEMU, until now.

Please review, thanks.

Peter Xu (2):
  migration: Boost SaveStateEntry.instance_id to 64 bits
  apic: Use 32bit APIC ID for migration instance ID

 hw/intc/apic_common.c        |  2 +-
 include/migration/register.h |  2 +-
 include/migration/vmstate.h  |  4 ++--
 migration/savevm.c           | 10 +++++-----
 stubs/vmstate.c              |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

--=20
2.21.0


