Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3641C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74E43214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E43214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i04ux-0003Zi-2I
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i04tM-0002RX-8L
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i04tK-0007K1-L8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i04tK-0007JH-GA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:13:42 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1522BC0022F1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 14:13:41 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id e13so4910600pff.9
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 07:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4eLBAMvdJFxfxQiijqpo0B1Sy99mf5DX7BsdXrS7UGA=;
 b=QR7grKEfzf0fENo4v+ntAJC6kgbLE8wJnVtmXJMlye7OUtl9qLjGcLF9qzCZfwsSzz
 4cfp31ho5znpzZKSIwgbfz2lZVEWK9uIBVvcOmMvpLGURjPudf6x/qQ27D94YOlN0TWn
 hvtajgo8aFAuFCMmRQMtphCI275iIfpZz2J3fR/JdA6SiQA2RBvNz5Fuqhc0qebNENl0
 lpE+IZo98zypU/ES+zq+KfYGsX8uoazxHjG819/t3Pj4QscNnWl4Ghr2aH8DlmpCoJR2
 zsOkBKJRJX6vIsnekWPtyC1Nr1skHWs8SYOfSvROvbehzE4lOuyEfFnX797AKe9K5JSu
 Ufuw==
X-Gm-Message-State: APjAAAURZF8Ib7V5ZGfs/WzCaayTxL3e7IPbLbBBDXUKYf2FRylr7Qdy
 PVOAPkwq3ds7ftN9MmBFJfTwpbbUZ/fSVQ14GIVR3btf9ac17qDnU27L4YwRYAY1pGL9CDsKE/P
 Wj81JaIjHUGvw9Ng=
X-Received: by 2002:a17:902:aa09:: with SMTP id
 be9mr27499579plb.52.1566310420128; 
 Tue, 20 Aug 2019 07:13:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw1f5+kjL/2QMq+nOlMUTnAqZGkX65fLaNJmtN8NLttR4bhAGxdG/YtwzrAY6x1EEiVRY1Xxw==
X-Received: by 2002:a17:902:aa09:: with SMTP id
 be9mr27499559plb.52.1566310419839; 
 Tue, 20 Aug 2019 07:13:39 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e185sm9057921pfa.119.2019.08.20.07.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 07:13:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 22:13:24 +0800
Message-Id: <20190820141328.10009-1-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 0/4] memory: Fix up coalesced_io_del not
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

v3:
- dropping patch 1 because I'm going to drop the has_coalesced_ranges
  variable later...
- moving previous patch 2 as patch 1 because I think it's definitely
  solving a standalone issue of KVM, and also it'll introduce a helper
  function that will be used in follow up patches.
- added new patches
  - patch 3: a cleanup and prepares for the next
  - patch 4: fixes another issue when add/clear coalescing ranges that
             Paolo pointed out

v2:
- simply migrate has_coalesced_range in patch 1, while I added
  comments in the code because that can be a bit unobvious [Paolo]

v1 is here:

https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03293.html

Peter Xu (4):
  memory: Split zones when do coalesced_io_del()
  memory: Remove has_coalesced_range counter
  memory: Refactor memory_region_clear_coalescing
  memory: Fix up memory_region_{add|del}_coalescing

 memory.c | 99 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

--=20
2.21.0


