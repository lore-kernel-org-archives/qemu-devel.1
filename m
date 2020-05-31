Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A579DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74589204EA
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYvY3gXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74589204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRym-0001pl-J1
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 13:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRuo-0004BW-Ul; Sun, 31 May 2020 13:38:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfRun-0004FR-Ln; Sun, 31 May 2020 13:38:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id y17so9136484wrn.11;
 Sun, 31 May 2020 10:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z6MXV/mZkWfnz890Yo+s0rvg8AHT39PfBFvpsFHjWdc=;
 b=QYvY3gXUnPTn17LDoEHOKbq6Mu4mCC5ZirXYyRfQqjW5yMjkLaLcPgaNmCokzrSMk1
 iS14BZGt5nbepXJHY+8YKtfXPZXZoNrZ+xgr27SkIjDH7+NfBvh7a00/wX4juM+cvnwK
 kJvp8SHZ9O1Fw+foevpkIx2zJ5dHganq6zkOmnCCVuUfWTlmW+u0u0wAD+jVqP2ieGrl
 iT20yzOXUuxrY/CD15YcZTH3BtjOGqMctoePxbz/lG6hLw9EA8Dkfw7WaiJU7nfxWIpo
 pcD/IKA8vgRB1+wufffNFi3pgiHvatdIAE+NJgbDW7auOUENhXlhJYpgVbftvrr2aaPq
 uw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=z6MXV/mZkWfnz890Yo+s0rvg8AHT39PfBFvpsFHjWdc=;
 b=Ms7wfQBUN3ioOyr1E7LYv6cBI6JNXGmRA0y+KP6X9SZLBQwJeIqRuRpQCCfqKtU5cf
 s50f6LwjXzkoo+AWhHoyu35hrxmjgIp3h2xxGWAaWm0/QFXmzei3C138YMUBHDWL8bzQ
 fIm3Fqtxz+8eddtrEJdU7XX1f96TrAgor0kuppwvkwQqanD665ftylbsKkKG1jEdJi2Q
 ElTpwilaacnvWyBvIbFf4nDA6QXbraymJZF5Q+fCE3uuniLIJbyH84Lq2ayI7rRGMsty
 hO4htEsGGs4F2reZQqJhE3fmicFzOHfxi8m48e/iowF2SMYc0JzAa2sYtqNdQc8pa3Xy
 XNHQ==
X-Gm-Message-State: AOAM530V+gZRV4LxMCXZgdvgHkguD1SvT8V05xcfekT9oqgS52PD8GKu
 qP5UW+JnUYUXlzD+rIe84CDZxgH/
X-Google-Smtp-Source: ABdhPJxmf1AHg9yOHBeUWTlVu63d2WHNpQGKdZws+bxSgk4Mw6bA+b97Z+h44ot+Y4hgdoKMFKkyYw==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr4028148wrv.287.1590946700911; 
 Sun, 31 May 2020 10:38:20 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l19sm7973121wmj.14.2020.05.31.10.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 10:38:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] hw/pci-host/prep: Correct RAVEN bus bridge memory region
 size
Date: Sun, 31 May 2020 19:38:08 +0200
Message-Id: <20200531173814.8734-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531173814.8734-1-f4bug@amsat.org>
References: <20200531173814.8734-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Andrew Jeffery <andrew@aj.id.au>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_set_size() handle the 16 Exabytes limit by
special-casing the UINT64_MAX value. This is not a problem
for the 32-bit maximum, 4 GiB.
By using the UINT32_MAX value, the bm-raven MemoryRegion
ends up missing 1 byte:

  $ qemu-system-ppc -M prep -S -monitor stdio -usb
  memory-region: bm-raven
    0000000000000000-00000000fffffffe (prio 0, i/o): bm-raven
      0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
      0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff

Fix by using the correct value. We now have:

  memory-region: bm-raven
    0000000000000000-00000000ffffffff (prio 0, i/o): bm-raven
      0000000000000000-000000003effffff (prio 0, i/o): alias bm-pci-memory @pci-memory 0000000000000000-000000003effffff
      0000000080000000-00000000ffffffff (prio 0, i/o): alias bm-system @system 0000000000000000-000000007fffffff

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/prep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1a02e9a670..88e2fc66a9 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -294,7 +294,7 @@ static void raven_pcihost_initfn(Object *obj)
                              &s->pci_memory, &s->pci_io, 0, TYPE_PCI_BUS);
 
     /* Bus master address space */
-    memory_region_init(&s->bm, obj, "bm-raven", UINT32_MAX);
+    memory_region_init(&s->bm, obj, "bm-raven", 4 * GiB);
     memory_region_init_alias(&s->bm_pci_memory_alias, obj, "bm-pci-memory",
                              &s->pci_memory, 0,
                              memory_region_size(&s->pci_memory));
-- 
2.21.3


