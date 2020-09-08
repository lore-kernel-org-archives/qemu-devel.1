Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F284C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3A72166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRvNg56A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3A72166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa0r-0007wG-7Y
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyT-0003an-Cz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyQ-0001wu-HN
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ESv+DcBmypfJUh4v6qfmkBeqJO22AIISs1JJWaC7Tdk=;
 b=bRvNg56AYBj54LARP9otcNunpR8VVeHJv0yQuzm2t6cc1p3VrQ7arLYhrao+9XpyS6ewcu
 DwemcgQznCb71IFOcqO368IBPHFh3/9AHEvXie3gPSft5fftBJ5we0S2+cLCOmqMwon+Qx
 Ux7W9+Vt0tl4HWMuX2mA0UwRbIi03QM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-niHDI6EQOp-B5xNCmQmdfQ-1; Tue, 08 Sep 2020 05:31:29 -0400
X-MC-Unique: niHDI6EQOp-B5xNCmQmdfQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366201074642;
 Tue,  8 Sep 2020 09:31:28 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E517FB96;
 Tue,  8 Sep 2020 09:31:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] docs: generate qemu-storage-daemon-qmp-ref(7) man page
Date: Tue,  8 Sep 2020 10:31:11 +0100
Message-Id: <20200908093113.47564-3-stefanha@redhat.com>
In-Reply-To: <20200908093113.47564-1-stefanha@redhat.com>
References: <20200908093113.47564-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWx0aG91Z2ggcWVtdS1zdG9yYWdlLWRhZW1vbiBRTVAgY29tbWFuZHMgYXJlIGlkZW50aWNhbCB0
byBRRU1VIFFNUApjb21tYW5kcyB0aGV5IGFyZSBhIHN1YnNldC4gR2VuZXJhdGUgYSBtYW51YWwg
cGFnZSBvZiBqdXN0IHRoZSBjb21tYW5kcwpzdXBwb3J0ZWQgYnkgcWVtdS1zdG9yYWdlLWRhZW1v
biBzbyB0aGF0IHVzZXJzIGtub3cgZXhhY3RseSB3aGF0IGlzCmF2YWlsYWJsZSBpbiBxZW11LXN0
b3JhZ2UtZGFlbW9uLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBy
ZWRoYXQuY29tPgotLS0KIGRvY3MvaW50ZXJvcC9xZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYu
dGV4aSB8IDgwICsrKysrKysrKysrKysrKysrKysKIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICA5ICsrKwogc3RvcmFnZS1kYWVtb24vcWFwaS9tZXNvbi5i
dWlsZCAgICAgICAgICAgICAgIHwgIDIgKwogMyBmaWxlcyBjaGFuZ2VkLCA5MSBpbnNlcnRpb25z
KCspCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9pbnRlcm9wL3FlbXUtc3RvcmFnZS1kYWVtb24t
cW1wLXJlZi50ZXhpCgpkaWZmIC0tZ2l0IGEvZG9jcy9pbnRlcm9wL3FlbXUtc3RvcmFnZS1kYWVt
b24tcW1wLXJlZi50ZXhpIGIvZG9jcy9pbnRlcm9wL3FlbXUtc3RvcmFnZS1kYWVtb24tcW1wLXJl
Zi50ZXhpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLmE2YTcwYzk2NzQK
LS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL2ludGVyb3AvcWVtdS1zdG9yYWdlLWRhZW1vbi1xbXAt
cmVmLnRleGkKQEAgLTAsMCArMSw4MCBAQAorXGlucHV0IHRleGluZm8KK0BzZXRmaWxlbmFtZSBx
ZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYuaW5mbworCitAaW5jbHVkZSB2ZXJzaW9uLnRleGkK
KworQGV4YW1wbGVpbmRlbnQgMAorQHBhcmFncmFwaGluZGVudCAwCisKK0BzZXR0aXRsZSBRRU1V
IFN0b3JhZ2UgRGFlbW9uIFFNUCBSZWZlcmVuY2UgTWFudWFsCisKK0BpZnRleAorQGNlbnRlciBA
aW1hZ2V7ZG9jcy9xZW11X2xvZ299CitAZW5kIGlmdGV4CisKK0Bjb3B5aW5nCitUaGlzIGlzIHRo
ZSBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCByZWZlcmVuY2UgbWFudWFsLgorCitDb3B5cmlnaHQg
QGNvcHlyaWdodHt9IDIwMjAgVGhlIFFFTVUgUHJvamVjdCBkZXZlbG9wZXJzCisKK0BxdW90YXRp
b24KK1RoaXMgbWFudWFsIGlzIGZyZWUgZG9jdW1lbnRhdGlvbjogeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yCittb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBhcworcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5k
YXRpb24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlCitMaWNlbnNlLCBvciAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLgorCitUaGlzIG1hbnVhbCBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKK1dJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKK01FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VCitHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisKK1lvdSBzaG91bGQgaGF2ZSByZWNl
aXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCithbG9uZyB3aXRo
IHRoaXMgbWFudWFsLiAgSWYgbm90LCBzZWUgaHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLy4K
K0BlbmQgcXVvdGF0aW9uCitAZW5kIGNvcHlpbmcKKworQGRpcmNhdGVnb3J5IFFFTVUKK0BkaXJl
bnRyeQorKiBRRU1VLVN0b3JhZ2UtRGFlbW9uLVFNUC1SZWY6IChxZW11LXN0b3JhZ2UtZGFlbW9u
LXFtcC1yZWYpLiBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCBSZWZlcmVuY2UgTWFudWFsCitAZW5k
IGRpcmVudHJ5CisKK0B0aXRsZXBhZ2UKK0B0aXRsZSBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCBS
ZWZlcmVuY2UgTWFudWFsCitAc3VidGl0bGUgUUVNVSB2ZXJzaW9uIEB2YWx1ZXtWRVJTSU9OfQor
QHBhZ2UKK0B2c2tpcCAwcHQgcGx1cyAxZmlsbGwKK0BpbnNlcnRjb3B5aW5nCitAZW5kIHRpdGxl
cGFnZQorCitAY29udGVudHMKKworQGlmbm90dGV4CitAbm9kZSBUb3AKK0B0b3AgUUVNVSBTdG9y
YWdlIERhZW1vbiBRTVAgcmVmZXJlbmNlCitAZW5kIGlmbm90dGV4CisKK0BtZW51CisqIEFQSSBS
ZWZlcmVuY2U6OgorKiBDb21tYW5kcyBhbmQgRXZlbnRzIEluZGV4OjoKKyogRGF0YSBUeXBlcyBJ
bmRleDo6CitAZW5kIG1lbnUKKworQG5vZGUgQVBJIFJlZmVyZW5jZQorQGNoYXB0ZXIgQVBJIFJl
ZmVyZW5jZQorCitAYyBmb3IgdGV4aTJwb2Q6CitAYyBtYW4gYmVnaW4gREVTQ1JJUFRJT04KKwor
QGluY2x1ZGUgc3RvcmFnZS1kYWVtb24vcWFwaS9xYXBpLWRvYy50ZXhpCisKK0BjIG1hbiBlbmQK
KworQG5vZGUgQ29tbWFuZHMgYW5kIEV2ZW50cyBJbmRleAorQHVubnVtYmVyZWQgQ29tbWFuZHMg
YW5kIEV2ZW50cyBJbmRleAorQHByaW50aW5kZXggZm4KKworQG5vZGUgRGF0YSBUeXBlcyBJbmRl
eAorQHVubnVtYmVyZWQgRGF0YSBUeXBlcyBJbmRleAorQHByaW50aW5kZXggdHAKKworQGJ5ZQpk
aWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA1YWFhMzY0NzMwLi4w
ZmYxOWNlNjk5IDEwMDY0NAotLS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5idWlsZApAQCAt
MTE2Miw2ICsxMTYyLDE1IEBAIGlmIGJ1aWxkX2RvY3MKICAgaWYgJ0NPTkZJR19HVUVTVF9BR0VO
VCcgaW4gY29uZmlnX2hvc3QKICAgICB0ZXhpICs9IHsncWVtdS1nYS1yZWYnOiBbJ2RvY3MvaW50
ZXJvcC9xZW11LWdhLXJlZi50ZXhpJywgcWdhX3FhcGlfZG9jX3RleGksIHZlcnNpb25fdGV4aV19
CiAgIGVuZGlmCisgIGlmIGhhdmVfdG9vbHMKKyAgICB0ZXhpICs9IHsKKyAgICAgICdxZW11LXN0
b3JhZ2UtZGFlbW9uLXFtcC1yZWYnOiBbCisJJ2RvY3MvaW50ZXJvcC9xZW11LXN0b3JhZ2UtZGFl
bW9uLXFtcC1yZWYudGV4aScsCisJcXNkX3FhcGlfZG9jX3RleGksCisJdmVyc2lvbl90ZXhpCisg
ICAgICBdCisgICAgfQorICBlbmRpZgogCiAgIGlmIG1ha2VpbmZvLmZvdW5kKCkKICAgICBjbWQg
PSBbCmRpZmYgLS1naXQgYS9zdG9yYWdlLWRhZW1vbi9xYXBpL21lc29uLmJ1aWxkIGIvc3RvcmFn
ZS1kYWVtb24vcWFwaS9tZXNvbi5idWlsZAppbmRleCBjZWE2MThiZWMwLi43YzQ4YTM4OGQ0IDEw
MDY0NAotLS0gYS9zdG9yYWdlLWRhZW1vbi9xYXBpL21lc29uLmJ1aWxkCisrKyBiL3N0b3JhZ2Ut
ZGFlbW9uL3FhcGkvbWVzb24uYnVpbGQKQEAgLTQsNCArNCw2IEBAIHFzZF9xYXBpX2ZpbGVzID0g
Y3VzdG9tX3RhcmdldCgnUUFQSSBmaWxlcyBmb3IgcWVtdS1zdG9yYWdlLWRhZW1vbicsCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tbWFuZDogWyBxYXBpX2dlbiwgJy1vJywgJ3N0
b3JhZ2UtZGFlbW9uL3FhcGknLCAnQElOUFVUQCcgXSwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBkZXBlbmRfZmlsZXM6IFsgcWFwaV9pbnB1dHMsIHFhcGlfZ2VuX2RlcGVuZHMgXSkK
IAorcXNkX3FhcGlfZG9jX3RleGkgPSBxc2RfcWFwaV9maWxlc1stMV0KKwogcXNkX3NzLmFkZChx
c2RfcWFwaV9maWxlcy50b19saXN0KCkpCi0tIAoyLjI2LjIKCg==


