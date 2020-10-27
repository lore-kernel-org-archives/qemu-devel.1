Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B21C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6900A2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHLWwaus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6900A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT12-000713-Dv
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXStu-0006JU-Ja
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXSto-0003Mp-IH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pgo/hPO3XkNAVq76Dm4trhglF7b49yWZ48wKN7aJntE=;
 b=YHLWwausy9gQO7lcvcvC5hhWKrbRd1M96anyLSCFl4Md8gGwa9DVukJyJ20aA1LhWd1BzZ
 16QypJ1UN6bnUtu41ClcmsCb43E68z1uDvjQaI3fNwjDGPqKMdQ3imVNNnJZolqsMBjUmG
 /4KsTXyncMJO//0atxnoxhnsBL3HOs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-Aqx_o5-NOECkqpopyMkKQg-1; Tue, 27 Oct 2020 13:36:39 -0400
X-MC-Unique: Aqx_o5-NOECkqpopyMkKQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 409F0195D561;
 Tue, 27 Oct 2020 17:36:38 +0000 (UTC)
Received: from localhost (ovpn-115-166.ams2.redhat.com [10.36.115.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D59C055760;
 Tue, 27 Oct 2020 17:36:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] vhost-user-blk-test: rename destroy_drive() to
 destroy_file()
Date: Tue, 27 Oct 2020 17:35:25 +0000
Message-Id: <20201027173528.213464-10-stefanha@redhat.com>
In-Reply-To: <20201027173528.213464-1-stefanha@redhat.com>
References: <20201027173528.213464-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_BASE64_TEXT=1.741, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Coiby Xu <coiby.xu@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZ1bmN0aW9uIGlzIHVzZWQgbm90IGp1c3QgZm9yIGltYWdlIGZpbGVzIGJ1dCBhbHNvIGZv
ciBVTklYIGRvbWFpbgpzb2NrZXRzIChRTVAgbW9uaXRvciBhbmQgdmhvc3QtdXNlci1ibGspLiBS
ZWZsZWN0IHRoYXQgaW4gdGhlIG5hbWUuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkg
PHN0ZWZhbmhhQHJlZGhhdC5jb20+Ci0tLQogdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVz
dC5jIHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5j
IGIvdGVzdHMvcXRlc3Qvdmhvc3QtdXNlci1ibGstdGVzdC5jCmluZGV4IDMxZjIzMzVmOTcuLmYw
NWYxNGMxOTIgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L3Zob3N0LXVzZXItYmxrLXRlc3QuYwor
KysgYi90ZXN0cy9xdGVzdC92aG9zdC11c2VyLWJsay10ZXN0LmMKQEAgLTY1OCw3ICs2NTgsOCBA
QCBzdGF0aWMgY29uc3QgY2hhciAqcXRlc3RfcWVtdV9zdG9yYWdlX2RhZW1vbl9iaW5hcnkodm9p
ZCkKICAgICByZXR1cm4gcWVtdV9zdG9yYWdlX2RhZW1vbl9iaW47CiB9CiAKLXN0YXRpYyB2b2lk
IGRyaXZlX2Rlc3Ryb3kodm9pZCAqcGF0aCkKKy8qIGdfdGVzdF9xdWV1ZV9kZXN0cm95KCkgY2xl
YW51cCBmdW5jdGlvbiBmb3IgZmlsZXMgKi8KK3N0YXRpYyB2b2lkIGRlc3Ryb3lfZmlsZSh2b2lk
ICpwYXRoKQogewogICAgIHVubGluayhwYXRoKTsKICAgICBnX2ZyZWUocGF0aCk7CkBAIC02Nzgs
NyArNjc5LDcgQEAgc3RhdGljIGNoYXIgKmRyaXZlX2NyZWF0ZSh2b2lkKQogICAgIGdfYXNzZXJ0
X2NtcGludChyZXQsID09LCAwKTsKICAgICBjbG9zZShmZCk7CiAKLSAgICBnX3Rlc3RfcXVldWVf
ZGVzdHJveShkcml2ZV9kZXN0cm95LCB0X3BhdGgpOworICAgIGdfdGVzdF9xdWV1ZV9kZXN0cm95
KGRlc3Ryb3lfZmlsZSwgdF9wYXRoKTsKICAgICByZXR1cm4gdF9wYXRoOwogfQogCkBAIC03MTcs
NyArNzE4LDcgQEAgc3RhdGljIGNoYXIgKnN0YXJ0X3Zob3N0X3VzZXJfYmxrKEdTdHJpbmcgKmNt
ZF9saW5lLCBpbnQgdnVzX2luc3RhbmNlcywKIAogICAgIHFtcF9mZCA9IG1rc3RlbXAocW1wX3Nv
Y2tfcGF0aCk7CiAgICAgZ19hc3NlcnRfY21waW50KHFtcF9mZCwgPj0sIDApOwotICAgIGdfdGVz
dF9xdWV1ZV9kZXN0cm95KGRyaXZlX2Rlc3Ryb3ksIHFtcF9zb2NrX3BhdGgpOworICAgIGdfdGVz
dF9xdWV1ZV9kZXN0cm95KGRlc3Ryb3lfZmlsZSwgcW1wX3NvY2tfcGF0aCk7CiAKICAgICBnX3N0
cmluZ19hcHBlbmRfcHJpbnRmKHN0b3JhZ2VfZGFlbW9uX2NvbW1hbmQsCiAgICAgICAgICAgICAi
ZXhlYyAlcyAiCkBAIC03MzEsNyArNzMyLDcgQEAgc3RhdGljIGNoYXIgKnN0YXJ0X3Zob3N0X3Vz
ZXJfYmxrKEdTdHJpbmcgKmNtZF9saW5lLCBpbnQgdnVzX2luc3RhbmNlcywKICAgICAgICAgc29j
a19wYXRoID0gZ19zdHJkdXAoc29ja19wYXRoX3RlbXBhdGUpOwogICAgICAgICBmZCA9IG1rc3Rl
bXAoc29ja19wYXRoKTsKICAgICAgICAgZ19hc3NlcnRfY21waW50KGZkLCA+PSwgMCk7Ci0gICAg
ICAgIGdfdGVzdF9xdWV1ZV9kZXN0cm95KGRyaXZlX2Rlc3Ryb3ksIHNvY2tfcGF0aCk7CisgICAg
ICAgIGdfdGVzdF9xdWV1ZV9kZXN0cm95KGRyaXZlX2ZpbGUsIHNvY2tfcGF0aCk7CiAgICAgICAg
IC8qIGNyZWF0ZSBpbWFnZSBmaWxlICovCiAgICAgICAgIGltZ19wYXRoID0gZHJpdmVfY3JlYXRl
KCk7CiAgICAgICAgIGdfc3RyaW5nX2FwcGVuZF9wcmludGYoc3RvcmFnZV9kYWVtb25fY29tbWFu
ZCwKLS0gCjIuMjYuMgoK


