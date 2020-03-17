Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3DCC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E2920714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0w3D6vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E2920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE6G-0006qx-J8
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jEDzP-0005O3-OF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jEDzN-0007xV-DV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33477)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jEDzM-0007sa-Ts
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584458320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NfCZn4u/MSSZO0ve40cCTa5850KeWw5uXF8AM5zmDWA=;
 b=I0w3D6vodelr9q11TXt+f2HfYXXCpGkd79J0h20fgS9c+E5yuFfWZa1c7NX0aFpB2tOXRO
 5oJkMZCQkgYvv53u1T5Wr9ZvtCid5eA70lryf4m10tW5Xiryq3wi2PUPUvaJDbrdOk0vRF
 EGRYcHsSJOiiGu8akTDSafsx9UvY51Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-IAInA0z5OmSRK6BD3sfACA-1; Tue, 17 Mar 2020 11:18:37 -0400
X-MC-Unique: IAInA0z5OmSRK6BD3sfACA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A9DA1365;
 Tue, 17 Mar 2020 15:18:35 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6A5FC5DA7C;
 Tue, 17 Mar 2020 15:18:32 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Block patches
Date: Tue, 17 Mar 2020 15:18:30 +0000
Message-Id: <20200317151831.531965-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA2MWMyNjVmMDY2MGVlNDc2OTg1ODA4
YzhhYTc5MTU2MTdjNDRmZDUzOgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL2RnaWxiZXJ0L3RhZ3MvcHVsbC1taWdyYXRpb24tMjAyMDAzMTNhJyBpbnRvIHN0YWdpbmcg
KDIwMjAtMDMtMTMgMTA6MzM6MDQgKzAwMDApCgphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVw
b3NpdG9yeSBhdDoKCiAgaHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL3FlbXUuZ2l0IHRhZ3Mv
YmxvY2stcHVsbC1yZXF1ZXN0Cgpmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gNGFiNzhi
MTkxODlhODEwMzhlNzQ0NzI4ZWQ5NDlkMDlhYTQ3NzU1MDoKCiAgYmxvY2svaW86IGZpeCBiZHJ2
X2NvX2RvX2NvcHlfb25fcmVhZHYgKDIwMjAtMDMtMTYgMTE6NDY6MTEgKzAwMDApCgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClB1bGwgcmVxdWVzdAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMSk6
CiAgYmxvY2svaW86IGZpeCBiZHJ2X2NvX2RvX2NvcHlfb25fcmVhZHYKCiBibG9jay9pby5jIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgotLSAK
Mi4yNC4xCgo=


