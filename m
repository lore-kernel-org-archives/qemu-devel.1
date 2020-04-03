Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B6C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFD0620737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge1eEFm1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD0620737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQCf-0004Wv-2G
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8c-00082E-Mh
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8b-0006ly-Eu
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26166
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8b-0006kv-Au
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDB2WNsWANTDRkq7tYOkdNI9gLX9QwIhSalUqrb4gxI=;
 b=ge1eEFm1MZa+pQMdNjlaRcf4FQQyJDy076g5CTptozyZqa0UePcO390gTF0lbVXwcnnJOF
 sRBxbE6aNfNd+CjsiZDH4cIVvXBkXdNeW+4dlPl9Ny2mdRQ3qDTVTL642XcMzGQZvAqPsQ
 mtbLCwkrzoPBsQEPpC8tBuPoPUR6/Sw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-v5v6iM4tNia-1h1VA9YPfw-1; Fri, 03 Apr 2020 13:29:46 -0400
X-MC-Unique: v5v6iM4tNia-1h1VA9YPfw-1
Received: by mail-wr1-f69.google.com with SMTP id o18so3448918wrx.9
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ddsOHjcFHZR+L9zNnBH3RB34rYLwZIBOYR9uJqMi8h8=;
 b=FFY4xext6bpXtJnFizwd91eYzRt1Fg7k1rdW2QUO/zRProczLAp+WCBPxH16QB7ngt
 zt13lSYhSSq2Vq7ZPRqllcF9u1StJj5czQzNZAq1hm8SKGdNW//MSpqt9xI8ceoC5ynT
 f7dM6jWsmU9XT391QojdUl2W4OuwU9gBPwRAlD1VQt5Cg81Jzp177GNB26y7qs7OPo+o
 OP0hX5Owhy06yN0DKeh734r9IpuVzgVEH4oYK4EHjwjps0StFg5A1lCdqUD+RcSCRjPn
 iCX39R1rJy+nrNVI5oTkvhc4S5zM3PNUzfp8c/EeyZc+zM44Ufuf+IPmziXzbKVYkMbb
 fx5g==
X-Gm-Message-State: AGi0PuYwZhnAU2hwZj4Eta5ae1ERxr4ATGMWm8swZBxREmlccPdZZjox
 nw7fEOB/I8q1IRlhyxsS6+Zxon9tQ+JT+ZUuzbhUH0R1nQarnVPXlO57HBoizPt7t6osMlYpxYs
 kf6/oBLhNg9uBhAE=
X-Received: by 2002:a1c:6505:: with SMTP id z5mr5369493wmb.28.1585934983301;
 Fri, 03 Apr 2020 10:29:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypKh9nHuWxLI8I0yMd+JJ71w2/5VEo04NvkpS0S0+m0S9OkHNdy60dBi+dl8a9cW0NufTvv91Q==
X-Received: by 2002:a1c:6505:: with SMTP id z5mr5369474wmb.28.1585934983074;
 Fri, 03 Apr 2020 10:29:43 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q19sm8440234wra.38.2020.04.03.10.29.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 3/8] tests/acceptance/ppc_prep_40p: Use mirror for
 ftp.software.ibm.com
Date: Fri,  3 Apr 2020 19:29:14 +0200
Message-Id: <20200403172919.24621-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid regular failures on Travis-CI with ftp.software.ibm.com,
use a mirror.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index 138064285a..1515561249 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -30,7 +30,8 @@ def test_factory_firmware_and_netbsd(self):
         :avocado: tags=3Dmachine:40p
         :avocado: tags=3Dslowness:high
         """
-        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
+        bios_url =3D ('http://ftpmirror.your.org/pub/misc/'
+                    'ftp.software.ibm.com/rs6000/firmware/'
                     '7020-40p/P12H0456.IMG')
         bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
         bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
--=20
2.21.1


