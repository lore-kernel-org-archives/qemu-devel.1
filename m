Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBE4C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E122168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cc/0Z3qM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E122168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzeX-0003Ac-5m
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1H-0007ek-Kb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1C-0001nX-Jo
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BL7gmCgKBlCSyQFWEkHmJlJ29WDBhZXlsfjEkz5skYc=;
 b=cc/0Z3qMNNhCLNB14IR4yosAyYdRf0205dc8qGmUBNJTMIw/1YRTAuBWcNE4EDLlI0P1ka
 DH1CiqjFYOLvP+8+4KmZvRpBLauNwDJN9QfLw6u6YA38lsf5XsDQLdp5Q5kQnxbOylU3fL
 HojWf3rRhFdBiAcnRBDdSyp40fwJ+VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-mxrUp7K-O3688MwbNsfYNg-1; Fri, 23 Oct 2020 11:30:10 -0400
X-MC-Unique: mxrUp7K-O3688MwbNsfYNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15B96EDBD6
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:30:07 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-189.ams2.redhat.com
 [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBDFC5B4BC;
 Fri, 23 Oct 2020 15:30:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH 4/7] Make page header nav narrower
Date: Fri, 23 Oct 2020 16:29:54 +0100
Message-Id: <20201023152957.488974-5-berrange@redhat.com>
In-Reply-To: <20201023152957.488974-1-berrange@redhat.com>
References: <20201023152957.488974-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the browser window is narrow, but not yet switched into the mobile
layout, the page header nav will line wrap. This breaks layout
assumptions resulting in overlapping/obscured text.

This deals with the probem by reducing padding between the links, and
shortening "Documentation" to just "Docs".

This avoids the line wrapping, as well as making room for new links in
the future.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/nav.html           | 2 +-
 assets/css/style-desktop.css | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/_includes/nav.html b/_includes/nav.html
index 58b6c5a..c66ee92 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -6,7 +6,7 @@
 			</li><li {% if current[1] == 'download' %}class='current'{% endif %}><a href="{{ relative_root }}/download">Download</a>
 			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="{{ relative_root }}/support">Support</a>
 			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="{{ relative_root }}/contribute">Contribute</a>
-			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="{{ relative_root }}/documentation">Documentation</a>
+			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="{{ relative_root }}/documentation">Docs</a>
 			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="{{ relative_root }}/blog">Blog</a></li>
 		</ul>
 	</nav>
diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index ce58fe2..b7e403a 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -237,13 +237,14 @@
 		{
 			text-align: right;
 			margin: 0;
+			padding: 0;
 		}
 
 		#nav > ul > li
 		{
 			display: inline-block;
 			margin: 0;
-			padding: 0.5em 2em 0.5em 0em;
+			padding: 0.5em 1em 0.5em 0em;
 			color: #FFF;
 			letter-spacing: 0.06em;
 			text-transform: uppercase;
-- 
2.26.2


