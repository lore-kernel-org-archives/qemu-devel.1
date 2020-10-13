Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3595C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725BE2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725BE2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSIu3-0004IK-C5
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpe-0006yl-R9; Tue, 13 Oct 2020 07:51:06 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpb-0004xV-Tu; Tue, 13 Oct 2020 07:51:06 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MuDoR-1kBSu60cDF-00udPG; Tue, 13 Oct 2020 13:50:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/14] tests/test-char: Use a proper fallthrough comment
Date: Tue, 13 Oct 2020 13:50:42 +0200
Message-Id: <20201013115052.133355-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xOnKqLYQxlYpUSu48+Sp9EeEa+GeWMDcwKFkY7MBbD/q83w2Lbq
 kzQimEGc08p2Dvf/DQ/Uoo+83qnzrH3ev5yR89+lX0EdyI2ArbMlOAXUQ/LZEcOoB/32vqe
 aD9Tot+oa9Wfzo9ZAfR7ZxLh55iDzkxH34J5xmf8UzjjRoyxZeF4jp2bsNREupStXC/XaG/
 zvOoF820DZCkAKQynzgAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IjiTpc+qpWc=:OZWwq/pQGGZoaeEu4igBWc
 etlj/vRPgo91s2wJF6y0CfqXkNskvjL3OC1YEu3by4rH9GVssqX0tKIG/5Cv/lQhGMtHud+s5
 +1+0Nf9xKN2Q3Yi59klEwXstsXe7QH7nnNzJ7PfYr71RQdHKBA2UwexvHMxylW3wuyfre6KfE
 OzzhCYwDl0yi+lz/kKdh3LKhVcjwneX3m0eBJ2YRqIv7H916QOhmrzeri/qKkYXajwh+YItwp
 KMe+NmAjBBee3Ju9HYwLhxGR5HcwDST6ltaGmGYAbSezsLoqpOz+Qz0tW8MC9BoHI/fOyxLG4
 J6alb7MvtXwgrGcl778OI7gGO76gNNTej9VbDN5YdgYI7ZVf0lKooiagdaILSgRhDB+KPCwW7
 ae9crXDJ/B1a9kkgYYmcmVdTZjp7OcZ2c1a+1qLAw/1nGcfSFPDswPR79XfW+CWt9g6O7qD8a
 pVIvIEu/6mBb7laPUZQzNYJQGkccL2iG+OclLXnTckmcwcXv45f6cL86QsssGB1u2JG9HcHnt
 v0b/eR9abHjyxnQBf3D52U7Cr2Rtnt4Az1NcJ2r9c24mnrxlDS1zu/HmrzkytSpyx8pPKrsKo
 8GtWoX54L5NQII6V3yIUlbx27wy0iPiek1HgHVdGjv+4UVeCvznloPP1nUrqmj5/d83jS9tT0
 i8dO+XnhVNcQBCf5247jWMeSON51vN4I2g6Njby0OA+K/I3ssFaByf+46xyY759le5JwBeK/f
 qNUB6v48MW1Acmu0AEol2JV5eA6/DwCjONFa7dgsX8eZPEc+DGeW0aNFNojN5yDEjNQSRbzMr
 +9GeykGgc8MZiSxFUuufRld7PGSuQlzIII1NBXdCxzQM9waTb+tgUM3Q6ytWNyQgUib/XGs
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:50:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

For being able to compile with -Werror=implicit-fallthrough we need
to use comments that the compiler recognizes. Use "fallthrough" instead
of "no break" here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20201002171343.283426-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/test-char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-char.c b/tests/test-char.c
index d35cc839bc60..9196e566e9ba 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -70,7 +70,7 @@ static void fe_event(void *opaque, QEMUChrEvent event)
             h->openclose_mismatch = true;
         }
         h->is_open = new_open_state;
-        /* no break */
+        /* fallthrough */
     default:
         quit = true;
         break;
-- 
2.26.2


