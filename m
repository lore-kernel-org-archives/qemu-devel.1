Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5EC2074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqH4BU03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5EC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKfd-00068g-Sm
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZk-0006Q7-QN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZi-0007yS-Tc
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv0iF36gbURFbN6c8IQknm689XzZJeY+jivZ5m5LzG0=;
 b=IqH4BU03hV8yDCeJHAH9aHPcN1nwo7rVFxW/7nC4Lcbtn+zPqr41jLX2xkUo16sDpAqCTH
 7fkWZoI4On+saFLJjxLVmqPt313iNlY1VPwDcUNb0Rm3YZhTyH/v2kS4KBRQuAPSIUAmv6
 fKYR74FAblcEnR1oExvQlVK30YttLS0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-VBQQwfAFP32vDI9sfEqtxw-1; Wed, 04 Nov 2020 10:19:48 -0500
X-MC-Unique: VBQQwfAFP32vDI9sfEqtxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F387E1018F64;
 Wed,  4 Nov 2020 15:19:45 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06E4155776;
 Wed,  4 Nov 2020 15:19:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/33] block/nvme: Move definitions before structure
 declarations
Date: Wed,  4 Nov 2020 15:18:05 +0000
Message-Id: <20201104151828.405824-11-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKVG8gYmUg
YWJsZSB0byB1c2Ugc29tZSBkZWZpbml0aW9ucyBpbiBzdHJ1Y3R1cmUgZGVjbGFyYXRpb25zLApt
b3ZlIHRoZW0gZWFybGllci4gTm8gbG9naWNhbCBjaGFuZ2UuCgpSZXZpZXdlZC1ieTogRXJpYyBB
dWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3pp
IDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5MzMwNi4xMDYzODc5LTktcGhpbG1k
QHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRo
YXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KLS0t
CiBibG9jay9udm1lLmMgfCAxOSArKysrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9udm1l
LmMgYi9ibG9jay9udm1lLmMKaW5kZXggZTk1ZDU5ZDMxMi4uYjA2MjlmNWRlOCAxMDA2NDQKLS0t
IGEvYmxvY2svbnZtZS5jCisrKyBiL2Jsb2NrL252bWUuYwpAQCAtNDEsNiArNDEsMTYgQEAKIAog
dHlwZWRlZiBzdHJ1Y3QgQkRSVk5WTWVTdGF0ZSBCRFJWTlZNZVN0YXRlOwogCisvKiBTYW1lIGlu
ZGV4IGlzIHVzZWQgZm9yIHF1ZXVlcyBhbmQgSVJRcyAqLworI2RlZmluZSBJTkRFWF9BRE1JTiAg
ICAgMAorI2RlZmluZSBJTkRFWF9JTyhuKSAgICAgKDEgKyBuKQorCisvKiBUaGlzIGRyaXZlciBz
aGFyZXMgYSBzaW5nbGUgTVNJWCBJUlEgZm9yIHRoZSBhZG1pbiBhbmQgSS9PIHF1ZXVlcyAqLwor
ZW51bSB7CisgICAgTVNJWF9TSEFSRURfSVJRX0lEWCA9IDAsCisgICAgTVNJWF9JUlFfQ09VTlQg
PSAxCit9OworCiB0eXBlZGVmIHN0cnVjdCB7CiAgICAgaW50MzJfdCAgaGVhZCwgdGFpbDsKICAg
ICB1aW50OF90ICAqcXVldWU7CkBAIC04MSwxNSArOTEsNiBAQCB0eXBlZGVmIHN0cnVjdCB7CiAg
ICAgUUVNVUJIICAgICAgKmNvbXBsZXRpb25fYmg7CiB9IE5WTWVRdWV1ZVBhaXI7CiAKLSNkZWZp
bmUgSU5ERVhfQURNSU4gICAgIDAKLSNkZWZpbmUgSU5ERVhfSU8obikgICAgICgxICsgbikKLQot
LyogVGhpcyBkcml2ZXIgc2hhcmVzIGEgc2luZ2xlIE1TSVggSVJRIGZvciB0aGUgYWRtaW4gYW5k
IEkvTyBxdWV1ZXMgKi8KLWVudW0gewotICAgIE1TSVhfU0hBUkVEX0lSUV9JRFggPSAwLAotICAg
IE1TSVhfSVJRX0NPVU5UID0gMQotfTsKLQogc3RydWN0IEJEUlZOVk1lU3RhdGUgewogICAgIEFp
b0NvbnRleHQgKmFpb19jb250ZXh0OwogICAgIFFFTVVWRklPU3RhdGUgKnZmaW87Ci0tIAoyLjI4
LjAKCg==


