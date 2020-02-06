Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9146C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:53:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90D721741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90D721741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgf9-0007QB-Sk
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgcV-000117-Ug
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgcU-0005xN-U4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:50:59 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:49843)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgcS-0005hb-C3; Thu, 06 Feb 2020 07:50:56 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1jQntD2g0A-00ij6L; Thu, 06 Feb 2020 13:50:41 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/bt: Remove empty Kconfig file
Date: Thu,  6 Feb 2020 13:50:20 +0100
Message-Id: <20200206125027.1926263-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qm7M2ETIRX3E62MLU0mLfzXlt4Y7C03B9CVA2gYLENWp7ZrDQEK
 HCBWpVctb8wVo5IHey68DtRnxWRLjdMUm8PUE8hAoLNqqLiVr7HP9vLLizNahZ2zDwchKfB
 zFCX2Nz8kzbI6GpYV1QFPWRHrAGZkYs5W3trArnpjdpvXJ4Zit1rNoQxyLCJvol+Ns/bvMh
 0U7IU4s7CBUu5+Mk4E71A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pn1RWsTAIA4=:94iC5nl03/nWjYeMzRXWSL
 zdbBbsyQqzYqZ/Rirc0H0jQBM1sSa6ufqPRvGm/ohBb5a4biOajt/mo1eW8fPaKBlHpKpeNBH
 spkAVBLq5WXNt+53bqSTlkJVaiq8n9IsUA+YGo4vZPqrjatvHijX8MBqOlXA/NzwplFLessDW
 +VPh1AmoyWiNfsQWQUNqnyDjf93KGni3XxDLLeUn4rsJ+bp6yW84VDyQ5oq2NPmOv4ZvnvMwd
 A221/aWvD98itxkPGQFF1zKPgsFLK9gyh6Pq2KcVCYheyYH5eK5zXZMGBf60a09o5qd2TzqYa
 FR/vNvMJbjWFXgE2MeEeqTA+SbqXPxoX+QPAvmLD8IASMyEEnKiOKhCG4a1NX2xjUMR3pr9Ky
 GYnbuolJ+xACBkppqQ/IlYK9dTfM69w6P5a+7V+qhzNJVz43b/3X8Z2kbZTXjyKDA09IxvvX5
 0MbQaSxw/MAyDJEVBhWzFL9zGMgE3GIDB+TiayTh0u7t2nCQTsMcoUi0PWe1RKkAzatjsT1sf
 C/e00pT9UVblI4zLrWhhiV0yZAt5tq9uZK7jmtOaSEI9a88d7jO52zU4D930P3pivESG/oB1c
 /1E5JxTwZNayeRk6dl+vFSn5dYk4Cf0iMTil/g1mo2Sg8AQAi3jxc+rgWx+5Dkd5LbQ68FlW9
 nDQ0xfhsu3SGhMEwD4PVXLgldBsBuByg0UiJ7BkdP0e9VFLYQXRspUJHZCHyN36qXQYOp3AWJ
 2ncTtiHMcE3DJ2Wfl+TCxY39KeV+L8EPA1QsTRxXCum4iSJP7epmbrVA1jMEmsz/V+qj1pBEt
 OrVnnHRQ60q+IuHCoVKT/C41JOzwquRE1rRwSjBiJCiS/AL2IgabEOoIX96d0aaajtf/0qC
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

While removing the bluetooth code some weeks ago, I had to leave the
hw/bt/Kconfig file around. Otherwise some of the builds would have been
broken since the generated dependency files tried to include it before
they were rebuilt. Meanwhile, all those dependency files should have
been updated, so we can remove the empty Kconfig file now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200123064525.6935-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/bt/Kconfig | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 hw/bt/Kconfig

diff --git a/hw/bt/Kconfig b/hw/bt/Kconfig
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.24.1


