Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C21C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A89622272
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjIVIHJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A89622272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjL0-0000hT-Mv
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 09:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJr-0007gL-5p
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:27 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:38659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGjJp-0002mA-K4
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 09:42:26 -0400
Received: by mail-ed1-x542.google.com with SMTP id c8so9995631edv.5
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GkKR887fLWOo4DC15+qJV+odLhc3rljp4gn44gOfM4I=;
 b=AjIVIHJOZ55sDAN+PJovqaHhO5Mgw9YfeOAVRE0u1Q3oc1G4TxH/BN38HgTwVfiK9P
 FDtGlKFAte/Udrv7a+Krcl00DSD4qL6FC+gAOU/Yc2s7ggTHb2zhSWmPwiLHEkBHzt8E
 5uiJYXsWkZlcOmP5I3VM95hxrBr/dqFH6S5Dw6ZquZ6x2kjstgVG+Bt8x0Lr8kyn/pIg
 xIO0vHmvgOtMM4FvBCS2zy4q/1SSbwtVYohJsrJ7OlwDCdRcR8R6nxaYOidaZteriqMv
 cojiuAwqXYzgVJ0ZIoBV/S3gzKxCjPJ/MTthCx9EuVrnnpWftvjwTp84eW/1GjrpL+kc
 qUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=GkKR887fLWOo4DC15+qJV+odLhc3rljp4gn44gOfM4I=;
 b=YRwRJiMP9GjVWUCQ1k2oFt3R466B0jfh943wHIpai3FriltACeFihLiV36dOrqZ0Gk
 d8m1pc988mtrmZzeQq3TGE+EWwZtuETbe6CQ3/3OnzW00qjh6x0SHSg3RiW4RVRNGhXG
 Mm+KfeMpYT9F9oyBpzM8+Qp6AVE8sa0jHbYQHBZsl9uerKYmoz7DYuhXwY5HF0dqTFA+
 FQGxegzq1dganXw+Rh8aIdtq+mVmnSeBieril4l2cKX3s106rSEFCZjMqVr+3t2nFNfH
 3o65N5JDw8+Lp8GT3l5hOmOR1QsXOtNEfWv29DpJSkR61Fcovdy4ZL5SQNiOQYY0WdQw
 w0uQ==
X-Gm-Message-State: AOAM530reBNJWvCGmOM6yZb+cGsFHUabjeGTcbyckIWOP76A+Grj9JQw
 VdMzg8/QZXwpH2gxrnjuy8Nd/+3Ct+I=
X-Google-Smtp-Source: ABdhPJy+c11jtdNBM8j8qwlmY1Ul3ZO4izmh2bC1Y2/LtURfoctxYJT4zCVL5fOXzzdTHnAC123Baw==
X-Received: by 2002:a50:875c:: with SMTP id 28mr2060098edv.20.1599831742273;
 Fri, 11 Sep 2020 06:42:22 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
 by smtp.gmail.com with ESMTPSA id i35sm1757165edi.41.2020.09.11.06.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 06:42:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ninjatool: rebuild multi-output targets if outputs are missing
Date: Fri, 11 Sep 2020 15:42:20 +0200
Message-Id: <20200911134221.46636-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "stamp file trick" used to group targets of a single multi-output rule
prevents the user from deleting one such target in order to force its
rebuild.  Doing so will not touch the stamp file, and therefore only
the dummy ":" command will be executed.

With this patch, ninjatool writes rules that force-rebuild the stamp
file if any of its outputs are missing.  Rebuilding the missing
target therefore causes the stamp file to be rebuilt too.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/ninjatool.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index 627a1cab45..6f0e35c727 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -908,6 +908,9 @@ class Ninja2Make(NinjaParserEventsWithVars):
             else:
                 stamp = '%s@%s.stamp' % (rule, sha1_text(targets)[0:11])
             self.print('%s: %s; @:' % (targets, stamp))
+            self.print('ifneq (%s, $(wildcard %s))' % (targets, targets))
+            self.print('.PHONY: %s' % (stamp, ))
+            self.print('endif')
             self.print('%s: %s | %s; ${ninja-command-restat}' % (stamp, inputs, orderonly))
             self.rule_targets[rule].append(stamp)
             self.stamp_targets[rule].append(stamp)
-- 
2.26.2


