Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11F3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568FC206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRsr0XQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568FC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGNpX-0004Gz-E5
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 10:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGNoY-00034G-H3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:44:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kGNoW-0001XV-DE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599749079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LD8t/xLDvSFb/IL6/FGU/ijbTiuWjo6KbSwHkMK/4A=;
 b=KRsr0XQFxGjdfMA20eCTTapL3KoWKT0uBlVU9K21P6EKfOIZjgchRYemCUrHVEFz0ga71L
 H+ZWv9x35u5Kn3Y3KhkfqLjZFI9gEflQzDYk0RaHQfNqJCfR31m6NHwvLEbMn7xhxyaa4s
 IIdcOKJkJKUVldVoD0cbiLBWXyfgwuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-zRK_2t87N6qiMqsg2px5rg-1; Thu, 10 Sep 2020 10:44:36 -0400
X-MC-Unique: zRK_2t87N6qiMqsg2px5rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DE2F64085;
 Thu, 10 Sep 2020 14:44:35 +0000 (UTC)
Received: from localhost (ovpn-113-198.ams2.redhat.com [10.36.113.198])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 042118358A;
 Thu, 10 Sep 2020 14:44:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] docs: generate qemu-storage-daemon-qmp-ref(7) man page
Date: Thu, 10 Sep 2020 15:43:58 +0100
Message-Id: <20200910144400.69615-2-stefanha@redhat.com>
In-Reply-To: <20200910144400.69615-1-stefanha@redhat.com>
References: <20200910144400.69615-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWx0aG91Z2ggcWVtdS1zdG9yYWdlLWRhZW1vbiBRTVAgY29tbWFuZHMgYXJlIGlkZW50aWNhbCB0
byBRRU1VIFFNUApjb21tYW5kcyB0aGV5IGFyZSBhIHN1YnNldC4gR2VuZXJhdGUgYSBtYW51YWwg
cGFnZSBvZiBqdXN0IHRoZSBjb21tYW5kcwpzdXBwb3J0ZWQgYnkgcWVtdS1zdG9yYWdlLWRhZW1v
biBzbyB0aGF0IHVzZXJzIGtub3cgZXhhY3RseSB3aGF0IGlzCmF2YWlsYWJsZSBpbiBxZW11LXN0
b3JhZ2UtZGFlbW9uLgoKQWRkIGFuIGgxIGhlYWRpbmcgaW4gc3RvcmFnZS1kYWVtb24vcWFwaS9x
YXBpLXNjaGVtYS5qc29uIHNvIHRoYXQKYmxvY2stY29yZS5qc29uIGlzIGF0IHRoZSBoMiBoZWFk
aW5nIGxldmVsLgoKU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgotLS0KIHN0b3JhZ2UtZGFlbW9uL3FhcGkvcWFwaS1zY2hlbWEuanNvbiAgICAgICAg
ICB8ICA0ICsKIGRvY3MvaW50ZXJvcC9xZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYudGV4aSB8
IDgwICsrKysrKysrKysrKysrKysrKysKIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA5ICsrKwogc3RvcmFnZS1kYWVtb24vcWFwaS9tZXNvbi5idWlsZCAg
ICAgICAgICAgICAgIHwgIDIgKwogNCBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCspCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9pbnRlcm9wL3FlbXUtc3RvcmFnZS1kYWVtb24tcW1wLXJl
Zi50ZXhpCgpkaWZmIC0tZ2l0IGEvc3RvcmFnZS1kYWVtb24vcWFwaS9xYXBpLXNjaGVtYS5qc29u
IGIvc3RvcmFnZS1kYWVtb24vcWFwaS9xYXBpLXNjaGVtYS5qc29uCmluZGV4IDYxMDBkMWYwYzku
LjkzOWE2YWZkMTggMTAwNjQ0Ci0tLSBhL3N0b3JhZ2UtZGFlbW9uL3FhcGkvcWFwaS1zY2hlbWEu
anNvbgorKysgYi9zdG9yYWdlLWRhZW1vbi9xYXBpL3FhcGktc2NoZW1hLmpzb24KQEAgLTE1LDcg
KzE1LDExIEBACiAKIHsgJ2luY2x1ZGUnOiAnLi4vLi4vcWFwaS9wcmFnbWEuanNvbicgfQogCisj
IworIyA9IEJsb2NrIGRldmljZXMKKyMjCiB7ICdpbmNsdWRlJzogJy4uLy4uL3FhcGkvYmxvY2st
Y29yZS5qc29uJyB9CisKIHsgJ2luY2x1ZGUnOiAnLi4vLi4vcWFwaS9jaGFyLmpzb24nIH0KIHsg
J2luY2x1ZGUnOiAnLi4vLi4vcWFwaS9jb21tb24uanNvbicgfQogeyAnaW5jbHVkZSc6ICcuLi8u
Li9xYXBpL2NvbnRyb2wuanNvbicgfQpkaWZmIC0tZ2l0IGEvZG9jcy9pbnRlcm9wL3FlbXUtc3Rv
cmFnZS1kYWVtb24tcW1wLXJlZi50ZXhpIGIvZG9jcy9pbnRlcm9wL3FlbXUtc3RvcmFnZS1kYWVt
b24tcW1wLXJlZi50ZXhpCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAuLmE2
YTcwYzk2NzQKLS0tIC9kZXYvbnVsbAorKysgYi9kb2NzL2ludGVyb3AvcWVtdS1zdG9yYWdlLWRh
ZW1vbi1xbXAtcmVmLnRleGkKQEAgLTAsMCArMSw4MCBAQAorXGlucHV0IHRleGluZm8KK0BzZXRm
aWxlbmFtZSBxZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYuaW5mbworCitAaW5jbHVkZSB2ZXJz
aW9uLnRleGkKKworQGV4YW1wbGVpbmRlbnQgMAorQHBhcmFncmFwaGluZGVudCAwCisKK0BzZXR0
aXRsZSBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCBSZWZlcmVuY2UgTWFudWFsCisKK0BpZnRleAor
QGNlbnRlciBAaW1hZ2V7ZG9jcy9xZW11X2xvZ299CitAZW5kIGlmdGV4CisKK0Bjb3B5aW5nCitU
aGlzIGlzIHRoZSBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCByZWZlcmVuY2UgbWFudWFsLgorCitD
b3B5cmlnaHQgQGNvcHlyaWdodHt9IDIwMjAgVGhlIFFFTVUgUHJvamVjdCBkZXZlbG9wZXJzCisK
K0BxdW90YXRpb24KK1RoaXMgbWFudWFsIGlzIGZyZWUgZG9jdW1lbnRhdGlvbjogeW91IGNhbiBy
ZWRpc3RyaWJ1dGUgaXQgYW5kL29yCittb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcworcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb24sIGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlCitMaWNlbnNlLCBvciAoYXQg
eW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLgorCitUaGlzIG1hbnVhbCBpcyBkaXN0cmli
dXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQKK1dJVEhPVVQgQU5Z
IFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKK01FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05V
CitHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisKK1lvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCith
bG9uZyB3aXRoIHRoaXMgbWFudWFsLiAgSWYgbm90LCBzZWUgaHR0cDovL3d3dy5nbnUub3JnL2xp
Y2Vuc2VzLy4KK0BlbmQgcXVvdGF0aW9uCitAZW5kIGNvcHlpbmcKKworQGRpcmNhdGVnb3J5IFFF
TVUKK0BkaXJlbnRyeQorKiBRRU1VLVN0b3JhZ2UtRGFlbW9uLVFNUC1SZWY6IChxZW11LXN0b3Jh
Z2UtZGFlbW9uLXFtcC1yZWYpLiBRRU1VIFN0b3JhZ2UgRGFlbW9uIFFNUCBSZWZlcmVuY2UgTWFu
dWFsCitAZW5kIGRpcmVudHJ5CisKK0B0aXRsZXBhZ2UKK0B0aXRsZSBRRU1VIFN0b3JhZ2UgRGFl
bW9uIFFNUCBSZWZlcmVuY2UgTWFudWFsCitAc3VidGl0bGUgUUVNVSB2ZXJzaW9uIEB2YWx1ZXtW
RVJTSU9OfQorQHBhZ2UKK0B2c2tpcCAwcHQgcGx1cyAxZmlsbGwKK0BpbnNlcnRjb3B5aW5nCitA
ZW5kIHRpdGxlcGFnZQorCitAY29udGVudHMKKworQGlmbm90dGV4CitAbm9kZSBUb3AKK0B0b3Ag
UUVNVSBTdG9yYWdlIERhZW1vbiBRTVAgcmVmZXJlbmNlCitAZW5kIGlmbm90dGV4CisKK0BtZW51
CisqIEFQSSBSZWZlcmVuY2U6OgorKiBDb21tYW5kcyBhbmQgRXZlbnRzIEluZGV4OjoKKyogRGF0
YSBUeXBlcyBJbmRleDo6CitAZW5kIG1lbnUKKworQG5vZGUgQVBJIFJlZmVyZW5jZQorQGNoYXB0
ZXIgQVBJIFJlZmVyZW5jZQorCitAYyBmb3IgdGV4aTJwb2Q6CitAYyBtYW4gYmVnaW4gREVTQ1JJ
UFRJT04KKworQGluY2x1ZGUgc3RvcmFnZS1kYWVtb24vcWFwaS9xYXBpLWRvYy50ZXhpCisKK0Bj
IG1hbiBlbmQKKworQG5vZGUgQ29tbWFuZHMgYW5kIEV2ZW50cyBJbmRleAorQHVubnVtYmVyZWQg
Q29tbWFuZHMgYW5kIEV2ZW50cyBJbmRleAorQHByaW50aW5kZXggZm4KKworQG5vZGUgRGF0YSBU
eXBlcyBJbmRleAorQHVubnVtYmVyZWQgRGF0YSBUeXBlcyBJbmRleAorQHByaW50aW5kZXggdHAK
KworQGJ5ZQpkaWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZAppbmRleCA1NDIx
ZWNhNjZhLi5mMjBlNDA5ZjhlIDEwMDY0NAotLS0gYS9tZXNvbi5idWlsZAorKysgYi9tZXNvbi5i
dWlsZApAQCAtMTIyOSw2ICsxMjI5LDE1IEBAIGlmIGJ1aWxkX2RvY3MKICAgaWYgJ0NPTkZJR19H
VUVTVF9BR0VOVCcgaW4gY29uZmlnX2hvc3QKICAgICB0ZXhpICs9IHsncWVtdS1nYS1yZWYnOiBb
J2RvY3MvaW50ZXJvcC9xZW11LWdhLXJlZi50ZXhpJywgcWdhX3FhcGlfZG9jX3RleGksIHZlcnNp
b25fdGV4aV19CiAgIGVuZGlmCisgIGlmIGhhdmVfdG9vbHMKKyAgICB0ZXhpICs9IHsKKyAgICAg
ICdxZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYnOiBbCisJJ2RvY3MvaW50ZXJvcC9xZW11LXN0
b3JhZ2UtZGFlbW9uLXFtcC1yZWYudGV4aScsCisJcXNkX3FhcGlfZG9jX3RleGksCisJdmVyc2lv
bl90ZXhpCisgICAgICBdCisgICAgfQorICBlbmRpZgogCiAgIGlmIG1ha2VpbmZvLmZvdW5kKCkK
ICAgICBjbWQgPSBbCmRpZmYgLS1naXQgYS9zdG9yYWdlLWRhZW1vbi9xYXBpL21lc29uLmJ1aWxk
IGIvc3RvcmFnZS1kYWVtb24vcWFwaS9tZXNvbi5idWlsZAppbmRleCBjZWE2MThiZWMwLi43YzQ4
YTM4OGQ0IDEwMDY0NAotLS0gYS9zdG9yYWdlLWRhZW1vbi9xYXBpL21lc29uLmJ1aWxkCisrKyBi
L3N0b3JhZ2UtZGFlbW9uL3FhcGkvbWVzb24uYnVpbGQKQEAgLTQsNCArNCw2IEBAIHFzZF9xYXBp
X2ZpbGVzID0gY3VzdG9tX3RhcmdldCgnUUFQSSBmaWxlcyBmb3IgcWVtdS1zdG9yYWdlLWRhZW1v
bicsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tbWFuZDogWyBxYXBpX2dlbiwg
Jy1vJywgJ3N0b3JhZ2UtZGFlbW9uL3FhcGknLCAnQElOUFVUQCcgXSwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXBlbmRfZmlsZXM6IFsgcWFwaV9pbnB1dHMsIHFhcGlfZ2VuX2Rl
cGVuZHMgXSkKIAorcXNkX3FhcGlfZG9jX3RleGkgPSBxc2RfcWFwaV9maWxlc1stMV0KKwogcXNk
X3NzLmFkZChxc2RfcWFwaV9maWxlcy50b19saXN0KCkpCi0tIAoyLjI2LjIKCg==


