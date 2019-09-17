Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2185C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18322054F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAgjXcr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18322054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIRp-0004zo-1p
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPa-00036a-DR
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPZ-00008z-4E
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41778)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIPY-00008P-U3
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:13 -0400
Received: by mail-wr1-x444.google.com with SMTP id h7so4241198wrw.8
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MzVBH/kpt2XMCawrMU8IpP+qVv1ELCy1DYBUOm+FjI4=;
 b=cAgjXcr+Mo6TtcrvUbUlc8VBDzhBcrsBJIpTvcZfMoXhq5isdi3B9w/drfN3NlPtuz
 MAUEjNrcyY8DT/XU90+vOcW7dwKLWRCFgU69vVIQ+8qbbRoUbYLvRPSK+AwHS4xjYyWA
 KaExyF/pYA1/Q+BcvmSu3XBe6K4J8qjXmmelda3BwWu2/6gBA6VccFMlvE+Byh6YwT89
 z+oWE82AQDQlA5/tDC+9IdFjHzCGsX5Jff0sXTm7Xd3o2t4GaxxxZfuQKhUlKiZ176pB
 HUGmLAu2bGl90TKr4gGb3Rd1vcRXlW3Fvntp4M2iw4PHPRopYKwOleC/Tdk+chXqtzje
 1UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MzVBH/kpt2XMCawrMU8IpP+qVv1ELCy1DYBUOm+FjI4=;
 b=E27TbCmxGP5bAokEOPs/seDXclxIcMagPJQ18H1CzU8/Dmurgs6+69YvYV8icluieB
 2X70Pf5lxyIOsWwP63YJkgyld0Q+8ichcSVxvnh5muMoX1KSsxSRZ/F10IGo9FWZFAMw
 x/azAkabTxWjp7HY6S2sj4n3YWdI3/89XgUVnQ6Vqx67qQpHTo0ZX27jZ1vIQsrGRK7N
 cJAplx9IYq8IPajDuVSPeYr27LPJwKKLy/o19ztYNwqgwnhSvbj7f/bt310toG/AFyb0
 jS84BKJDP/YdbfDUdJ4TLTVjx1SvfmQxBaglM7Tb/dp8V1TtZZzB4Joqm0XvlHTfE2zf
 iclw==
X-Gm-Message-State: APjAAAUnKVCdr/dn/HBJJvkaqIcM6pdce26AwtUZtMO9zj4x5dLTfvG9
 6HnTVyCxaEioqLzSygxkxNFpGg==
X-Google-Smtp-Source: APXvYqxO4aiSmOBFKfEPIOtYdhXk7H7gBKLvVja0QvGnOejZdjmKvK2uodgiPQCe9duwoLM0uGH/Rg==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr42785wrp.143.1568745671774;
 Tue, 17 Sep 2019 11:41:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i8sm4197675wrw.36.2019.09.17.11.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 11:41:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 71BAA1FF87;
 Tue, 17 Sep 2019 19:41:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 17 Sep 2019 19:41:00 +0100
Message-Id: <20190917184109.12564-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH  v1 0/9] testing/next (docker,podman,float)
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is the current status of the testing/next queue. It contains a
number of fixes for docker and podman as well as some additional tests
for floating point under TCG I've been experimenting with.

Although we have reasonable confidence in large chunks of the core
softfloat code thanks to check-softfloat there is a wide range of
guest specific behaviour. I've written a couple of tests while trying
to generalise test cases for some PPC bugs and have tried to make them
multiarch so they can run on all targets. To be fully effective a
reference trace needs to be added for each target it exercises.

I was a little worried about the impact of adding reference files
after the test-i386-fprem debacle (which was around 64M). However the
new references files are ~32-80k per test per target which is fairly
favourable considering tests/qemu-iotests contains around 10Mb of text
files. Git should do a fairly good job at compressing the common stuff
anyway.

If other architecture maintainers want to run the tests on known good
hardware we can add them to the appropriate places in tests/tcg.

Alex Bennée (7):
  tests/docker: fix DOCKER_PARTIAL_IMAGES
  target/ppc: fix signal delivery for ppc64abi32
  tests/tcg: clean-up some comments after the de-tangling
  tests/tcg: re-enable linux-test for ppc64abi32
  tests/tcg: add float_madds test to multiarch
  tests/tcg: add generic version of float_convs
  tests/tcg: add refs for PPC float_[convs|madds] tests (FAILS TESTS)

John Snow (2):
  tests/docker: add sanitizers back to clang build
  podman: fix command invocation

 linux-user/ppc/signal.c              |   4 +-
 tests/docker/Makefile.include        |   2 +-
 tests/docker/docker.py               |   2 +-
 tests/docker/test-clang              |   6 +-
 tests/tcg/Makefile.target            |  16 +-
 tests/tcg/aarch64/Makefile.target    |   3 +-
 tests/tcg/aarch64/float_convs.ref    | 748 ++++++++++++++++++++++
 tests/tcg/aarch64/float_madds.ref    | 892 +++++++++++++++++++++++++++
 tests/tcg/arm/Makefile.target        |  16 +-
 tests/tcg/arm/float_convs.ref        | 748 ++++++++++++++++++++++
 tests/tcg/arm/float_madds.ref        | 892 +++++++++++++++++++++++++++
 tests/tcg/configure.sh               |   1 +
 tests/tcg/multiarch/Makefile.target  |  23 +-
 tests/tcg/multiarch/float_convs.c    | 102 +++
 tests/tcg/multiarch/float_helpers.c  | 275 +++++++++
 tests/tcg/multiarch/float_helpers.h  |  31 +
 tests/tcg/multiarch/float_madds.c    | 104 ++++
 tests/tcg/ppc/float_convs.ref        | 748 ++++++++++++++++++++++
 tests/tcg/ppc/float_madds.ref        | 892 +++++++++++++++++++++++++++
 tests/tcg/ppc64/float_convs.ref      | 748 ++++++++++++++++++++++
 tests/tcg/ppc64/float_madds.ref      | 892 +++++++++++++++++++++++++++
 tests/tcg/ppc64abi32/float_convs.ref | 748 ++++++++++++++++++++++
 tests/tcg/ppc64abi32/float_madds.ref | 892 +++++++++++++++++++++++++++
 23 files changed, 8759 insertions(+), 26 deletions(-)
 create mode 100755 tests/tcg/aarch64/float_convs.ref
 create mode 100644 tests/tcg/aarch64/float_madds.ref
 create mode 100644 tests/tcg/arm/float_convs.ref
 create mode 100644 tests/tcg/arm/float_madds.ref
 create mode 100644 tests/tcg/multiarch/float_convs.c
 create mode 100644 tests/tcg/multiarch/float_helpers.c
 create mode 100644 tests/tcg/multiarch/float_helpers.h
 create mode 100644 tests/tcg/multiarch/float_madds.c
 create mode 100644 tests/tcg/ppc/float_convs.ref
 create mode 100644 tests/tcg/ppc/float_madds.ref
 create mode 100644 tests/tcg/ppc64/float_convs.ref
 create mode 100644 tests/tcg/ppc64/float_madds.ref
 create mode 100644 tests/tcg/ppc64abi32/float_convs.ref
 create mode 100644 tests/tcg/ppc64abi32/float_madds.ref

-- 
2.20.1


