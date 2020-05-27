Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D07C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93CC2089D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bybw7Ev3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93CC2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2LP-0007Fs-Th
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1je2Kd-0005o0-3c
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:07:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1je2Kb-0004Cm-Sn
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:07:18 -0400
Received: by mail-oi1-x242.google.com with SMTP id l6so22884760oic.9
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 13:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2TS1eRfgqhmzoUX81Qz+ToFgWPsvcwaQKJ/hqzNjhDI=;
 b=bybw7Ev3QzUN2zWL+EKoySuw4oK/4m0JqV+Wl6J6u+8+iyniBSzZNZzDr1361+grhe
 DpcRMmxwndcIQttAkcN/ONP4pm+UJ9j6TPfaSVYSUxXBhn6n93SzWPtpTbBIlHrk5t53
 9qjj6649HXO+10nhicRA4pVR4FhymhZjJJWAAMzZOwDIUiB/KHAWsd9nYyvz8QNUg/FX
 zojGvaCbvKPZeutdB5G4jJY+QT1/Rh+UPzOHaTMj4nfHRMZpWM41qFc9Vq39mC4AMpCJ
 9DooMTFKKtwjW51hjd3qKS17NrZnc4MgJBcq/MGupaBx6TRTaEMU96n8lOsoXuJyldjx
 fofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2TS1eRfgqhmzoUX81Qz+ToFgWPsvcwaQKJ/hqzNjhDI=;
 b=ZxMEG8xTrL8V0a5yv22rQU2jDGmH8bD69s/zTEDz2klfC6Ho72FZKkF95CiKhc2DH6
 xtyL6Z7blScMj2uyGTv7tx4Id4krc/hmJWslkcHOzKwuFErVq8sOlug8pHnw3lIoWVuf
 RkOB09oKE6TJ5NSdlSmI16IUoeU56eTf7OS8rSJGCa+TMqBoD2LKNki+NOF/0BAU9C+/
 wSA2+HbwSpI4FJLZsjjVJUeYpWR/8Q5ZeSLPpvUsBPBoO4nONn56rGQ5V+TeIYLfx5jg
 4OcpMSMP5K7PnGnffXIRH31ATQaEiLGsgt6iDyD21rliRD6h/LRhkylhDJOYbIuY/4jC
 aldQ==
X-Gm-Message-State: AOAM533y0AGS17xL+kd5Ki3U2d0eGXN4D3VrTVcA4O/NugCcXx4vPibA
 adST8+/qc0RkT4Jym22gFEFisMlV3OXg9+e4WI81VA==
X-Google-Smtp-Source: ABdhPJxuYtuQbn7XshhLBLst8Q0r6g6a1RtM3BcLfa/D26yLwJE0wxJGwEZzFPUi09kSnn63rM1JBpxnWln+rMvvGQA=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr3693502oih.48.1590610036449; 
 Wed, 27 May 2020 13:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200526164211.1569366-1-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 May 2020 21:07:05 +0100
Message-ID: <CAFEAcA_zO06wPw=iZ-AGMF1YJp1htMJOy0_Nensn3GhWafr=EQ@mail.gmail.com>
Subject: Re: [PULL 00/11] bitmaps patches for 2020-05-26
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 at 17:43, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 8f72c75cfc9b3c84a9b5e7a58ee5e471cb2f19c8:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20200526-pull-request' into staging (2020-05-26 10:59:01 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-26
>
> for you to fetch changes up to 9f2bcd08bce234f67239aaf6f4b881ccf0a76d55:
>
>   iotests: Add test 291 to for qemu-img bitmap coverage (2020-05-26 11:28:24 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-26
>
> - fix non-blockdev migration of bitmaps when mirror job is in use
> - add bitmap sizing to 'qemu-img measure'
> - add 'qemu-img convert --bitmaps'
>
> ----------------------------------------------------------------


iotest 190 failed on freebsd:

  TEST    iotest-qcow2: 190 [fail]
QEMU          --
"/home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/../../aarch64-softmmu/qemu-system-aarch64"
-nodefaults -d
isplay none -machine virt -accel qtest
QEMU_IMG      --
"/home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/../../qemu-img"
QEMU_IO       --
"/home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/../../qemu-io"
--cache writeback --aio threads -f qcow2
QEMU_NBD      --
"/home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/../../qemu-nbd"
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- NetBSD/amd64 localhost 9.0
TEST_DIR      -- /home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/mktemp.MJWbGXjT
SOCKET_SCM_HELPER --

--- /home/qemu/qemu-test.BE3Bvf/src/tests/qemu-iotests/190.out
2020-05-27 15:13:27.000000000 +0000
+++ /home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/190.out.bad
 2020-05-27 15:30:50.377759533 +0000
@@ -17,7 +17,7 @@
 fully allocated size: 10813440
 required size: 2199023255552
 fully allocated size: 2199023255552
-required size: 7012352
+required size: 17170432
 fully allocated size: 17170432
 required size: 335806464
 fully allocated size: 2199359062016

NetBSD failed too but I'm not sure if it was the same thing
or just that it's being very unreliable currently.

thanks
-- PMM

