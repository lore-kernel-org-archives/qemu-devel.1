Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA2B21D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ7Zx2pR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA2B21D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVXJ-00021U-MG
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIVWo-0001bO-SC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kIVWm-0004fO-8p
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600255383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gEhXq/KFo2mGq0q7NJVjnSRKOCYiAZ2FLz5+hSm5pSY=;
 b=IQ7Zx2pRBmIE9HtWfToDYW0fM/s7M/l+tdHlAeW87x9NO+xp/bczxgsUghKTvHEx0XGKQU
 SstV/+lSoluEFQS6oeiz1PQIijuSh44fY6GM+ANNtgXwCmvJKLxQ+IvSM98R5PF6woPrzk
 hd/EX35g0M8fsMYKajGI3Aq/7AOom2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-4UOcKLPEOx6S1N6Vi9mGvA-1; Wed, 16 Sep 2020 07:22:59 -0400
X-MC-Unique: 4UOcKLPEOx6S1N6Vi9mGvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C871007380;
 Wed, 16 Sep 2020 11:22:57 +0000 (UTC)
Received: from localhost (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 858A760CCC;
 Wed, 16 Sep 2020 11:22:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] virtiofsd: document cache=auto default
Date: Wed, 16 Sep 2020 12:22:50 +0100
Message-Id: <20200916112250.760245-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: virtio-fs@redhat.com, "Harry G. Coin" <hgcoin@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogIkhhcnJ5IEcuIENvaW4iIDxoZ2NvaW5AZ21haWwuY29tPgoKVGhlIHZpcnRpb2ZzZCAt
LWhlbHAgb3V0cHV0IGRvY3VtZW50cyB0aGUgY2FjaGU9YXV0byBkZWZhdWx0IHZhbHVlIGJ1dAp0
aGUgbWFuIHBhZ2UgZG9lcyBub3QuIEZpeCB0aGlzLgoKU2lnbmVkLW9mZi1ieTogSGFycnkgRy4g
Q29pbiA8aGdjb2luQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUByZWRoYXQuY29tPgotLS0KIGRvY3MvdG9vbHMvdmlydGlvZnNkLnJzdCB8IDEgKwog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZG9jcy90b29scy92
aXJ0aW9mc2QucnN0IGIvZG9jcy90b29scy92aXJ0aW9mc2QucnN0CmluZGV4IGUzM2M4MWVkNDEu
LjM1MmEyOWNlM2MgMTAwNjQ0Ci0tLSBhL2RvY3MvdG9vbHMvdmlydGlvZnNkLnJzdAorKysgYi9k
b2NzL3Rvb2xzL3ZpcnRpb2ZzZC5yc3QKQEAgLTEwMyw2ICsxMDMsNyBAQCBPcHRpb25zCiAgIGZv
cmJpZHMgdGhlIEZVU0UgY2xpZW50IGZyb20gY2FjaGluZyB0byBhY2hpZXZlIGJlc3QgY29oZXJl
bmN5IGF0IHRoZSBjb3N0IG9mCiAgIHBlcmZvcm1hbmNlLiAgYGBhdXRvYGAgYWN0cyBzaW1pbGFy
IHRvIE5GUyB3aXRoIGEgMSBzZWNvbmQgbWV0YWRhdGEgY2FjaGUKICAgdGltZW91dC4gIGBgYWx3
YXlzYGAgc2V0cyBhIGxvbmcgY2FjaGUgbGlmZXRpbWUgYXQgdGhlIGV4cGVuc2Ugb2YgY29oZXJl
bmN5LgorICBUaGUgZGVmYXVsdCBpcyBgYGF1dG9gYC4KIAogRXhhbXBsZXMKIC0tLS0tLS0tCi0t
IAoyLjI2LjIKCg==


