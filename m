Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A050C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B572072E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+zLAJ+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B572072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1bc-0001py-3p
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xc-000501-W4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:44120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xb-0004VS-8l
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id o20so5011209pfp.11
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjtM93cPfHXC/wpcKA/3KPJAzih780/GtMQx/utGEfc=;
 b=r+zLAJ+4qp9vNURa0kuTMTdE7TwaM2Pc7vY7vK8j6yaub9u8bvLzmsRzfdeJ8c/BSB
 LUaARnqZeh5D4xkwXb77ECFAU5cmc8r5eurRMj99nw6mBYcAKPLd9Foz5lRZT4Yl1NRI
 LNT+IMGoaJSp2pCEKhfrWA5hSpCxx/382QcqDyFEU6BaTsjwFUgtFlKAU/Myu4Zw5INr
 IQLUGp6nSCclQeGJAZ4PFRsr5ekbTwcsjEcamMkServDETYG2Etua4VpyZk44ctFFhS+
 W4B8+bvKByasd2fak0z9EFBfioaG/3a2/EfSjewGMQM0Sh72HSpdFxo8oXjm+xIre1DE
 syWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gjtM93cPfHXC/wpcKA/3KPJAzih780/GtMQx/utGEfc=;
 b=TSo+tiNlsbEeA60wWQyLPdSuCcyfPAgFyUZGphzF2h9vNTx25IHOCrTFAJiJbbuYrJ
 q1reBTq/EAh1y/0idrD5kj5BkR89I+PePDk9WUmye+Duq8kj6WZ43RQK26ALfNi+lfXK
 q1ojnuegkMiHwC0ikxsdgJnd914hQIvWsJYDqXFb7ZVabU11ypHHiSBqc5VvMjKHAYdH
 +coKAfETUM5KmK5twR+epR/SkNQhwbWJsgBNGS0nujfgeOk6rd/1tkkh8/1c0ibVsU6y
 zcA09wTQjAuEY6sVuvphtu/F+WaXzzxxzMLM2FKMEvEXuMOSEyoWs8xQeaYMZ/3by5eH
 uNkA==
X-Gm-Message-State: AOAM533Z+Ac/eZDdt6qc38NP3NJaapeXHaQU6wy0iybLSdUzjCxVY88i
 BwgIOlux4WsoCd9TskEWGI6jNg+t8mnVkw==
X-Google-Smtp-Source: ABdhPJwlsnvg8Zqlcdr8ZtggEGFdbp9TK7Y2PLqtsSxcP+v5KDfhTc5Gxv+co/dbQsHTAT/VJZvE3w==
X-Received: by 2002:a17:902:7005:b029:d2:ab25:53d5 with SMTP id
 y5-20020a1709027005b02900d2ab2553d5mr8009407plk.57.1601570084899; 
 Thu, 01 Oct 2020 09:34:44 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t12sm6946028pfh.73.2020.10.01.09.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:34:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/6] Enable plugin support on msys2/mingw
Date: Fri,  2 Oct 2020 00:34:23 +0800
Message-Id: <20201001163429.1348-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x430.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

V2-V3=0D
Split following patches out=0D
=0D
V1-V2=0D
1. Fixes review comments=0D
2. Increase QEMU_PLUGIN_VERSION to 1 for compat  QEMU_PLUGIN_VERSION 0=0D
3. Revise the loader to support for version 0 and 1=0D
4. By export function qemu_plugin_initialize in plugin, and call it in load=
er=3D=0D
, so=0D
  we have no need call it in every plugin. And also provide a standard impl=
em=3D=0D
entation,=0D
  anyway, use can also override it.=0D
=0D
Add this feature on msys2/mingw by using glib provided cross-platform dlsym=
 f=3D=0D
unctional.=0D
=0D
Yonggang Luo (6):=0D
  plugins: Fixes a issue when dlsym failed, the handle not closed=0D
  plugin: Fixes compiling errors on msys2/mingw=0D
  cirrus: Enable plugin in cirrus for windows=0D
  plugin: define QEMU_PLUGIN_API_IMPLEMENTATION first=0D
  plugin: getting qemu_plugin_get_hwaddr only expose one function=0D
    prototype=0D
  plugin: Getting qemu-plugin works under win32.=0D
=0D
 .cirrus.yml                  |   3 +-=0D
 Makefile                     |   1 -=0D
 configure                    |  71 -------------=0D
 contrib/plugins/hotblocks.c  |   3 +-=0D
 contrib/plugins/hotpages.c   |   1 +=0D
 contrib/plugins/howvec.c     |   1 +=0D
 contrib/plugins/lockstep.c   |   1 +=0D
 include/qemu/qemu-plugin.h   | 197 +++++++++++++++++++++++++++--------=0D
 meson.build                  |   6 +-=0D
 plugins/api.c                |  71 +++++++------=0D
 plugins/core.c               |  11 +-=0D
 plugins/loader.c             |  51 ++++++++-=0D
 plugins/meson.build          |  10 +-=0D
 plugins/plugin.h             |   1 +=0D
 plugins/qemu-plugins.symbols |  40 -------=0D
 tests/plugin/bb.c            |   5 +-=0D
 tests/plugin/empty.c         |   1 +=0D
 tests/plugin/insn.c          |   1 +=0D
 tests/plugin/mem.c           |   1 +=0D
 19 files changed, 262 insertions(+), 214 deletions(-)=0D
 delete mode 100644 plugins/qemu-plugins.symbols=0D
=0D
--=3D20=0D
2.28.0.windows.1=0D
=0D

