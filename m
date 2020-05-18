Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1713C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7911620758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLXmLd86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7911620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai69-00059L-K9
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4n-0002y7-3v; Mon, 18 May 2020 11:53:13 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4m-0008Um-4a; Mon, 18 May 2020 11:53:12 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so32643wmc.2;
 Mon, 18 May 2020 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W0NZH996mfqrH/xeDmImG2NwLarasbVlVoAElHsd8sQ=;
 b=tLXmLd86dVALrDyfRBSDM7xGyBzx8PJJWlY3i38vW6q9/Pq2n5mt3ItbF9uZKtViWL
 5wjAhT45r111vXSVIQUuwkb/+pC4BmSqWADibN6q3Locg2JVINUoZqSROZBnySBdcKu2
 o7icrgMjNdj41GvG+1h7CXICRijZyk9PCqmL73xjibtIUlwr5m8fU954ESI+FigCiT6C
 bs8ilZH4spkBeWmS9qFncwqfwwrAdAuMAk77e2TsE5z07YnW6/jjk8LqIzgX5aLh8Lf3
 32nm7cFpyxPY9VYf1Y8EuTeXM0FeWyXQRN+cYia6fpPx0obBb5QsL6e2VcrOwfrxbO5A
 rQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=W0NZH996mfqrH/xeDmImG2NwLarasbVlVoAElHsd8sQ=;
 b=N59ieeDvlkbI2wRu3Xh7M0H+XLAtvnzvgUrCwcD/9QedorWAYZvGUuLRGlqm9HTx+x
 YdUWChS2MY02nHMTJbXELHt3mT5QaqTqXMg6mT+JBuqIZwkNCV+2rDaOHMnyq0wMlbWB
 L/TyXM8iZAyOmJUdHYHaXb1k8BQPf84lvsnyLweMnRP6lJpSw2EBQYqgi1izXpo0EALh
 J10PniDXLNRrSbAsO7jxMkYso0iJI494XRV8MVbyoxfewg+1y8ienAPA2zQemsmzivOm
 DZy2kAcUe8gyu5bkQ2ECHn1ahLAyMQyIKsGeqQoSLQA7RfHh4hbqEHGcp56heDOwAc3f
 rk6g==
X-Gm-Message-State: AOAM533nRauENzjgJYhiOjyC/sEs8PkOFZEki5xsbjNuD4sRj0WnzDVn
 KYUGkuJ+5dsSLhLsSfbmC35xHi6dm5w=
X-Google-Smtp-Source: ABdhPJwFfUufdYrC8E/cFB2xycdYjZB2Yu69MdjITV5JZ/mrnUeCukTsqIzH1kqKOnPbmTGUwxINOQ==
X-Received: by 2002:a7b:c948:: with SMTP id i8mr41508wml.138.1589817189954;
 Mon, 18 May 2020 08:53:09 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] exec/memory: Enforce checking MemTxResult values
Date: Mon, 18 May 2020 17:53:01 +0200
Message-Id: <20200518155308.15851-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Various places ignore the MemTxResult indicator of
transaction failed. Fix the easy places.
The rest are the DMA devices, which require deeper
analysis.

Since v1:
- Dropped "exec/memory: Emit warning when MemTxResult is ignored"
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg704180.html

Philippe Mathieu-Daudé (7):
  exec: Let address_space_read/write_cached() propagate MemTxResult
  exec: Propagate cpu_memory_rw_debug() error
  disas: Let disas::read_memory() handler return EIO on error
  hw/elf_ops: Do not ignore write failures when loading ELF
  hw/arm/boot: Abort if set_kernel_args() fails
  accel/kvm: Let KVM_EXIT_MMIO return error
  hw/core/loader: Assert loading ROM regions succeeds at reset

 include/exec/cpu-all.h |  1 +
 include/exec/memory.h  | 19 +++++++++++--------
 include/hw/elf_ops.h   | 11 ++++++++---
 accel/kvm/kvm-all.c    | 13 +++++++------
 disas.c                | 13 ++++++++-----
 exec.c                 | 28 ++++++++++++++++------------
 hw/arm/boot.c          | 19 +++++++++++++------
 hw/core/loader.c       |  8 ++++++--
 8 files changed, 70 insertions(+), 42 deletions(-)

-- 
2.21.3


