Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13052C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE312071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpPE9LvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE312071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdD1A-00057b-0p
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0J-0003jz-D3
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0H-0004Bu-My
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590412732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CAnA96Wo6G0ciR8USK1EdbSYOwrvZQpGqO/wXhWEYks=;
 b=RpPE9LvMbyae+VAo33UpeK04wjmjqtcN4HbE5pLY27aSRKcyyxG+p+GjTWEydZg3M5Oaiz
 hGagZfquvuQBb/Han2fB5/hW8gVpqf4n9ri6cTl1Dm9IOLLMsWYt7hjbKLac1489gkiQ6a
 4FLdWcy85ZwRpA88QJ7nnWshWFSlZ4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-mtRIuxUlMAiwtSHqpCLVyA-1; Mon, 25 May 2020 09:18:48 -0400
X-MC-Unique: mtRIuxUlMAiwtSHqpCLVyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5AE0801503;
 Mon, 25 May 2020 13:18:47 +0000 (UTC)
Received: from thuth.com (ovpn-113-78.ams2.redhat.com [10.36.113.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A3D05C1BB;
 Mon, 25 May 2020 13:18:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/7] Gitlab CI improvements and fixes
Date: Mon, 25 May 2020 15:18:16 +0200
Message-Id: <20200525131823.715-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, almost all piplines of our Gitlab CI are broken, since there
has been a change in the default Debian-based container that causes the
QEMU build process to fail (aka. the "BITS_PER_LONG" macro problem).

We could likely either wait for the containers to get fixed, or we could
try to work-around that issue in the QEMU sources, but considering that
we test with Ubuntu (and thus Debian-based) containers in our Travis-CI
already, we should maybe do something different here and rather switch
our Gitlab-CI to some RPM-based distros instead, to get even more test
coverage. This is now done in the 5th patch. Along the way, there are
clean-ups and some minor improvements, and a fix to be able to build QEMU
with Clang again (last patch).

After applying this patch series, the Gitlab-CI shows "green" again:

 https://gitlab.com/huth/qemu/pipelines/149326595

Alex Bennée (1):
  linux-user: limit check to HOST_LONG_BITS < TARGET_ABI_BITS

Cleber Rosa (1):
  GitLab CI: avoid calling before_scripts on unintended jobs

Philippe Mathieu-Daudé (1):
  gitlab-ci: Remove flex/bison packages

Thomas Huth (4):
  MAINTAINERS: Add Philippe, Alex and Wainer to the Gitlab-CI section
  gitlab-ci: Move edk2 and opensbi YAML files to .gitlab-ci.d folder
  gitlab-ci: Do not use the standard container images from gitlab
  gitlab-ci: Determine the number of jobs dynamically

 .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml  |  0
 .../opensbi.yml                               |  0
 .gitlab-ci.yml                                | 67 +++++++++++++------
 MAINTAINERS                                   |  5 +-
 linux-user/elfload.c                          |  2 +
 5 files changed, 51 insertions(+), 23 deletions(-)
 rename .gitlab-ci-edk2.yml => .gitlab-ci.d/edk2.yml (100%)
 rename .gitlab-ci-opensbi.yml => .gitlab-ci.d/opensbi.yml (100%)

-- 
2.18.1


