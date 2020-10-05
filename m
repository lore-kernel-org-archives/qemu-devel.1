Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39045C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB75020639
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRmdxfO1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB75020639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSlt-0006jI-Sq
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSf1-0005yY-80
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kPSez-0008Gv-Hj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 11:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601912660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2oVRTewZtVGZG2GCafRUewUFORQU15oW+TyxD4WO/8k=;
 b=HRmdxfO1QsZ2Cp+bi5zu7BrdNsMl2bcuY79FOa5hcyOheyyLWou2BQrDYI9ckfVfzwmhlH
 coJHvScKSf+216lO8UPonHXUXT5Lv/fKY1awVz+MXR9/B0UZLJDIIPL7hBEs6/Q+Y3sn3u
 UdN/sI1AVMrYbcWvd2b9ngFuhtI2zog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-53Wea_1GM3i21X8-9hGbxQ-1; Mon, 05 Oct 2020 11:44:18 -0400
X-MC-Unique: 53Wea_1GM3i21X8-9hGbxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3DF8107ACF5;
 Mon,  5 Oct 2020 15:44:16 +0000 (UTC)
Received: from localhost (ovpn-112-117.ams2.redhat.com [10.36.112.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF2E60C11;
 Mon,  5 Oct 2020 15:44:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 14/17] include/block/block.h: drop non-ascii quotation mark
Date: Mon,  5 Oct 2020 16:43:20 +0100
Message-Id: <20201005154323.31347-15-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
References: <20201005154323.31347-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPgoKVGhpcyBpcyB0aGUgb25seSBub24tYXNjaWkgY2hhcmFjdGVyIGluIHRoZSBmaWxlIGFu
ZCBpdCBkb2Vzbid0IHJlYWxseQpuZWVkZWQgaGVyZS4gTGV0J3MgdXNlIG5vcm1hbCAiJyIgc3lt
Ym9sIGZvciBjb25zaXN0ZW5jeSB3aXRoIHRoZSByZXN0CjExIG9jY3VycmVuY2VzIG9mICInIiBp
biB0aGUgZmlsZS4KClNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkg
PHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFr
ZUByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJl
ZGhhdC5jb20+Ci0tLQogaW5jbHVkZS9ibG9jay9ibG9jay5oIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9i
bG9jay9ibG9jay5oIGIvaW5jbHVkZS9ibG9jay9ibG9jay5oCmluZGV4IDhiODdkZjY5YTEuLmNl
MmFjMzkyOTkgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYmxvY2svYmxvY2suaAorKysgYi9pbmNsdWRl
L2Jsb2NrL2Jsb2NrLmgKQEAgLTMwNCw3ICszMDQsNyBAQCBlbnVtIEJkcnZDaGlsZFJvbGVCaXRz
IHsKICAgICBCRFJWX0NISUxEX0ZJTFRFUkVEICAgICA9ICgxIDw8IDIpLAogCiAgICAgLyoKLSAg
ICAgKiBDaGlsZCBmcm9tIHdoaWNoIHRvIHJlYWQgYWxsIGRhdGEgdGhhdCBpc27igJl0IGFsbG9j
YXRlZCBpbiB0aGUKKyAgICAgKiBDaGlsZCBmcm9tIHdoaWNoIHRvIHJlYWQgYWxsIGRhdGEgdGhh
dCBpc24ndCBhbGxvY2F0ZWQgaW4gdGhlCiAgICAgICogcGFyZW50IChpLmUuLCB0aGUgYmFja2lu
ZyBjaGlsZCk7IHN1Y2ggZGF0YSBpcyBjb3BpZWQgdG8gdGhlCiAgICAgICogcGFyZW50IHRocm91
Z2ggQ09XIChhbmQgb3B0aW9uYWxseSBDT1IpLgogICAgICAqIFRoaXMgZmllbGQgaXMgbXV0dWFs
bHkgZXhjbHVzaXZlIHdpdGggREFUQSwgTUVUQURBVEEsIGFuZAotLSAKMi4yNi4yCgo=


