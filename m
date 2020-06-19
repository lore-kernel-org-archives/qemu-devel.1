Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF0F2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpQKx16G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF0F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFpc-00088N-JK
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFiw-0006Is-Mz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFiu-0006gr-Tv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NJFzzQUK4oUGscimCZCDMzmOjZZhjC5cSgVU5jzFQ8A=;
 b=VpQKx16G6tI8f5hEIlvvCV1C3MBrmyb/eGiJFm1uwOyNSrNmjQIB5VDghK8QseStW4UOF5
 Bq4zvnMCc3nd6pw96+L1MwuGPKKlVhiYNq3+ejvrBrwpLjbnajnCpdcJreg+3MYb037t1x
 Ornlt7822mk4UlMEx3wKKJvPXWB5YGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-BW25WVnpNcqUBnMl1v18ig-1; Fri, 19 Jun 2020 08:02:18 -0400
X-MC-Unique: BW25WVnpNcqUBnMl1v18ig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B65F464;
 Fri, 19 Jun 2020 12:02:17 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB425C1D0;
 Fri, 19 Jun 2020 12:02:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 3/6] block-helpers: rename check_logical_block_size() to
 check_block_size()
Date: Fri, 19 Jun 2020 13:01:54 +0100
Message-Id: <20200619120157.2422429-3-stefanha@redhat.com>
In-Reply-To: <20200619120157.2422429-1-stefanha@redhat.com>
References: <20200614183907.514282-4-coiby.xu@gmail.com>
 <20200619120157.2422429-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
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

QmxvY2sgc2l6ZSBjaGVja2luZyBpcyB0aGUgc2FtZSB3aGV0aGVyIGl0J3MgYSBwaHlzaWNhbCwg
bG9naWNhbCwgb3IKb3RoZXIgYmxvY2sgc2l6ZSB2YWx1ZS4gVXNlIGEgbW9yZSBnZW5lcmFsIG5h
bWUgdG8gc2hvdyB0aGlzIGZ1bmN0aW9uCmNhbiBiZSB1c2VkIGluIG90aGVyIGNhc2VzIHRvbyAo
anVzdCBsaWtlIHRoZSBxZGV2IHByb3BlcnR5IHRoYXQgdGhpcwpjb2RlIG9yaWdpbmFsbHkgY29t
ZXMgZnJvbSkuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhh
dC5jb20+Ci0tLQogdXRpbC9ibG9jay1oZWxwZXJzLmggICAgICB8IDQgKystLQogaHcvY29yZS9x
ZGV2LXByb3BlcnRpZXMuYyB8IDIgKy0KIHV0aWwvYmxvY2staGVscGVycy5jICAgICAgfCA0ICsr
LS0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3V0aWwvYmxvY2staGVscGVycy5oIGIvdXRpbC9ibG9jay1oZWxwZXJzLmgKaW5k
ZXggZWM2NDIxNTYwYy4uYjUzMjk1YTUyOSAxMDA2NDQKLS0tIGEvdXRpbC9ibG9jay1oZWxwZXJz
LmgKKysrIGIvdXRpbC9ibG9jay1oZWxwZXJzLmgKQEAgLTEzLDcgKzEzLDcgQEAKICNkZWZpbmUg
TUFYX0JMT0NLX1NJWkUgICAgICAgICAgKDIgKiBNaUIpCiAjZGVmaW5lIE1BWF9CTE9DS19TSVpF
X1NUUiAgICAgICIyIE1pQiIKIAotdm9pZCBjaGVja19sb2dpY2FsX2Jsb2NrX3NpemUoY29uc3Qg
Y2hhciAqaWQsIGNvbnN0IGNoYXIgKm5hbWUsIGludDY0X3QgdmFsdWUsCi0gICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApOwordm9pZCBjaGVja19ibG9ja19zaXplKGNvbnN0IGNoYXIg
KmlkLCBjb25zdCBjaGFyICpuYW1lLCBpbnQ2NF90IHZhbHVlLAorICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCk7CiAKICNlbmRpZiAvKiBCTE9DS19IRUxQRVJTX0ggKi8KZGlmZiAt
LWdpdCBhL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmMgYi9ody9jb3JlL3FkZXYtcHJvcGVydGll
cy5jCmluZGV4IDAzOTgxZmViMDIuLjI4YTZkOGIyZWUgMTAwNjQ0Ci0tLSBhL2h3L2NvcmUvcWRl
di1wcm9wZXJ0aWVzLmMKKysrIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYwpAQCAtODAwLDcg
KzgwMCw3IEBAIHN0YXRpYyB2b2lkIHNldF9ibG9ja3NpemUoT2JqZWN0ICpvYmosIFZpc2l0b3Ig
KnYsIGNvbnN0IGNoYXIgKm5hbWUsCiAgICAgICAgIGVycm9yX3Byb3BhZ2F0ZShlcnJwLCBsb2Nh
bF9lcnIpOwogICAgICAgICByZXR1cm47CiAgICAgfQotICAgIGNoZWNrX2xvZ2ljYWxfYmxvY2tf
c2l6ZShkZXYtPmlkID8gOiAiIiwgbmFtZSwgdmFsdWUsIGVycnApOworICAgIGNoZWNrX2Jsb2Nr
X3NpemUoZGV2LT5pZCA/IDogIiIsIG5hbWUsIHZhbHVlLCBlcnJwKTsKICAgICBpZiAoZXJycCkg
ewogICAgICAgICByZXR1cm47CiAgICAgfQpkaWZmIC0tZ2l0IGEvdXRpbC9ibG9jay1oZWxwZXJz
LmMgYi91dGlsL2Jsb2NrLWhlbHBlcnMuYwppbmRleCA5ZTY4OTU0YzQ2Li41MWQ5ZDAyYzQzIDEw
MDY0NAotLS0gYS91dGlsL2Jsb2NrLWhlbHBlcnMuYworKysgYi91dGlsL2Jsb2NrLWhlbHBlcnMu
YwpAQCAtMjIsOCArMjIsOCBAQAogICoKICAqICBNb3ZlZCBmcm9tIGh3L2NvcmUvcWRldi1wcm9w
ZXJ0aWVzLmM6c2V0X2Jsb2Nrc2l6ZSgpCiAgKi8KLXZvaWQgY2hlY2tfbG9naWNhbF9ibG9ja19z
aXplKGNvbnN0IGNoYXIgKmlkLCBjb25zdCBjaGFyICpuYW1lLCBpbnQ2NF90IHZhbHVlLAotICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQordm9pZCBjaGVja19ibG9ja19zaXplKGNv
bnN0IGNoYXIgKmlkLCBjb25zdCBjaGFyICpuYW1lLCBpbnQ2NF90IHZhbHVlLAorICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkKIHsKICAgICAvKiB2YWx1ZSBvZiAwIG1lYW5zICJ1
bnNldCIgKi8KICAgICBpZiAodmFsdWUgJiYgKHZhbHVlIDwgTUlOX0JMT0NLX1NJWkUgfHwgdmFs
dWUgPiBNQVhfQkxPQ0tfU0laRSkpIHsKLS0gCjIuMjYuMgoK


