Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B45C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECED220874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECED220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJi3Q-0002YL-4Y
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrM-0006Cm-5H; Sat, 19 Sep 2020 14:45:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrK-0001Mr-9e; Sat, 19 Sep 2020 14:45:19 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDN3O-1k9IWV25o6-00AWak; Sat, 19 Sep 2020 20:45:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] scripts/git.orderfile: Display meson files along with
 buildsys ones
Date: Sat, 19 Sep 2020 20:44:42 +0200
Message-Id: <20200919184451.2129349-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A+6bhBMoofjtXKS/JB+fhDqaqGPu2KXHJ17i68ULWgL4QXv03tp
 zIobRMpTJmNnx+vI0eCugUhvwBLD2NOHkl+1yNgPco3kNlhPYVsONYNGehGkcGFA2UThLzc
 96gsnO34xrZyGiP4ItRx2J0AUURnZHobmmH9HedaUIjCZlpfDeKIylOUaiO6jpIy9CdnHi+
 U2ewdp4RGhx4lHl6oDQgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y6zqzLSkU60=:UakqP4WPN9wUIwZxyyYNN1
 I9AW+zwa3c1qWEwqV6nf1YciYzQQyJkdVnD4JlK8j/acv5mVPJiRfnDGNaJttBhBrZAf3PPxx
 upETvTCPFSpCH+h3ds/ePd9L4N2jFF/+j+Yf8LKFhIrn1EgEZeraustYIbc9BwwhxCA1lFtPM
 F8tJpOV9Co7rJVmCcM+OkYCziJxSwPBB1Eql1O/hIkr6AZ0YiAPsVvsrnGcNZmcsm9Iekorzn
 Ib4S8uWcWPkz7M639mnFjNP7Jl+L7QLKrFaFNqh/u+fM5VcRFP3x02B2skECWkUREHefgUYRc
 TlLOXw3MO+S3WHQ6PQW266YygkgTSbPBYbrBTr7MuwtOQ2KCKb7Z7DHIgJFEJDQrsYF1ViYdf
 iqNiWjnzxlTPFjHxL+hn36nb/rd7GAwDjANfYQw1ycmDc9d1v5kwneicyZn6LqhuBDyV+iPo0
 bpa2Q6HAmvHKUFAhRhQ9spqtY7Fd1ABE4f3rbu575vsMNSWnK0lwdXjgoUUZ1AjixCf99TrRB
 z30JPnYO2bXuqPXaqtAh5E8kIKs5s34/m7bKiEV/y52Bm499SUgkZRCp67MfJKygUhxMFtrnV
 HnRQUtTDx0iV1dINhyWQxHhWb+n/pfsiVZ5Sg4SxKj5jiD5KiWNyVhd9umWTZig3Hi8G2Agur
 PJCo9W84rQ38upCKsdId27cW4CGtu3p9Y1t43xH7YBAp2vXsuPnRvEvmJOOrOrUgZmFj2uAv4
 /wwpyIHfJ8XqR4AfPKgNUAeRQPCwz8WluJuM/BU6ojS2YaISKuWHZN6X3/K3URPWkL0rbRd5D
 XO4zxT708YLBBe4vAsGfqVQg/YHhGeDEqdNvvg7ijE7Fl+nMCe/uFhLgeqVrBTZji7aMMyD
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Since commit a56650518f5 ("configure: integrate Meson in the build
system") we replaced many Makefile by Meson files. Adapt the
git.orderfile script to display the new file at the same position.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200907161222.41915-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/git.orderfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 73fd818d7f3e..a021afc2d517 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -18,6 +18,7 @@ docs/*
 configure
 Makefile*
 *.mak
+meson.build
 
 # qapi schema
 qapi/*.json
-- 
2.26.2


