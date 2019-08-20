Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F1C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99E42087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 05:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzwWl-0008J2-Il
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 01:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1hzwVS-0006oI-9Q
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hzwVQ-0004wr-Ij
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hzwVQ-0004wN-Dt
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 01:16:28 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 576A066C58
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:16:27 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id 71so3347989pld.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 22:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=E9Dwo1FV2giLPODc47v+fqtPgWxUXq7+Jhb3E+lD+wQ=;
 b=s5IXb2f+EePp99/qMndiGYwyC0V6RxGIHMIRwKolNzWBg4sbIQuBHcQEGumKGuiKWF
 Qs0SxAnO8LIv+CK/uFB91ciGF+6PJRr0ATCuJo5rgGgQ7TtK8LcJ55r/WnOIIMltvcno
 19O8/tcbrFOo3jeQy30fLUBEVWy2vP+uDSO/GmoukR46ndOwxLSnPg58nZ7jfStonSV5
 K2OW3Sb/1UKjSNac84HCYd7AYNYjGlqGbxb5vad/uOfmA1WRvR5ayy0IvnrwRFzEw4yG
 BaX8sQznb/eX0snIt9z9Q014VldiSOgCWa7qUQsIoC9dkdsGR/oGyXV9B6+VRRscZL5x
 sCFA==
X-Gm-Message-State: APjAAAVg/pK5o7C/G0zkSYoRZpOVKDNBa72YcmaoyBhjCaHdE/Al7hDh
 y2b5xxzrcfx27qB0xppsWlnx+ZMnUHFOShmSo5oDGQYBXqcjmq5skclZ3Lk/GubgetXtjAbIBDq
 ylfcztGWmtlMfLy4=
X-Received: by 2002:a17:902:30d:: with SMTP id
 13mr26537940pld.284.1566278186358; 
 Mon, 19 Aug 2019 22:16:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOMAYdlBlx9VYXMO8fiD64PkWL+g4hjQiwni/dE8Y6cvaALIvP6AJNfK4o3RAwJVCGvJwIog==
X-Received: by 2002:a17:902:30d:: with SMTP id
 13mr26537918pld.284.1566278186157; 
 Mon, 19 Aug 2019 22:16:26 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e6sm17462610pfn.71.2019.08.19.22.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 22:16:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 13:16:13 +0800
Message-Id: <20190820051615.1210-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 0/2] memory: Fix up coalesced_io_del not
 working for KVM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2:
- simply migrate has_coalesced_range in patch 1, while I added
  comments in the code because that can be a bit unobvious [Paolo]

v1 is here:

https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03293.html

Peter Xu (2):
  memory: Inherit has_coalesced_range from the same old FlatRange
  memory: Split zones when do coalesced_io_del()

 memory.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

--=20
2.21.0


