Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA2020665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXxsJ3Gc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA2020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDi6I-0001pm-B5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDi5f-00017b-Gb
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kDi5d-0007MV-Vh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599112037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yvp/ImzPMt39bxPyLCzp6LQbYjuKLzWAteVcqDwfdXg=;
 b=PXxsJ3GcUkCkOFR8h7tC//znnMTg63VwU7112DpGdMqbgEUgpWfrYOltYILFpMp8TaFSEQ
 Qb5GmOg6CCRlFesMsPSx0YeTOcplI0UBgg7C7J4FmXkMFLKEq4Ox4XLhtJ/e6eQS5R/TWz
 Y9gZc7sZXDA503fZaduxwTvkj2GxuHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-ehLh0cbXNVGULK0wC0Byag-1; Thu, 03 Sep 2020 01:47:13 -0400
X-MC-Unique: ehLh0cbXNVGULK0wC0Byag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F55C1DDE8;
 Thu,  3 Sep 2020 05:47:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DCF378B3C;
 Thu,  3 Sep 2020 05:47:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3E3D016E31; Thu,  3 Sep 2020 07:47:11 +0200 (CEST)
Date: Thu, 3 Sep 2020 07:47:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL v2 00/15] Cirrus-CI improvements, and other CI-related
 fixes, m68k
Message-ID: <20200903054711.q7uvc32qlchtugau@sirius.home.kraxel.org>
References: <20200902154932.390595-1-thuth@redhat.com>
 <CAFEAcA89Pjp_k5pJh26juFDO1a3M8H_s0+5cGBoZq5v7=ZYing@mail.gmail.com>
 <cd4a7bf7-c525-1aab-dab6-dcc0d22bf538@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cd4a7bf7-c525-1aab-dab6-dcc0d22bf538@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> Darn. I've added Gerd's patch since it is needed to fix the acceptance
> tests in the Gitlab-CI. Could we maybe revert the patch that introduced
> the regression instead, as long as no other proper fix is available? The
> failing CI is really bugging me.

Well, ddcf607fa3d6 fixes another nasty issue (builds modifying the
source tree), so reverting that isn't really an option.

We could have configure remove the symlink in case is present.  That way
old build trees with the symlink already created should work too.  Right
now only build trees created with ddcf607fa3d6 present are working
properly.

Untested patch below.

take care,
  Gerd

diff --git a/configure b/configure
index b1e11397a827..493b4e86da62 100755
--- a/configure
+++ b/configure
@@ -8107,6 +8107,7 @@ LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/acceptance tests/data"
 LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
+UNLINK="pc-bios/keymaps"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.elf \
@@ -8127,6 +8128,11 @@ for f in $LINKS ; do
         symlink "$source_path/$f" "$f"
     fi
 done
+for f in $UNLINK ; do
+    if [ -L "$f" ]; then
+        rm -f "$f"
+    fi
+done
 
 (for i in $cross_cc_vars; do
   export $i


