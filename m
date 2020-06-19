Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84485C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504E1207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEsgXa7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504E1207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFnT-000572-JZ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhy-0004ix-C0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60689
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFhv-0006bx-HK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eBszrZF1I98U/hQogfZ1smFo4dHaMqYHR5OPOupl3lY=;
 b=EEsgXa7uDdtUGvBuDLCEt2/MlsgIISwt+3fWfLcN3y1SO8fnMh264gjuDe8mcdE539DVkG
 N9eAb9blcrf01c3gvEcligHbvyZZtZJbmImRxUhY8Tbo50ZvbjiyPLncquO/QSPtmG6+xw
 6eIR8nl0hQy0juAzRzmbrIR5Q/V6y9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-leVTzzBwNGuPbVmZo2t7gA-1; Fri, 19 Jun 2020 08:01:17 -0400
X-MC-Unique: leVTzzBwNGuPbVmZo2t7gA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EDA107ACF2;
 Fri, 19 Jun 2020 12:01:16 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D84819C79;
 Fri, 19 Jun 2020 12:01:15 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 5/6] vhost-user-server: fix s/initialized/initialize/ typo
Date: Fri, 19 Jun 2020 13:00:45 +0100
Message-Id: <20200619120046.2422205-5-stefanha@redhat.com>
In-Reply-To: <20200619120046.2422205-1-stefanha@redhat.com>
References: <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619120046.2422205-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIHByZXNlbnQgdGVuc2UgaXMgdXNlZCBoZXJlLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhh
am5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgotLS0KIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIu
YyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyBiL3V0aWwvdmhvc3QtdXNlci1z
ZXJ2ZXIuYwppbmRleCBhNTc4NWNiZjg2Li40MmE1MWQxOTBjIDEwMDY0NAotLS0gYS91dGlsL3Zo
b3N0LXVzZXItc2VydmVyLmMKKysrIGIvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCkBAIC0yNzks
NyArMjc5LDcgQEAgc3RhdGljIHZvaWQgdnVfYWNjZXB0KFFJT05ldExpc3RlbmVyICpsaXN0ZW5l
ciwgUUlPQ2hhbm5lbFNvY2tldCAqc2lvYywKIAogICAgIGlmICghdnVfaW5pdCgmc2VydmVyLT52
dV9kZXYsIHNlcnZlci0+bWF4X3F1ZXVlcywgc2lvYy0+ZmQsIHBhbmljX2NiLAogICAgICAgICAg
ICAgICAgICB2dV9tZXNzYWdlX3JlYWQsIHNldF93YXRjaCwgcmVtb3ZlX3dhdGNoLCBzZXJ2ZXIt
PnZ1X2lmYWNlKSkgewotICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxlZCB0byBpbml0aWFsaXpl
ZCBsaWJ2aG9zdC11c2VyIik7CisgICAgICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGluaXRp
YWxpemUgbGlidmhvc3QtdXNlciIpOwogICAgICAgICByZXR1cm47CiAgICAgfQogCi0tIAoyLjI2
LjIKCg==


