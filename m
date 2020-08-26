Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D18C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DCB20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EDJv+9ZB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DCB20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB305-0001WE-OF
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k7-0008PM-Cj
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:58637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k2-0002V6-Js
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476431;
 bh=WOmbPSJ1IovLaHobnoaa9ga8qpoZn56dcothAl1FiBM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EDJv+9ZBAf2dikXl4ESGdgTkQGpACSf2XGCOFlSwTpiIVnp9p4NLf4qbyvH1K3aOI
 Y3exqD/9c827c/4H30L0I2f2y3SlIh7Htp10GdZRvafKsswzqlUGhfrlG3O4QIcnOX
 b7Nx5JuH2LZ+InNLfFW1t7Uh4MXd/ErGJzH8xkxE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9G2-1kvfyK3dby-00oCmj; Wed, 26
 Aug 2020 23:13:50 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 08/12] Revert "hw/display/artist: Avoid drawing line when
 nothing to display"
Date: Wed, 26 Aug 2020 23:13:41 +0200
Message-Id: <20200826211345.14295-9-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d51Jk091MHy0/uWiAvsPCMxV5KgbRoHY+vZnwzS2JW5OCyaxnhO
 Eza8yfR1MgljjIOIB1L8BRK2oE3V9A12reouPPfBzhU1bTFlwXxqLBZ7hLUlbR7A6pCDWqt
 onkuXZClDKT3S7iV+ZegTDM4+Ltp660r0fVfJ9ijKFHghuUd42VMfljeR+zROYTtqr9nUIs
 9RfqZknpSQM5b2OvlMqeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U0iJNkCBwKM=:SyUI7T0s0fzUU9Rqdm8d3d
 +snLy+Eso6T3ASvrz5AstxfVmko/vN9hP88Xr5AXFJNZEQmRjpFpNwuMBZegazYf7ckF7rb46
 BpS+hJRSWR6J0g+OSWA/ZESwfDOgH7YmKCW9LKX+7RwLuULeq6kekAikUkVL+SZAbL/Km4n8x
 ilzOf3cBOov1FTGM7kH6h0neWJ5EfTqxk6yD7uq+6mGv7/cWH5uhPAUnC90fWConvoZNXpNji
 n97lNjaqZv7F2gYzzq4yigcg4FZ9Jog6sJMgFLxSLsgeRjr2fsMIGcwBn4GGkEatmbLSA4E/L
 z2Awxq3FuVpn5CJORXNsM4aEUW8qsTJQLTDcm1iMdRpBR2Z0oq5m96UcOA4Qh6x13+49MVmB9
 2t4S3OomBpJEz2JF8+5P06ZCSauGyxVp3q2JQTpprH5t29GrosYhGzVBdyvjxYRo41s3Znkz2
 wlUrP6g7LxubmsSxaBMbNI2+KpmJmpEwTotF58DpK4LPq5upKU59+ZjHpaAkHKO7tsJP/7zsb
 nwvXyYA8+D7LSzcbjjWebrA9cSjwGtmlZQOckkQrUx0PSDlIXZwvFGUAErqJF7vbSlggq0aI6
 7TsyUDixX6fFDlfc+v6Coh66UorRSKG0mdcrmNlTaTM1OT5P5sdCHXK5XR9Dfu/K46jtx34K/
 FOmLyOBNeOiugWBCDHGVqpeY4ISkJTM8VivJTxiNbyp8lhW66peTef0ITGvj5kRl47Qp+D1gt
 0svxkserlN7uB32e2c8xaY78i5k4ZPiF9SuApBru86DRHX50kynoAiG7YfsiT1gB8K18QwFBd
 e75TFG1H9nXq1u3RgFf1ik3yTmXhiFBd//qlJKL/BZqTVW6j/6esScQ7FBGR+Tjoeb41wW6MG
 TtOnUZjlRdt5IXXZtNlCnwF3tq3+4ozNcwRg0qHOX1mwWJspOX5y6MXLOz/bRoTW+9l3glXqy
 eEBWXVqbvoRsu9OyQgfiLFsiMPmEpzvtYIiIJXu8xlVZkFpxgWPUUlOplt/8m9Qa9QtMLnPHM
 20a67xRsaBTTKz+0L4k/w1vUYfVxMNMQqHMwGy67JXMGUQmI0MlAVltyTofc8d2X6f0w2sBBW
 gWFiGhK7ETJ6Zq1Or8Rzq6janHhokVpKbpcX+ya3XtyEuZD4JA1F1HlB+xJD0d8IvqZdwKODM
 tebWZQseRyC2ggVNeM1oda86QBjhY60zaICqxJkbCVfH7ILOzu3+wLxWy/i42FeqXy/9TPyua
 YS2sfvs12vRdV427S
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:54
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit b0f6455feac97e41045ee394e11c24d92c370f6e.
It's wrong. A line could even be a dot.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 47de17b9e9..f37aa9eb49 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -591,9 +591,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     } else {
         dy =3D y1 - y2;
     }
-    if (!dx || !dy) {
-        return;
-    }

     c1 =3D false;
     if (dy > dx) {
=2D-
2.21.3


