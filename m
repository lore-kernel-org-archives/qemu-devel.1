Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6535FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9069B206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQVcyG7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9069B206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkv7-0003GT-Cd
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktT-0001eI-PB
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktQ-0005HA-WE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B3Za74C98Ha3l/Z2JJ9/Rchr4HclDmhLft0wEXaxUKg=;
 b=hQVcyG7g3bjNScR7VzOejgfCzk+ro4ETXLJJwIUvftJ1dI4zL6pzhBSxxPpUo2AW+rW4bX
 BLwjBEgFrtARao+Plc7F360cUzFMMOz+/b2rjBAKP/LS959m59paEsAkMby2aI5vxohy3e
 hka+vXiYMl6wGTOlGJBa8eLIdhoEJFU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-K28wZRMGOOG83DRMhoKKtA-1; Tue, 06 Oct 2020 07:12:23 -0400
X-MC-Unique: K28wZRMGOOG83DRMhoKKtA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so4251837wrt.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B3Za74C98Ha3l/Z2JJ9/Rchr4HclDmhLft0wEXaxUKg=;
 b=hmzyF7zgV45B2HoqHoGNZNIuN/OKaC5NP9X1EVODglThXVU9WwnP2KzkoG0fg+jiNb
 qESjCCleRn43u/3V2PJPtPCdL6ll9BR1kSwnASbfQRqdxSc8lwnjU1kQDWBnrxkyUeeI
 Mm+W6Lu8mNQ9BDT9hvqo7zVJFLRNnTgYpk508SSXkLxnnUYcO5W8+fzaE/NQ8sVLz9ZI
 8VNwsxG/J53gC58cwSowZJbrGX8Qb0t1LM/JEo8ri1hLtnQ3ZrMg42fh37NMKcaz52vs
 hBB4IkGd/J25Ygc41hH+PgFmkPyt/e4ycudsNnFQfGulJ6KMZ4XAUUvwFQR7ltvxcOp8
 ZUlg==
X-Gm-Message-State: AOAM530sKc7AM+nL7f/g6qULqlpkU1KvGfhLfNZvyvzQ9XYNnsUimmdR
 DnJOC3H9779LmV7hahXuTz0G+zLsbRKPiesc6JgpMWT9S2e9UcHjXlpMxTZycHFotIpZgJb3Xvo
 L18sh26t2hSzh39E=
X-Received: by 2002:adf:93e5:: with SMTP id 92mr4201901wrp.31.1601982742064;
 Tue, 06 Oct 2020 04:12:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/rZ3vnWA1AcYsSWlAZQv3nyqo2IENZgClrQdkP3wzT3ZKqypFLgkLr6tuWBmUeHajPxxt1A==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr4201876wrp.31.1601982741807;
 Tue, 06 Oct 2020 04:12:21 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h17sm4351458wro.27.2020.10.06.04.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] meson: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 13:12:09 +0200
Message-Id: <20201006111219.2300921-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make Meson machinery more consistent, as requested by Paolo.

Philippe Mathieu-Daudé (10):
  migration: Only add migration files to the Meson sourceset
  meson.build: Add comments to clarify code organization
  meson.build: Sort sourcesets alphabetically
  hw/core: Move the creation of the library to the main meson.build
  chardev: Move the creation of the library to the main meson.build
  migration: Move the creation of the library to the main meson.build
  io: Move the creation of the library to the main meson.build
  crypto: Move the creation of the library to the main meson.build
  authz: Move the creation of the library to the main meson.build
  qom: Move the creation of the library to the main meson.build

 meson.build           | 86 ++++++++++++++++++++++++++++++++++++++-----
 authz/meson.build     | 10 -----
 chardev/meson.build   |  6 ---
 crypto/meson.build    | 10 -----
 hw/core/meson.build   |  6 ---
 io/meson.build        | 10 -----
 migration/meson.build |  8 +---
 qom/meson.build       |  8 ----
 8 files changed, 77 insertions(+), 67 deletions(-)

-- 
2.26.2


