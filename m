Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B15C720760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgN0zWUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B15C720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSAU-0001Im-Mp
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9W-0007nk-Ji; Fri, 03 Jul 2020 16:19:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9V-0001UA-7F; Fri, 03 Jul 2020 16:19:18 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so33963444wrv.9;
 Fri, 03 Jul 2020 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Udt5N6SRjoTPSTAfmcAdn52pFZatqP/O7Mbt2kSJMIg=;
 b=UgN0zWUB2u9dOkVEc7dbpf6ztfvUgvdQXUNp5/bLgcy70ojv5ONG4UFkKLZbmnIbK+
 WSqOcIYe3+ebQGH73TvriNtDGUjvAtOk1W8IcqGUDKfms0IjFedpUn1D3cFXGD4S9KqC
 YFhm+Zk9tQl1y31Z+1kp+ii0Mx+fuM7HcBUA+juE2jltRsPgI/DeBvYc8RUBlPypzcKc
 zKRbBok3Vlppa76nxTfZt2MvJw1n1nJ/sE+U3izIl1Dx6q9mYx+lJC6iQVeRpYVeLZLf
 WdDn83KKDv/AnhZH5U+5DWrGEfjRZ+zKYUchAJEkSUOIAUpDmfSCnSvW+RH+SvHkt599
 UkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Udt5N6SRjoTPSTAfmcAdn52pFZatqP/O7Mbt2kSJMIg=;
 b=af3MbSojQgcW3NilX9y3DxibGOQyNBoQsEn8yCgEeZ65vrT2ExjuxkyV+7oDLsE9fl
 7pXUP8BYreUKIisUA8QxDW0mmF/p2HYllTnaIztLXYHMEDRFmyACWD1YrzA4S5XhpeGn
 Crjbbb9x+0o2T+KJoC7pFuaahpBMIee2wIMpCkcKkk0bftdgGq4yC29V09PjHVLd/NF8
 Dl5KaWizex58dSesNFxNnW1GQNznxlcjQmkdrVB8s5Ip9gUiz0IOnm3CwytbWVs7CZeH
 xyVa2OFa73ubLhJBTbYhViHO/Mk+2M0xt6MrH0AOk2oYfUMyiNfR5NBIR7pNmN2kchpM
 xlSg==
X-Gm-Message-State: AOAM530+uWOY9QaVzhmLofwRDK3T69cTC+lIKa2y4SJKZQFxs1CS3iuG
 kLtZ+NTQ4RL0JYszrZZ/ZaRq8L1j9kA=
X-Google-Smtp-Source: ABdhPJznkhG6Jh4rYylVnslmCxFcGwyD01017Rw5BCrUIy7b062mEWGD9/SClBjynQPTW5Of5toayA==
X-Received: by 2002:a5d:6a90:: with SMTP id s16mr37262143wru.8.1593807555377; 
 Fri, 03 Jul 2020 13:19:15 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 01/18] migration/vmstate: Document vmstate_dummy
Date: Fri,  3 Jul 2020 22:18:54 +0200
Message-Id: <20200703201911.26573-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

vmstate_dummy is special and restricted to linux-user. See commit
c71c3e99b8 ("Add a vmstate_dummy struct for CONFIG_USER_ONLY").

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/migration/vmstate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f68ed7db13..af7d80cd4e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -194,7 +194,7 @@ struct VMStateDescription {
     const VMStateDescription **subsections;
 };
 
-extern const VMStateDescription vmstate_dummy;
+extern const VMStateDescription vmstate_dummy; /* Exclusively for linux-user */
 
 extern const VMStateInfo vmstate_info_bool;
 
-- 
2.21.3


