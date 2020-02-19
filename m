Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9953DC34051
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B5924673
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B5924673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MWW-0001B4-HR
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPu-0003iU-Vk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPt-0005V8-BQ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:18 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:56387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPd-000543-2c; Wed, 19 Feb 2020 05:17:01 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MK3iK-1ik4d83kmE-00LZU1; Wed, 19 Feb 2020 11:16:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] mailmap: Add entry for Yu-Chen Lin
Date: Wed, 19 Feb 2020 11:15:56 +0100
Message-Id: <20200219101612.1033925-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xe7wKhpW7sXLoo199dRB/P1e4/7TgICYuBSsWrRJup5IcV/QJDq
 a3CtbgancMWpc6D9W43PZRdAidSaEqYjrGaO4EZABDLuWLwsZGVSKhanQtrmHNUkoSY71Yw
 X+7zg2yuL6+yQzXjWqm4g8ZhUAo8qffqJAtPZOMDtVxO1JY7tHz68pHonIULRpI+U9wIyBt
 GcBjEZwc7K2b2iiwySwdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zqlyOD3cVig=:l34FrFYAmNKubln+sQibfc
 nXhE9k6YREHjSeSHnh4MWVUiIXIUevjWujFUVpGLzOhtomdgDjl9pDfDrEWGGcxnZYPGz2klw
 A//D1MYnxLZb0Ay/u2BpAI45opHZPxf/puY365Ns0yQMyGck69mRumDbRi7qd759wPVtvCL8q
 Hrg+ofqGj7v+oFcaVRXOUtsj4yas0TIN2wMRzxEv6DjSNRIaa8xXWv9+KUYgNimV2+BBHOHZs
 3vt5fczORZqIeUisPGwZUeEYr2rWbN6A62APLezlVZB8Fc4fP/jXWU6i5rOumcJxlvosbsPDH
 hEnVjem8OdItiiBliC2UOGjUa9AW0ykME1aNrQD9c3vpZFRLljALG/ls6rPT88g1DBTILJ7iE
 UosapGHp263xeQj2mWwCpZyzQVZKpH65urLNOwHhWWcqoVBNQ23QPoJCfflADQElXKngsCLVs
 c3HMxrosmjkOGA+XmqADp3QA8QLSIIwbY4JaXxyzQUTCV0Au0iE/+jdlSCZQ8k4FAq8ECMrpJ
 c7k64HtgDklPEbHEpOG1USZuGfhkxDsMms1t/SpUNuao1mMMKDG5gpfp3pccRTv7X729zVgRK
 2q/TINmzLbrtVw2qNSdoC/2PDmeU1IdomReLLCuSOiCbMZYneiQxj9bw9uvji/eKErbuyboFb
 VoaUWrn199W8euBQzIS9a+TIp2S5EKZF0wnTtIz6+xcFVH7nV6HVwpdASnnTSZYq5JDbtymVV
 MjZuHgohszDDcHlKk1dN2dQZrybMitFg0QjCnfv0vU6uPoJH0yd641DUth01GIL7g96OScKnt
 2xLZegXgl5Mh7Y3xrKZmwVmw8t+VLvxafTDkiFlgJ6nSwD++/Gzg0MXJ1hyu4mjRxzwfTme
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Yu-Chen Lin <yuchenlin@synology.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Yu-Chen Lin <npes87184@gmail.com>, Thomas Huth <huth@tuxfamily.org>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yu-Chen Lin <npes87184@gmail.com>

I have two mail address, add entries for
showing author and email correctly.

Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Yu-Chen Lin <yuchenlin@synology.com>
Message-Id: <20200206125504.7150-1-npes87184@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a521c17b4430..76154c7d8abc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -152,7 +152,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
 Xinhua Cao <caoxinhua@huawei.com>
 Xiong Zhang <xiong.y.zhang@intel.com>
 Yin Yin <yin.yin@cs2c.com.cn>
-yuchenlin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>
 YunQiang Su <syq@debian.org>
 YunQiang Su <ysu@wavecomp.com>
 Yuri Pudgorodskiy <yur@virtuozzo.com>
-- 
2.24.1


