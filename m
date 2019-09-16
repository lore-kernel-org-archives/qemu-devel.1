Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA87C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D89206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fe+NE2JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D89206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9sCW-0005IA-SP
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 10:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnC-0004Ib-Mp
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i9rnA-0006rn-JZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:46829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i9rnA-0006rQ-Bs
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:15:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id o18so7868262wrv.13
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=trF4PUeQYqIN1FaA3mMgwum5hWySICsncWehaFgqsF0=;
 b=fe+NE2JRwk7ME04uMCeHLKURUF8VQtDaXScJmfSDYzUIRbXuZDPCNWoPV4znRNN723
 GXUdkrARL3+SSeTkN0iXY8r5Qu3uZmK+N5PiSbibE07D7TjF5f41Iutumxsnbbl87A+D
 L+QXPhk5vOfN1qpW8TQmkW5Ut78n2SNR2Eac0TEWbHxF9kXeucT3ank/R3hwM5ZPvGQx
 oMYjD6VYv6Rh61neHNh3aX7W2sYP3clq1M//Dgedn6JQtQQ4u1ejV7xCO9Ws/j2nMeaO
 JFxnuBJ/L9yPCZfVKj364fblcfIF4Iab2oYnRTZk0/TLQg8hRzGChN5aZ+rGnkIHUaZt
 2acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=trF4PUeQYqIN1FaA3mMgwum5hWySICsncWehaFgqsF0=;
 b=AU1coUYOpv1WQS/wOZbNbf/0nD/DbiLPoKrMQFmLC1ffvMJLTquDrYEANLjZSq8nxC
 S5cSSu/OSDA3k+X0/DTnIlNnPsEoebGhGPmDYslaJZ1eICIYsZmnsIyNq36CALtMN2Ed
 tmOTAu6i3E2st5UuR/pxI8ZVLZFZxjPVsfSC8O/8S4vzT5rB1sBna9mTrrm+JRvyhsRw
 hYxyyLSk6mlZ2nDqB/BcSvUG9Baxo+skulSTozAsuTA030zmiW0EjCRopNk8kO2cGQnR
 A/880/+EyEDUFAKFNvNFbZKmEzY07mc3nuPiaYv+rJcJRFqblcM1sHi55RBO3uZM7A4p
 SMTQ==
X-Gm-Message-State: APjAAAVIcAygz3iL7tsmCA8QPpQVrWHelYlYL0kBhJ2Htzeh1B1ChsJR
 cIYcVGmF+7CAUu6gmBnqqbZNEA==
X-Google-Smtp-Source: APXvYqxXcqmQ0C0cBkjxxg7JJa4GfbhXsKLD60dWAK9lZxZsybh9XArNgJw/YjoLdoucVQPS6v2h3Q==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr11580wro.330.1568643346931;
 Mon, 16 Sep 2019 07:15:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s9sm15185884wme.36.2019.09.16.07.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2019 07:15:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 15:15:29 +0100
Message-Id: <20190916141544.17540-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
Subject: [Qemu-devel] [PATCH v2 00/15] target/arm: Implement semihosting v2.0
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements support in QEMU for v2.0 of the
Arm semihosting specification:
 https://developer.arm.com/docs/100863/latest/preface

Specifically, v2.0 has:
 * a mechanism for detection of optional extra features,
   which works by allowing the guest to open a magic file
   named ":semihosting-features" and read some feature
   flags from it
 * two defined extensions:
  - STDOUT_STDERR lets the guest separately open stdout and
    stderr via the ":tt" magic filename (v1.0 only allowed
    access to stdout)
  - EXIT_EXTENDED lets A32/T32 guests exit with a specified
    exit status (otherwise only available to A64 guests).
    This is something that people have been complaining
    about for a long time.

(Technically some of the things we already support, like
having an A64 semihosting interface at all, are also part of
the v2.0 spec.)

This patchset:
 * fixes some bugs relating to errnos in some cases
 * makes semihosting hand out its own filedescriptors rather
   than just passing out host fd numbers
 * abstracts out the fd-related semihosting calls so they
   indirect via a function table based on the type of the fd
 * adds a new type of fd representing the magic file
   ":semihosting-features" which is used for feature-detection
 * implements both of the extensions defined by the v2.0 spec

I've tested this by improving my semihosting test suite:
 https://git.linaro.org/people/peter.maydell/semihosting-tests.git/
(if people have other guest binaries that make much use of
semihosting then testing would certainly be welcome.)

Changes v1->v2:
 * Added a patch which corrects misunderstanding in a FIXME
   comment about the when the callback function is called
   for arm_gdb_syscall()
 * in patch 4, if the SYS_open is going via the gdbstub, we
   must do the associate_guestfd() work in the gdbstub callback
   function. This is because in softmmu mode the callback will
   not be called until after do_arm_semihosting() returns.
   (The v1 series effectively broke SYS_open in the gdbstub
   + softmmu config)
 * Pass CPUARMState* to set_swi_errno(), rather than creating
   an odd local-to-this-file typedef of TaskState for the
   softmmu compilation
 * New patch: avoid ifdeffery in gdb callback fns by
   using set_swi_errno() rather than doing it by-hand
 * The various 'factor out SYS_foo' patches are basically
   unchanged, but all the functions no longer need to take
   a TaskState*. This seemed kind of borderline as to whether
   to retain Alex's reviewed-by tags, so I dropped them.
 * Since we need 'env' for set_swi_errno(), we don't need
   to put the variable declaration inside ifdefs any more
   in the host_readfn() etc.

I do plan to have a go at fixing the odd FIXME surrounding
arm_gdb_syscall() which patch 3 clarifies/states in a comment.
But I thought it better to not tangle that up with this
patchset, which is already pretty long.

thanks
-- PMM


Peter Maydell (15):
  target/arm/arm-semi: Capture errno in softmmu version of
    set_swi_errno()
  target/arm/arm-semi: Always set some kind of errno for failed calls
  target/arm/arm-semi: Correct comment about gdb syscall races
  target/arm/arm-semi: Make semihosting code hand out its own file
    descriptors
  target/arm/arm-semi: Restrict use of TaskState*
  target/arm/arm-semi: Use set_swi_errno() in gdbstub callback functions
  target/arm/arm-semi: Factor out implementation of SYS_CLOSE
  target/arm/arm-semi: Factor out implementation of SYS_WRITE
  target/arm/arm-semi: Factor out implementation of SYS_READ
  target/arm/arm-semi: Factor out implementation of SYS_ISTTY
  target/arm/arm-semi: Factor out implementation of SYS_SEEK
  target/arm/arm-semi: Factor out implementation of SYS_FLEN
  target/arm/arm-semi: Implement support for semihosting feature
    detection
  target/arm/arm-semi: Implement SH_EXT_EXIT_EXTENDED extension
  target/arm/arm-semi: Implement SH_EXT_STDOUT_STDERR extension

 target/arm/arm-semi.c | 707 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 577 insertions(+), 130 deletions(-)

-- 
2.20.1


