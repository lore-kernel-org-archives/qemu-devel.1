Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E8FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA992145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 09:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0TmPBdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA992145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFw7V-0004KT-18
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 05:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFw6v-0003th-Ub
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:09:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFw6t-000311-Ta
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 05:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599642586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4UdJ2oann9osaYh1MVcHJyU9RJPzV/YjIbmpxCe2CA4=;
 b=e0TmPBdkgxCp3ODOYdgbCybs4F02Px1q5RnONtPBgT1mCWmRBzoZU3WamLRRqMzCSDS9+5
 QvLbTPbWiX0nwgickW2LzlCsvMV146xaypsPvdpb7ED6SKzcNuvc1rnlo5abzY92L5eMu+
 VpLSGwYz/7qQoSmvZj9k+yRePq5Nmtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-OTkSQTUONBWKfP3NgpyRnA-1; Wed, 09 Sep 2020 05:09:44 -0400
X-MC-Unique: OTkSQTUONBWKfP3NgpyRnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8C8B1DDFF
 for <qemu-devel@nongnu.org>; Wed,  9 Sep 2020 09:09:43 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85EB85C1C2;
 Wed,  9 Sep 2020 09:09:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] MAINTAINERS: add Paolo Bonzini as RCU maintainer
Date: Wed,  9 Sep 2020 10:08:51 +0100
Message-Id: <20200909090851.14458-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:05:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIFJDVSBjb2RlIHRoYXQgUGFvbG8gbWFpbnRhaW5zIGlzIG1pc3NpbmcgYSBNQUlOVEFJTkVS
UyBmaWxlIGVudHJ5LgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIE1BSU5UQUlORVJTIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMK
aW5kZXggN2QwYTVlOTFlNC4uNTAyOTZjYWFjNCAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysr
IGIvTUFJTlRBSU5FUlMKQEAgLTIyOTEsNiArMjI5MSwxNCBAQCBGOiBzb2Z0bW11L2NwdXMuYwog
Rjogc29mdG1tdS9jcHUtdGhyb3R0bGUuYwogRjogcWFwaS9ydW4tc3RhdGUuanNvbgogCitSZWFk
LCBDb3B5LCBVcGRhdGUgKFJDVSkKK006IFBhb2xvIEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5j
b20+CitTOiBNYWludGFpbmVkCitGOiBpbmNsdWRlL3FlbXUvcmN1Ki5oCitGOiB0ZXN0cy9yY3V0
b3J0dXJlLmMKK0Y6IHRlc3RzL3Rlc3QtcmN1LSouYworRjogdXRpbC9yY3UuYworCiBIdW1hbiBN
b25pdG9yIChITVApCiBNOiBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IDxkZ2lsYmVydEByZWRoYXQu
Y29tPgogUzogTWFpbnRhaW5lZAotLSAKMi4yNi4yCgo=


