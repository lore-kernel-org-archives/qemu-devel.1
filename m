Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259CAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E6120826
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7w8Twg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E6120826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSEa-0001Ai-4E
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9n-0008TW-Ll; Fri, 03 Jul 2020 16:19:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:52617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9m-0001Wf-5R; Fri, 03 Jul 2020 16:19:35 -0400
Received: by mail-wm1-x32a.google.com with SMTP id q15so33110524wmj.2;
 Fri, 03 Jul 2020 13:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X0TkWU8PuPZ6uux23flPCYqwbAkg6A2t1I5zwG8OBgo=;
 b=u7w8Twg968kI8AKtoU1/m++5qI0lpJ6WoOEujAGkIkTtQ38ipAHoP44FvLhAqfeOtz
 jmtU+8vpr97NTcA3p2RbHTEEZK4T3dl2qRyK2c+hZBFW7p+cPQSw9erq9dTiE2cngN7K
 Nwi7A4ZSHm91D89C/e4cMdItyDSuMeRIqquYn/ETb7ju9y2P4fTCUb+ET5gq5Vm+n8aJ
 yaLS9ZA+Y0zhDX+SaPmlgb6ZEDYfxarR1gSOq2JvSKJW6on3ZMx86vxgl27mzExFNQwS
 8DEtyJZoks0j8gW8HViOFxohG/lEqqqflwvIhxb9BUZZVsO9xJ/30JQzSCeK8fBrJnSw
 oZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=X0TkWU8PuPZ6uux23flPCYqwbAkg6A2t1I5zwG8OBgo=;
 b=ggD0hvM0btaOve2vJlTMMjZJtq94iuN29wLn8FoOxBX+0UhrTSdgQig8Oi9ULNxG76
 8vxNhziaFc9JzD5G4IcwlQvfcO7w4dOWK9M/UMXoN77qvv4qrpehkBdbeJm7XFLy4wCC
 hIBIi0rnERKYHjQvHBSELmpyO5BZLyuZU8MjJyta/Drn+lhD+g/+t5/Tkk37XllM1jSn
 Wu5yzp3J5X+ncvLQIJGTJB+/shmJI8IiR1eiuqsZGzUU+eNCYm3YrCELVfV2RyJLVCk6
 RWbGGx0RdEAhaFS6zpEdNZYZmVJjy/hdNOgHdslH7EoGwoUDkChz4CRpvzsMY0JIBnJS
 morA==
X-Gm-Message-State: AOAM530+dNzK7rgwWs0wT0db98NojR5/nbK6S2QUSirMlgqXytlRR381
 uUJL8TYhPE4uH3gGCndKM4hhqbY+LJ8=
X-Google-Smtp-Source: ABdhPJxWqep2wkmGdRh70ATZaO9U4oTyz7Ox7wD7VjTMw8D71mvs2s9f+WKP6tafj/+9Lggh9MxLfA==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr38628402wma.102.1593807572337; 
 Fri, 03 Jul 2020 13:19:32 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 13/18] hw/misc/armsse-cpuid: Mark the device with no
 migratable fields
Date: Fri,  3 Jul 2020 22:19:06 +0200
Message-Id: <20200703201911.26573-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device doesn't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/armsse-cpuid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/armsse-cpuid.c b/hw/misc/armsse-cpuid.c
index d58138dc28..61251d538b 100644
--- a/hw/misc/armsse-cpuid.c
+++ b/hw/misc/armsse-cpuid.c
@@ -115,6 +115,7 @@ static void armsse_cpuid_class_init(ObjectClass *klass, void *data)
      * This device has no guest-modifiable state and so it
      * does not need a reset function or VMState.
      */
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
 
     device_class_set_props(dc, armsse_cpuid_props);
 }
-- 
2.21.3


