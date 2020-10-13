Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC35820870
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 01:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CANr51kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC35820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS8nN-0004KH-Sq
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 21:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8j0-0007l9-5U
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 21:03:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:41945)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kS8ix-0000fl-OP
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 21:03:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id c20so4850557pfr.8
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Quo+WLN2RYs/0yCjl1IWKH3iZ7BJXQe59V3pgIHgXgA=;
 b=CANr51kx++YywajXnqEBe1PvhMANGwxx/6m8SKiw910wSZ4nGVewff2HJ2YSgnqltI
 1gI4PhPlI4eIUqS2yUTn4vE6hC7gUjidCm5gTHRVVK/nrIl8jObbObnsJVWW+EoLGkji
 EyJyU9kkeQqTdETmQGnegxEivIqcyW6cIsYmrhTJcvsGrNSjn/en/uumjPdjKs5Fr6xG
 IVsnjVNvnn7aCN8Hww0f2+jAoaefbkhZ+ofh+OtRWRWb2vOX/czmqkeYfujP4+shFXZl
 jNZZ2OtSXMFZUg50ZlkEMCUYvcC3IWA3KUveWpebgMQ8GIk3LImxJgBamgXalI+UXB+6
 XaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Quo+WLN2RYs/0yCjl1IWKH3iZ7BJXQe59V3pgIHgXgA=;
 b=NrLjkKIeFqNiEccNAnrJl1sZFMuXMjt0wA3sW4PPvTK5ziKwwyaSygN1F+FIUXP7Bc
 GFYfol+fOIKIXmnFKuSAdXCcBHsPw1hXcKtOj0e07pOcXs0+GXQMROJK4jInwUrDdMtK
 gnXn5EenMAdEmD6NflNGJKzsQBKRNvfKABZY5JbDsPxbcj1aedoKfBYrj/ujMtuZn8uT
 xN8zZ3Y3SrxhJy9mr8DjKd2NzI2YMWZCClCaAgrBqb6jxbUcAiFKxD3r/TlFcYwLnFI/
 fuQ9y/vQ15W2CgGddPQ5Hgg92cvgnBd46Rgxw2O7ogUyfz+1b/gAfOWoK6s7hNrXDKlX
 FzYA==
X-Gm-Message-State: AOAM530mUlDVkT468awmNr3gAyxXFnz/rPiq2wMVgSJfVKPvZZq98uJE
 EaFOvxHCgshh4BaD3ZOw8o+GghhzUTAPVw==
X-Google-Smtp-Source: ABdhPJxZ25J7hhxSxPm8mb9tar+CvA0mXOZcxeA7DPp2KdsD6pFl6lHQ3Hcg/K2U8AyiO3PWqEKG5w==
X-Received: by 2002:a63:ff01:: with SMTP id k1mr15555320pgi.141.1602551009505; 
 Mon, 12 Oct 2020 18:03:29 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x23sm20809529pfc.47.2020.10.12.18.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 18:03:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] Fixes gcrypt testing on msys2/mingw
Date: Tue, 13 Oct 2020 09:03:08 +0800
Message-Id: <20201013010310.497-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gcrypt: test_tls_psk_init should write binary file instead text file.=0D
gcrypt: Enable crypto tests under msys2/mingw by implement custom qemu_sock=
et=3D=0D
pair=0D
=0D
Yonggang Luo (2):=0D
  gcrypt: test_tls_psk_init should write binary file instead text file.=0D
  gcrypt: Enable crypto tests under msys2/mingw=0D
=0D
 include/qemu/osdep.h             |  1 +=0D
 include/sysemu/os-win32.h        |  5 +++=0D
 tests/crypto-tls-psk-helpers.c   |  6 ++-=0D
 tests/crypto-tls-x509-helpers.c  |  6 ++-=0D
 tests/crypto-tls-x509-helpers.h  |  5 ++-=0D
 tests/test-crypto-tlscredsx509.c | 47 +++++++++++---------=0D
 tests/test-crypto-tlssession.c   | 64 +++++++++++++++------------=0D
 tests/test-io-channel-tls.c      | 49 +++++++++++---------=0D
 util/osdep.c                     | 16 +++++++=0D
 util/oslib-win32.c               | 76 ++++++++++++++++++++++++++++++++=0D
 10 files changed, 198 insertions(+), 77 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

