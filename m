Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629E6204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnOFgsF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629E6204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2HN-0005Vv-GL
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2GB-0004Li-Jj
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:19 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:37274)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2G9-0008AN-P6
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:26:19 -0400
Received: by mail-qk1-x742.google.com with SMTP id m11so14982182qka.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=raBocYizrkulDEyGXccw4mVvr1iHMUyErLiJlzSTQb4=;
 b=BnOFgsF+6yFTASxJ4lpCTbAR41Xxg5oUHit93shswxRrkKlSeu/2zQsYtZxwNebLSd
 /HK9nfyxownBJs05msuqQJ5xIEHDdWc8Od/ADy78QSb33ZaYCrT+rxvi+vI9M32UvuxN
 xkESBaWlbEn/3JPX+7F/anrQAqt16u+JzYlxGLeHI1e5iODAIz29EKA8MlGTN9/e5RRZ
 rBlVf24Ta0Jm9juGsHEcAlKzvbaEzVTnV0I4Ihn1qxFbDODEc/qkXdjN1BCxGn36B1dI
 lrZGPF+fdBD1k2kVUZdo3FwSnliWljknhUgWbUdUD//L0VeGTM+fBclpRT0UF6EVJY9T
 1F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=raBocYizrkulDEyGXccw4mVvr1iHMUyErLiJlzSTQb4=;
 b=cwTYDHNSf1/i3SFlDwtevPZpEsMVxGkmSKZjD02g8GMNrZiT90DHbhBlLgMkS+rizz
 DT13TjyxPTCbr336unoO5wuLBaN4CskyKExYinbSti6wYHf6ItcJhvoUvH5wh9mojVNf
 nAzjnnj7jFjM6libXUJ6eNYq86ZY+wLIJNJgFgOWVLg5me7rnw1d1ykaFY60Abmi8cbj
 qO+vMfga5n0xfcmtIH2fv6rkafM2OeUxcZdwFgfOUP1Kh3TG9+i7TvRd5yd7bfkC859w
 5YJgbYxKNfeowZEMoVccI4QZNEN8E/chsIv2rgXEkeMqJ+OkqMKg2WkA3t9wtizzzJfr
 lh2w==
X-Gm-Message-State: AOAM532D04U+3B+C8qOjvbu1SCAD5qBm1TBbelL6nv53sAD9q+MNxJ3D
 ehSOpvvdEJiRKq1r0ZknjCSNMGWVacbOLg==
X-Google-Smtp-Source: ABdhPJyHgQksNWpWJJ/AQrnpsxlGB/g2Gw36esjPL+JIJO7plCmAy3eUu16TpwN74EWOeElzWVyHvQ==
X-Received: by 2002:a37:9f47:: with SMTP id i68mr19630243qke.425.1589894776121; 
 Tue, 19 May 2020 06:26:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:26:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/12] tests/vm: Add support for aarch64 VMs
Date: Tue, 19 May 2020 09:22:47 -0400
Message-Id: <20200519132259.405-1-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=robert.foley@linaro.org; helo=mail-qk1-x742.google.com
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is version 7 of the patch series to
add support for aarch64 VMs in the vm-build infrastructure.
 - Ubuntu 18.04 aarch64 VM
 - CentOS 8 aarch64 VM

v6: https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg03134.html

Changes in v7
- Made changes to the way we discover the efi image for aarch64 VMs
  - Added support for discovering efi aarch64 image in pc-bios folder.
  - Added support for efi image discovered in configure to eventually
    get passed through the makefile to the vm script.
- Changed basevm.py BaseVM to pass args through to __init__
- Included two patches from Alex for genisoimage.

Alex Bennée (2):
  configure: add alternate binary for genisoimage
  tests/vm: pass --genisoimage to basevm script

Robert Foley (10):
  tests/vm: pass args through to BaseVM's __init__
  tests/vm: Add configuration to basevm.py
  tests/vm: Added configuration file support
  tests/vm: Pass --debug through for vm-boot-ssh.
  tests/vm: Add ability to select QEMU from current build.
  tests/vm: allow wait_ssh() to specify command
  tests/vm: Added a new script for ubuntu.aarch64.
  tests/vm: Added a new script for centos.aarch64.
  tests/vm: change scripts to use self._config
  tests/vm: Add workaround to consume console

 configure                         |  31 +++-
 python/qemu/console_socket.py     | 162 ++++++++++++++++
 python/qemu/machine.py            |  23 ++-
 tests/vm/Makefile.include         |  28 +++
 tests/vm/aarch64vm.py             | 106 +++++++++++
 tests/vm/basevm.py                | 294 +++++++++++++++++++++++-------
 tests/vm/centos-8-aarch64.ks      |  51 ++++++
 tests/vm/centos.aarch64           | 227 +++++++++++++++++++++++
 tests/vm/conf_example_aarch64.yml |  51 ++++++
 tests/vm/conf_example_x86.yml     |  50 +++++
 tests/vm/fedora                   |  17 +-
 tests/vm/freebsd                  |  16 +-
 tests/vm/netbsd                   |  19 +-
 tests/vm/openbsd                  |  17 +-
 tests/vm/ubuntu.aarch64           | 117 ++++++++++++
 15 files changed, 1110 insertions(+), 99 deletions(-)
 create mode 100644 python/qemu/console_socket.py
 create mode 100644 tests/vm/aarch64vm.py
 create mode 100644 tests/vm/centos-8-aarch64.ks
 create mode 100755 tests/vm/centos.aarch64
 create mode 100644 tests/vm/conf_example_aarch64.yml
 create mode 100644 tests/vm/conf_example_x86.yml
 create mode 100755 tests/vm/ubuntu.aarch64

-- 
2.17.1


