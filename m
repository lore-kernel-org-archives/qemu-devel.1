Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B247EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776A120409
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWtIZlNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776A120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPkf-0002aZ-HH
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjT-0000ue-I2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jGPjS-0002MO-9Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jGPjS-0002Lf-1z
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:15:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id f3so17815775wrw.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hMJEO+fywVSMs0azGgDTjWwqanjwLiD4o0h3ff8FnRU=;
 b=kWtIZlNfi9qx5r1GVz8yIZfTgd+sQ9GpUAb9nh8oCK7JU6vxAXMZjULBTr203f6CNB
 A/xxs+8rb+PTWlMNT1FdZpavwaZXTNcknZfK8aJ641crIMFuODEDnOovBwbsWuRIbvRY
 STWQmPs3mBYBnK8b1qHA2wsWSeHhZ0DH5BZCz3XFANg1r9CYMogaE4T4XjZ/vtFyZSJ9
 kXFfiiBpmZ3bFxqOTzu9oWbWF3mUV2G9AK8HVJoq+SJg8AwOB4SIc+oJ7vECEJ7zwSvn
 SbVYUoU7Att7iin3DfQgAsvS2PNKPdeDIziO6Rkz5Y7I6AlmCSFUgfv+qL0u/jW1YBoX
 XDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hMJEO+fywVSMs0azGgDTjWwqanjwLiD4o0h3ff8FnRU=;
 b=kLz7MnvqvxLmYFMB4aT0BZlnddLEkHagmRU3ao6G6XFDLhnHSYknP5IbNIEX8MWdU4
 uy7B+EXmkp1cfjBF6SyqaGJX1jD466jFdKh+En2Kp8dpIWVCzKFTwqU07ssasQzzp2VT
 Irn/+jX2ODgP3vpL+HS2/touJYcwgdOedfAQsfilbK5noxkxJh96zVHJdtD5C1pwZrbG
 49f8D2bCSD05DCK5HtLUpohcfwzy49Qydwbd/3TuRoDKZw4/OAZp+eIRFXyMBROIxrOU
 /rFXUalK3dzwO4kBcTEc5S8qkJC7xPXrtNznrEkUKM3bxBYghDDOIS3Phwi8q6G00TCx
 caEQ==
X-Gm-Message-State: ANhLgQ2i7jPMTqu25oZCbHORkbBXdy8Q+3RHdolisu5rVzuGoiPAjOCo
 z1WRE6fyfgix5s8lWf0VJhw/Hg==
X-Google-Smtp-Source: ADFU+vvsOFNCVoliJR/d5bf7cpuHE/qofPRWPpLQqfLRqflF5VYWrwbdBRSvq8xg94HNxiQW3EkAnA==
X-Received: by 2002:adf:f812:: with SMTP id s18mr16985218wrp.380.1584980116588; 
 Mon, 23 Mar 2020 09:15:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t124sm75263wmg.13.2020.03.23.09.15.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 09:15:15 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A859C1FF7E;
 Mon, 23 Mar 2020 16:15:14 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 for 5.0 00/11] testing/next
Date: Mon, 23 Mar 2020 16:15:03 +0000
Message-Id: <20200323161514.23952-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Hi,

This is the current testing/next queue. I've re-instated Gerd's VM
patches after I tracked down the failure to a weird interaction
between check-acceptance and the @skipIf changes I had in my tree.
I've re-run all BSD builds with check-unit and it seems sound.

The following still need review:

 - configure: disable MTTCG for MIPS guests
 - tests/vm: fix basevm config

Alex Bennée (2):
  tests/vm: fix basevm config
  configure: disable MTTCG for MIPS guests

Gerd Hoffmann (4):
  tests/vm: write raw console log
  tests/vm: move vga setup
  tests/vm: update FreeBSD to 12.1
  tests/vm: update NetBSD to 9.0

Philippe Mathieu-Daudé (5):
  tests/docker: Keep package list sorted
  tests/docker: Install gcrypt devel package in Debian image
  tests/docker: Use Python3 PyYAML in the Fedora image
  tests/docker: Add libepoxy and libudev packages to the Fedora image
  .travis.yml: Add a KVM-only s390x job

 configure                                    |  2 +-
 .travis.yml                                  | 42 ++++++++++++++++++++
 tests/docker/dockerfiles/centos7.docker      |  6 ++-
 tests/docker/dockerfiles/debian-amd64.docker |  1 +
 tests/docker/dockerfiles/fedora.docker       | 10 +++--
 tests/vm/basevm.py                           | 23 ++++++-----
 tests/vm/fedora                              |  1 +
 tests/vm/freebsd                             |  5 ++-
 tests/vm/netbsd                              | 24 ++++-------
 tests/vm/openbsd                             |  1 +
 tests/vm/ubuntu.i386                         |  5 ++-
 11 files changed, 85 insertions(+), 35 deletions(-)

-- 
2.20.1


