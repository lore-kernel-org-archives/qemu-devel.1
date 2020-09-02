Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC84207D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxHrjpj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC84207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSfg-00031h-Te
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMb-0006Vo-PY
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDSMX-0007Ag-1M
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599051580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EKJrEDpc7ENF0eGvrpw7+HFUjiqX3/oYPynl9tD1Jw=;
 b=OxHrjpj5eaEyfCdJk+ezOp9VaW8e8RXhXVCFgBBEg4bhtbZoHAzfUp8QA3NepIy/rUqJiP
 LR+xykxsMZNKGjW9qUCRhPhrMClvLCKHlXMo57fY3Xg7CU4dXq6jaUgqTUQt9WILQxjXOz
 RWSvyNDlBmAgpI5yZr8Wn0PkHlcDRjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-RlflslKHM-2leSC745BVbw-1; Wed, 02 Sep 2020 08:59:38 -0400
X-MC-Unique: RlflslKHM-2leSC745BVbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB515107B7E1
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA49D5D9CC
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 12:59:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/39] configure: drop dead variables
Date: Wed,  2 Sep 2020 08:59:16 -0400
Message-Id: <20200902125917.26021-39-pbonzini@redhat.com>
In-Reply-To: <20200902125917.26021-1-pbonzini@redhat.com>
References: <20200902125917.26021-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/configure b/configure
index 044cb413f2..43e7761a10 100755
--- a/configure
+++ b/configure
@@ -313,7 +313,6 @@ audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
 host_cc="cc"
-libs_tools=""
 audio_win_int=""
 libs_qga=""
 debug_info="yes"
@@ -421,7 +420,6 @@ mingw32="no"
 gcov="no"
 EXESUF=""
 HOST_DSOSUF=".so"
-LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
 prefix="/usr/local"
@@ -845,7 +843,6 @@ Darwin)
   darwin="yes"
   hax="yes"
   hvf="yes"
-  LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -4922,7 +4919,7 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
   LIBS="$LIBS -lrt"
 fi
 
-# Check whether we need to link libutil for openpty()
+# Check whether we have openpty() in either libc or libutil
 cat > $TMPC << EOF
 extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
 int main(void) { return openpty(0, 0, 0, 0, 0); }
@@ -4933,7 +4930,6 @@ if compile_prog "" "" ; then
   have_openpty="yes"
 else
   if compile_prog "" "-lutil" ; then
-    libs_tools="-lutil $libs_tools"
     have_openpty="yes"
   fi
 fi
@@ -7382,13 +7378,10 @@ if test "$sparse" = "yes" ; then
 fi
 echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "LDFLAGS_NOPIE=$LDFLAGS_NOPIE" >> $config_host_mak
-echo "LD_REL_FLAGS=$LD_REL_FLAGS" >> $config_host_mak
 echo "LD_I386_EMULATION=$ld_i386_emulation" >> $config_host_mak
-echo "LIBS_TOOLS+=$libs_tools" >> $config_host_mak
 echo "PTHREAD_LIB=$PTHREAD_LIB" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 echo "HOST_DSOSUF=$HOST_DSOSUF" >> $config_host_mak
-echo "LDFLAGS_SHARED=$LDFLAGS_SHARED" >> $config_host_mak
 echo "LIBS_QGA=$libs_qga" >> $config_host_mak
 echo "TASN1_LIBS=$tasn1_libs" >> $config_host_mak
 echo "TASN1_CFLAGS=$tasn1_cflags" >> $config_host_mak
-- 
2.26.2



