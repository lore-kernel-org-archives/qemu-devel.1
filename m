Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD04EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3662F2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be3gGSOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3662F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFiiU-0004tM-4z
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihK-00036C-7I; Tue, 08 Sep 2020 14:50:30 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:40688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihI-0002kz-Hm; Tue, 08 Sep 2020 14:50:29 -0400
Received: by mail-pg1-x52d.google.com with SMTP id j34so188848pgi.7;
 Tue, 08 Sep 2020 11:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=30KkRCFEtXNka1aga0YHq3EqESHJABavOs610tDas18=;
 b=Be3gGSOulo7LD2Xgr3lfyiQIIYyNJPzoLDmCDqUDa/gO6ghcf+0pFbKo2Wxac6DsQD
 /rUK4aTSlSlE4wCNwjGyc9Xyma0Bsti1PkJJZmHrwFjM7F/m5UbGJOxYnt2e1WY2Zf6G
 Zz6OEO0sbMZVpcFHOskD3QkLXO/Bp7PKIudjAxHtMEn6kduhuk8b+JTP5bAz9wqTkYV8
 amRrarwtZ2PtlyqsSduqTX85QWbLhUOWAzu7E9WAJGMvdj2KzAAd33UrCjxm5D6qHKuG
 t1PrvvCNJUjqDEVxbksyfFU8uNTBlIM4DxgRxwtVaBNwyu4eMz+FjPJy9Ig0D+Iax/g9
 URnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=30KkRCFEtXNka1aga0YHq3EqESHJABavOs610tDas18=;
 b=XEGVec8wJnxlULiZwLHwgPoSNpY1QpyNz/wfAUFNKLEK9Pff9zlK4BOr00X/nO8n90
 LFDMTA/5QpZ3owOwncdsnINxMYVvtloMJYrcKruezsIjOxHpphPV9+tgUSV0LZpTuj9U
 wQceB2wdo+c54LZ41Vn07xeb04NLGFoo7bmgEkZqwto7+u6K8cUnKrIk+Rqh1q/ovXgt
 bZpD3pLG5BMW3UB80GtLNVqjSmaELgjH68dinIhAlrFFCaioAF78u5xvyXWuA6HILj5I
 1R1QUg57qVz8BUD5hohOG3HWEYf0cgheD95dNK3x+RmKLDTvs6PN4CmgBfYuqVbwL9jP
 wzJg==
X-Gm-Message-State: AOAM531gzN1rJ1rfcFVcu1sNRwMJEBPITLVrbrKOkD49LCPbE9ot4JJP
 b1lOA+1EBbzKFWzcwJmeFNgNEkF+eGFRwfuz
X-Google-Smtp-Source: ABdhPJyqi+yLqF1aWAOhzmqZ8Buu+4f9lZMT+zsW4wRE5+uBl1oVBWReVWlZ4PstIWiL8jbmlxnzxQ==
X-Received: by 2002:a63:242:: with SMTP id 63mr83722pgc.375.1599591024692;
 Tue, 08 Sep 2020 11:50:24 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/16] meson: remove empty else and duplicated gio deps
Date: Wed,  9 Sep 2020 02:49:14 +0800
Message-Id: <20200908184918.1085-13-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52d.google.com
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 5421eca66a..0b1741557d 100644
--- a/meson.build
+++ b/meson.build
@@ -317,7 +317,6 @@ opengl = not_found
 if 'CONFIG_OPENGL' in config_host
   opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
                               link_args: config_host['OPENGL_LIBS'].split())
-else
 endif
 gtk = not_found
 if 'CONFIG_GTK' in config_host
@@ -344,11 +343,6 @@ if 'CONFIG_ICONV' in config_host
   iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
                              link_args: config_host['ICONV_LIBS'].split())
 endif
-gio = not_found
-if 'CONFIG_GIO' in config_host
-  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
-- 
2.28.0.windows.1


