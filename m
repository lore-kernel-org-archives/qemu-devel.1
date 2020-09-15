Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF03C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BE14206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfqS9iGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE14206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDuw-0000t5-Pr
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIDuB-0008Eb-CZ; Tue, 15 Sep 2020 12:34:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIDu9-00062J-KG; Tue, 15 Sep 2020 12:34:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id k14so2251690pgi.9;
 Tue, 15 Sep 2020 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s2T2ElnQNYuoeSNC0tZ6pkdPXUdDMCc2T3Nh6TvMvFc=;
 b=nfqS9iGTIxaXk7UuZI4W8nI9uUqo74ti2STCMFkNgNBgv/Y+zzqx6gCDXUb3KetA2U
 UYGaQQCOisW8irTirtMv1i5HFeL5xRO71KIXya67HhjrVZASwgqwlervBEtJd/KO+2Zx
 cnWp78L1S892fdEcXJRx+LrCX9eHJ8XN3Xi3+auJWzJqhjh8Yy2STc3lpsyJVFjvFCuY
 Hgs9FHLRXUsFEc8ZEeB7fSO20B1cwe2i26BEXPDca4jwtUDsADU21jv/CEvtZWp4UU4L
 KX8rTxyMvbE9NLVd2Ra6MXkhgqWVVMwrTYWCDylipjMjLyX4nexMizTQEFi9YUX3yY3z
 4pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s2T2ElnQNYuoeSNC0tZ6pkdPXUdDMCc2T3Nh6TvMvFc=;
 b=je1KO9n7VGGUl0Klx8jxhwokePsJ7UUzCY38Gszy3stXTQvfSm8pmPwyCqCz4ltIiR
 tlHso3IYcye73yBUjZEFNqlmhXiXnFxNabbFQZtTNw5Huiu7KX7qYgfwdcRuSFcyRJeA
 3RnIETdfFuXqRQ0psTwz8bvUySDF78uPCOHFPGXZjTz5iEotLkEoI27tnYgPNvKp0eZG
 +IIhKSRytYaLOZau3ZmI/pv2mJeu2om28nEjcyRmQEqVXE3kiOtKyfGH/blUL7tg0+xu
 SaQZCVATHk81FaE+dwex/3NqGieODLGB1hT7ldvxTN4RjESmPJSXY+/rux69ffWMc5fI
 IVdg==
X-Gm-Message-State: AOAM530FAnOMREynMimRSLtoweJP/7hcsCChhSfVNFzsJ0Wq/0Hn99E4
 yBCnvuOtpseAlz9Fbv1KR/BIG6mCOBoC7FbWZQw=
X-Google-Smtp-Source: ABdhPJxTspRWnMt6VAC3ZSEIuxwJhnfrzL35SasrFrdF0NiFI8hLOOiGc/ytgRhXVjoy+8MOrLRSSA==
X-Received: by 2002:a65:6487:: with SMTP id e7mr7189793pgv.409.1600187643286; 
 Tue, 15 Sep 2020 09:34:03 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id a16sm11708429pgh.48.2020.09.15.09.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 09:34:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] guest agent: Fixes for windows guest agent building on
 msys2/mingw
Date: Wed, 16 Sep 2020 00:33:43 +0800
Message-Id: <20200915163343.1100-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error message:
"cc" "-Iqga/qemu-ga.exe.p" "-Iqga" "-I../qga" "-I." "-Iqapi" "-Itrace" "-Iu=
i" "-Iui/shader" "-IC:/CI-Tools/msys64/mingw64/include" "-IC:/CI-Tools/msys=
64/mingw64/include/glib-2.0" "-IC:/CI-Tools/msys64/mingw64/lib/glib-2.0/inc=
lude" "-fdiagnostics-color=3Dauto" "-pipe" "-Wall" "-Winvalid-pch" "-Werror=
" "-std=3Dgnu99" "-g" "-m64" "-mcx16" "-D_GNU_SOURCE" "-D_FILE_OFFSET_BITS=
=3D64" "-D_LARGEFILE_SOURCE" "-Wstrict-prototypes" "-Wredundant-decls" "-Wu=
ndef" "-Wwrite-strings" "-Wmissing-prototypes" "-fno-strict-aliasing" "-fno=
-common" "-fwrapv" "-Wold-style-declaration" "-Wold-style-definition" "-Wty=
pe-limits" "-Wformat-security" "-Wformat-y2k" "-Winit-self" "-Wignored-qual=
ifiers" "-Wempty-body" "-Wnested-externs" "-Wendif-labels" "-Wexpansion-to-=
defined" "-Wno-missing-include-dirs" "-Wno-shift-negative-value" "-Wno-psab=
i" "-fstack-protector-strong" "-iquote" "/c/work/xemu/qemu/tcg/i386" "-iquo=
te" "." "-iquote" "/c/work/xemu/qemu" "-iquote" "/c/work/xemu/qemu/accel/tc=
g" "-iquote" "/c/work/xemu/qemu/include" "-iquote" "/c/work/xemu/qemu/disas=
/libvixl" "-pthread" "-mms-bitfields" -MD -MQ qga/qemu-ga.exe.p/commands-wi=
n32.c.obj -MF "qga/qemu-ga.exe.p/commands-win32.c.obj.d" -o qga/qemu-ga.exe=
.p/commands-win32.c.obj "-c" ../qga/commands-win32.c -MP
../qga/commands-win32.c:62:24: error: redundant redeclaration of 'CM_Get_De=
vNode_PropertyW' [-Werror=3Dredundant-decls]
   62 | CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../qga/commands-win32.c:26:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/cfgmgr32.h:840:26: no=
te: previous declaration of 'CM_Get_DevNode_PropertyW' was here
  840 |   CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst=
, const DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyB=
uffer, PULONG PropertyBufferSize, ULONG ulFlags);
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~
cc1.exe: all warnings being treated as errors
make: [Makefile.ninja:5143=EF=BC=9Aqga/qemu-ga.exe.p/commands-win32.c.obj] =
=E9=94=99=E8=AF=AF 1 (=E5=B7=B2=E5=BF=BD=E7=95=A5=EF=BC=89

This error comes from qemu configure didn't add predefined macro -DUNICODE =
-D_UNICODE in QEMU_CFLAGS,
and these too macro are standard config for win32 if using windows wide api.

in cfgmgr32.h
  CMAPI CONFIGRET WINAPI CM_Get_DevNode_PropertyW(DEVINST dnDevInst, const =
DEVPROPKEY *PropertyKey, DEVPROPTYPE *PropertyType, PBYTE PropertyBuffer, P=
ULONG PropertyBufferSize, ULONG ulFlags);
#ifdef UNICODE
#define CM_Get_DevNode_Property CM_Get_DevNode_PropertyW
#endif

macro CM_Get_DevNode_Property defined only when UNICODE are defined.
and in win32, UNICODE and _UNICODE should be defined at the same time

#endif

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 9f141891ea..f5d661af4a 100755
--- a/configure
+++ b/configure
@@ -812,6 +812,7 @@ MINGW32*)
   mingw32=3D"yes"
   hax=3D"yes"
   whpx=3D""
+  QEMU_CFLAGS=3D"-DUNICODE -D_UNICODE $QEMU_CFLAGS"
   vhost_user=3D"no"
   audio_possible_drivers=3D"dsound sdl"
   if check_include dsound.h; then
--=20
2.28.0.windows.1


