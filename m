Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DECC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7862078B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk9IexiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7862078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k99b0-00027j-Sz
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 12:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99aG-0000vB-2N
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:08:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k99aC-0003cG-Kc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 12:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598026079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wss4PuFuftaUGSiEsj4ZhHDH2Wc88qjKeJrLN5JbRXc=;
 b=Lk9IexiLQAidQTY2EdDJmshKq/zAVW6GMsVUftSujPNQkklABI+G6+00HqpG3QEUwJ5+xC
 6Ru1LgfYMVUXAy5pkHIoPuZ2nLqG2PkeIFQ+PZ+i36fpW8refiyrrlAVqZIIIqwS7shYew
 j4lMQ08NhcyGRsd8lV7B/3Fb5Twy2T0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-7y2WepvNNzKfp-W1jPw1XQ-1; Fri, 21 Aug 2020 12:07:57 -0400
X-MC-Unique: 7y2WepvNNzKfp-W1jPw1XQ-1
Received: by mail-wm1-f69.google.com with SMTP id z10so960990wmi.8
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 09:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wss4PuFuftaUGSiEsj4ZhHDH2Wc88qjKeJrLN5JbRXc=;
 b=rKDO8lfu0Hd1SvoSgPdhZJ7fp0zbHszh9vBTvLbYozI+vcbCuuDcPP4q8aPhq5FCqx
 wcD01S7YddAKMEn9dr8g+u9mmSZ6IvpMXCcedtnHSUd+9aO+zsEFjj5ymJFWagGpCXVY
 yYv+XU7qO6Dial+x24JAlVZpL9lUP0cw9oOFMNIfdDEV11fBGHvjLN8Tjuwe29Wu8pag
 XcGvpvf1MSiwOYofKlG5/mtCSv+9CB8AofJaDmZwLrsRZ3BIJ6pGhV0rbohWmPJFBXSv
 qR9sAs/R+k9N0bTAirtUSeCPF+wTuF02tsrNt19lMFk48NK+06MLDLnQeoUQ747Bi1BG
 214w==
X-Gm-Message-State: AOAM531j2XD8DAdDyYesFcUI0y12xWVsvNgjWa6ZXALtUQXSZvcebr0m
 9PEnostDqi/1LsmYp0N88drr+Wh5IvHmG5FsbiMZw4ZNgG1h2E/WM9svu8Ze0LyePSGaa1nNLfR
 sDvf572gEKUrxaX0=
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr2900082wmf.53.1598026075918; 
 Fri, 21 Aug 2020 09:07:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznHPD8Rs6+Hk+d229OCWyTs0vuuvAnm620mS7Ms1K53kveJMdT9pctIG5LfBYo/Xxj4KeIpQ==
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr2900056wmf.53.1598026075650; 
 Fri, 21 Aug 2020 09:07:55 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g7sm5350957wrv.82.2020.08.21.09.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 09:07:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] meson: Build qemu-keymap when configured using
 --disable-tools
Date: Fri, 21 Aug 2020 18:07:50 +0200
Message-Id: <20200821160752.1254102-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix --enable-system --disable-tools builds.

Marc-André Lureau (1):
  meson: convert pc-bios/keymaps/Makefile

Philippe Mathieu-Daudé (1):
  meson: Do not consider qemu-keymap a 'tool'

 Makefile                    |  8 ------
 meson.build                 | 11 ++++----
 pc-bios/keymaps/Makefile    | 56 -------------------------------------
 pc-bios/keymaps/meson.build | 56 +++++++++++++++++++++++++++++++++++++
 pc-bios/meson.build         |  1 +
 ui/meson.build              |  2 +-
 6 files changed, 64 insertions(+), 70 deletions(-)
 delete mode 100644 pc-bios/keymaps/Makefile
 create mode 100644 pc-bios/keymaps/meson.build

-- 
2.26.2


