Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B162FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA00207C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA00207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtBxS-00026n-R0
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwJ-0000jt-AQ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:41975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwG-0003rk-Nz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:51 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYNeM-1kOSK631Ig-00VLzq; Wed, 08 Jul 2020 17:24:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] linux-user: fix print_syscall_err()
Date: Wed,  8 Jul 2020 17:24:33 +0200
Message-Id: <20200708152435.706070-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fLcC9BCfeTyot3W2W95e23GqUQ+BUR4MvvLFLNcJyaE3SuoCcQQ
 7iFM6FMZWksTTYpO++voz/6y1uR7iETRerFi1FRBweue1f52CZaXw0QsZdAsFtNSP4y4OiT
 QcMFPVeMw8fs6SY+i4B7cLBqNteGPU1GUEforsm+1vvDwStebFzNUyaR1HxLAU5WAzFA0uA
 FYBkcCadt97lpUd9uTARg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IEnEzrYY+Hw=:NaqVEgwG6j4UF207puxNTU
 /Rzfx7y2s/BczmFbglhcYqz6tMsqKwcmcGuzL46qKngCXHg9DNZ6lEqcY/wOme9PG4ws3+dGC
 wlBG6seibCHklU1tGR9Ag7CwkzHvdbE1tlue1DlHI9m7swsBl6Wbmk1jVaYD2UNxCDxN0/u/c
 OmRI7nsotzJ8cbqmYqhaGh+M/xkXapcuNiZCY00qO1gUxu3bj+x9pZMGRxMQx/Oxa+yV0DBW9
 gqYJo0owjGN/7mbBjAQezZpDXvD9bxZPArwsTDYoXXbY+UNiUZN9KMKFLL9ladv0a3fOA8YXr
 E+I8nQd5H72MF95sxbaItlBSbrRMFV/tVWM8dP1Gl9kdTYiWzY5dIfZCaSSAzBdQ0Wm1hf5+6
 JnV7u1L3K6znvbyh0Ahup8i21RBvw3Y8qPyEyncI/3b9vqvqwA5uL6rvMSMmdue67to7frvGi
 n3Jq1olo8KfIGz2H4LHNGxPaG5TWO0Ea0Q6h19SP/1xsIve8bOV6aVe9YELmyzKgQG1/akotS
 7rdg0LFydS4QmmjnK0e+1YXmsE4TMMAFWlQicgMNfy0PYdY3g+ZU6UD0D+HGC9vfSlQIqPAw+
 PbIStpIRk4D5XUj1F+B5T7Hgib+LNX6QAUac7h61x473eiSvkfkKSy04ac6nEz8jVMqtMfTxk
 582mMxKX30zeoJr73hRa8cUGVkHAkwSJYfU+CNT1hwycjsT7UZ3CGXxtohsBIhz5UVDYamV8W
 kbaiwKx38/O9eLUjdPZ6T21EvwU2dfBbUk7N+C26KX0Ej3Qk81iGHJlZGybQHfrX4ZGBG4uuO
 M6n0QYeSr2z2Y0SFnHUw60BpV04blvvJR1YPsqAjcnP11ruEoy5pTpEmQNuMkYZA4FqQAMU
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:24:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function has been introduced to manage in a generic way the error=0D
code of the syscall in the strace output.=0D
=0D
But it has introduced a regression regarding two previous commits:=0D
=0D
2a7e12455c1d ("linux-user/strace.c: Correct errno printing for mmap etc")=0D
   that intoduced the use of "-ret" rather than of "errno"=0D
962b289ef350 ("linux-user: fix QEMU_STRACE=3D1 segfault")=0D
   that checks "-ret" is a valid error number=0D
=0D
That series fixes that.=0D
=0D
v2: add the patch to check "-ret" is valid=0D
=0D
Laurent Vivier (2):=0D
  linux-user: fix the errno value in print_syscall_err()=0D
  linux-user: fix print_syscall_err() when syscall returned value is=0D
    negative=0D
=0D
 linux-user/strace.c | 36 +++++++++++++-----------------------=0D
 1 file changed, 13 insertions(+), 23 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

