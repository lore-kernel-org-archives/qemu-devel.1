Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8754C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A1B2311A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/cAOrrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A1B2311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLT3d-0002aw-5H
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyl-000697-TI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLSyj-0003uV-RD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600960573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6PHIjyFCnSD5O0lRubUaswcGxHfrErHXK9pUYe9z2k=;
 b=c/cAOrrBy1p+Ezkt0d9GMHeLTC5XR8SB+VDURtviDPBYMdEgmNsrI52z+L1PgFV16kNiZ4
 0lyP/hVEgS/t627hx6pHSa7dQW12M+l4v1Tyw12rPcvCVWdp1rktQ+efZJExaVkth1y5iB
 Dx/yzCNBFdR2aiqiXNzi8E8blSnrDBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-kdKylezLPBSp5KaaGqMwCA-1; Thu, 24 Sep 2020 11:16:11 -0400
X-MC-Unique: kdKylezLPBSp5KaaGqMwCA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A020188C125;
 Thu, 24 Sep 2020 15:16:10 +0000 (UTC)
Received: from localhost (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9AD81002C00;
 Thu, 24 Sep 2020 15:16:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/13] util/vhost-user-server: drop unused
 DevicePanicNotifier
Date: Thu, 24 Sep 2020 16:15:42 +0100
Message-Id: <20200924151549.913737-7-stefanha@redhat.com>
In-Reply-To: <20200924151549.913737-1-stefanha@redhat.com>
References: <20200924151549.913737-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

VGhlIGRldmljZSBwYW5pYyBub3RpZmllciBjYWxsYmFjayBpcyBub3QgdXNlZC4gRHJvcCBpdC4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0t
CiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmggICAgICAgICAgICAgfCAzIC0tLQogYmxvY2svZXhw
b3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5jIHwgMyArLS0KIHV0aWwvdmhvc3QtdXNlci1zZXJ2
ZXIuYyAgICAgICAgICAgICB8IDYgLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVy
LmggYi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmgKaW5kZXggNTIzMmY5NjcxOC4uOTIxNzdmYzkx
MSAxMDA2NDQKLS0tIGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5oCisrKyBiL3V0aWwvdmhvc3Qt
dXNlci1zZXJ2ZXIuaApAQCAtMjksMTIgKzI5LDEwIEBAIHR5cGVkZWYgc3RydWN0IFZ1RmRXYXRj
aCB7CiB9IFZ1RmRXYXRjaDsKIAogdHlwZWRlZiBzdHJ1Y3QgVnVTZXJ2ZXIgVnVTZXJ2ZXI7Ci10
eXBlZGVmIHZvaWQgRGV2aWNlUGFuaWNOb3RpZmllckZuKFZ1U2VydmVyICpzZXJ2ZXIpOwogCiBz
dHJ1Y3QgVnVTZXJ2ZXIgewogICAgIFFJT05ldExpc3RlbmVyICpsaXN0ZW5lcjsKICAgICBBaW9D
b250ZXh0ICpjdHg7Ci0gICAgRGV2aWNlUGFuaWNOb3RpZmllckZuICpkZXZpY2VfcGFuaWNfbm90
aWZpZXI7CiAgICAgaW50IG1heF9xdWV1ZXM7CiAgICAgY29uc3QgVnVEZXZJZmFjZSAqdnVfaWZh
Y2U7CiAgICAgVnVEZXYgdnVfZGV2OwpAQCAtNTQsNyArNTIsNiBAQCBib29sIHZob3N0X3VzZXJf
c2VydmVyX3N0YXJ0KFZ1U2VydmVyICpzZXJ2ZXIsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFNvY2tldEFkZHJlc3MgKnVuaXhfc29ja2V0LAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBBaW9Db250ZXh0ICpjdHgsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQx
Nl90IG1heF9xdWV1ZXMsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIERldmljZVBhbmlj
Tm90aWZpZXJGbiAqZGV2aWNlX3BhbmljX25vdGlmaWVyLAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBWdURldklmYWNlICp2dV9pZmFjZSwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRXJyb3IgKiplcnJwKTsKIApkaWZmIC0tZ2l0IGEvYmxvY2svZXhwb3J0L3Zob3N0
LXVzZXItYmxrLXNlcnZlci5jIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZlci5j
CmluZGV4IGVmMDdhODdlYjEuLmYyYmZkZGJmMjYgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYworKysgYi9ibG9jay9leHBvcnQvdmhvc3QtdXNlci1ibGst
c2VydmVyLmMKQEAgLTQzOSw4ICs0MzksNyBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2Jsa19z
ZXJ2ZXJfc3RhcnQoVnVCbG9ja0RldiAqdnVfYmxvY2tfZGV2aWNlLAogICAgIGN0eCA9IGJkcnZf
Z2V0X2Fpb19jb250ZXh0KGJsa19icyh2dV9ibG9ja19kZXZpY2UtPmJhY2tlbmQpKTsKIAogICAg
IGlmICghdmhvc3RfdXNlcl9zZXJ2ZXJfc3RhcnQoJnZ1X2Jsb2NrX2RldmljZS0+dnVfc2VydmVy
LCBhZGRyLCBjdHgsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSE9TVF9VU0VS
X0JMS19NQVhfUVVFVUVTLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwg
JnZ1X2Jsb2NrX2lmYWNlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1Rf
VVNFUl9CTEtfTUFYX1FVRVVFUywgJnZ1X2Jsb2NrX2lmYWNlLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZXJycCkpIHsKICAgICAgICAgZ290byBlcnJvcjsKICAgICB9CmRpZmYg
LS1naXQgYS91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMgYi91dGlsL3Zob3N0LXVzZXItc2VydmVy
LmMKaW5kZXggZWJiODUwNzMxYi4uODkyODE1ODI3ZCAxMDA2NDQKLS0tIGEvdXRpbC92aG9zdC11
c2VyLXNlcnZlci5jCisrKyBiL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuYwpAQCAtODEsMTAgKzgx
LDYgQEAgc3RhdGljIHZvaWQgcGFuaWNfY2IoVnVEZXYgKnZ1X2RldiwgY29uc3QgY2hhciAqYnVm
KQogICAgICAgICBjbG9zZV9jbGllbnQoc2VydmVyKTsKICAgICB9CiAKLSAgICBpZiAoc2VydmVy
LT5kZXZpY2VfcGFuaWNfbm90aWZpZXIpIHsKLSAgICAgICAgc2VydmVyLT5kZXZpY2VfcGFuaWNf
bm90aWZpZXIoc2VydmVyKTsKLSAgICB9Ci0KICAgICAvKgogICAgICAqIFNldCB0aGUgY2FsbGJh
Y2sgZnVuY3Rpb24gZm9yIG5ldHdvcmsgbGlzdGVuZXIgc28gYW5vdGhlcgogICAgICAqIHZob3N0
LXVzZXIgY2xpZW50IGNhbiBjb25uZWN0IHRvIHRoaXMgc2VydmVyCkBAIC0zODUsNyArMzgxLDYg
QEAgYm9vbCB2aG9zdF91c2VyX3NlcnZlcl9zdGFydChWdVNlcnZlciAqc2VydmVyLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBTb2NrZXRBZGRyZXNzICpzb2NrZXRfYWRkciwKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQWlvQ29udGV4dCAqY3R4LAogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MTZfdCBtYXhfcXVldWVzLAotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBEZXZpY2VQYW5pY05vdGlmaWVyRm4gKmRldmljZV9wYW5pY19ub3RpZmllciwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgVnVEZXZJZmFjZSAqdnVfaWZhY2UsCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkKIHsKQEAgLTQwMiw3ICsz
OTcsNiBAQCBib29sIHZob3N0X3VzZXJfc2VydmVyX3N0YXJ0KFZ1U2VydmVyICpzZXJ2ZXIsCiAg
ICAgICAgIC52dV9pZmFjZSAgICAgICAgICAgICAgPSB2dV9pZmFjZSwKICAgICAgICAgLm1heF9x
dWV1ZXMgICAgICAgICAgICA9IG1heF9xdWV1ZXMsCiAgICAgICAgIC5jdHggICAgICAgICAgICAg
ICAgICAgPSBjdHgsCi0gICAgICAgIC5kZXZpY2VfcGFuaWNfbm90aWZpZXIgPSBkZXZpY2VfcGFu
aWNfbm90aWZpZXIsCiAgICAgfTsKIAogICAgIHFpb19uZXRfbGlzdGVuZXJfc2V0X25hbWUoc2Vy
dmVyLT5saXN0ZW5lciwgInZob3N0LXVzZXItYmFja2VuZC1saXN0ZW5lciIpOwotLSAKMi4yNi4y
Cgo=


