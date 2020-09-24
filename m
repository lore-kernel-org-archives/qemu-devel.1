Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEAEC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC2021D24
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+E0S1dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC2021D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLT4V-00046Q-A1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSzG-0006Qf-F8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSz8-0003x5-I9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ahlddk+iewwx5/PR/zEk/CKIz3WSU4EAu9WhOmcyRoY=;
 b=B+E0S1dWDhARZkTBlPf0hhh9aD6ODUAytiIKOgILnLcWCFqMC0uJkVME5HoQsKfAed/0jt
 wxbBb/XP2qaO5QwlXY1vjFmuIi4sevfG5BBOG/vKLtiPWQXWti8auBBVCim1mFjMwKqbtA
 3Z1WdmLlzXAqssDx+e7zOcmvyhMAdGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-70t_fZW9Mv-TyL0Q_z_dCg-1; Thu, 24 Sep 2020 11:16:34 -0400
X-MC-Unique: 70t_fZW9Mv-TyL0Q_z_dCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC561801E53;
 Thu, 24 Sep 2020 15:16:32 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6158860C04;
 Thu, 24 Sep 2020 15:16:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/13] util/vhost-user-server: move header to include/
Date: Thu, 24 Sep 2020 16:15:48 +0100
Message-Id: <20200924151549.913737-13-stefanha@redhat.com>
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVhZGVycyB1c2VkIGJ5IG90aGVyIHN1YnN5c3RlbXMgYXJlIGxvY2F0ZWQgaW4gaW5jbHVkZS8u
IEFsc28gYWRkIHRoZQp2aG9zdC11c2VyLXNlcnZlciBhbmQgdmhvc3QtdXNlci1ibGstc2VydmVy
IGhlYWRlcnMgdG8gTUFJTlRBSU5FUlMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgNCArKystCiB7dXRpbCA9PiBpbmNsdWRlL3FlbXV9L3Zob3N0LXVzZXIt
c2VydmVyLmggfCAwCiBibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMgICAgICAg
fCAyICstCiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmMgICAgICAgICAgICAgICAgICAgfCAyICst
CiA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKIHJlbmFt
ZSB7dXRpbCA9PiBpbmNsdWRlL3FlbXV9L3Zob3N0LXVzZXItc2VydmVyLmggKDEwMCUpCgpkaWZm
IC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwppbmRleCA1NWFkNmFiZTczLi40ZDFk
N2MxODU0IDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMzA0
Myw5ICszMDQzLDExIEBAIFZob3N0LXVzZXIgYmxvY2sgZGV2aWNlIGJhY2tlbmQgc2VydmVyCiBN
OiBDb2lieSBYdSA8Q29pYnkuWHVAZ21haWwuY29tPgogUzogTWFpbnRhaW5lZAogRjogYmxvY2sv
ZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jCi1GOiB1dGlsL3Zob3N0LXVzZXItc2VydmVy
LmMKK0Y6IGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuaAorRjogaW5jbHVkZS9x
ZW11L3Zob3N0LXVzZXItc2VydmVyLmgKIEY6IHRlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRl
c3QuYwogRjogdGVzdHMvcXRlc3QvbGlicW9zL3Zob3N0LXVzZXItYmxrLmMKK0Y6IHV0aWwvdmhv
c3QtdXNlci1zZXJ2ZXIuYwogCiBSZXBsaWNhdGlvbgogTTogV2VuIENvbmd5YW5nIDx3ZW5jb25n
eWFuZzJAaHVhd2VpLmNvbT4KZGlmZiAtLWdpdCBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuaCBi
L2luY2x1ZGUvcWVtdS92aG9zdC11c2VyLXNlcnZlci5oCnNpbWlsYXJpdHkgaW5kZXggMTAwJQpy
ZW5hbWUgZnJvbSB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmgKcmVuYW1lIHRvIGluY2x1ZGUvcWVt
dS92aG9zdC11c2VyLXNlcnZlci5oCmRpZmYgLS1naXQgYS9ibG9jay9leHBvcnQvdmhvc3QtdXNl
ci1ibGstc2VydmVyLmMgYi9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKaW5k
ZXggOTFmYzcwNDBiMi4uODEwNzJhNWE0NiAxMDA2NDQKLS0tIGEvYmxvY2svZXhwb3J0L3Zob3N0
LXVzZXItYmxrLXNlcnZlci5jCisrKyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2
ZXIuYwpAQCAtMTMsNyArMTMsNyBAQAogI2luY2x1ZGUgImJsb2NrL2Jsb2NrLmgiCiAjaW5jbHVk
ZSAiY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaCIKICNpbmNsdWRlICJzdGFu
ZGFyZC1oZWFkZXJzL2xpbnV4L3ZpcnRpb19ibGsuaCIKLSNpbmNsdWRlICJ1dGlsL3Zob3N0LXVz
ZXItc2VydmVyLmgiCisjaW5jbHVkZSAicWVtdS92aG9zdC11c2VyLXNlcnZlci5oIgogI2luY2x1
ZGUgInZob3N0LXVzZXItYmxrLXNlcnZlci5oIgogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCIKICNp
bmNsdWRlICJxb20vb2JqZWN0X2ludGVyZmFjZXMuaCIKZGlmZiAtLWdpdCBhL3V0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXIuYyBiL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwppbmRleCAyYTI3MTM5ZWI4
Li4zZmQyNmM5ZjMwIDEwMDY0NAotLS0gYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKKysrIGIv
dXRpbC92aG9zdC11c2VyLXNlcnZlci5jCkBAIC05LDggKzksOCBAQAogICovCiAjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIgogI2luY2x1ZGUgInFlbXUvbWFpbi1sb29wLmgiCisjaW5jbHVkZSAicWVt
dS92aG9zdC11c2VyLXNlcnZlci5oIgogI2luY2x1ZGUgImJsb2NrL2Fpby13YWl0LmgiCi0jaW5j
bHVkZSAidmhvc3QtdXNlci1zZXJ2ZXIuaCIKIAogLyoKICAqIFRoZW9yeSBvZiBvcGVyYXRpb246
Ci0tIAoyLjI2LjIKCg==


