Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743DC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 20:19:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C832145D
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 20:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf/uTyLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C832145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF18l-00029T-Q5
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kF188-0001Mb-4E
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 16:19:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:36935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kF186-0006Ei-LV
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 16:19:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id n22so10772472edt.4
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZMD/tE3yZPns6sRLITBcsfqFN/RwaKPM3Cs//4EKA8A=;
 b=Lf/uTyLG/tepB/UCcL8CU9hzZwF9pH1N8m+upwysJTuZBKdRMAzNh1sLKVx4gDq2xa
 AWnNCOuEWjgupQXBZOvawBmp0/G5qVPJZ2AuMrjo0HPzLvROn5nvE91NlUifSVLmntJd
 Abw0LnvCAUFVAQBmPyYlsI29nqnMDZWyofVONpYDmKTWuRhlnF7rGnXugbxor0kQnMil
 1PRYhu4UZ5BEvLeueqMjvbG/d+AN5bFMjgOq3SB6XdGgg7RpSRHuVlQ19CUP4B9H/yUT
 FUAAAZmK2PF3c0qEzxIeP6IIF2IsiRDl+9JaNx2k/JkHdu1PbCupdQGYMeYYxDUAAQ0Y
 OLJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZMD/tE3yZPns6sRLITBcsfqFN/RwaKPM3Cs//4EKA8A=;
 b=JzJrW69Fl7D2KgHB/AT8lo7tQmuoNkPYWC4y/qQMiNcIrEWGjJz382RJHL+lMpzUir
 eZSUmvhUoVw5WYFHopFM2sA/v/51WmQtGcJzhjWPzWoSiTWjWYITeuFlQGrz/WrupKD/
 G8KqOh7K+mJssQxjmk4mTvESQXLp7UMWAO36HWEsSnQMCykNrnQrrk1YZSAU/SB/SPCN
 rwshh1qiOOYzw+IzoeIL5N665NmeXL97vhLmJKjggUeBQ8do/FSVogM7LNVi0dIBSTSW
 eRAlIvsQz3rhqu0oiZddQg4pgHUNnepfEjhxHnTnoiO/9Yfhltw1GK/bQTCiK2C3sZtQ
 B1Yg==
X-Gm-Message-State: AOAM5327OQS5eZth3cJ+feMKsP06J3wkaOUYsOnqXRgmKgFmY2XMXZvN
 AcXbz2NCKuo+XH/oop5fBU+rlriuP6Q=
X-Google-Smtp-Source: ABdhPJwQIOUTvuKaJn5LxUICw20CAlZrvVhQDNArzEsqadoQzUiQswUyTZ7nAHnWo78VcBDgQd77FQ==
X-Received: by 2002:aa7:d30b:: with SMTP id p11mr13744452edq.80.1599423552975; 
 Sun, 06 Sep 2020 13:19:12 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:79e5:61d2:1641:7362])
 by smtp.gmail.com with ESMTPSA id v2sm1399435ejh.57.2020.09.06.13.19.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 13:19:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/45] configure: drop dead variables and functions
Date: Sun,  6 Sep 2020 22:19:11 +0200
Message-Id: <20200906201911.11814-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200906201911.11814-1-pbonzini@redhat.com>
References: <20200906201911.11814-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x536.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/configure b/configure
index 249da3dd00..d63d12ae96 100755
--- a/configure
+++ b/configure
@@ -331,7 +331,6 @@ audio_drv_list=""
 block_drv_rw_whitelist=""
 block_drv_ro_whitelist=""
 host_cc="cc"
-libs_tools=""
 audio_win_int=""
 libs_qga=""
 debug_info="yes"
@@ -439,7 +438,6 @@ mingw32="no"
 gcov="no"
 EXESUF=""
 HOST_DSOSUF=".so"
-LDFLAGS_SHARED="-shared"
 modules="no"
 module_upgrades="no"
 prefix="/usr/local"
@@ -863,7 +861,6 @@ Darwin)
   darwin="yes"
   hax="yes"
   hvf="yes"
-  LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
   if [ "$cpu" = "x86_64" ] ; then
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
@@ -4946,7 +4943,7 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
   LIBS="$LIBS -lrt"
 fi
 
-# Check whether we need to link libutil for openpty()
+# Check whether we have openpty() in either libc or libutil
 cat > $TMPC << EOF
 extern int openpty(int *am, int *as, char *name, void *termp, void *winp);
 int main(void) { return openpty(0, 0, 0, 0, 0); }
@@ -4957,7 +4954,6 @@ if compile_prog "" "" ; then
   have_openpty="yes"
 else
   if compile_prog "" "-lutil" ; then
-    libs_tools="-lutil $libs_tools"
     have_openpty="yes"
   fi
 fi
@@ -6505,12 +6501,6 @@ else
     cxx=
 fi
 
-echo_version() {
-    if test "$1" = "yes" ; then
-        echo "($2)"
-    fi
-}
-
 config_host_mak="config-host.mak"
 
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
@@ -7428,7 +7418,6 @@ echo "NM=$nm" >> $config_host_mak
 echo "PKG_CONFIG=$pkg_config_exe" >> $config_host_mak
 echo "WINDRES=$windres" >> $config_host_mak
 echo "CFLAGS=$CFLAGS" >> $config_host_mak
-echo "CXXFLAGS=$CXXFLAGS" >> $config_host_mak
 echo "CFLAGS_NOPIE=$CFLAGS_NOPIE" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_CXXFLAGS=$QEMU_CXXFLAGS" >> $config_host_mak
@@ -7440,13 +7429,10 @@ if test "$sparse" = "yes" ; then
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

