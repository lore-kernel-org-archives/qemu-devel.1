Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0FC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:42:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45666206DD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRx8fBDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45666206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPApX-0001qL-7X
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAnr-0000tX-N1
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAnp-0008NU-Nr
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id z22so507991wmi.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p/+UFJ5tcX1x4IrUrs4JVRko4rLWEYX7wuvXqdP/XvQ=;
 b=XRx8fBDtNixUdPAoTHm06hfCWyxWSHTE50J/49B+SS++GcxeMf8QYYPOmGwBrnGzcV
 7prQkl3t3CEj0TzArNoGvpL3JGaIGhyih0gEUAMHzHFxyrxwh67xKxg1Iq4ZKhwgTuJ0
 wyClS3VRtIPHJZvZqbYtzyZTJQ1VI8U9ptoIsAW6T8rDbHLtxZLU2/5BvVH3R+QaVNtm
 yNbukNovuE83JjPRM3PG17f+WshHBOPDH+tliaJLz4v6XZYnNS9OJdgDLXrLCbmKOgcc
 mzIAn7tjvW+jYkfwa+X02mTdqbe3+OMaIQpYgJ135s6TPV3siAXlJBj/i9vFkmOZSqSj
 pryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=p/+UFJ5tcX1x4IrUrs4JVRko4rLWEYX7wuvXqdP/XvQ=;
 b=lxk96R62od8m5Xwh9zx/wQIulPb6vXmry5bH2nRa3091dWS2KT6hCK4IkvApRBBlex
 ulOFNRJfMEVFYqDKk2Hx3OFGqoScfv8hg6X5u0GY3+oVl6Of6iZEuMYqu2CvfgyVsLHI
 NgI0wwaDG1QTTZOkxjPSDqyk/MP0BqB0lu/TnTJT0WqtMEt1DQPYKZjg/O4n7pwe5Rek
 IKhtLjo5g2QrOAZ8l4XoK6rZw7PoULrT7LQvuwZA8wmpQk06pxdSt4ka6nC5qAUKhpXl
 WpxpPame4GhsRA6VEWTsTb0LgTjA4yJvrHerQuIoLtT5qE6T/1yI5DVQ7e/TD512FyJ/
 setQ==
X-Gm-Message-State: AOAM533gf9up88IeXK83TeTz24OPGCGCbhm0cn4XO/QE1ztmvWoAY0eL
 exQVWCqAHCcvWl6ctyxMOi6TL84h7Ac20w==
X-Google-Smtp-Source: ABdhPJzOld8x6t0n4Z/bXGdDazc27ssLhdIgTWMc7a7p1ak/Fla/pRH1Jhd/ht5pBVcdXz30wVM1qw==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr13483313wmb.32.1601844015891; 
 Sun, 04 Oct 2020 13:40:15 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y1sm10245424wma.36.2020.10.04.13.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 13:40:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
Date: Sun,  4 Oct 2020 22:40:10 +0200
Message-Id: <20201004204010.2048608-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004204010.2048608-1-f4bug@amsat.org>
References: <20201004204010.2048608-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Mike Ryan <mikeryan@isi.edu>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Vince Weaver <vince@csl.cornell.edu>, Xinyu Li <precinct@mail.ustc.edu.cn>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Amir Charif <amir.charif@cea.fr>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Alex Barcelo <abarcelo@ac.upc.edu>,
 =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>,
 linzhecheng <linzc@zju.edu.cn>,
 Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>,
 Dayeol Lee <dayeol@berkeley.edu>, Zhang Mengchi <zhangmengchi@mprc.pku.edu.cn>,
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>,
 Brian Wheeler <bdwheele@indiana.edu>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Christoffer Dall <cdall@cs.columbia.edu>, Colin Lord <cdlord2@illinois.edu>,
 Gabriel Somlo <somlo@cmu.edu>, Alexander Bulekov <alxndr@bu.edu>,
 Fan Yang <Fan_Yang@sjtu.edu.cn>, Fabrice Desclaux <fabrice.desclaux@cea.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9sar=20Belley?= <cesar.belley@lse.epita.fr>,
 Akkarit Sangpetch <asangpet@andrew.cmu.edu>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Timothy Edward Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributions from these academic domains.
Add the entries to the gitdm 'academic' domain map.

Cc: Akkarit Sangpetch <asangpet@andrew.cmu.edu>
Cc: Alexander Bulekov <alxndr@bu.edu>
Cc: Alexander Oleinik <alxndr@bu.edu>
Cc: Alex Barcelo <abarcelo@ac.upc.edu>
Cc: Brian Wheeler <bdwheele@indiana.edu>
Cc: Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
Cc: Christoffer Dall <cdall@cs.columbia.edu>
Cc: Colin Lord <cdlord2@illinois.edu>
Cc: Dayeol Lee <dayeol@berkeley.edu>
Cc: Fan Yang <Fan_Yang@sjtu.edu.cn>
Cc: Gabriel Somlo <somlo@cmu.edu>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linzhecheng <linzc@zju.edu.cn>
Cc: Lluís Vilanova <vilanova@ac.upc.edu>
Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: Mike Ryan <mikeryan@isi.edu>
Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Vince Weaver <vince@csl.cornell.edu>
Cc: Xinyu Li <precinct@mail.ustc.edu.cn>
Cc: Zhang Mengchi <zhangmengchi@mprc.pku.edu.cn>
Cc: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
Cc: Timothy Edward Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: César Belley <cesar.belley@lse.epita.fr>
Cc: Amir Charif <amir.charif@cea.fr>
Cc: Fabrice Desclaux <fabrice.desclaux@cea.fr>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with the entry of your
domain, please reply with a Reviewed-by/Acked-by tag. If you
disagree or doesn't care, please either reply with Nack-by or
ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
One Reviewed-by/Ack-by from someone from a domain should be
sufficient to get the domain included in the final patch.
---
 contrib/gitdm/group-map-academics | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index c7b0dd46a3..fd42bb8069 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -11,9 +11,17 @@ ispras.ru
 pavel.dovgaluk@gmail.com
 
 # Columbia University
-cs.columbia.edu
 cota@braap.org
 
 jiaxun.yang@flygoat.com
 
 artem.k.pisarenko@gmail.com
+
+uni-paderborn.de
+edu
+ac.uk
+edu.cn
+edu.tw
+cmp.felk.cvut.cz
+epita.fr
+cea.fr
-- 
2.26.2


