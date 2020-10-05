Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA72C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D7520674
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3hbgO3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D7520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTAB-0005Tm-WC
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSq3-00042K-L7; Mon, 05 Oct 2020 11:55:48 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSq0-0001VG-Bt; Mon, 05 Oct 2020 11:55:46 -0400
Received: by mail-pf1-x443.google.com with SMTP id g10so3953334pfc.8;
 Mon, 05 Oct 2020 08:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S9CFILtwnTNoYWDU+gcG8nfY+MVQ931Y5dt22FE9Gcs=;
 b=m3hbgO3loBDK0JnQ0Qd7lKDWnEJIeQsIcCGGE0oO9kQrtImkPxkqligfc4FNAYrFMX
 XMBBrH8GJkj9MrgPETfGqEDAx9g559ZxwXdWVBThY1E15xxF2PZPo3xDdr2bszyOm9Kw
 hzvb0L0W1RNGIh21GsPSJX42yelhHctRGapfufFvppPyj5mcRhLoqwnHqDCBh8xe3502
 LZRMdYi/iisuCHHlpIV6FKP0QyUiI5yxJIgg3AagPzO6RXQo2aD06N3lfsok6kvxBfaH
 0I6nBUdwCHIhBlLZ/hHVqZUguNdNmD2RezUjg3orXCzcyDr7lgMzQHm1UywLSn+2sy51
 WjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=S9CFILtwnTNoYWDU+gcG8nfY+MVQ931Y5dt22FE9Gcs=;
 b=ZCVgGK/hLZVZxHhMVqpTPwpX1qfN3xQ1FtE6fWqMy7w66xTE+iAehsqXI5eOwhee7X
 iK3pYAFHzd4TzHeOAu0p/SUyYN1UbpY//8uu03GwU1/ZZyoZ6BMlDCGOQ/A2CnLNu8xj
 L+l+lBVIirIPuGIbpx7oWklrq88p3+qFgESeid5CHe3+dbfvuJ5hEM6GJtepi0EunO1B
 x4HRx0xghnQrfvTHgK7wqfgXHUhbv1LA6T7ivpU2IAMbthpPmJEqz1ipvaf+vv4imQf2
 teUpoJq6Ce97rMtcP3t+OI+e7k2kWKOP1Gnjc/P6zRu1O6ZflHhDfifjwqdBeY081wNR
 s/fA==
X-Gm-Message-State: AOAM531pzJ4syFtidC4iXjromyAOO7P5SmKJ8lErPln5Q3EDNx1agt5F
 cWUspbC1CLgAyIiftkAj/VXr0oGly3jQEQ==
X-Google-Smtp-Source: ABdhPJzDxzX87LZmCkuXLdnxeVc8LlTXn+CleH2NOpm5/QLi+CqR8ow29LVfIZjKQNRQ4z14/FSlZA==
X-Received: by 2002:a65:6091:: with SMTP id t17mr83503pgu.429.1601913341404;
 Mon, 05 Oct 2020 08:55:41 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u22sm34803pgi.85.2020.10.05.08.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:55:40 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 0/4] Fixes curses on msys2/mingw
Date: Mon,  5 Oct 2020 23:55:20 +0800
Message-Id: <20201005155524.442-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V7-V8=0D
Rebase to master and  resolve conflict of=0D
*configure: fixes indent of $meson setup=0D
=0D
V6-V7=0D
Update the configure script for=0D
* curses: Fixes compiler error that complain don't have langinfo.h on msys2=
/m=3D=0D
ingw=0D
=0D
V5-V6=0D
Dropping configure: Fixes ncursesw detection under msys2/mingw by convert t=
he=3D=0D
m to meson first.=0D
That need the meson 0.56 upstream to fixes the curses detection.=0D
Add=0D
* configure: fixes indent of $meson setup=0D
=0D
Yonggang Luo (4):=0D
  configure: fixes indent of $meson setup=0D
  curses: Fixes compiler error that complain don't have langinfo.h on=0D
    msys2/mingw=0D
  curses: Fixes curses compiling errors.=0D
  win32: Simplify gmtime_r detection not depends on if  _POSIX_C_SOURCE=0D
    are defined on msys2/mingw=0D
=0D
 configure                 | 53 ++++++---------------------------------=0D
 include/sysemu/os-win32.h |  4 +--=0D
 ui/curses.c               | 14 +++++------=0D
 util/oslib-win32.c        |  4 +--=0D
 4 files changed, 19 insertions(+), 56 deletions(-)=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

