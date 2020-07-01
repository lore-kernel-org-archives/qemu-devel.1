Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D63C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 057D42067D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7IHosNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057D42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqaZm-0004ms-8k
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 07:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqaZ5-0003vW-01
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:06:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:43923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqaZ1-0004h9-Ec
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 07:06:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id j4so20901870wrp.10
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=user-agent:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SLsZUay/IDOdgyI8te1i7CAz4RVRgyY9sbQxBoCW40s=;
 b=o7IHosNLhIDFGGys30qsRgADVzvZ3cN6hg8F1utEaJwl7JlHcIK+hBmcTgMMhJ9ppo
 HenZXMHWpAGB6RqzILpXk9RbV8LfXijECXakUy28HOw7+CJQOTM8qv8uzKTvhF5SXd2K
 OgN7vs1vvxBQ2MnB7e5w+r8iBud2Lz/FRS14DSCPwwFCvb2IHS2/W/z+jj8X3j3ixThm
 nKBuv/whmPoKgizdNhizUGrUoSyiqOzFUl1h7X/oSQOwMiwXVhS9Mz7o/Pi93Ss7ugD/
 K0zDsk/Lf+OwW3VWjB6W/cY9ivf6IsedGVkqlkrquD0ICiz3tMn1ZpgCbXvjQKmrYJol
 68ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:user-agent:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=SLsZUay/IDOdgyI8te1i7CAz4RVRgyY9sbQxBoCW40s=;
 b=DLp8AksMHMoV+adFuxk1mcPV5nPmphzOsU5aHQApLu4qNOxIpqxMIlG+ZHBKsRW3Od
 vmd08SEFI0duFlMtvzZfO4bGi27iL9hgymbZRJu6W0cXkhJ6tBSTVRpxm1Zc8Z+eA21Q
 D09FhXu7Bft7D/D2PYKjtU2uUCNfKbM2tM9+7xdxjZRmgKTRDpcyoTl/3vdboEHBTRb5
 s9OQ4cyo1PUy56Nz6PgI849LL147fytOGO0noVsZU0sItmBG7A8j5ZQSCCsdYxdRlfMk
 G7WH9TpFfTl316W9cWURTW5Sl4bcSLSHVJ4PbKKd3MdOd49hIlTkj/Nb1ek1ua9gM70i
 Zchw==
X-Gm-Message-State: AOAM533XqXfIPL28ecwBe3Vr4C5e56KWCg5mbW19zIpt7hbxTZgVE13D
 ttNkHZDcZfaN5Zeev/YFQsfS9A==
X-Google-Smtp-Source: ABdhPJyZ28hPsCEmXjzPUnbpDGSUdTW/N0dl2oFZA+7WBQMjldX+SaFECCSFKAnz4qcSduT2fLpAsQ==
X-Received: by 2002:adf:8444:: with SMTP id 62mr25045437wrf.278.1593601561284; 
 Wed, 01 Jul 2020 04:06:01 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p29sm6891737wmi.43.2020.07.01.04.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 04:05:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE90F1FF7E;
 Wed,  1 Jul 2020 12:05:58 +0100 (BST)
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Race with atexit functions in system emulation
Date: Wed, 01 Jul 2020 12:05:58 +0100
Message-ID: <87v9j7qyuh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

While running some TSAN tests I ran into the following race condition:

  WARNING: ThreadSanitizer: data race (pid=3D1605)
    Write of size 4 at 0x55c437814d98 by thread T2 (mutexes: write M619):
      #0 replay_finish /home/alex.bennee/lsrc/qemu.git/replay/replay.c:393:=
17 (qemu-system-aarch64+0xc55116)
      #1 at_exit_wrapper() <null> (qemu-system-aarch64+0x368988)
      #2 handle_semihosting /home/alex.bennee/lsrc/qemu.git/target/arm/help=
er.c:9740:25 (qemu-system-aarch64+0x5e75b0)
      #3 arm_cpu_do_interrupt /home/alex.bennee/lsrc/qemu.git/target/arm/he=
lper.c:9788:9 (qemu-system-aarch64+0x5e75b0)
      #4 cpu_handle_exception /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu=
-exec.c:504:13 (qemu-system-aarch64+0x4a4690)
      #5 cpu_exec /home/alex.bennee/lsrc/qemu.git/accel/tcg/cpu-exec.c:712:=
13 (qemu-system-aarch64+0x4a4690)
      #6 tcg_cpu_exec /home/alex.bennee/lsrc/qemu.git/cpus.c:1452:11 (qemu-=
system-aarch64+0x441157)
      #7 qemu_tcg_rr_cpu_thread_fn /home/alex.bennee/lsrc/qemu.git/cpus.c:1=
554:21 (qemu-system-aarch64+0x441157)
      #8 qemu_thread_start /home/alex.bennee/lsrc/qemu.git/util/qemu-thread=
-posix.c:521:9 (qemu-system-aarch64+0xe38bd0)

    Previous read of size 4 at 0x55c437814d98 by main thread:
      #0 replay_mutex_lock /home/alex.bennee/lsrc/qemu.git/replay/replay-in=
ternal.c:217:9 (qemu-system-aarch64+0xc55c03)
      #1 os_host_main_loop_wait /home/alex.bennee/lsrc/qemu.git/util/main-l=
oop.c:239:5 (qemu-system-aarch64+0xe5af4f)
      #2 main_loop_wait /home/alex.bennee/lsrc/qemu.git/util/main-loop.c:51=
8:11 (qemu-system-aarch64+0xe5af4f)
      #3 qemu_main_loop /home/alex.bennee/lsrc/qemu.git/softmmu/vl.c:1664:9=
 (qemu-system-aarch64+0x5ce806)
      #4 main /home/alex.bennee/lsrc/qemu.git/softmmu/main.c:49:5 (qemu-sys=
tem-aarch64+0xdbf8b7)

    Location is global 'replay_mode' of size 4 at 0x55c437814d98 (qemu-syst=
em-aarch64+0x0000021a9d98)

Basically we have a clash between semihosting wanting to do an exit,
which is useful for reporting status and the fact that we have atexit()
handlers to clean up that clash with the main loop accessing the mutex
while we go. Ultimately I think this is harmless as we are shutting down
anyway but I was wondering how we would clean something like this up?

Should we maybe defer the exit to once the main loop has been exited
with a some sort of vmstop? Or could we have an atexit handler that
kills the main thread?

I should point out that linux-user has a fairly heavy preexit_cleanup
function to do this sort of tidying up. atexit() is also fairly heavily
used for other devices in system emulation.

Ideas?

--=20
Alex Benn=C3=A9e

