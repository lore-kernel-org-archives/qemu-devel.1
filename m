Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24853C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861632074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y74OA9yb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861632074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKd6-0002It-IN
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZZ-0005yK-Ew
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaKZW-0007xU-AJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604503177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SDFk5PbT1fcpoJeoCbXDc0HMullXY8b21Cyi2Mg2wg=;
 b=Y74OA9ybUIHyetqH3ze4G6uRc5X/C+ZeiAANYTwqdSF1qWNFeq6r24NrxmjvYnuhW/QsIm
 jz3eEAAzWF/8WRQVPGEfY9ugQVDU7m2fjaMoaBpJJZZ3WZREOyP2Q0lBaUztyLgQ96lwYI
 43yGIZ2O5lfzzWSOZfY3AQhLL+q4wzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-MlGACpTqNpqKyKx8kiBOOg-1; Wed, 04 Nov 2020 10:19:35 -0500
X-MC-Unique: MlGACpTqNpqKyKx8kiBOOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE2E48049C3;
 Wed,  4 Nov 2020 15:19:33 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B27DE19C4F;
 Wed,  4 Nov 2020 15:19:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/33] block/nvme: Improve nvme_free_req_queue_wait() trace
 information
Date: Wed,  4 Nov 2020 15:18:03 +0000
Message-Id: <20201104151828.405824-9-stefanha@redhat.com>
In-Reply-To: <20201104151828.405824-1-stefanha@redhat.com>
References: <20201104151828.405824-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgoKV2hhdCB3
ZSB3YW50IHRvIHRyYWNlIGlzIHRoZSBibG9jayBkcml2ZXIgc3RhdGUgYW5kIHRoZSBxdWV1ZSBp
bmRleC4KClN1Z2dlc3RlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29t
PgpSZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPgpSZXZpZXdl
ZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPgpNZXNzYWdlLWlkOiAyMDIwMTAyOTA5
MzMwNi4xMDYzODc5LTctcGhpbG1kQHJlZGhhdC5jb20KU2lnbmVkLW9mZi1ieTogU3RlZmFuIEhh
am5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgpUZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4KLS0tCiBibG9jay9udm1lLmMgICAgICAgfCAyICstCiBibG9jay90
cmFjZS1ldmVudHMgfCAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9udm1lLmMgYi9ibG9jay9udm1lLmMKaW5k
ZXggOGQ3NDQwMWFlNy4uMjlkMjU0MWI5MSAxMDA2NDQKLS0tIGEvYmxvY2svbnZtZS5jCisrKyBi
L2Jsb2NrL252bWUuYwpAQCAtMjkyLDcgKzI5Miw3IEBAIHN0YXRpYyBOVk1lUmVxdWVzdCAqbnZt
ZV9nZXRfZnJlZV9yZXEoTlZNZVF1ZXVlUGFpciAqcSkKIAogICAgIHdoaWxlIChxLT5mcmVlX3Jl
cV9oZWFkID09IC0xKSB7CiAgICAgICAgIGlmIChxZW11X2luX2Nvcm91dGluZSgpKSB7Ci0gICAg
ICAgICAgICB0cmFjZV9udm1lX2ZyZWVfcmVxX3F1ZXVlX3dhaXQocSk7CisgICAgICAgICAgICB0
cmFjZV9udm1lX2ZyZWVfcmVxX3F1ZXVlX3dhaXQocS0+cywgcS0+aW5kZXgpOwogICAgICAgICAg
ICAgcWVtdV9jb19xdWV1ZV93YWl0KCZxLT5mcmVlX3JlcV9xdWV1ZSwgJnEtPmxvY2spOwogICAg
ICAgICB9IGVsc2UgewogICAgICAgICAgICAgcWVtdV9tdXRleF91bmxvY2soJnEtPmxvY2spOwpk
aWZmIC0tZ2l0IGEvYmxvY2svdHJhY2UtZXZlbnRzIGIvYmxvY2svdHJhY2UtZXZlbnRzCmluZGV4
IDg2MjkyZjMzMTIuLmNjNWUyYjU1Y2IgMTAwNjQ0Ci0tLSBhL2Jsb2NrL3RyYWNlLWV2ZW50cwor
KysgYi9ibG9jay90cmFjZS1ldmVudHMKQEAgLTE1NCw3ICsxNTQsNyBAQCBudm1lX3J3X2RvbmUo
dm9pZCAqcywgaW50IGlzX3dyaXRlLCB1aW50NjRfdCBvZmZzZXQsIHVpbnQ2NF90IGJ5dGVzLCBp
bnQgcmV0KSAicwogbnZtZV9kc20odm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBi
eXRlcykgInMgJXAgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5dGVzICUiUFJJZDY0IiIKIG52bWVfZHNt
X2RvbmUodm9pZCAqcywgdWludDY0X3Qgb2Zmc2V0LCB1aW50NjRfdCBieXRlcywgaW50IHJldCkg
InMgJXAgb2Zmc2V0IDB4JSJQUkl4NjQiIGJ5dGVzICUiUFJJZDY0IiByZXQgJWQiCiBudm1lX2Rt
YV9tYXBfZmx1c2godm9pZCAqcykgInMgJXAiCi1udm1lX2ZyZWVfcmVxX3F1ZXVlX3dhaXQodm9p
ZCAqcSkgInEgJXAiCitudm1lX2ZyZWVfcmVxX3F1ZXVlX3dhaXQodm9pZCAqcywgdW5zaWduZWQg
cV9pbmRleCkgInMgJXAgcSAjJXUiCiBudm1lX2NtZF9tYXBfcWlvdih2b2lkICpzLCB2b2lkICpj
bWQsIHZvaWQgKnJlcSwgdm9pZCAqcWlvdiwgaW50IGVudHJpZXMpICJzICVwIGNtZCAlcCByZXEg
JXAgcWlvdiAlcCBlbnRyaWVzICVkIgogbnZtZV9jbWRfbWFwX3Fpb3ZfcGFnZXModm9pZCAqcywg
aW50IGksIHVpbnQ2NF90IHBhZ2UpICJzICVwIHBhZ2VbJWRdIDB4JSJQUkl4NjQKIG52bWVfY21k
X21hcF9xaW92X2lvdih2b2lkICpzLCBpbnQgaSwgdm9pZCAqcGFnZSwgaW50IHBhZ2VzKSAicyAl
cCBpb3ZbJWRdICVwIHBhZ2VzICVkIgotLSAKMi4yOC4wCgo=


