Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6470C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657AB21707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxL903oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657AB21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPLG-0002h2-6j
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuh-0003oG-FT
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuc-0006Cb-8d
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+/dVjGzf9OeYfzI+8CPoE4FYLY0YoMTdaAUoG1f2Fk=;
 b=IxL903oeKY7qucT40l1OUR7+dCnAtCnI/6cgZiegQiJjY5tWPAF95aNHndb7TsUFg+mXNi
 LoihRmKlcuA/nLdlg04ShBhu2jIxi6iCtYoETRhzW5IK6MBO1oFo52pnPyhxulFso2Uncj
 0AOJGhfEVNo2jUl3xVVuNZ9EixRwr78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-6SYlUbkxO2CVshuQaOahZg-1; Tue, 27 Oct 2020 09:21:11 -0400
X-MC-Unique: 6SYlUbkxO2CVshuQaOahZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D657101F7CC
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B50F1972B;
 Tue, 27 Oct 2020 13:21:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 13/16] Move wiki link from footer into the header
 navbar
Date: Tue, 27 Oct 2020 13:20:12 +0000
Message-Id: <20201027132015.621733-14-berrange@redhat.com>
In-Reply-To: <20201027132015.621733-1-berrange@redhat.com>
References: <20201027132015.621733-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The wiki is important enough that it should be presented more
prominently in the page header navbar, rather than the footer.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/footer.html | 1 -
 _includes/nav.html    | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 07f7866..fba5f08 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -9,7 +9,6 @@
 			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
 			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
 			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
-			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
 		</ul>
 		<ul class="style">
 			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
diff --git a/_includes/nav.html b/_includes/nav.html
index c66ee92..73b39b3 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -7,6 +7,7 @@
 			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="{{ relative_root }}/support">Support</a>
 			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="{{ relative_root }}/contribute">Contribute</a>
 			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="{{ relative_root }}/documentation">Docs</a>
+			</li><li><a href="https://wiki.qemu.org">Wiki</a>
 			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="{{ relative_root }}/blog">Blog</a></li>
 		</ul>
 	</nav>
-- 
2.26.2


