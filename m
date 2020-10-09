Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA28C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714F122282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhSu2OEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714F122282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyNy-0008Sh-Ch
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCj-0002W7-Rb
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58477)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCe-00033E-L1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFnVhMLuEriDxJ4B0fq+DMN68qIzPOHHtQfUhTd9ezk=;
 b=hhSu2OEQF/JX5PfvW7EwjzCdMihikFGt9vcDGSYBvYeXkj0MoKqSq+vl02e4UsefPD7dh2
 cBMhaeYW5NHggS43UcCJ3EhafWQ4WGdt0EYiqXbh+s9sUg3b4Id/1OlPTseHyiieeRwkjM
 p/fh9Prx/l8N6ABWMusD4rkYCAKHJLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-GyPmFJ95PzaDulAefgiBAg-1; Fri, 09 Oct 2020 15:37:17 -0400
X-MC-Unique: GyPmFJ95PzaDulAefgiBAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55CBC87951E;
 Fri,  9 Oct 2020 19:37:15 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC5C576660;
 Fri,  9 Oct 2020 19:37:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 19/30] util/vhost-user-server: move header to include/
Date: Fri,  9 Oct 2020 20:35:18 +0100
Message-Id: <20201009193529.322822-20-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGVhZGVycyB1c2VkIGJ5IG90aGVyIHN1YnN5c3RlbXMgYXJlIGxvY2F0ZWQgaW4gaW5jbHVkZS8u
IEFsc28gYWRkIHRoZQp2aG9zdC11c2VyLXNlcnZlciBhbmQgdmhvc3QtdXNlci1ibGstc2VydmVy
IGhlYWRlcnMgdG8gTUFJTlRBSU5FUlMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ck1lc3NhZ2UtaWQ6IDIwMjAwOTI0MTUxNTQ5LjkxMzczNy0x
My1zdGVmYW5oYUByZWRoYXQuY29tClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3Rl
ZmFuaGFAcmVkaGF0LmNvbT4KLS0tCiBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCA0ICsrKy0KIHt1dGlsID0+IGluY2x1ZGUvcWVtdX0vdmhvc3QtdXNlci1zZXJ2
ZXIuaCB8IDAKIGJsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyAgICAgICB8IDIg
Ky0KIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYyAgICAgICAgICAgICAgICAgICB8IDIgKy0KIDQg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQogcmVuYW1lIHt1
dGlsID0+IGluY2x1ZGUvcWVtdX0vdmhvc3QtdXNlci1zZXJ2ZXIuaCAoMTAwJSkKCmRpZmYgLS1n
aXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDI4MjYyMzE5ZGIuLjU5ZmNhZjk3
MDYgMTAwNjQ0Ci0tLSBhL01BSU5UQUlORVJTCisrKyBiL01BSU5UQUlORVJTCkBAIC0zMDcyLDkg
KzMwNzIsMTEgQEAgVmhvc3QtdXNlciBibG9jayBkZXZpY2UgYmFja2VuZCBzZXJ2ZXIKIE06IENv
aWJ5IFh1IDxDb2lieS5YdUBnbWFpbC5jb20+CiBTOiBNYWludGFpbmVkCiBGOiBibG9jay9leHBv
cnQvdmhvc3QtdXNlci1ibGstc2VydmVyLmMKLUY6IHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwor
RjogYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5oCitGOiBpbmNsdWRlL3FlbXUv
dmhvc3QtdXNlci1zZXJ2ZXIuaAogRjogdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5j
CiBGOiB0ZXN0cy9xdGVzdC9saWJxb3Mvdmhvc3QtdXNlci1ibGsuYworRjogdXRpbC92aG9zdC11
c2VyLXNlcnZlci5jCiAKIFJlcGxpY2F0aW9uCiBNOiBXZW4gQ29uZ3lhbmcgPHdlbmNvbmd5YW5n
MkBodWF3ZWkuY29tPgpkaWZmIC0tZ2l0IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5oIGIvaW5j
bHVkZS9xZW11L3Zob3N0LXVzZXItc2VydmVyLmgKc2ltaWxhcml0eSBpbmRleCAxMDAlCnJlbmFt
ZSBmcm9tIHV0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuaApyZW5hbWUgdG8gaW5jbHVkZS9xZW11L3Zo
b3N0LXVzZXItc2VydmVyLmgKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJs
ay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwppbmRleCA5
MWZjNzA0MGIyLi44MTA3MmE1YTQ2IDEwMDY0NAotLS0gYS9ibG9jay9leHBvcnQvdmhvc3QtdXNl
ci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
CkBAIC0xMyw3ICsxMyw3IEBACiAjaW5jbHVkZSAiYmxvY2svYmxvY2suaCIKICNpbmNsdWRlICJj
b250cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oIgogI2luY2x1ZGUgInN0YW5kYXJk
LWhlYWRlcnMvbGludXgvdmlydGlvX2Jsay5oIgotI2luY2x1ZGUgInV0aWwvdmhvc3QtdXNlci1z
ZXJ2ZXIuaCIKKyNpbmNsdWRlICJxZW11L3Zob3N0LXVzZXItc2VydmVyLmgiCiAjaW5jbHVkZSAi
dmhvc3QtdXNlci1ibGstc2VydmVyLmgiCiAjaW5jbHVkZSAicWFwaS9lcnJvci5oIgogI2luY2x1
ZGUgInFvbS9vYmplY3RfaW50ZXJmYWNlcy5oIgpkaWZmIC0tZ2l0IGEvdXRpbC92aG9zdC11c2Vy
LXNlcnZlci5jIGIvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCmluZGV4IDJhMjcxMzllYjguLjNm
ZDI2YzlmMzAgMTAwNjQ0Ci0tLSBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYworKysgYi91dGls
L3Zob3N0LXVzZXItc2VydmVyLmMKQEAgLTksOCArOSw4IEBACiAgKi8KICNpbmNsdWRlICJxZW11
L29zZGVwLmgiCiAjaW5jbHVkZSAicWVtdS9tYWluLWxvb3AuaCIKKyNpbmNsdWRlICJxZW11L3Zo
b3N0LXVzZXItc2VydmVyLmgiCiAjaW5jbHVkZSAiYmxvY2svYWlvLXdhaXQuaCIKLSNpbmNsdWRl
ICJ2aG9zdC11c2VyLXNlcnZlci5oIgogCiAvKgogICogVGhlb3J5IG9mIG9wZXJhdGlvbjoKLS0g
CjIuMjYuMgoK


