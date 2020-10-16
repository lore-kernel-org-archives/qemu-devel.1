Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EEBC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B872083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzzIrrUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B872083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTORy-0003Xk-0O
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODn-0000ii-Cq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODl-0002qZ-D8
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BWsA8yD3GFX0ZlGypxueWbXfCg5ZhlkQRt4O9jNGkS4=;
 b=YzzIrrUPHVF9XduFe5/A2Lqs6gkNZ/4ghQABdZiovK+6NAiffZZF+7NjzGPt76dKXtj9xv
 Ggy/suDHA7OnTvVFMPyDhCJ21BKh3FZBKtcx8YtTPgHDg3Zzc7FZb3AhPl2Z4eeII+KE1K
 WUTvib3hDJodK1Vy9EOznqAD3KHqtt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-liZtC25sPdun2U6EEW5v2w-1; Fri, 16 Oct 2020 07:48:24 -0400
X-MC-Unique: liZtC25sPdun2U6EEW5v2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67E0018A8246;
 Fri, 16 Oct 2020 11:48:22 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 254595C1BD;
 Fri, 16 Oct 2020 11:48:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/22] cirrus: Enable doc build on msys2/mingw
Date: Fri, 16 Oct 2020 07:48:11 -0400
Message-Id: <20201016114814.1564523-20-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Currently rST depends on old version sphinx-2.x.
Install it by downloading it.
Remove the need of university mirror, the main repo are recovered.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201015220626.418-5-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .cirrus.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 396888fbd3..e099da0fec 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -76,7 +76,6 @@ windows_msys2_task:
         ((Get-Content -path C:\tools\msys64\etc\\post-install\\07-pacman-key.post -Raw) -replace '--refresh-keys', '--version') | Set-Content -Path C:\tools\msys64\etc\\post-install\\07-pacman-key.post
         C:\tools\msys64\usr\bin\bash.exe -lc "sed -i 's/^CheckSpace/#CheckSpace/g' /etc/pacman.conf"
         C:\tools\msys64\usr\bin\bash.exe -lc "export"
-        C:\tools\msys64\usr\bin\bash.exe -lc "grep -rl 'repo.msys2.org/' /etc/pacman.d/mirrorlist.* | xargs sed -i 's/repo.msys2.org\//mirrors.tuna.tsinghua.edu.cn\/msys2\//g'"
         C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Sy
         echo Y | C:\tools\msys64\usr\bin\pacman.exe --noconfirm -Suu --overwrite=*
         taskkill /F /FI "MODULES eq msys-2.0.dll"
@@ -111,6 +110,11 @@ windows_msys2_task:
           mingw-w64-x86_64-curl \
           mingw-w64-x86_64-gnutls \
           "
+        bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
+          https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
+          C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
+        C:\tools\msys64\usr\bin\bash.exe -lc "pacman --noconfirm -U /c/tools/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz"
+        del C:\tools\mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz
         C:\tools\msys64\usr\bin\bash.exe -lc "rm -rf /var/cache/pacman/pkg/*"
         cd C:\tools\msys64
         echo "Start archive"
-- 
2.26.2



