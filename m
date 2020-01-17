Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F8C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB9E20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3UInWbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB9E20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPY3-0003sU-9Y
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1isPUG-0006wr-AE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1isPUC-0003oj-EV
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1isPUC-0003oV-B9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579259299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oMTMGpxtSHxsDoSc2IO75R119iBtH87I1K69gvCCnzw=;
 b=K3UInWbZY2/wnn3L/XWFwAdCEuMTA1CJnuzzYbKg00Cy+gmCD2ffqYxrCbVlyYKBklx2eK
 1ot3mStzGyEj00nH7lK0DnnznbL5bvzQjBDO0I6LUJq5ENypDfrrwqqX2g+pG3+Uyfqu1a
 6Sx7R2n1sMG855BO0qc4JEFUFJS8LqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-BEsFnOJxPm-coQyk_jcmxA-1; Fri, 17 Jan 2020 06:08:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C05190B2A0;
 Fri, 17 Jan 2020 11:08:13 +0000 (UTC)
Received: from thuth.com (ovpn-116-212.ams2.redhat.com [10.36.116.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4523E60C87;
 Fri, 17 Jan 2020 11:08:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/4] gitlab-ci.yml: Run tcg test with tci
Date: Fri, 17 Jan 2020 12:07:58 +0100
Message-Id: <20200117110758.1995-5-thuth@redhat.com>
In-Reply-To: <20200117110758.1995-1-thuth@redhat.com>
References: <20200117110758.1995-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: BEsFnOJxPm-coQyk_jcmxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Since commit 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add
implementation for INDEX_op_ld16u_i64") has been included now, we
can also run the TCG tests with tci, so let's enable them in our
Gitlab CI now.

Message-Id: <20191127155105.3784-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dce8f2d3f5..d9a90f795d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -87,6 +87,7 @@ build-tci:
  - ../configure --enable-tcg-interpreter
       --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; =
done)"
  - make -j2
+ - make run-tcg-tests-x86_64-softmmu
  - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/px=
e-test
  - for tg in $TARGETS ; do
      export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
--=20
2.18.1


