Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91872C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 583DC206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUCyokQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583DC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFlp-00022t-GJ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFin-0005sb-Dp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFih-0006fH-SE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qerQErdalHQiK49BHtasKxC2XsYO05yy8OaZy5W7ME=;
 b=eUCyokQytwRS7biEYUdmGMYftYx9n7Iz5e2eO7VB50FPKTY0Rd7+MrpMPsYUbjwL4PvM8k
 +ueJxbHi5xgNL6MJfyr3Re1Sm11BzMI3lagCCkyCOHTVQj1n6lxOcXB/mfO5aWtkK4mKuH
 j7cQMRNZsEucH/CxLxEpOT5AMtDd6d8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241--qo0FxrrMEuv0MsJMtwAjg-1; Fri, 19 Jun 2020 08:02:05 -0400
X-MC-Unique: -qo0FxrrMEuv0MsJMtwAjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22BEBA0BD7;
 Fri, 19 Jun 2020 12:02:04 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F3035D9CA;
 Fri, 19 Jun 2020 12:02:00 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 1/6] block-helpers: move MIN/MAX_BLOCK_SIZE constants into
 header file
Date: Fri, 19 Jun 2020 13:01:52 +0100
Message-Id: <20200619120157.2422429-1-stefanha@redhat.com>
In-Reply-To: <20200614183907.514282-4-coiby.xu@gmail.com>
References: <20200614183907.514282-4-coiby.xu@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

TW92ZSB0aGUgY29uc3RhbnRzIGZyb20gaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYyB0bwp1dGls
L2Jsb2NrLWhlbHBlcnMuaCBzbyB0aGF0IGtub3dsZWRnZSBvZiB0aGUgbWluL21heCB2YWx1ZXMg
aXMKZW5jYXBzdWxhdGVkIGluIGJsb2NrLWhlbHBlcnMgY29kZS4KCkNhbGxlcnMgc2hvdWxkIG5v
dCBhc3N1bWUgc3BlY2lmaWMgbWluL21heCB2YWx1ZXMuIEluIGZhY3QsIHRoZSB2YWx1ZXMKaW4g
aHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYyBhbmQgdXRpbC9ibG9jay1oZWxwZXJzLmMgZGlkIG5v
dCBtYXRjaC4gVXNlCnRoZSBody9jb3JlL3FkZXYtcHJvcGVydGllcy5jIHZhbHVlcyBzaW5jZSB0
aGF0J3Mgd2hhdCBleGlzdGluZyBjb2RlCmV4cGVjdHMuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4g
SGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRpbC9ibG9jay1oZWxwZXJzLmgg
ICAgICB8IDEyICsrKysrKysrKysrKwogaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYyB8IDExIC0t
LS0tLS0tLS0tCiB1dGlsL2Jsb2NrLWhlbHBlcnMuYyAgICAgIHwgIDcgKystLS0tLQogMyBmaWxl
cyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS91dGlsL2Jsb2NrLWhlbHBlcnMuaCBiL3V0aWwvYmxvY2staGVscGVycy5oCmluZGV4IGYwNmJl
MjgyYTEuLjQ2OTc1Y2E3YWYgMTAwNjQ0Ci0tLSBhL3V0aWwvYmxvY2staGVscGVycy5oCisrKyBi
L3V0aWwvYmxvY2staGVscGVycy5oCkBAIC0xLDYgKzEsMTggQEAKICNpZm5kZWYgQkxPQ0tfSEVM
UEVSU19ICiAjZGVmaW5lIEJMT0NLX0hFTFBFUlNfSAogCisjaW5jbHVkZSAicWVtdS91bml0cy5o
IgorCisvKiBsb3dlciBsaW1pdCBpcyBzZWN0b3Igc2l6ZSAqLworI2RlZmluZSBNSU5fQkxPQ0tf
U0laRSAgICAgICAgICBJTlQ2NF9DKDUxMikKKyNkZWZpbmUgTUlOX0JMT0NLX1NJWkVfU1RSICAg
ICAgIjUxMiBCIgorLyoKKyAqIHVwcGVyIGxpbWl0IGlzIGFyYml0cmFyeSwgMiBNaUIgbG9va3Mg
c3VmZmljaWVudCBmb3IgYWxsIHNlbnNpYmxlIHVzZXMsIGFuZAorICogbWF0Y2hlcyBxY293MiBj
bHVzdGVyIHNpemUgbGltaXQKKyAqLworI2RlZmluZSBNQVhfQkxPQ0tfU0laRSAgICAgICAgICAo
MiAqIE1pQikKKyNkZWZpbmUgTUFYX0JMT0NLX1NJWkVfU1RSICAgICAgIjIgTWlCIgorCiB2b2lk
IGNoZWNrX2xvZ2ljYWxfYmxvY2tfc2l6ZShjb25zdCBjaGFyICppZCwgY29uc3QgY2hhciAqbmFt
ZSwgdWludDE2X3QgdmFsdWUsCiAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOwog
CmRpZmYgLS1naXQgYS9ody9jb3JlL3FkZXYtcHJvcGVydGllcy5jIGIvaHcvY29yZS9xZGV2LXBy
b3BlcnRpZXMuYwppbmRleCBiNDc4ZjEwMGFmLi4wMzk4MWZlYjAyIDEwMDY0NAotLS0gYS9ody9j
b3JlL3FkZXYtcHJvcGVydGllcy5jCisrKyBiL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmMKQEAg
LTE0LDcgKzE0LDYgQEAKICNpbmNsdWRlICJxYXBpL3Zpc2l0b3IuaCIKICNpbmNsdWRlICJjaGFy
ZGV2L2NoYXIuaCIKICNpbmNsdWRlICJxZW11L3V1aWQuaCIKLSNpbmNsdWRlICJxZW11L3VuaXRz
LmgiCiAjaW5jbHVkZSAidXRpbC9ibG9jay1oZWxwZXJzLmgiCiAKIHZvaWQgcWRldl9wcm9wX3Nl
dF9hZnRlcl9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsCkBAIC03
ODIsMTYgKzc4MSw2IEBAIGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3Bfc2l6ZTMyID0gewog
CiAvKiAtLS0gYmxvY2tzaXplIC0tLSAqLwogCi0vKiBsb3dlciBsaW1pdCBpcyBzZWN0b3Igc2l6
ZSAqLwotI2RlZmluZSBNSU5fQkxPQ0tfU0laRSAgICAgICAgICA1MTIKLSNkZWZpbmUgTUlOX0JM
T0NLX1NJWkVfU1RSICAgICAgIjUxMiBCIgotLyoKLSAqIHVwcGVyIGxpbWl0IGlzIGFyYml0cmFy
eSwgMiBNaUIgbG9va3Mgc3VmZmljaWVudCBmb3IgYWxsIHNlbnNpYmxlIHVzZXMsIGFuZAotICog
bWF0Y2hlcyBxY293MiBjbHVzdGVyIHNpemUgbGltaXQKLSAqLwotI2RlZmluZSBNQVhfQkxPQ0tf
U0laRSAgICAgICAgICAoMiAqIE1pQikKLSNkZWZpbmUgTUFYX0JMT0NLX1NJWkVfU1RSICAgICAg
IjIgTWlCIgotCiBzdGF0aWMgdm9pZCBzZXRfYmxvY2tzaXplKE9iamVjdCAqb2JqLCBWaXNpdG9y
ICp2LCBjb25zdCBjaGFyICpuYW1lLAogICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpv
cGFxdWUsIEVycm9yICoqZXJycCkKIHsKZGlmZiAtLWdpdCBhL3V0aWwvYmxvY2staGVscGVycy5j
IGIvdXRpbC9ibG9jay1oZWxwZXJzLmMKaW5kZXggZDMxMzA5Y2MwZS4uMDg5ZmUzNDAxZCAxMDA2
NDQKLS0tIGEvdXRpbC9ibG9jay1oZWxwZXJzLmMKKysrIGIvdXRpbC9ibG9jay1oZWxwZXJzLmMK
QEAgLTI1LDEzICsyNSwxMCBAQAogdm9pZCBjaGVja19sb2dpY2FsX2Jsb2NrX3NpemUoY29uc3Qg
Y2hhciAqaWQsIGNvbnN0IGNoYXIgKm5hbWUsIHVpbnQxNl90IHZhbHVlLAogICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKQogewotICAgIGNvbnN0IGludDY0X3QgbWluID0gNTEyOwot
ICAgIGNvbnN0IGludDY0X3QgbWF4ID0gMzI3Njg7Ci0KICAgICAvKiB2YWx1ZSBvZiAwIG1lYW5z
ICJ1bnNldCIgKi8KLSAgICBpZiAodmFsdWUgJiYgKHZhbHVlIDwgbWluIHx8IHZhbHVlID4gbWF4
KSkgeworICAgIGlmICh2YWx1ZSAmJiAodmFsdWUgPCBNSU5fQkxPQ0tfU0laRSB8fCB2YWx1ZSA+
IE1BWF9CTE9DS19TSVpFKSkgewogICAgICAgICBlcnJvcl9zZXRnKGVycnAsIFFFUlJfUFJPUEVS
VFlfVkFMVUVfT1VUX09GX1JBTkdFLAotICAgICAgICAgICAgICAgICAgIGlkLCBuYW1lLCAoaW50
NjRfdCl2YWx1ZSwgbWluLCBtYXgpOworICAgICAgICAgICAgICAgICAgIGlkLCBuYW1lLCB2YWx1
ZSwgTUlOX0JMT0NLX1NJWkUsIE1BWF9CTE9DS19TSVpFKTsKICAgICAgICAgcmV0dXJuOwogICAg
IH0KIAotLSAKMi4yNi4yCgo=


