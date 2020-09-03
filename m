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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4569EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04E972071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 06:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cm7dTlKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E972071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDiUm-0001JO-T5
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 02:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiRK-0008KJ-57
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:09:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:47345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDiRI-0001MB-Ce
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 02:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599113378;
 bh=ZxN2CjZ8yqbtZ4X6rd5Rct9kPLP/FvAVNOK4psdJS5E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cm7dTlKXKFowAqU5odvVb534FIsKrNe18melq4H62ZrTRnF9TrWuke4x/LNdI9Rm4
 3aYGNj82M6VIUnnWnA/9UhIXV3WyQ+8RdFlQbfkOcboAR3R815pIaEs1gxTbMEKaBG
 E6laABBVO3fSYzuD4BY3bPaGhW2/jGgyBF9C1Bo0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mwfai-1kTbfU1PdC-00y98w; Thu, 03
 Sep 2020 08:09:38 +0200
Date: Thu, 3 Sep 2020 08:09:36 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] hw/display/artist: Fix artist screen resolution
Message-ID: <20200903060936.GC8548@ls3530.fritz.box>
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-7-deller@gmx.de>
 <65284ae3-f0fe-336e-a205-0494abb20f08@linaro.org>
 <20200902214819.GA2424@ls3530.fritz.box>
 <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45bf91fd-4e7f-7379-18a2-cdada67a3f6d@linaro.org>
X-Provags-ID: V03:K1:oeb7u7Zz1pdIua5UMZeNONAXw/y6W5L5yCvBsNRuaUVzDMpSbBE
 HFbSMekJNVEei2ONUXrqzFe+KxEedfBM7reoKykhQdXXsvQiz6N+ygcOQD98zwJU9f3520a
 IJbLUWbmyhpbV6VoNROX3MmJ5eksYIbvGNP4KGtWwxz6kCsp9Ufuq4FV7+uqaoREf1NtBF6
 mpWK5MXQ3BJ42QX4qzzew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mhu5CwDW/uE=:RDl47VLsi44WjhaErpmxhj
 mLl74MB5PQie9P6Zvtd8iSi9u4Q7wMCu6R9iElwHjp5Ky9hmdVrXhiPcIQcVYXuwiRa3g3MLw
 tFQXet5brHupaLX9wjh7jhTG21Z6Z+lnIyRlb7nt9tltAUqipnLZg8KU4FzO/fsLo0o3c7Cj7
 YKupeFSvFme/0YyeyLlwA0Vj/l8925hhM36BuCIj4Fvz4msDrBiymZh6bpXNCV2uTQAozTV6A
 DgpIrVkkpLBGkEeUDKXHGd0QwET9rUbwjD/rBVmZ7p8RuPzQCSyDTCGJETWx7LeeHp3DlwwX6
 mKfritotzt48i5Lit35/CPyBELXdtkZRWLWPkOJrr9jDGJTfkygyRQt/KuW/Pydf47ENloOkr
 5TvNt6lWDKZ6Q2Hoy/cE8BV1Sw8jRpzw8KdeSS8clBoUohrsYoT9q5GRm73g/LmZQrAqSzO/l
 /ph4i/r0LmXxCzbJeJBSyWRlEYV3fwDLMpfgPEAy6UilpeYMn0jFWiJje/FXwQaPfs3kWhGYY
 TyQ2nF2ls57py7cllg2tolOa6fTlzI7iPw6U4gE0ee3VpBxqZxNUHvkRBB+u0VU68gKPGvt4F
 m4OkjrGSoYmzmB4udOJ6iOk2/AgGv96aqmRBq7vWI5eYtO1tmLJzve5IP3q0uqMhxy7TR3prV
 b33Ce7yPWFDoKeSx1mpc7+o5toj3luF0KdQwXiaSGeDB/D5cYgqMp6RD4fQiPZS6KsFKd3OxL
 U2ds9MmrLV/Opqy4njiD6NiZfwEy154aRPUe7a/cfXiJq++VBxEKY4B4edZJ2jsmlYwOEkeXg
 GghAjY1ssgTUjcMyt2uWcU7I/zbaT9BAZaWz1WGTffK92aXgzH1gmRa4jh/TqkbGm97RAtVcx
 WyGCrCc5RjMWkUPF0pZR540IA943WuPSA1Cz901cyUPe8nd1HOOCUI8wNvuZmp2rhjK83zmoI
 Ojvf346BiNk8sJUs4NcVlQS7zjF5rZ7RFO9DHp1jca6blqla0pkNjIfD4Xwu6TFvEU8RX2Dng
 I3D9HonpXcgvdgrMG26hZoAfRq3DO0URCpzZvK+d1m9GOCQoHu1v5eWGb5q/ogYSOQJDJwqL0
 t++Wkmb13XevFFiv5rrL7TsjCCwCQaDpnv2+11q71Bxv3F6Y1s10Vj1rWTRYmScvzJhhnsTkN
 8ZAuZ3P/bpyEbIPTNYmKn/rZccdn+EvRoW2q64/O73GfcR4e3sn8caTB3CmOlomCQea6ApNf/
 a4DgVNsgZf4ctqYrf
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 02:09:39
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

New patch #3/3:

=46rom 476aeb9b832ae172a9d6a28aa9e43300dedd419b Mon Sep 17 00:00:00 2001
Subject: [PATCH] hw/display/artist: Allow screen size up to 2048 lines

Adjust the ADDR_TO_Y() macro to extract 11 bits, which allows userspace
to address screen sizes up to 2048 lines (instead of 1024 before).

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 16d85c65f8..955296d3d8 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -193,7 +193,7 @@ static const char *artist_reg_name(uint64_t addr)
 #undef REG_NAME

 /* artist has a fixed line length of 2048 bytes. */
-#define ADDR_TO_Y(addr) extract32(addr, 11, 10)
+#define ADDR_TO_Y(addr) extract32(addr, 11, 11)
 #define ADDR_TO_X(addr) extract32(addr, 0, 11)

 static int16_t artist_get_x(uint32_t reg)

