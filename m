Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9091C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8192071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SDHDp045"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8192071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiSu-0000Eg-GB
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiPW-0006KI-4V
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:07:50 -0400
Received: from mout.gmx.net ([212.227.15.19]:36461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiPT-00017k-Vf
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599113265;
 bh=FnqMfc5eme204zT7diEvfvd2s2l1oM9ukh0b4AzbigE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SDHDp045xQunu+TZ2a5a7Cq3ga+i6Ipn2/1++fAhvpne8iL2yCsAnnAzb5Nn1QYUf
 QkoTx/ycCzepZcvLGA+dVfxiGDzGojgakzaWNchId/2SRpfABN6qyANpEXnAoRCGyw
 Ht0+E/L0OFgZ9h4wN+Uqin0/Wq21IWpVkj730bI0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1khNL33Jue-01332q; Thu, 03
 Sep 2020 08:07:45 +0200
Date: Thu, 3 Sep 2020 08:07:44 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
Message-ID: <20200903060744.GA8548@ls3530.fritz.box>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
 <20200902214819.GA2424@ls3530.fritz.box>
 <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
X-Provags-ID: V03:K1:Ia8R+7qVNKgfKo9RuCCSQHZPEvjE0Xa8z7O/p32GKXMq2rapVri
 dAhYxQIgtMNLR1hudNQpe9sNTubVe1EDZQq22OPNCxoHD1H8cRjeJgQeXeOiFdi9wHz5tI+
 rkUh4i1XhefD0TpVsUATA2ihrduVvjIaUUzyAtjl34cJX+da8ItJKTwTjSkrgtFc6OKwiAW
 KcBaoWGH74RApw0q4FMZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cpEcgmDJcDI=:3aLGIg5FJdliwVFKAuReM+
 BCXQhofYBAJn3+bnPdDjAp4XrxT+u0EJr85hn9aawM2k736dqW7Lm9d+YhjYN8KuA1h9TuGHJ
 GiU8c6AE1lrFjLFEPMt9sjYIJsi3M4CNE//G7fdR79ppneO5tocgs9J8RIRTFQeIjF0gOZaR7
 Hi4dh+92hkKPeT8l9vM+MDEMwMvaHwTu4JZuQoFa4IomkDk8yt0VfCyw5tMFpL+vDMQ7zoB2X
 K5duxQsslrAsCaQGw2cqJ46WAjDBKT7Gq5tcQ2C6gK9UBUWYk5kKeygpgPMgZNt22CFPMg/d+
 QD4A6rthAqTlSGcP4Yz9TrKHBCaxTP3DAwVmNZoo9Qhxr+F+IblNJYpF35JLcYiHVlBM5KUrH
 k2wdw4vncbVvkncRh2RI9Xnh/2snJ61qzmJaTFG//IMLzpXauw0tqjFK2adB0c/IK4HjlZaZn
 zHQ7DX9gXQQ7fcfs7qtDyrYUYG3MJv3cHkBAdg7lQ08zAjj4R20fWCyCE0jGmAJltYiAsgdZW
 3XnjGd4vDFUYq75BMiq9nGzkaZmXDpDmT+Fo0TIph63L/woftvZ5XrQAEuOPv+j1wIQ88zvsh
 iTvZHYJ8FyLHDNuOuO5hIpIbzUJp82dqRgXXxQ40wIn2oIu8xspJqZThUmXfwRL7GpGx5wMLz
 NfzR8YtLpXc//PPvrODZ4KfffVE+4jyIhQfrEDJfGdLFZlvHAD5yhbUt49BCyxfwX/Ifvxnc8
 DPfYJ3f38wF5Qtu6Lvqcp4qnj0/ByipUy7Sd6fJjuzcDiWjOlzKQ+75KUPIsednanP/7QfF7V
 lPhIU7bT2bfxh8A5Bizvd81R0PwMzHcT+H73jccULsBW4/8T2tX/BRYDtzZrT/UfyK8HSFRbq
 URVdk/1AvWMJsI90s0+wUQrXH/MHn0sYAz+WCJeZ0xqgZijBL3pFqTUUhSN2coqQF7HnDyy1C
 pJyVRiRXRc85JsJn4WhInMDJFjDPWTdux2/eO4PEj4bOVNE4tVQZTyepANcz8rV5wj/f8TWrP
 gRHYKY+v3LOFFnUM921eSrABnkWNX0FBSx1KpRHhQYs0YSBjcowmAfez5p1B59SdGdS1cmqkd
 O2a2ItVS82HKizomBRvXiGBYL/IFu9+gATmii97SLYbuhdH8NgKZ75/PmWW8mhqmLrzjTi3eu
 0c5OcWb0DT7Xr1mhv5McmdV/DeKjVnaCV45VcnbBW82EFzQRQBgCdusYWSQGtTBP4CskDHQMd
 Z+wxdkxc5AK8eAeRg
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:07:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

New patch #1:

=46rom 80ad61c2ba25ca608b7c1c1cf701ae8164219cf6 Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Subject: [PATCH] hw/display/artist: Verify artist screen resolution

Artist hardware is limited to 2048 x 2048 pixels.
STI ROMs allow at minimum 640 x 480 pixels.

Qemu users can adjust the screen size on the command line with:
 -global artist.width=3D800 -global artist.height=3D600
but we need to ensure that the screen size stays inside the given
boundaries, otherwise print an error message and adjust.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 71982559c6..ff1532fdc1 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1374,6 +1374,18 @@ static void artist_realizefn(DeviceState *dev, Erro=
r **errp)
     struct vram_buffer *buf;
     hwaddr offset =3D 0;

+    if (s->width > 2048 || s->height > 2048) {
+        error_report("artist: screen size can not exceed 2048 x 2048 pixe=
l.");
+        s->width =3D MIN(s->width, 2048);
+        s->height =3D MIN(s->height, 2048);
+    }
+
+    if (s->width < 640 || s->height < 480) {
+        error_report("artist: minimum screen size is 640 x 480 pixel.");
+        s->width =3D MAX(s->width, 640);
+        s->height =3D MAX(s->height, 480);
+    }
+
     memory_region_init(&s->mem_as_root, OBJECT(dev), "artist", ~0ull);
     address_space_init(&s->as, &s->mem_as_root, "artist");


