Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48777C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77834208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X327hNTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77834208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGWra-0000S5-Cr
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 20:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGWqs-0008QT-Gm
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:23:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGWqp-0000tA-Ug
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599783818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ofoTr6pbu0BQoyMo87r9E4ANE2rBpWuYtrqlFMHgvrg=;
 b=X327hNTbgZaUqwAMNYB7hsUIGzLG1PU/0h/k5qKdAN2xyrsgGqjOgoPMypBA4CuadG/66L
 N7KFdoGUvAlbCQ7bHEBJFqHGhPu9fB1PX6kN7qQLGwQm4Zof21M61sf/c5zjsXLclXmV49
 GvFIjYqmR9ZTOC/YkxOGyJ5sj5bTeLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-KVgwRT3BP_e4nmCD3MBTsQ-1; Thu, 10 Sep 2020 20:23:36 -0400
X-MC-Unique: KVgwRT3BP_e4nmCD3MBTsQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721171006714;
 Fri, 11 Sep 2020 00:23:35 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2116210013D9;
 Fri, 11 Sep 2020 00:23:34 +0000 (UTC)
Date: Thu, 10 Sep 2020 20:23:33 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: fixup! docs: Move object.h overview doc comment to qom.rst
Message-ID: <20200911002333.GP1618070@habkost.net>
References: <20200910221526.10041-1-ehabkost@redhat.com>
 <20200910221526.10041-10-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910221526.10041-10-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 20:23:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 06:15:26PM -0400, Eduardo Habkost wrote:
> Move the whole contents of the overview doc comment from object.h
> to qom.rst.
> 
> This makes the documentation source easier to read and edit, and
> also solves the backslash escaping issue at the typecasting macro
> examples.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Fixup for a bug I introduced accidentally before sending the
series.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 2070a2ced4..1a2e5dc661 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -80,7 +80,7 @@ specific type:
 .. code-block::
    :caption: Typecasting macros
 
-#define MY_DEVICE_GET_CLASS(obj) \
+    #define MY_DEVICE_GET_CLASS(obj) \
       OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
    #define MY_DEVICE_CLASS(klass) \
       OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)

-- 
Eduardo


