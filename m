Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C37C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA4820729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQZfoWPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA4820729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gLU-0003n1-Vw
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGa-0003DF-1S
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:40 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGY-00062L-Fq
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:39 -0400
Received: by mail-wm1-x343.google.com with SMTP id t14so14085328wmi.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l47U03HezxiRa34Hi3q2A5qZxOmUpp0uisa6/2TcHYQ=;
 b=lQZfoWPjHU4Pjkx4oZ6oS78TUARb4S8WhEQBh+bEPzB88gP+rlXUGn7IFL5TsYXW8+
 uIYqtZoeZmbJ50So+/jdCPitt5qX+mRLA8kBGo1KnN15sOHFCiKtApKPbyILfdS3jwMl
 J55wY3Jvzo62YZzddpMe8LltqCi+Hg9INQQTZKAdaMRxgkLFzvvIXvLHjvhJCwv9GHsX
 eqJd+9GsNViwwsT18KSFqA3jeDBOPDxiNauDo5dNE7W8yunCpKCo9lGd1xKjfwAMB20N
 zGZD88d3/16MqyAz0HR7BNtRExfdgorprk0WIe6rmPEbwAXq7pI+ZfuPI2rzHom8JEJ8
 a+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=l47U03HezxiRa34Hi3q2A5qZxOmUpp0uisa6/2TcHYQ=;
 b=T86s+L18HuyRhErHMBnbQ6dVZxdlWJJ2pknV9IAgHTU2V8TOslet6UUSyEZkoyZrIL
 3nxSCqkvsn73J+7PwkLxrLG21tfmFsdFu6zlIRGJSEQUyGn0ggroAXXrba4pxyliXIr/
 bfNhZOZYrWQvYVFfSmEDEn9PBLdyy9ZrxocB6YQ81/xTfw4W6cGsQeakBFaKJ8+fd+OK
 TCQSYg459ZzvSGjCIykOUPh36ToK5f6mduXx06vEj+ngyBpb6HAcp4zaStWoLV/ZE05F
 QYucBtBBsmHJt+/jaCeWCXdiqjh3qHWsxVPh6R07yIKdoZVlVwsi4hHQfNEU+Txe72Uj
 K/4w==
X-Gm-Message-State: AOAM530Y+me/vHqG7rhk8Cy+0ZCLzas5Z7t1X4x83npCWgVK7uCZLWto
 R+WjE+fUJS1bf7Ljf5phJwvPq/8d0NI=
X-Google-Smtp-Source: ABdhPJwsZxR3X4qAX6yMpe+ZrUqaryN81A5Oq9RyhsVStuCn7Lo7CoPuwHXE4H4RNZlvEHNOOWaD7g==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14677459wme.50.1597675056907; 
 Mon, 17 Aug 2020 07:37:36 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.36 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 010/150] nsis: use "make DESTDIR=" instead of "make prefix="
Date: Mon, 17 Aug 2020 16:35:03 +0200
Message-Id: <20200817143723.343284-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x343.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The next patch will prevent modifying the prefix on "make install".  Adjust the
creation of the installer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f237ff899d..9d9478205c 100644
--- a/Makefile
+++ b/Makefile
@@ -1188,16 +1188,16 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
-	$(MAKE) install prefix=${INSTDIR}
+$(INSTALLER): $(SRC_PATH)/qemu.nsi
+	$(MAKE) install DESTDIR=${INSTDIR}
 ifdef SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in *.exe; do \
            $(SIGNCODE) $${i}; \
          done \
         )
 endif # SIGNCODE
-	(cd ${INSTDIR}; \
+	(cd ${INSTDIR}/${bindir}; \
          for i in qemu-system-*.exe; do \
            arch=$${i%.exe}; \
            arch=$${arch#qemu-system-}; \
@@ -1206,11 +1206,11 @@ endif # SIGNCODE
            echo File \"\$${BINDIR}\\$$i\"; \
            echo SectionEnd; \
          done \
-        ) >${INSTDIR}/system-emulations.nsh
+        ) >${INSTDIR}/${bindir}/system-emulations.nsh
 	makensis $(nsisflags) \
                 $(if $(BUILD_DOCS),-DCONFIG_DOCUMENTATION="y") \
                 $(if $(CONFIG_GTK),-DCONFIG_GTK="y") \
-                -DBINDIR="${INSTDIR}" \
+                -DBINDIR="${INSTDIR}/${bindir}" \
                 $(if $(DLL_PATH),-DDLLDIR="$(DLL_PATH)") \
                 -DSRCDIR="$(SRC_PATH)" \
                 -DOUTFILE="$(INSTALLER)" \
-- 
2.26.2



