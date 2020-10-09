Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4A5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 567FC22282
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 19:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee/IDpuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 567FC22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQyIz-00027P-FC
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 15:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCH-0001nB-6Y
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kQyCF-0002zT-D8
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 15:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602272214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdFA0gi4lPND73681h9S2D+UwbTUzOeLnw5f9F7v1Fg=;
 b=Ee/IDpuuRZeY9WkUz645mCOABgWnPmvpwYcDVRk8OMy1urbDHjuK88BZK0TD8aDDElSuEP
 L6NtyKs9vWXZdofP5btos9UGzTVKqyDhZWJu49Fz049yl1EvIIEYjayMBQOFbt9rROEbfn
 LDO3kdnFfsQtCJsKnnRO5SWYycDAsWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-mgO7V3vOOrGa4trewG_uSg-1; Fri, 09 Oct 2020 15:36:50 -0400
X-MC-Unique: mgO7V3vOOrGa4trewG_uSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73EEA186DD2B;
 Fri,  9 Oct 2020 19:36:49 +0000 (UTC)
Received: from localhost (ovpn-112-20.ams2.redhat.com [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 617EA75127;
 Fri,  9 Oct 2020 19:36:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 13/30] util/vhost-user-server: drop unused DevicePanicNotifier
Date: Fri,  9 Oct 2020 20:35:12 +0100
Message-Id: <20201009193529.322822-14-stefanha@redhat.com>
In-Reply-To: <20201009193529.322822-1-stefanha@redhat.com>
References: <20201009193529.322822-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

VGhlIGRldmljZSBwYW5pYyBub3RpZmllciBjYWxsYmFjayBpcyBub3QgdXNlZC4gRHJvcCBpdC4K
ClNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KTWVz
c2FnZS1pZDogMjAyMDA5MjQxNTE1NDkuOTEzNzM3LTctc3RlZmFuaGFAcmVkaGF0LmNvbQpTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdXRp
bC92aG9zdC11c2VyLXNlcnZlci5oICAgICAgICAgICAgIHwgMyAtLS0KIGJsb2NrL2V4cG9ydC92
aG9zdC11c2VyLWJsay1zZXJ2ZXIuYyB8IDMgKy0tCiB1dGlsL3Zob3N0LXVzZXItc2VydmVyLmMg
ICAgICAgICAgICAgfCA2IC0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5oIGIv
dXRpbC92aG9zdC11c2VyLXNlcnZlci5oCmluZGV4IDUyMzJmOTY3MTguLjkyMTc3ZmM5MTEgMTAw
NjQ0Ci0tLSBhL3V0aWwvdmhvc3QtdXNlci1zZXJ2ZXIuaAorKysgYi91dGlsL3Zob3N0LXVzZXIt
c2VydmVyLmgKQEAgLTI5LDEyICsyOSwxMCBAQCB0eXBlZGVmIHN0cnVjdCBWdUZkV2F0Y2ggewog
fSBWdUZkV2F0Y2g7CiAKIHR5cGVkZWYgc3RydWN0IFZ1U2VydmVyIFZ1U2VydmVyOwotdHlwZWRl
ZiB2b2lkIERldmljZVBhbmljTm90aWZpZXJGbihWdVNlcnZlciAqc2VydmVyKTsKIAogc3RydWN0
IFZ1U2VydmVyIHsKICAgICBRSU9OZXRMaXN0ZW5lciAqbGlzdGVuZXI7CiAgICAgQWlvQ29udGV4
dCAqY3R4OwotICAgIERldmljZVBhbmljTm90aWZpZXJGbiAqZGV2aWNlX3BhbmljX25vdGlmaWVy
OwogICAgIGludCBtYXhfcXVldWVzOwogICAgIGNvbnN0IFZ1RGV2SWZhY2UgKnZ1X2lmYWNlOwog
ICAgIFZ1RGV2IHZ1X2RldjsKQEAgLTU0LDcgKzUyLDYgQEAgYm9vbCB2aG9zdF91c2VyX3NlcnZl
cl9zdGFydChWdVNlcnZlciAqc2VydmVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
b2NrZXRBZGRyZXNzICp1bml4X3NvY2tldCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QWlvQ29udGV4dCAqY3R4LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBt
YXhfcXVldWVzLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEZXZpY2VQYW5pY05vdGlm
aWVyRm4gKmRldmljZV9wYW5pY19ub3RpZmllciwKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29uc3QgVnVEZXZJZmFjZSAqdnVfaWZhY2UsCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEVycm9yICoqZXJycCk7CiAKZGlmZiAtLWdpdCBhL2Jsb2NrL2V4cG9ydC92aG9zdC11c2Vy
LWJsay1zZXJ2ZXIuYyBiL2Jsb2NrL2V4cG9ydC92aG9zdC11c2VyLWJsay1zZXJ2ZXIuYwppbmRl
eCBlZjA3YTg3ZWIxLi5mMmJmZGRiZjI2IDEwMDY0NAotLS0gYS9ibG9jay9leHBvcnQvdmhvc3Qt
dXNlci1ibGstc2VydmVyLmMKKysrIGIvYmxvY2svZXhwb3J0L3Zob3N0LXVzZXItYmxrLXNlcnZl
ci5jCkBAIC00MzksOCArNDM5LDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9ibGtfc2VydmVy
X3N0YXJ0KFZ1QmxvY2tEZXYgKnZ1X2Jsb2NrX2RldmljZSwKICAgICBjdHggPSBiZHJ2X2dldF9h
aW9fY29udGV4dChibGtfYnModnVfYmxvY2tfZGV2aWNlLT5iYWNrZW5kKSk7CiAKICAgICBpZiAo
IXZob3N0X3VzZXJfc2VydmVyX3N0YXJ0KCZ2dV9ibG9ja19kZXZpY2UtPnZ1X3NlcnZlciwgYWRk
ciwgY3R4LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVkhPU1RfVVNFUl9CTEtf
TUFYX1FVRVVFUywKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsICZ2dV9i
bG9ja19pZmFjZSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZIT1NUX1VTRVJf
QkxLX01BWF9RVUVVRVMsICZ2dV9ibG9ja19pZmFjZSwKICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGVycnApKSB7CiAgICAgICAgIGdvdG8gZXJyb3I7CiAgICAgfQpkaWZmIC0tZ2l0
IGEvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jIGIvdXRpbC92aG9zdC11c2VyLXNlcnZlci5jCmlu
ZGV4IGViYjg1MDczMWIuLjg5MjgxNTgyN2QgMTAwNjQ0Ci0tLSBhL3V0aWwvdmhvc3QtdXNlci1z
ZXJ2ZXIuYworKysgYi91dGlsL3Zob3N0LXVzZXItc2VydmVyLmMKQEAgLTgxLDEwICs4MSw2IEBA
IHN0YXRpYyB2b2lkIHBhbmljX2NiKFZ1RGV2ICp2dV9kZXYsIGNvbnN0IGNoYXIgKmJ1ZikKICAg
ICAgICAgY2xvc2VfY2xpZW50KHNlcnZlcik7CiAgICAgfQogCi0gICAgaWYgKHNlcnZlci0+ZGV2
aWNlX3BhbmljX25vdGlmaWVyKSB7Ci0gICAgICAgIHNlcnZlci0+ZGV2aWNlX3BhbmljX25vdGlm
aWVyKHNlcnZlcik7Ci0gICAgfQotCiAgICAgLyoKICAgICAgKiBTZXQgdGhlIGNhbGxiYWNrIGZ1
bmN0aW9uIGZvciBuZXR3b3JrIGxpc3RlbmVyIHNvIGFub3RoZXIKICAgICAgKiB2aG9zdC11c2Vy
IGNsaWVudCBjYW4gY29ubmVjdCB0byB0aGlzIHNlcnZlcgpAQCAtMzg1LDcgKzM4MSw2IEBAIGJv
b2wgdmhvc3RfdXNlcl9zZXJ2ZXJfc3RhcnQoVnVTZXJ2ZXIgKnNlcnZlciwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU29ja2V0QWRkcmVzcyAqc29ja2V0X2FkZHIsCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEFpb0NvbnRleHQgKmN0eCwKICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdWludDE2X3QgbWF4X3F1ZXVlcywKLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRGV2aWNlUGFuaWNOb3RpZmllckZuICpkZXZpY2VfcGFuaWNfbm90aWZpZXIsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFZ1RGV2SWZhY2UgKnZ1X2lmYWNlLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApCiB7CkBAIC00MDIsNyArMzk3LDYg
QEAgYm9vbCB2aG9zdF91c2VyX3NlcnZlcl9zdGFydChWdVNlcnZlciAqc2VydmVyLAogICAgICAg
ICAudnVfaWZhY2UgICAgICAgICAgICAgID0gdnVfaWZhY2UsCiAgICAgICAgIC5tYXhfcXVldWVz
ICAgICAgICAgICAgPSBtYXhfcXVldWVzLAogICAgICAgICAuY3R4ICAgICAgICAgICAgICAgICAg
ID0gY3R4LAotICAgICAgICAuZGV2aWNlX3BhbmljX25vdGlmaWVyID0gZGV2aWNlX3BhbmljX25v
dGlmaWVyLAogICAgIH07CiAKICAgICBxaW9fbmV0X2xpc3RlbmVyX3NldF9uYW1lKHNlcnZlci0+
bGlzdGVuZXIsICJ2aG9zdC11c2VyLWJhY2tlbmQtbGlzdGVuZXIiKTsKLS0gCjIuMjYuMgoK


