Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06CAC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F24B218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzNxRzxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F24B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY7P-0005oy-Kg
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4g-0001BO-P3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42469
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4d-0003jf-I2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=swxwgPNJA0kCw8ve561kB+YcpWzG8SXkzcWHziTPdMI=;
 b=YzNxRzxVjexe2Cuyk7EsFg66PgaXJUmypIrcynaOxXR7K61ifYVC+q3WWafwi4DYOKQFnT
 7lad+P5vXqoq3glP6c9GhyYJqA9rit/U9gJNzHr2ajSgQiIaG/ubO+F4MvG84EGBMqaLdE
 IN6SzShcfkUU5E3yxg4vbkjrUcegjto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-mRhcCKn1O-CuM7XmNvEo8g-1; Tue, 08 Sep 2020 03:29:46 -0400
X-MC-Unique: mRhcCKn1O-CuM7XmNvEo8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3154F18B9EC3
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:45 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16C62811BC;
 Tue,  8 Sep 2020 07:29:40 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 00/10] edk2: adopt the edk2-stable202008 release
Date: Tue,  8 Sep 2020 09:29:29 +0200
Message-Id: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmVmOiAgICBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC9xZW11LytidWcvMTg1MjE5NgpSZXBv
OiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sZXJzZWsvcWVtdS5naXQKQnJhbmNoOiBlZGsyc3RhYmxl
MjAyMDA4X2xwXzE4NTIxOTYKClRoaXMgc2VyaWVzIGNvbnN1bWVzIHRoZSBmb2xsb3dpbmcgdXBz
dHJlYW0gZWRrMiByZWxlYXNlczoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3RpYW5vY29yZS9lZGsy
L3JlbGVhc2VzL3RhZy9lZGsyLXN0YWJsZTIwMTkwOAogIGh0dHBzOi8vZ2l0aHViLmNvbS90aWFu
b2NvcmUvZWRrMi9yZWxlYXNlcy90YWcvZWRrMi1zdGFibGUyMDE5MTEKICBodHRwczovL2dpdGh1
Yi5jb20vdGlhbm9jb3JlL2VkazIvcmVsZWFzZXMvdGFnL2VkazItc3RhYmxlMjAyMDAyCiAgaHR0
cHM6Ly9naXRodWIuY29tL3RpYW5vY29yZS9lZGsyL3JlbGVhc2VzL3RhZy9lZGsyLXN0YWJsZTIw
MjAwNQogIGh0dHBzOi8vZ2l0aHViLmNvbS90aWFub2NvcmUvZWRrMi9yZWxlYXNlcy90YWcvZWRr
Mi1zdGFibGUyMDIwMDgKCldvcnRoIG1lbnRpb25pbmcgKGluIHJhbmRvbSBvcmRlcik6CgotIHZh
cmlvdXMgQ1ZFIGZpeGVzIChzZWUgc2hvcnRsb2cpCi0gT3BlblNTTC0xLjEuMWcKLSBVRUZJIEhU
VFBTIEJvb3QgZm9yIEFSTS9BQVJDSDY0Ci0gVFBNMiBmb3IgQVJNL0FBUkNINjQKLSBWQ1BVIGhv
dHBsdWcgd2l0aCBTTUkKLSBzdXBwb3J0IGZvciBMaW51eCB2NS43KyBpbml0cmQgYW5kIG1peGVk
IG1vZGUgbG9hZGluZwotIEZ1c2lvbi1NUFQgU0NTSSBkcml2ZXIgaW4gT1ZNRgotIFZNd2FyZSBQ
VlNDU0kgZHJpdmVyIGluIE9WTUYKLSBQWEV2NCAvIFBYRXY2IGJvb3QgcG9zc2libGUgdG8gZGlz
YWJsZSBvbiB0aGUgUUVNVSBjb21tYW5kIGxpbmUKLSBTRVYtRVMgc3VwcG9ydAoKVGhlIElBMzIg
YW5kIFg2NCBiaW5hcmllcyBhcmUgbm93IHNtYWxsZXIgLS0gdGhlIHJlYXNvbiBpcyB0aGF0IEkg
YnVpdAp0aGVtIHdpdGggRGV2VG9vbFNldCA5IChnY2MtOSkgb24gUkhFTDcsIGFuZCBzbyB0aGlz
IGlzIHRoZSBmaXJzdCB0aW1lCnRoZXkndmUgdW5kZXJnb25lIExUTyAod2l0aCB0aGUgR0NDNSBl
ZGsyIHRvb2xjaGFpbiBzZXR0aW5ncykuCgpDYzogIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEBy
ZWRoYXQuY29tPgpDYzogSWdvciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4KQ2M6IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4KClRoYW5rcywKTGFzemxv
CgpMYXN6bG8gRXJzZWsgKDEwKToKICBNYWtlZmlsZTogcmVtb3ZlIG9ic29sZXRlIGVkazIgZXhj
ZXB0aW9uIGZyb20gImNsZWFuIiBydWxlCiAgcm9tcy9lZmlyb20sIHRlc3RzL3VlZmktdGVzdC10
b29sczogdXBkYXRlIGVkazIncyBvd24gc3VibW9kdWxlcyBmaXJzdAogIHJvbXMvTWFrZWZpbGUu
ZWRrMjogcHJlcGFyZSBmb3IgcmVwbGFjaW5nIFRQTTIqX0VOQUJMRSBtYWNyb3MKICB0ZXN0czog
YWNwaTogdG9sZXJhdGUgInZpcnQvU1NEVC5tZW1ocCIgbWlzbWF0Y2ggdGVtcG9yYXJpbHkKICBy
b21zL2VkazI6IHVwZGF0ZSBzdWJtb2R1bGUgZnJvbSBlZGsyLXN0YWJsZTIwMTkwNSB0bwogICAg
ZWRrMi1zdGFibGUyMDIwMDgKICByb21zL01ha2VmaWxlLmVkazI6IGNvbXBsZXRlIHJlcGxhY2lu
ZyBUUE0yKl9FTkFCTEUgbWFjcm9zCiAgcm9tcy9NYWtlZmlsZS5lZGsyOiBlbmFibGUgbmV3IEFS
TS9BQVJDSDY0IGZsYWdzIHVwIHRvCiAgICBlZGsyLXN0YWJsZTIwMjAwOAogIHBjLWJpb3M6IHJl
ZnJlc2ggZWRrMiBidWlsZCBhcnRpZmFjdHMgZm9yIGVkazItc3RhYmxlMjAyMDA4CiAgcGMtYmlv
czogdXBkYXRlIHRoZSBSRUFETUUgZmlsZSB3aXRoIGVkazItc3RhYmxlMjAyMDA4IGluZm9ybWF0
aW9uCiAgdGVzdHM6IGFjcGk6IHVwZGF0ZSAidmlydC9TU0RULm1lbWhwIiBmb3IgZWRrMi1zdGFi
bGUyMDIwMDgKCiBNYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAt
CiBwYy1iaW9zL1JFQURNRSAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNCArLS0KIHBjLWJp
b3MvZWRrMi1hYXJjaDY0LWNvZGUuZmQuYnoyICAgICAgIHwgQmluIDExNzgwNzAgLT4gMTUwNzcy
MiBieXRlcwogcGMtYmlvcy9lZGsyLWFybS1jb2RlLmZkLmJ6MiAgICAgICAgICAgfCBCaW4gMTE3
Mjc1MiAtPiAxNTAzMTg3IGJ5dGVzCiBwYy1iaW9zL2VkazItaTM4Ni1jb2RlLmZkLmJ6MiAgICAg
ICAgICB8IEJpbiAxNzM2MTk5IC0+IDE2NDY3NDEgYnl0ZXMKIHBjLWJpb3MvZWRrMi1pMzg2LXNl
Y3VyZS1jb2RlLmZkLmJ6MiAgIHwgQmluIDE5NDM5NDkgLT4gMTg2MDU0NiBieXRlcwogcGMtYmlv
cy9lZGsyLXg4Nl82NC1jb2RlLmZkLmJ6MiAgICAgICAgfCBCaW4gMTcxNzA5NCAtPiAxNjgwMTY0
IGJ5dGVzCiBwYy1iaW9zL2VkazIteDg2XzY0LXNlY3VyZS1jb2RlLmZkLmJ6MiB8IEJpbiAxOTU4
MDM3IC0+IDE5MTIxMTIgYnl0ZXMKIHJvbXMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxICsKIHJvbXMvTWFrZWZpbGUuZWRrMiAgICAgICAgICAgICAgICAgICAgIHwgIDI2
ICsrKysrKysrKysrKy0tLS0tLS0tCiByb21zL2VkazIgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgMiArLQogdGVzdHMvZGF0YS9hY3BpL3ZpcnQvU1NEVC5tZW1ocCAgICAgICAgfCBC
aW4gNzM2IC0+IDczNiBieXRlcwogdGVzdHMvdWVmaS10ZXN0LXRvb2xzL01ha2VmaWxlICAgICAg
ICAgfCAgIDEgKwogMTMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRp
b25zKC0pCgoKYmFzZS1jb21taXQ6IDlkNTU4OWJiM2ZlZWQ0NDJhZTdlZTI0ZDJkODgyYWEwMzEy
MzQ5YTYKLS0gCjIuMTkuMS4zLmczMDI0N2FhNWQyMDEKCg==


