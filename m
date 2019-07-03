Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03F3218A0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 11:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03F3218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hidZF-0002sV-1J
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 07:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hidYS-0002R0-Au
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hidYR-0001I0-7s
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:36:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hidYR-0001Gz-26
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 07:36:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 212E93680B;
 Wed,  3 Jul 2019 11:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-136.ams2.redhat.com
 [10.36.116.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F6FF8D44;
 Wed,  3 Jul 2019 11:35:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5C2C1132ABF; Wed,  3 Jul 2019 13:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
References: <20190528082308.22032-1-armbru@redhat.com>
 <20190528082308.22032-4-armbru@redhat.com>
Date: Wed, 03 Jul 2019 13:24:16 +0200
In-Reply-To: <20190528082308.22032-4-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 28 May 2019 10:23:07 +0200")
Message-ID: <87muhvwecf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 11:36:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] Makefile: Rename targets for make
 recursion
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
Cc: Peter Maydell <peter.maydell@linaro.org>, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter pointed out that this makes an incremental build without -k fail
once.  By "once", I mean it works fine when you retry.  Squashing in the
appended patch to avoid this inconvenience.


diff --git a/Makefile b/Makefile
index e68982bd99..34bbcfc590 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,12 @@ capstone/all: .git-submodule-status
 slirp/all: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
 
+# Compatibility gunk to keep make working across the rename of targets
+# for recursion, to be removed some time after 4.1.
+subdir-dtc: dtc/all
+subdir-capstone: capstone/all
+subdir-slirp: slirp/all
+
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
 	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
 

