Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715BCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7B220787
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrUVZs4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7B220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdFt-0000OD-86
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEM-0007m8-G7
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdEK-0001ag-Ts
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589560235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wO38HulAjajXIuZag86qRRm1D8lu7JKmEEm22bGagck=;
 b=FrUVZs4X9qU8FGOLpYDIwpD99uI+yZtFfyT40jmGLuFEm5r8em+U9o62bxtOmr5GOHQEKA
 PxOQe0J8S+Zmur12uYGfSuVtCR/Ny+qwc39oOHVXpayoZm7lP02b1C6WL2DXNQaxaYOPRS
 LXLtlAvqNqGotKWYpLM2kECD0D1U2Jk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-keedQgGoOU6lxQlfsDW7ww-1; Fri, 15 May 2020 12:30:33 -0400
X-MC-Unique: keedQgGoOU6lxQlfsDW7ww-1
Received: by mail-wm1-f71.google.com with SMTP id t82so1128565wmf.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 09:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wO38HulAjajXIuZag86qRRm1D8lu7JKmEEm22bGagck=;
 b=d4I65AWO6hmGvRWf284x/XFtYfy1zzYH2+1LoVoFlRIDKM+998bCq8zRU98ietqCKc
 cejq8mvotZSZBiUBPZO0yPHdFOgLH1N+Z7NKIFnQQsH6JuIX+TmcQVAy12cOobOxfRAU
 MA7S8hrmpN8hja0sP5NeZg6e55pT7e4+4jPDcWCRElIm3GR16XtAbKFPQK/jyb5hyR/L
 4sB5Vhw2ZP+DHzQcA+hyaLRfbgvxEwsFRTdlHF0ORiQ18fhOkVuZbgxr4FmrmSDrukvl
 zccetC0a9/L1YjR5wlxM/UpsKVKHi3YHcCQm0USt7zlaVN/V+IXy2pJskHpwEr/jIxlF
 4GOw==
X-Gm-Message-State: AOAM530u6HUH2eYhWvRzhb61PvJbUb8BdscD2LY+HnQbbfvyzRjdFH+g
 Pe7/dx6tPcvKjzLOFbgR63M33zVmGUy1CXjZOqQBnS9mBKMvP1T0shPyOTg4dmdh0RLp5pdYlyR
 HmKWHrx+AuX4C9QM=
X-Received: by 2002:a7b:c146:: with SMTP id z6mr5124023wmi.156.1589560232500; 
 Fri, 15 May 2020 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygku44R1i8M4vIvvi5Zb00+TLT+QZxUGWcACqXgOISb9eUeUVL8h/btHw6qnooMFoXUKhItw==
X-Received: by 2002:a7b:c146:: with SMTP id z6mr5123997wmi.156.1589560232283; 
 Fri, 15 May 2020 09:30:32 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id g135sm4116146wme.22.2020.05.15.09.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 09:30:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/5] tests: Remove unused bison/flex packages
Date: Fri, 15 May 2020 18:30:24 +0200
Message-Id: <20200515163029.12917-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I was misguided by libdtc warnings, and thought bison/flex
were required to build QEMU, so installed them in docker
(and they also ended in the VM scripts).

Claudio's series "libfdt: build only the strict necessary"
even silents the warnings.

Based-on: <20200514193811.6798-1-cfontana@suse.de>

Philippe Mathieu-Daudé (5):
  tests/docker: Remove flex/bison packages
  tests/vm: Remove flex/bison packages
  gitlab-ci: Remove flex/bison packages
  cirrus-ci: Remove flex/bison packages
  scripts/coverity-scan: Remove flex/bison packages

 .cirrus.yml                                         | 2 +-
 .gitlab-ci.yml                                      | 2 +-
 scripts/coverity-scan/coverity-scan.docker          | 2 --
 tests/docker/dockerfiles/centos7.docker             | 2 --
 tests/docker/dockerfiles/centos8.docker             | 2 --
 tests/docker/dockerfiles/debian-xtensa-cross.docker | 2 --
 tests/docker/dockerfiles/debian10.docker            | 2 --
 tests/docker/dockerfiles/debian9.docker             | 2 --
 tests/docker/dockerfiles/fedora.docker              | 2 --
 tests/docker/dockerfiles/ubuntu.docker              | 2 +-
 tests/docker/dockerfiles/ubuntu1804.docker          | 2 +-
 tests/vm/fedora                                     | 1 -
 tests/vm/freebsd                                    | 1 -
 tests/vm/netbsd                                     | 1 -
 tests/vm/openbsd                                    | 1 -
 tests/vm/ubuntu.i386                                | 2 +-
 16 files changed, 5 insertions(+), 23 deletions(-)

-- 
2.21.3


