Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1F2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1F2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0fO-00062V-R7
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0007m9-Mq; Wed, 10 Jun 2020 09:10:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37667)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Up-0003d4-9a; Wed, 10 Jun 2020 09:10:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6KML-1iq5PX05ST-016hql; Wed, 10 Jun 2020 15:10:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 07/16] qemu-img: Fix doc typo for 'bitmap' subcommand
Date: Wed, 10 Jun 2020 15:10:02 +0200
Message-Id: <20200610131011.1941209-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fK8iv6C1HwdqQhd/VkgelztgmZ7yxCQwoDAv43kmXHdv0sWRPjY
 RA9JL+I2c0a7jdxDQbdasICULdQk1X8tMYW2Z5oX35UEEqwWRXrkCP9mVE2fR1khinotDux
 ps0FXEvEvCGoGixiHt9vUJk3E3qRnfjhIHzc3OKHvhBihPP5dPhujaE/4QHlEhNqEAoNmml
 sYBnb+gHwOci0/goFiP3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YbtXtnlVb9Q=:zP3khABMS+VslhTTURfDky
 atM1nzYWYeKVpKdsZpV1tKWIuj31z8an7nfJWQuUOjm3F4iVA8Wi3YH6D9olXG2KsASRKkR5p
 2Ql6kVXa/MoQy2M/Q8uo6yw8UpmFz/IVAjKfxA7XxTUd3vIvsamXg1jzncU1+Z1SmGcD6hof3
 tFf76ViH1PlFOlCKrV0DuC+Mn++eIuhEfa8LaARRE5PrbB252gQv2oCbYe3zAtgbeGpg/wtAy
 EJlprAJ8ViCJJ2h8NPRwmw+SiwT6LQ4h4xOGU8/neaG4AfdF+HxjGfd/6H6FmT94+8CaIh63L
 sih1GKIuO5vp6XDqccI2fFimsCHR8HXK9PB7ChzBB7xed5pLkHVKuaMqxsCxHGI5/DX1ryvmo
 hRreQB5knWlOIu/fjfmz0kRpmDr/iyjsyks55B88eUbFt87tw4GGEkucKBN5vcYwphc7Q9uRv
 HYUWzIJ8ajxjkV7zm43HxqAbWDIm3bL4uw2R0XQaFTrUDC2beXeapUzBEOm/69cHKq+5i8Fj0
 WcUFamYzoDaelnXawFDMfXNujhsA9lVDyWeITkepseqNMV+F5xqEKSKaqaZpYv9lfni+X7cea
 8ZfFYIFV9GCoAWqcaAYaeD7+fHyqaEU8ooGaZ2zpTxM3zX9NctwVoabgX8GLe/kP2kVqySGp1
 2FY17rq1amQCkw5ZAwWEy9xhy4F8ic7mfDL+QGMRk3qEKIRmySVoIfDsv4Qzz+aGpQB5qmkfK
 qbw73A7WU4uRShNvHUarNP29xPqzR3wFtapLWzN1EhgdbXPc1/eek5GMXxNxwNulu8rqRwbV8
 Wfwh9iqZeCKCr93loMqvegER/O7ZQfdVZy7OrI+WIbcZFXzPceNh8YwhvDZ6HfNByQRD5+T
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Prefer a consistent naming for the --merge argument.

Fixes: 3b51ab4bf
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200529144527.1943527-1-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/tools/qemu-img.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 69cd9a30373a..7f0737488ade 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -300,7 +300,7 @@ Command description:
 
   ``--disable`` to change *BITMAP* to stop recording future edits.
 
-  ``--merge`` to merge the contents of *SOURCE_BITMAP* into *BITMAP*.
+  ``--merge`` to merge the contents of the *SOURCE* bitmap into *BITMAP*.
 
   Additional options include ``-g`` which sets a non-default
   *GRANULARITY* for ``--add``, and ``-b`` and ``-F`` which select an
-- 
2.26.2


