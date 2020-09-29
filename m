Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B31C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870CF2076B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRXJEsyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870CF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMKw-0005GG-CC
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6K-0001x8-96
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6F-0003Wp-LI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UyNoF6Vbf91KHQj0PbwDBku/9y2cJ8cDM2oIkeoQQH8=;
 b=IRXJEsyWF7eAjRu4Xv1SvL/MBeqPBAOcADcsWC7Pnkbvs/YL1TYnYeWgaeNYy/UtB3niq4
 33L5iquO7iuYtN9LMHh4HBX9O3hAReTdMtAP76cNsCxneIayAYxlI1cEyS8o1YlfMHBHNI
 rM8jpRmzw81ljXUGyWchyOXfKAAH6fI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-kBSA0BSiN2OQ62r-vviXfg-1; Tue, 29 Sep 2020 16:19:33 -0400
X-MC-Unique: kBSA0BSiN2OQ62r-vviXfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC6D1DE06;
 Tue, 29 Sep 2020 20:19:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE215D9DC;
 Tue, 29 Sep 2020 20:19:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0658611358DC; Tue, 29 Sep 2020 22:19:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] configure: Drop texinfo requirement
Date: Tue, 29 Sep 2020 22:19:25 +0200
Message-Id: <20200929201926.2155622-29-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

We don't need the texinfo and pod2man programs to build our documentation
any more, so remove them from configure's tests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-21-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 configure | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/configure b/configure
index 8ee15810c8..ecc8e90e8b 100755
--- a/configure
+++ b/configure
@@ -4874,14 +4874,14 @@ if test "$docs" != "no" ; then
   else
     sphinx_ok=no
   fi
-  if has makeinfo && has pod2man && test "$sphinx_ok" = "yes"; then
+  if test "$sphinx_ok" = "yes"; then
     docs=yes
   else
     if test "$docs" = "yes" ; then
       if has $sphinx_build && test "$sphinx_ok" != "yes"; then
         echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
       fi
-      feature_not_found "docs" "Install texinfo, Perl/perl-podlators and a Python 3 version of python-sphinx"
+      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
     fi
     docs=no
   fi
@@ -6301,13 +6301,6 @@ if test "$solaris" = "no" && test "$tsan" = "no"; then
     fi
 fi
 
-# test if pod2man has --utf8 option
-if pod2man --help | grep -q utf8; then
-    POD2MAN="pod2man --utf8"
-else
-    POD2MAN="pod2man"
-fi
-
 # Use ASLR, no-SEH and DEP if available
 if test "$mingw32" = "yes" ; then
     for flag in --dynamicbase --no-seh --nxcompat; do
@@ -7456,7 +7449,6 @@ echo "HOST_DSOSUF=$HOST_DSOSUF" >> $config_host_mak
 echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
-echo "POD2MAN=$POD2MAN" >> $config_host_mak
 if test "$gcov" = "yes" ; then
   echo "CONFIG_GCOV=y" >> $config_host_mak
 fi
-- 
2.26.2


