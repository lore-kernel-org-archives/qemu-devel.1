Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A02DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C5320656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxd6gKs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C5320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO2F-0002ih-W8
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1I-00013G-Bs
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:04 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:45995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvO1G-0006oG-US
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:43:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id s10so22944256wrw.12
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2kQViIC5+9PvqKmlhSyw3D2e/Rk9cWBtF+16LewFggU=;
 b=jxd6gKs3gyaONVuseSojodyvFe3qXsF6x/Bgof5N2Wj5mE1QbICMH+enbg2fo97IS5
 jtgFAUSWc2ag1dEharm7+nkB3dGofy4fhlaLUEr6ACHWuRDhIarece3UB5LCxgGuhff+
 FTNS04qEnYLLvt7tde2vKrP0PMHcpSjJdPg+GOKgE2O6ZReQVpmRVT/4TGIcQkf9y237
 P/BxwYTZ9Tx/1nt/3J+kZGIumE6Fjw1lU/nhCzQKwFREW0vfQh10SHKxymKjihmPXb+Z
 VO2b739GAZzT7Rat62zelLNHawrlTF+Oma7Jam4KNK6NhIdZdeLBPwkOlldMqaU5P905
 6o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2kQViIC5+9PvqKmlhSyw3D2e/Rk9cWBtF+16LewFggU=;
 b=rhP0xLUDKXLE5tB9jTY0QWsj5oSKXAXk65o3wjD3ewCDYg2gOEm3iyTCp9/yVSOrlt
 MP5cChl7cKK7u8RvzkzQfe0m7WYywfSYxQSqOwaaPKbDCWslsfk9J02SaBRntvzsO82h
 bNjW1UcvxBJWrXRGPT4XJwQJoA90lOtlZ4DwuD2dRZXyy6qJYe0Opuhtj1dIUpZQQm/D
 pMz2CVpVNUNcfKTKAjLOgOjG1EtM+IDB7mjuCC89ctf3UAYA04B+62+j/D4nWBX4u3RB
 66ZVkJzsmqp0u1lgFKRq01fUOpbcO9UuHjEPISy6BbQ8jyvsbaiFIvYCiRdVuIS+uZ+H
 e0OQ==
X-Gm-Message-State: AOAM530DffcoYNO9L5k5RPtuh6cyLnGruprsgtkF+HhH0Yyjyd4VdtUM
 kdQLqJUod5mh828AGxv1Eg6RqFeWI94=
X-Google-Smtp-Source: ABdhPJxG5WDG/1t+TPzHsMAP46ZGMRgVFNGq/hijDSmnIFmA6vazWPo//rW6lEM43mborFGV0Uf5+w==
X-Received: by 2002:adf:ec4e:: with SMTP id w14mr7190451wrn.280.1594744981448; 
 Tue, 14 Jul 2020 09:43:01 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 138sm6474380wmb.1.2020.07.14.09.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 09:43:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 2/4] qemu/osdep: Reword qemu_get_exec_dir()
 documentation
Date: Tue, 14 Jul 2020 18:42:55 +0200
Message-Id: <20200714164257.23330-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714164257.23330-1-f4bug@amsat.org>
References: <20200714164257.23330-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 Sarah Harris <S.E.Harris@kent.ac.uk>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This comment is confuse, reword it a bit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu/osdep.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 979a403984..a96849dd90 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -588,7 +588,10 @@ char *qemu_get_local_state_pathname(const char *relative_pathname);
 void qemu_init_exec_dir(const char *argv0);
 
 /* Get the saved exec dir.
- * Caller needs to release the returned string by g_free() */
+ *
+ * The caller is responsible for releasing the value returned with g_free()
+ * after use.
+ */
 char *qemu_get_exec_dir(void);
 
 /**
-- 
2.21.3


