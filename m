Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBC7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 21:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359D32087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDU1SHuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359D32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb8vA-0000kg-Lh
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 16:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kb8uH-0000GC-7m
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 16:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kb8uE-0007TV-La
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 16:04:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604696660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=H/PXH+B7if04WRAIWkL+Jy54eXHRDtPsYGgcuKex6ec=;
 b=ZDU1SHuPAlPWL5AS6+1GiRCgrqquuRA5cAmoYOtCVL9o/klnln6D4STWZbrp92QF2aqav9
 ArNAK2+CY4sSUZzyQzRa2N4naOiSyVdP66AbqVuD1vTEtWAU4AfKVxqR5FoKMcAIN7ZBo3
 KtSVPwadyoCRu3XYQF/7bAm4z2MBJcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-It-9kqyZPx-HCm3U8SEjjw-1; Fri, 06 Nov 2020 16:04:17 -0500
X-MC-Unique: It-9kqyZPx-HCm3U8SEjjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5767B803654
 for <qemu-devel@nongnu.org>; Fri,  6 Nov 2020 21:04:16 +0000 (UTC)
Received: from localhost (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12A311A4D8;
 Fri,  6 Nov 2020 21:04:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: always include contrib/libvhost-user
Date: Fri,  6 Nov 2020 21:03:40 +0000
Message-Id: <20201106210340.698771-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 06:30:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bGlidmhvc3QtdXNlciBpcyBuZWVkZWQgd2hlbiBDT05GSUdfTElOVVggaXMgc2V0LiBUaGUgQ09O
RklHX1ZIT1NUX1VTRVIKY2hlY2sgaW4gbWVzb24uYnVpbGQgaXMgaW5jb3JyZWN0LgoKSW4gZmFj
dCwgbm8gZXhwbGljaXQgY2hlY2sgaXMgbmVlZGVkIHNpbmNlIHRoaXMgZGVwZW5kZW5jeSBpcyBu
b3QgYnVpbHQKYnkgZGVmYXVsdC4gSWYgc29tZXRoaW5nIGRlY2xhcmVzIGEgZGVwZW5kZW5jeSBv
biBsaWJ2aG9zdC11c2VyIHRoZW4gaXQKd2lsbCBiZSBidWlsdCwgb3RoZXJ3aXNlIGl0IHdvbid0
IGJlIGJ1aWx0IChpLmUuIG9uIG5vbi1MaW51eCBob3N0cykuCgpUaGlzIGZpeGVzIC4vY29uZmln
dXJlIC0tZGlzYWJsZS12aG9zdC11c2VyICYmIG1ha2UuCgpGaXhlczogYmMxNWU0NGNiMjE5MWJi
YjIzMTg4NzhhY2RmNTAzODEzNGU1NjM5NCAoImNvbmZpZ3VyZTogaW50cm9kdWNlIC0tZW5hYmxl
LXZob3N0LXVzZXItYmxrLXNlcnZlciIpClJlcG9ydGVkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+ClJlcG9ydGVkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQogbWVzb24uYnVpbGQgfCA2ICstLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxk
IGIvbWVzb24uYnVpbGQKaW5kZXggZjUxNzUwMTBkZi4uYjQ3MzYyMDMyMSAxMDA2NDQKLS0tIGEv
bWVzb24uYnVpbGQKKysrIGIvbWVzb24uYnVpbGQKQEAgLTE0NTAsMTEgKzE0NTAsNyBAQCB0cmFj
ZV9ldmVudHNfc3ViZGlycyArPSBbCiAgICd1dGlsJywKIF0KIAotdmhvc3RfdXNlciA9IG5vdF9m
b3VuZAotaWYgJ0NPTkZJR19WSE9TVF9VU0VSJyBpbiBjb25maWdfaG9zdAotICBzdWJkaXIoJ2Nv
bnRyaWIvbGlidmhvc3QtdXNlcicpCi1lbmRpZgotCitzdWJkaXIoJ2NvbnRyaWIvbGlidmhvc3Qt
dXNlcicpCiBzdWJkaXIoJ3FhcGknKQogc3ViZGlyKCdxb2JqZWN0JykKIHN1YmRpcignc3R1YnMn
KQotLSAKMi4yOC4wCgo=


