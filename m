Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E787C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D12921531
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pToxCEM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D12921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNiO-0007PA-B8
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrNhN-00069S-NB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:33:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:52001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jrNhL-0000gt-An
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:33:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id 22so32411792wmg.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CeG9nlQhToqpHzt8UXhXcJictiL/725CMXkORsMubBY=;
 b=pToxCEM/mRyigrmcs+ehq8V3y1Rb4vU5fmKmHJFWf+wpuig/Cz0DNVO+MGo8d1pIXb
 XVmcO69SOYsVsTM2zfgLamtEqfiJEYWbhFst9L+L7AqqMrMo8+FuTG/x2BmYwoKhSO5I
 3QnftWDaLIXj95uYl/oi/WvCjwv7q36t94apMPQt3NwhVbhXkuwIk2MfDxSQT/+Lw2hd
 i+PbeMuOoU+bjaM/mKfB3GiklHnfLdFLQrkUlI+PIWOUBe7AKUsF8fc46a+FF4nXe7aO
 I2V9R3BirK3tTVVXfZJhXhfGA1EAyWfah8NCCQ9vq+0R64uidQW8Cb2hs7gVY0CRTmZF
 UPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CeG9nlQhToqpHzt8UXhXcJictiL/725CMXkORsMubBY=;
 b=uUrBHLA23CIacVjDGdSdVWFlBBXT3zt96s5iq5lV9ddy4i6xhAookR4G7fj5RmsFlS
 MsHTwBIISxXw6VgaNfqWgHJrkSHdA6Eaug63uG1cQKCGz2U1LbXWOE3gNUjeMREvgUOd
 g5xVNG7Jg6j87x31Ask4+8ZAvzHlrNIMupM4+u5xUlWJmlwiyDP7q9rQymqtQfItscEL
 DjGtK6NBz+GSzHW2nMunBg2r0jJSRP4NppHdv4m9bL/E4xnpPcKMJc3e+qBR0XEXyu7z
 ILvMyPtoFCHHHedUwGSp7cyUgUfh4+q07f62HK5DsCdXG/TLwumFWeQkjMAuq4Gyv1Wj
 0cng==
X-Gm-Message-State: AOAM532YFdWKnr99PH1Rt8q/RjV+jDJ3V4XsKgWDkcVNel5V9F/dowkc
 rNRG3KFyr74DRxttCQ57N7UN6g==
X-Google-Smtp-Source: ABdhPJxiAq8zKlQbiiXspIXPb01nRK16PNgxheehueYUUDkeSC4zhSlH5ke/nh9a1xZj0TKOTCuklg==
X-Received: by 2002:a1c:398b:: with SMTP id g133mr36067091wma.76.1593790432943; 
 Fri, 03 Jul 2020 08:33:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm1987631wrr.85.2020.07.03.08.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 08:33:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A78D1FF7E;
 Fri,  3 Jul 2020 16:33:51 +0100 (BST)
References: <159357217483.1717.4076077243388027502.malonedeb@chaenomeles.canonical.com>
 <159378865160.17942.5070159367065081063.malone@soybean.canonical.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1885827 <1885827@bugs.launchpad.net>
Subject: Re: [Bug 1885827] Re: building plugin failed on Windows with mingw
In-reply-to: <159378865160.17942.5070159367065081063.malone@soybean.canonical.com>
Date: Fri, 03 Jul 2020 16:33:50 +0100
Message-ID: <877dvkpq8x.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Emilio G . Cota" <cota@braap.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Xiaolei <1885827@bugs.launchpad.net> writes:

> If I keep "-Wl,-soname,$@" in the command , I got similar linking errors.
>=20=20
> makefile:=20
> SONAMES :=3D $(addsuffix .dll,$(addprefix lib,$(NAMES)))
>
> QEMU_CFLAGS +=3D -fPIC -fno-stack-protector -DBUILDING_DLL
> QEMU_CFLAGS +=3D -I$(SRC_PATH)/include/qemu
>
> all: $(SONAMES)
> lib%.dll: %.o
>     $(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
>
> output:
> x86_64-w64-mingw32-gcc -shared -Wl,-soname,libbb.dll -o libbb.dll bb.o
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: bb.o: in function `g_autoptr_cleanup_generic_gf=
ree':
> C:/msys64/mingw64/include/glib-2.0/glib/glib-autocleanups.h:28: undefined=
 reference to `g_free'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: bb.o: in function `plugin_exit':
> C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/bb.c:27: undefined referenc=
e to `g_strdup_printf'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/b=
b.c:29: undefined reference to `qemu_plugin_outs'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: bb.o: in function `vcpu_tb_trans':
> C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/bb.c:42: undefined referenc=
e to `qemu_plugin_tb_n_insns'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/b=
b.c:45: undefined reference to `qemu_plugin_register_vcpu_tb_exec_inline'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/b=
b.c:47: undefined reference to `qemu_plugin_register_vcpu_tb_exec_inline'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/b=
b.c:50: undefined reference to `qemu_plugin_register_vcpu_tb_exec_cb'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: bb.o: in function `qemu_plugin_install':
> C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/bb.c:64: undefined referenc=
e to `qemu_plugin_register_vcpu_tb_trans_cb'
> C:/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/9.3.0/../../../../x86=
_64-w64-mingw32/bin/ld.exe: C:/QRS_Project/simdsp/qemu-4.2.0/tests/plugin/b=
b.c:65: undefined reference to `qemu_plugin_register_atexit_cb'
> collect2.exe: error: ld returned 1 exit status

Cc'ing Emilio as he wrote the initial code so I assume built it at one poin=
t.

--=20
Alex Benn=C3=A9e

