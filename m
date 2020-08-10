Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8185EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3A3206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DZcNoYKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3A3206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57sl-0003pG-DT
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nd-0000zv-TE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:13 -0400
Received: from mout.gmx.net ([212.227.15.18]:59033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57na-0008GU-PX
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065887;
 bh=WOmbPSJ1IovLaHobnoaa9ga8qpoZn56dcothAl1FiBM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DZcNoYKAhr7fFtZSuuP0WzRuOGW5iu29qXZZ8KIxw7S0YWiPovPoNvvAvM+UaxA5e
 pEApVa5E7QZvthvztBSgTm4vD0rAjdWb9LWolePrETbwagxt4ESJJascezrRCkRAN6
 doRmmB9btlEcQQ03D3flkqUne8KchfddfNKFQXjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1k6EFm45rw-0016Im; Mon, 10
 Aug 2020 15:24:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 08/12] Revert "hw/display/artist: Avoid drawing line when
 nothing to display"
Date: Mon, 10 Aug 2020 15:24:37 +0200
Message-Id: <20200810132441.16551-9-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FSLJL8fni5LyydvTm0rgWc96QgpkSmsBseMxLySOG5nFTANsFKO
 SWDopwtH4wuCyslENQxlv3uDVZMnfe7GpB+RLoMONbUPrXsJgTVherFIv0Keoyh30wo24lk
 W2tPH3FKtYbT2KJAVILtcLxxiiKJ7xS96BAR5GLVxLkDLlefELk2JvWkd5Ddi4gv+R2jXKN
 MNznQooF8MFQWRHJTR6gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wsySTu7L3Bs=:MHRRHCM9YlsDFvIVWVusmV
 q8XRj8MjQiWCzS1SmSZbgvKVablzs9j7JxjCVoz9GGYWB0a15x2m5nJXdffPVIMwXHPUkDcgq
 fLTKWmUqPpaBOFKUyTj96hLbmta6RhengxllEzAmtausYLlFoCczk7OhUBoU9V4znSyV+uXcW
 uFX2DsE7M8ymG/foeMlTxTmq3lnXD2Kk5OOiO8jH7ewzfMvt0bEt1xSKivb5kD8tOjpNOyMXm
 hewhAo1+bZAtmYC1SKtV75oQ3yUJRDRyk3Mme7FPSx0FI4ft+o5IjAtSulDZSbbj1Gje6NS8J
 gmF6wnbTj0xbw1j7qTbAvSDQHHWHwcMETQUM7wnBNCeGpjB+JBUeDRZSEvSJT697K/4I8ijCj
 tN6ol9d7FXSoVYOgfqGFR0z3CuIeK5jlAILn2KcKqSwhp6rBB4YmsrXLsUVv3RqxYIfWaD4jL
 J8FDIXq1OFRf3HvpFTvXxezHT1oAA3FlShIAHwXTZybPiEGSuzfHk7RFEOr6GdCAUFn1xrYa5
 8xmiP7Dg10y2vfZzq/iuaOIDXZArRYr+wadst7Rawvluh7fgmKBshnipbiXPFdKFvszTOVp33
 2niCKHlTzvmVdWKPfeKIlWuHbSEzCvwmqvmmodxPMPS76E9ZpBdgQnuKEX+YayL8nDPlB228Q
 Kfk9GQ0pQDChwJ3n8irXzuBYm8aLUNyHEBAvw+ZcQLz0YZtHljf7hLWRakQAxoal+f05ilkIB
 ytUtFHRm2jTDYsIv7nGAoTJ1G9Ux3f1vB6gFU6b0MNhSTYfcecyvLba+RTV3nm2oonThLn9ZQ
 hxQFPVYoy/gS99ikN+yd4ozzjxXjKp0cYMd3oY99fkbvJ1brW7S1iCy9xs25cIWopV3vi+0Iu
 zaVQ+Z6Lk+sl2bk03bhh39dhqEB8Fdhr67v3KRFr2yJw3808EATv7PrVjTrXPoaD6EkoWEQMy
 j29AjJA3FJabHHbeMS9tr7rRsp9+T4bOmJhbE8LwT2GHyFjmGLL8/PldNs4Kgy2xoDphR1JMZ
 jqWtE6RqHUeNNgOk0BGCb5QxQEBMGJlLHrMo21Hmry5jIUy0A+ldqzzHvY0zWgXdYFwY54s0u
 TF7MKzZzXx1G3HciPQH2F4uDQE0Q40B2W4/+6V0rUbNjERJcwIXB4rxnhhAX+82istcbs+T4P
 LfA3xhIRIfFCMo1zR5ICnKz+Da98FrbeUV6eqRVJcS6ajEfhd8/H+7e7JSeRq3Fep77CPy9u0
 PFEK4Cq5QmxdIH3/4
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


