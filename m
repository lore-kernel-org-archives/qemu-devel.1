Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3064AC468A7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C84216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcRMO2xu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C84216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV5K-0000D7-Qv
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33798)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiH-0002PV-AG
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUiG-0001cT-FD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUiG-0001b7-6I
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:21:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id z23so10800666wma.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id;
 bh=YKQVzgq3S8pbHfjxunqcgSDhYJoFnQL+HqhuUJeM31w=;
 b=YcRMO2xuF/PGz4izIJ33oJsb5r1HuQd7mOW0zsdRczOF/WFYsrm8p+kiuzMUeUHam2
 1DMSV0bsZZQkQZIbJLYhObPK7/autPJIvtyEf5j8bvBBLyUzU5D9DPb0VojMPek/yx5I
 1gnyYg6NH+5BxqaGcAXPkGUMPHqEZooRgSb54LMmoSlGWHh1r5AnezRUHSwrtnMi0jc6
 NHNWI4IJSEgb7MiY7Ah8DAhMPGhiYqKoBYq8L4RqeWR9buDg6e18jslubUYY5VJdASea
 DGH5X+HeX+0JbnP22cIqcxj5v9chve/krihycZ92zeJQHrF/xmlVrP2rxS/jpC0hDD3e
 BhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id;
 bh=YKQVzgq3S8pbHfjxunqcgSDhYJoFnQL+HqhuUJeM31w=;
 b=L0qQl3vDAo3X33SNrRrBRwRspxctwqZDfCxFY82Mxz2QaW4t8SQ5GsvH3wMlSKnwKM
 KnMQJYc10YQ2UX+67wUV1uY0CdNA0o9ZjxIYWXE9TOUqRX5taI5FXeuPUZruy6va9LlR
 KcQi46HQWxjEbu5/0qUG6Fb7Y8tnqiNP5gIadQX3X5evw2WyBgVD1pY8w02S8D20AQqI
 rbOb9rC+Zk7+FS5ae0kbiympWLSe/mQxS/x2AsEb9ywhCYQyZzwQdBhXBxcoXQasatQy
 S/fBAPfHD3Kuopurvir/IXgNNXcXFGjW2SgY2XVMpht7S9Q/dZhNunxo/mui8CUwEC7Q
 qmCg==
X-Gm-Message-State: APjAAAXjtm98A14V43CTIGDvq56RnYUodo0CjU5C4pSSHXN0nGQngMDa
 RbGwLaLdfyh7FnYooWhgszEQpp6Jceg=
X-Google-Smtp-Source: APXvYqwGF8reefmdYF95hIC3k2rFbuF4xWS3wak7WZAeqX8/fHz8igfCTxccEBnF8J1LA6XgLIdCJQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr4265723wmc.110.1562358102083; 
 Fri, 05 Jul 2019 13:21:42 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id l9sm5582926wmh.36.2019.07.05.13.21.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:21:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:21:38 +0200
Message-Id: <1562358100-27171-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PATCH v3 0/2] hw/i386: Fix linker error when ISAPC is
 disabled
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 fixes the issue pointed out by Patchew and Philippe.

Julio Montes (2):
  Makefile: generate header file with the list of devices enabled
  hw/i386: Fix linker error when ISAPC is disabled

 Makefile.target       |  4 ++++
 hw/i386/pc_piix.c     | 12 +++++++++---
 scripts/create_config |  2 ++
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
1.8.3.1


