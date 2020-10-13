Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B20C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3331220659
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 11:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC1pC3lS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3331220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSI9u-0001rA-47
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 07:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyV-0005Wx-4R
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSHyR-0006FC-De
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602586565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=HFWVGxZUvbmsJDFetUBPlJ5LZnoIYXTDI/5efETFvOQ=;
 b=ZC1pC3lSN1If7yDa/elyFuQtYVZ57Thr96gmiiY1Yxf3kr2HEMN9DT0egPY0PARBTUnA97
 GzB6AuFEBGff8RaAN0ZNQdDcu3LqHhX+B3KDb2p0ogK4S63SFuNk7hx2CpD4B11rIqWo2m
 t016jIYEcUhIgqaY1vyoQvwrgP0Cgbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-QG2ON734NbqZmuxaFdJERA-1; Tue, 13 Oct 2020 06:56:02 -0400
X-MC-Unique: QG2ON734NbqZmuxaFdJERA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C88D8030BA;
 Tue, 13 Oct 2020 10:56:01 +0000 (UTC)
Received: from thuth.com (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95126EF41;
 Tue, 13 Oct 2020 10:55:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/23] docs/system/deprecated: Mark the 'moxie' CPU as
 deprecated
Date: Tue, 13 Oct 2020 12:55:16 +0200
Message-Id: <20201013105527.20088-13-thuth@redhat.com>
In-Reply-To: <20201013105527.20088-1-thuth@redhat.com>
References: <20201013105527.20088-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is currently unclear whether anybody is still using the 'moxie' CPU,
and there are no images for testing available this CPU, so the code has
likely bit-rotten in the course of time. When I asked the maintainer
for information, I did not get a reply within four weeks yet (see
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07201.html).
The last Signed-off-by line from Anthony in our repo is from 2013,
so it seems like this code is rather unmaintained. Time to put it onto
the deprecation list to see whether somebody is still interested in this
code or whether we could remove it in a couple of releases.

Message-Id: <20200923171815.97801-1-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/deprecated.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 5e8346f7bf..09ec8b1ae8 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -283,6 +283,14 @@ for VNC should be performed using the pluggable QAuthZ objects.
 System emulator CPUS
 --------------------
 
+``moxie`` CPU (since 5.2.0)
+'''''''''''''''''''''''''''
+
+The ``moxie`` guest CPU support is deprecated and will be removed in
+a future version of QEMU. It's unclear whether anybody is still using
+CPU emulation in QEMU, and there are no test images available to make
+sure that the code is still working.
+
 ``compat`` property of server class POWER CPUs (since 5.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-- 
2.18.2


