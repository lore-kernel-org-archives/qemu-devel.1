Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BDC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333C32075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CIXx17sR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333C32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmYo-00077y-2q
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVn-0002gb-D8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVl-0001sA-Jc
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/s6R5f8ZjpImJ1yDPXJ7mTGHg0FFOi4BEA6zhtvc/j0=;
 b=CIXx17sRWB0bmqPi14atH2JGZ6Q/cwpmewd7xAC36MjycVRmHdLCGP61XZrwN6PDXDt97s
 E08JyKrp+HwDGQ8MfzIij63KlrIPnzu7FeJ1WH15fSJ+aJ4X8GkLEM4I9jx76yEUz2m4RQ
 h1zekc7DQ4vUTrU92cE+YUlRYZAC7eo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-SA0yC9cuOoSaF4sx9ILPtA-1; Tue, 06 Oct 2020 08:56:06 -0400
X-MC-Unique: SA0yC9cuOoSaF4sx9ILPtA-1
Received: by mail-wr1-f72.google.com with SMTP id o6so5303933wrp.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/s6R5f8ZjpImJ1yDPXJ7mTGHg0FFOi4BEA6zhtvc/j0=;
 b=lsHobUQ9ZIqTucxrNSXajNED13VwLtN16xXG6nqjIu7XjVqN8Ir1QKKClfL+/Mc5Dz
 NcxxGHur0Up6lnDzCfgdEYreMLhl0kck4Xvr2WtJQUZJJjo3smIVwy2b2IXDN8ZIZDWP
 K9ZCrJe8DJ6lQTipWUhp6dUr11amF0yMw2qNdbm2UBopgnRf25NJORWXbquT6e1nd2iR
 u8HslXgOE11OHcRb2Ie1+kYL+CI4boFx3Q7H7+XAAL8RFRp8iECbXuEkgLbu1M6X6b7B
 MssO7z1Mdlb484FwvAcT+1w5QEW4pkJeBQqrFeSsJ8Qn3vn8Jis3Xvfh9Jzr7X0Ac6W5
 dmhQ==
X-Gm-Message-State: AOAM531T2H9GUAX0ITz7sq8NvXUQB2wxJqjdj8jfXc8EB6ZunAAGh1Qx
 cGusf8NcBE2ipSxIlMF7pbZIodvRHDPL1j7z7WMIQhbtAzKBvjnfh18UQgCn870usFgtWOzmRMa
 pDut9SpnRNDMkZrk=
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4234571wma.47.1601988964724; 
 Tue, 06 Oct 2020 05:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzP8d2JR0A4V85oQydg12onvbAYdepu4CL6MsDQYSmhgRH5lia8XxZbejhDoiTmvAx6qYwoCg==
X-Received: by 2002:a1c:38c7:: with SMTP id f190mr4234545wma.47.1601988964527; 
 Tue, 06 Oct 2020 05:56:04 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id s12sm3662933wmd.20.2020.10.06.05.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/9] meson: Move the creation of the library to the main
 meson.build
Date: Tue,  6 Oct 2020 14:55:53 +0200
Message-Id: <20201006125602.2311423-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make Meson machinery more consistent, as requested by Paolo.

Since v1: addressed Paolo's review comments
- Drop migration RFC patch
- Move comment block

Series coded while listening to Brass Against songs:

  https://www.youtube.com/channel/UClJMqrWQJ8OYWJ4ZdfqZdeQ

and available in the Git repository at:

  https://gitlab.com/philmd/qemu.git branches/meson_libraries_consistency

Philippe Mathieu-Daudé (9):
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


