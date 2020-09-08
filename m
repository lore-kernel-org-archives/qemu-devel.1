Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15AEC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E86C2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isDCUdUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E86C2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFikO-0000xQ-9f
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihA-0002tV-NQ; Tue, 08 Sep 2020 14:50:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:33775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFih8-0002hq-UU; Tue, 08 Sep 2020 14:50:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id c196so49272pfc.0;
 Tue, 08 Sep 2020 11:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=INK+kK1nWbJF7y+rXihzR5UqDDo3HdyPVAq4bdijot0=;
 b=isDCUdUfT2aQ208FaU1RwZRcQ4ZgSspqOkDdV2BmRe9ucEEUFCCilst3EkvCXVgnWz
 VjkjOWCisC7N8zi+CZ7Iz88kgzokrjQkiiz8XQv1IhX4qOoljT+TBUYQaqxF5AKNjjMB
 K7qoQ8iHdggCENhxfRddlJsnfnT6NYa6lSCNyBnrY20Lt6Wor0nNbssJi6srBXi3vKY9
 jY0E8+vOP1kQYwXr7MnqOwc6Kq9TFkf5pIkeHp6uvD/A9yMNtVa4ZEYq1OLo7RfEFDf+
 IUuDSgL4/6ZMTp+vY2L8k0KBtxRogtJurf0idDrJZmEzGRZemGfs0wrRhXhky7TGVOaV
 /rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=INK+kK1nWbJF7y+rXihzR5UqDDo3HdyPVAq4bdijot0=;
 b=RfcuowNqpEQqyG1BVCYMEsIoeiZdoQ8OhqDwseiT9dxkhoe8lyVgpcvD9TEDzjZjQT
 U4VdqVeXjBwFT2cTjJI2j4lig8NsyMqsumtdp6DYtr0p6nMAs0795KMUASWEQ4pQZATB
 V2Jm6D5+A+o+C3n32u3Fk6Cqo62F8MiWkl8ny/XTKrSPJW0jDwLxCRISR8jkeXH+kR5R
 bM+8k64uLFx5t08CmwLWCZ7rvVJyz5fKVhSB+tugKZeTrniiEzsoYJts5UxWQhkXiCd1
 SW3uhg6XzJAjR/e0N5s3iWFSo68qS4536IKOD8lgR56oG1+7V7u1Qq6mryhkdXAFVtXX
 EHpw==
X-Gm-Message-State: AOAM531izNmay/zVL6afzcx4qK7LJSMnhTxvlBZ8oNk5aqg48v1VaVoz
 c+3qihIQbE/v032eFSb0NIRz3mIPbM4qjZVq
X-Google-Smtp-Source: ABdhPJyQANkA3MXT9rKBX0DtGUNkZBqmqVBCL89DrSChekjamn1Erz8l8JDzzATRR3ol1yqCopJSKA==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr43793plr.99.1599591016745; 
 Tue, 08 Sep 2020 11:50:16 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:13 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] meson: Use -b to ignore CR vs. CR-LF issues on Windows
Date: Wed,  9 Sep 2020 02:49:12 +0800
Message-Id: <20200908184918.1085-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x430.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On windows, a difference in line endings causes testsuite failures
complaining that every single line in files such as
'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b to diff.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qapi-schema/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..f1449298b0 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


