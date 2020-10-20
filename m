Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E14C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A39221D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0yCfT79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A39221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvbL-0000iT-3L
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQR-0002dC-CK
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQP-00005c-9Q
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRUoT07906sFVWIUUFYkWYYD5IjjfCeylwHHA3Kl8SY=;
 b=X0yCfT799F9R3FCZk51v8Dtu1SaNZxXbOAVAeTF5rZC8e0IpRmi6AvOxBJ/BApiNafneXP
 XMaUerAz+u18d2oFf2TyjKHVJnjlpKB/JSCI1raXCbh8CaknaZmH5FGOKFX67AUbfrW9My
 gvPT2djrW7eKkfv0AdN07ZgTEzFJN10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-yuy1YmGiOU-cZPXPF1tkUA-1; Tue, 20 Oct 2020 13:27:49 -0400
X-MC-Unique: yuy1YmGiOU-cZPXPF1tkUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE1801006C90;
 Tue, 20 Oct 2020 17:27:47 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4014A2639C;
 Tue, 20 Oct 2020 17:27:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] MAINTAINERS: Add Python library stanza
Date: Tue, 20 Oct 2020 13:27:22 -0400
Message-Id: <20201020172742.1483258-2-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm proposing that I split the actual Python library off from the other
miscellaneous python scripts we have and declare it maintained. Add
myself as a maintainer of this folder, along with Cleber.

I will be actively working to add CI style guide checks, strict typing,
and an actual package infrastructure to this folder specifically which
differentiates it from loose, miscellaneous scripts which are generally
maintained by other individuals with subject matter expertise.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Cleber Rosa <crosa@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 MAINTAINERS | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7f0acf866..6a197bd358 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2373,11 +2373,18 @@ S: Maintained
 F: include/sysemu/cryptodev*.h
 F: backends/cryptodev*.c
 
+Python library
+M: John Snow <jsnow@redhat.com>
+M: Cleber Rosa <crosa@redhat.com>
+R: Eduardo Habkost <ehabkost@redhat.com>
+S: Maintained
+F: python/
+T: git https://gitlab.com/jsnow/qemu.git python
+
 Python scripts
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Odd fixes
-F: python/qemu/*py
 F: scripts/*.py
 F: tests/*.py
 
-- 
2.26.2


