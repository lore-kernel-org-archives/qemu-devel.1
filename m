Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEEBC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:46:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC2221707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5kkk7MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC2221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPIb-0007vF-2P
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuY-0003U1-EH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuW-0006BU-Dg
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdW/AzfFSSKfvR/W0HSDFMYpjCcpdNKB9zfqWXqZL3c=;
 b=E5kkk7MOm45vouog/pBQqhjWfQPSpcuoSZpOrqp6Bo1ulJe6Nl5ZOZ72T7WityjnQmkgO9
 ajjocmJt6MiPE/LlwZDYJ7+FmTzDXwmahiimGMhwapBaT2xZMMYZSR5pPD9EFhtTIxu7L1
 gzT4SWDvbK/icb1/bewdRHaEF28imwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-RLSNb24MPqa4MDm3ObhNqQ-1; Tue, 27 Oct 2020 09:21:08 -0400
X-MC-Unique: RLSNb24MPqa4MDm3ObhNqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15C10101962E
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:07 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB9C01972B;
 Tue, 27 Oct 2020 13:21:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 11/16] Bring contribution links out of the footer
 into the home page
Date: Tue, 27 Oct 2020 13:20:10 +0000
Message-Id: <20201027132015.621733-12-berrange@redhat.com>
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
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The selection of contribution links are important information to present
to visitors to the site. They are best placed in a prominent position on
the home page rather than in the footer

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/footer.html | 7 -------
 index.html            | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 411ff55..07f7866 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -5,13 +5,6 @@
 			<li><a href="{{ relative_root }}/download">Download</a></li>
 			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
 		</ul>
-		<ul class="style">
-			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
-			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
-			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
-			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
-			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
-		</ul>
 		<ul class="style">
 			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
 			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
diff --git a/index.html b/index.html
index d057a87..be1d210 100644
--- a/index.html
+++ b/index.html
@@ -27,6 +27,14 @@ bxslider: True
 			  <span><a href="{{ relative_root }}/download">Other releases</a></span>
 			</li>
 {% endfor %}
+
+			<li><strong>Contribute</strong>
+			  <span><a href="{{ relative_root }}/contribute">Overview</a></span>
+			  <span><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></span>
+			  <span><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></span>
+			  <span><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></span>
+			  <span><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></span>
+			</li>
 		</ul>
 	</div>
 </div>
-- 
2.26.2


