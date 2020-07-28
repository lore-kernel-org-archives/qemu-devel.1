Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542E8C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD22206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtAenA/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD22206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QgL-0007PG-E7
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k0Qda-00033R-4l
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:31:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43319
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k0QdY-0001iq-Bw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595946680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=irwRtc9ju39Fk2YfT8vZ26jBVICsAOBS67+XXlSHKD8=;
 b=DtAenA/jcxrW45KmU/V5GikY69rmgFGTXgaCvYzmgMvxiDZET6x5lX1YDrmnTvxApP77dx
 7/KRpdoV0LlxHjq0YBUjS0d/LsRAVvGUxJ3WfA/v4gruWKkV4tMWYtD1vfLwa9cF4l8+uf
 jK0GHDAvHauIderL5u0l8Iw7FnWSmEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-E5BEWxZ7OPCeQFMk2TCLFA-1; Tue, 28 Jul 2020 10:31:16 -0400
X-MC-Unique: E5BEWxZ7OPCeQFMk2TCLFA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF9CA1009442;
 Tue, 28 Jul 2020 14:31:15 +0000 (UTC)
Received: from localhost (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACB985DA72;
 Tue, 28 Jul 2020 14:31:11 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Update slirp (+ debug test-serial)
Date: Tue, 28 Jul 2020 18:31:06 +0400
Message-Id: <20200728143108.2192896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 264991512193ee50e27d43e66f832d5041cf3b28:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-07-27' into staging (2020-07-28 14:38:17 +0100)

are available in the Git repository at:

  https://github.com/elmarco/qemu.git tags/slirp-pull-request

for you to fetch changes up to 9c15f57891af7c2cb3baf2d66a1b1f3f87a665ba:

  slirp: update to latest stable-4.2 branch (2020-07-28 18:27:59 +0400)

----------------------------------------------------------------
slirp: update to latest stable-4.2 branch

----------------------------------------------------------------

Marc-André Lureau (2):
  test-char: abort on serial test error
  slirp: update to latest stable-4.2 branch

 tests/test-char.c | 2 +-
 slirp             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.28.0.rc2.1.g3d20111cbd


