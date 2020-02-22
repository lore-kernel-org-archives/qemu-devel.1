Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396FDC35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05EAE2071E
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSRsqdY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05EAE2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Qds-0005HN-6f
	for qemu-devel@archiver.kernel.org; Sat, 22 Feb 2020 04:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j5QXz-0001gB-QP
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j5QXy-00013A-Gt
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j5QXy-00011w-Bz
 for qemu-devel@nongnu.org; Sat, 22 Feb 2020 03:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582361642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPQG1OdHq8UAgRpu6zvXm1yk9uAUtAE+Tzs9fa1EHUA=;
 b=GSRsqdY5+dMzQyBVyZcQn3Ypsl2KqUu7t7pC0rGkWi0xoJ+4yv5YWasLSopwM3GiVeAtaz
 bqc3Vzk6Oueza1RMHtX8XBBD6tLnZceyuSFi3t5+HYj3ARr1AjSZJ9rD3ivdGw3lRstexE
 98kzgOcbrdqQ/LldQPrZNvvTFvbmK0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-qI8e39YWMseekB3k034S6g-1; Sat, 22 Feb 2020 03:53:59 -0500
X-MC-Unique: qI8e39YWMseekB3k034S6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B182107ACC5;
 Sat, 22 Feb 2020 08:53:58 +0000 (UTC)
Received: from localhost (ovpn-116-74.ams2.redhat.com [10.36.116.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBF7960BE0;
 Sat, 22 Feb 2020 08:53:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/31] libqos: rename i2c_send and i2c_recv
Date: Sat, 22 Feb 2020 08:50:17 +0000
Message-Id: <20200222085030.1760640-19-stefanha@redhat.com>
In-Reply-To: <20200222085030.1760640-1-stefanha@redhat.com>
References: <20200222085030.1760640-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Darren Kenny <darren.kenny@oracle.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogQWxleGFuZGVyIEJ1bGVrb3YgPGFseG5kckBidS5lZHU+CgpUaGUgbmFtZXMgaTJjX3Nl
bmQgYW5kIGkyY19yZWN2IGNvbGxpZGUgd2l0aCBmdW5jdGlvbnMgZGVmaW5lZCBpbgpody9pMmMv
Y29yZS5jLiBUaGlzIGNhdXNlcyBhbiBlcnJvciB3aGVuIGxpbmtpbmcgYWdhaW5zdCBsaWJxb3Mg
YW5kCnNvZnRtbXUgc2ltdWx0YW5lb3VzbHkgKGZvciBleGFtcGxlIHdoZW4gdXNpbmcgcXRlc3Qg
aW5wcm9jKS4gUmVuYW1lIHRoZQpsaWJxb3MgZnVuY3Rpb25zIHRvIGF2b2lkIHRoaXMuCgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4YW5kZXIgQnVsZWtvdiA8YWx4bmRyQGJ1LmVkdT4KUmV2aWV3ZWQtYnk6
IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IERhcnJl
biBLZW5ueSA8ZGFycmVuLmtlbm55QG9yYWNsZS5jb20+CkFja2VkLWJ5OiBUaG9tYXMgSHV0aCA8
dGh1dGhAcmVkaGF0LmNvbT4KTWVzc2FnZS1pZDogMjAyMDAyMjAwNDExMTguMjMyNjQtMTAtYWx4
bmRyQGJ1LmVkdQpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogdGVzdHMvcXRlc3QvbGlicW9zL2kyYy5jICAgfCAxMCArKysrKy0tLS0tCiB0
ZXN0cy9xdGVzdC9saWJxb3MvaTJjLmggICB8ICA0ICsrLS0KIHRlc3RzL3F0ZXN0L3BjYTk1NTIt
dGVzdC5jIHwgMTAgKysrKystLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9saWJxb3MvaTJjLmMg
Yi90ZXN0cy9xdGVzdC9saWJxb3MvaTJjLmMKaW5kZXggMTU2MTE0ZTc0NS4uMzhmODAwZGJhYiAx
MDA2NDQKLS0tIGEvdGVzdHMvcXRlc3QvbGlicW9zL2kyYy5jCisrKyBiL3Rlc3RzL3F0ZXN0L2xp
YnFvcy9pMmMuYwpAQCAtMTAsMTIgKzEwLDEyIEBACiAjaW5jbHVkZSAibGlicW9zL2kyYy5oIgog
I2luY2x1ZGUgImxpYnF0ZXN0LmgiCiAKLXZvaWQgaTJjX3NlbmQoUUkyQ0RldmljZSAqaTJjZGV2
LCBjb25zdCB1aW50OF90ICpidWYsIHVpbnQxNl90IGxlbikKK3ZvaWQgcWkyY19zZW5kKFFJMkNE
ZXZpY2UgKmkyY2RldiwgY29uc3QgdWludDhfdCAqYnVmLCB1aW50MTZfdCBsZW4pCiB7CiAgICAg
aTJjZGV2LT5idXMtPnNlbmQoaTJjZGV2LT5idXMsIGkyY2Rldi0+YWRkciwgYnVmLCBsZW4pOwog
fQogCi12b2lkIGkyY19yZWN2KFFJMkNEZXZpY2UgKmkyY2RldiwgdWludDhfdCAqYnVmLCB1aW50
MTZfdCBsZW4pCit2b2lkIHFpMmNfcmVjdihRSTJDRGV2aWNlICppMmNkZXYsIHVpbnQ4X3QgKmJ1
ZiwgdWludDE2X3QgbGVuKQogewogICAgIGkyY2Rldi0+YnVzLT5yZWN2KGkyY2Rldi0+YnVzLCBp
MmNkZXYtPmFkZHIsIGJ1ZiwgbGVuKTsKIH0KQEAgLTIzLDggKzIzLDggQEAgdm9pZCBpMmNfcmVj
dihRSTJDRGV2aWNlICppMmNkZXYsIHVpbnQ4X3QgKmJ1ZiwgdWludDE2X3QgbGVuKQogdm9pZCBp
MmNfcmVhZF9ibG9jayhRSTJDRGV2aWNlICppMmNkZXYsIHVpbnQ4X3QgcmVnLAogICAgICAgICAg
ICAgICAgICAgICB1aW50OF90ICpidWYsIHVpbnQxNl90IGxlbikKIHsKLSAgICBpMmNfc2VuZChp
MmNkZXYsICZyZWcsIDEpOwotICAgIGkyY19yZWN2KGkyY2RldiwgYnVmLCBsZW4pOworICAgIHFp
MmNfc2VuZChpMmNkZXYsICZyZWcsIDEpOworICAgIHFpMmNfcmVjdihpMmNkZXYsIGJ1ZiwgbGVu
KTsKIH0KIAogdm9pZCBpMmNfd3JpdGVfYmxvY2soUUkyQ0RldmljZSAqaTJjZGV2LCB1aW50OF90
IHJlZywKQEAgLTMzLDcgKzMzLDcgQEAgdm9pZCBpMmNfd3JpdGVfYmxvY2soUUkyQ0RldmljZSAq
aTJjZGV2LCB1aW50OF90IHJlZywKICAgICB1aW50OF90ICpjbWQgPSBnX21hbGxvYyhsZW4gKyAx
KTsKICAgICBjbWRbMF0gPSByZWc7CiAgICAgbWVtY3B5KCZjbWRbMV0sIGJ1ZiwgbGVuKTsKLSAg
ICBpMmNfc2VuZChpMmNkZXYsIGNtZCwgbGVuICsgMSk7CisgICAgcWkyY19zZW5kKGkyY2Rldiwg
Y21kLCBsZW4gKyAxKTsKICAgICBnX2ZyZWUoY21kKTsKIH0KIApkaWZmIC0tZ2l0IGEvdGVzdHMv
cXRlc3QvbGlicW9zL2kyYy5oIGIvdGVzdHMvcXRlc3QvbGlicW9zL2kyYy5oCmluZGV4IDk0NWI2
NWIzNGMuLmM2NWYwODc4MzQgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L2xpYnFvcy9pMmMuaAor
KysgYi90ZXN0cy9xdGVzdC9saWJxb3MvaTJjLmgKQEAgLTQ3LDggKzQ3LDggQEAgc3RydWN0IFFJ
MkNEZXZpY2Ugewogdm9pZCAqaTJjX2RldmljZV9jcmVhdGUodm9pZCAqaTJjX2J1cywgUUd1ZXN0
QWxsb2NhdG9yICphbGxvYywgdm9pZCAqYWRkcik7CiB2b2lkIGFkZF9xaTJjX2FkZHJlc3MoUU9T
R3JhcGhFZGdlT3B0aW9ucyAqb3B0cywgUUkyQ0FkZHJlc3MgKmFkZHIpOwogCi12b2lkIGkyY19z
ZW5kKFFJMkNEZXZpY2UgKmRldiwgY29uc3QgdWludDhfdCAqYnVmLCB1aW50MTZfdCBsZW4pOwot
dm9pZCBpMmNfcmVjdihRSTJDRGV2aWNlICpkZXYsIHVpbnQ4X3QgKmJ1ZiwgdWludDE2X3QgbGVu
KTsKK3ZvaWQgcWkyY19zZW5kKFFJMkNEZXZpY2UgKmRldiwgY29uc3QgdWludDhfdCAqYnVmLCB1
aW50MTZfdCBsZW4pOwordm9pZCBxaTJjX3JlY3YoUUkyQ0RldmljZSAqZGV2LCB1aW50OF90ICpi
dWYsIHVpbnQxNl90IGxlbik7CiAKIHZvaWQgaTJjX3JlYWRfYmxvY2soUUkyQ0RldmljZSAqZGV2
LCB1aW50OF90IHJlZywKICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqYnVmLCB1aW50MTZf
dCBsZW4pOwpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3QvcGNhOTU1Mi10ZXN0LmMgYi90ZXN0cy9x
dGVzdC9wY2E5NTUyLXRlc3QuYwppbmRleCA0YjgwMGQzYzNlLi5kODBlZDkzY2QzIDEwMDY0NAot
LS0gYS90ZXN0cy9xdGVzdC9wY2E5NTUyLXRlc3QuYworKysgYi90ZXN0cy9xdGVzdC9wY2E5NTUy
LXRlc3QuYwpAQCAtMzIsMjIgKzMyLDIyIEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYXV0b2luYyh2
b2lkICpvYmosIHZvaWQgKmRhdGEsIFFHdWVzdEFsbG9jYXRvciAqYWxsb2MpCiAKICAgICBwY2E5
NTUyX2luaXQoaTJjZGV2KTsKIAotICAgIGkyY19zZW5kKGkyY2RldiwgJnJlZywgMSk7CisgICAg
cWkyY19zZW5kKGkyY2RldiwgJnJlZywgMSk7CiAKICAgICAvKiBQQ0E5NTUyX0xTMCAqLwotICAg
IGkyY19yZWN2KGkyY2RldiwgJnJlc3AsIDEpOworICAgIHFpMmNfcmVjdihpMmNkZXYsICZyZXNw
LCAxKTsKICAgICBnX2Fzc2VydF9jbXBoZXgocmVzcCwgPT0sIDB4NTQpOwogCiAgICAgLyogUENB
OTU1Ml9MUzEgKi8KLSAgICBpMmNfcmVjdihpMmNkZXYsICZyZXNwLCAxKTsKKyAgICBxaTJjX3Jl
Y3YoaTJjZGV2LCAmcmVzcCwgMSk7CiAgICAgZ19hc3NlcnRfY21waGV4KHJlc3AsID09LCAweDU1
KTsKIAogICAgIC8qIFBDQTk1NTJfTFMyICovCi0gICAgaTJjX3JlY3YoaTJjZGV2LCAmcmVzcCwg
MSk7CisgICAgcWkyY19yZWN2KGkyY2RldiwgJnJlc3AsIDEpOwogICAgIGdfYXNzZXJ0X2NtcGhl
eChyZXNwLCA9PSwgMHg1NSk7CiAKICAgICAvKiBQQ0E5NTUyX0xTMyAqLwotICAgIGkyY19yZWN2
KGkyY2RldiwgJnJlc3AsIDEpOworICAgIHFpMmNfcmVjdihpMmNkZXYsICZyZXNwLCAxKTsKICAg
ICBnX2Fzc2VydF9jbXBoZXgocmVzcCwgPT0sIDB4NTQpOwogfQogCi0tIAoyLjI0LjEKCg==


