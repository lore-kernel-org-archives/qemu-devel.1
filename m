Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0261C2BBD0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F403218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 07:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjeopsSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F403218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFY7b-00067d-PH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 03:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4p-0001Pr-81
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFY4n-0003mQ-42
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 03:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599550200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Mc+l5oLDgHB39gWm0BM6aQb/fYryBlI52dtyFliiLk=;
 b=bjeopsSj2Fb8/JQ6PVC8t67LL22YYWdcZKrkdnhr8JlhhNgaHjim8iN2bJ1o9UH7CObxvY
 XGelBCyD3SaSZX5brZNUFiukT+LyRawZS0SuOGikz40puf10aTac6aw+MMUzf1geneo5VK
 A7cPH2qEhOpuf56r3V2Upx3UoqMxmB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-pRTonswvOG-8vEcQyq3MjA-1; Tue, 08 Sep 2020 03:29:58 -0400
X-MC-Unique: pRTonswvOG-8vEcQyq3MjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A36D418B9EDE
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 07:29:57 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D163D7E30C;
 Tue,  8 Sep 2020 07:29:56 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 08/10] pc-bios: refresh edk2 build artifacts for
 edk2-stable202008
Date: Tue,  8 Sep 2020 09:29:37 +0200
Message-Id: <20200908072939.30178-9-lersek@redhat.com>
In-Reply-To: <20200908072939.30178-1-lersek@redhat.com>
References: <20200908072939.30178-1-lersek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmVidWlsZCB0aGUgcGMtYmlvcy9lZGsyLSouZmQuYnoyIGJpbmFyaWVzLCBiYXNlZCBvbiB0aGUg
ZWRrMi1zdGFibGUyMDIwMDgKcmVsZWFzZS4KCkNjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+ClJlZjogaHR0cHM6Ly9idWdzLmxhdW5jaHBhZC5uZXQvcWVtdS8r
YnVnLzE4NTIxOTYKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNv
bT4KLS0tCiBwYy1iaW9zL2VkazItYWFyY2g2NC1jb2RlLmZkLmJ6MiAgICAgICB8IEJpbiAxMTc4
MDcwIC0+IDE1MDc3MjIgYnl0ZXMKIHBjLWJpb3MvZWRrMi1hcm0tY29kZS5mZC5iejIgICAgICAg
ICAgIHwgQmluIDExNzI3NTIgLT4gMTUwMzE4NyBieXRlcwogcGMtYmlvcy9lZGsyLWkzODYtY29k
ZS5mZC5iejIgICAgICAgICAgfCBCaW4gMTczNjE5OSAtPiAxNjQ2NzQxIGJ5dGVzCiBwYy1iaW9z
L2VkazItaTM4Ni1zZWN1cmUtY29kZS5mZC5iejIgICB8IEJpbiAxOTQzOTQ5IC0+IDE4NjA1NDYg
Ynl0ZXMKIHBjLWJpb3MvZWRrMi14ODZfNjQtY29kZS5mZC5iejIgICAgICAgIHwgQmluIDE3MTcw
OTQgLT4gMTY4MDE2NCBieXRlcwogcGMtYmlvcy9lZGsyLXg4Nl82NC1zZWN1cmUtY29kZS5mZC5i
ejIgfCBCaW4gMTk1ODAzNyAtPiAxOTEyMTEyIGJ5dGVzCiA2IGZpbGVzIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wYy1iaW9zL2VkazItYWFy
Y2g2NC1jb2RlLmZkLmJ6MiBiL3BjLWJpb3MvZWRrMi1hYXJjaDY0LWNvZGUuZmQuYnoyCmluZGV4
IGEwNzQwODViMjI0Zi4uNWJmMzExNDY0YTc5IDEwMDY0NApCaW5hcnkgZmlsZXMgYS9wYy1iaW9z
L2VkazItYWFyY2g2NC1jb2RlLmZkLmJ6MiBhbmQgYi9wYy1iaW9zL2VkazItYWFyY2g2NC1jb2Rl
LmZkLmJ6MiBkaWZmZXIKZGlmZiAtLWdpdCBhL3BjLWJpb3MvZWRrMi1hcm0tY29kZS5mZC5iejIg
Yi9wYy1iaW9zL2VkazItYXJtLWNvZGUuZmQuYnoyCmluZGV4IDQyNDUzY2QxZjI3My4uN2E5ODA2
OTgxNGRjIDEwMDY0NApCaW5hcnkgZmlsZXMgYS9wYy1iaW9zL2VkazItYXJtLWNvZGUuZmQuYnoy
IGFuZCBiL3BjLWJpb3MvZWRrMi1hcm0tY29kZS5mZC5iejIgZGlmZmVyCmRpZmYgLS1naXQgYS9w
Yy1iaW9zL2VkazItaTM4Ni1jb2RlLmZkLmJ6MiBiL3BjLWJpb3MvZWRrMi1pMzg2LWNvZGUuZmQu
YnoyCmluZGV4IDYzMzc1OTY4OGUzMi4uZTdiMWJlZmUyY2ZlIDEwMDY0NApCaW5hcnkgZmlsZXMg
YS9wYy1iaW9zL2VkazItaTM4Ni1jb2RlLmZkLmJ6MiBhbmQgYi9wYy1iaW9zL2VkazItaTM4Ni1j
b2RlLmZkLmJ6MiBkaWZmZXIKZGlmZiAtLWdpdCBhL3BjLWJpb3MvZWRrMi1pMzg2LXNlY3VyZS1j
b2RlLmZkLmJ6MiBiL3BjLWJpb3MvZWRrMi1pMzg2LXNlY3VyZS1jb2RlLmZkLmJ6MgppbmRleCBk
ZjI3YmRkMmRkYmQuLmI1ZGY1YmVkMzA4NiAxMDA2NDQKQmluYXJ5IGZpbGVzIGEvcGMtYmlvcy9l
ZGsyLWkzODYtc2VjdXJlLWNvZGUuZmQuYnoyIGFuZCBiL3BjLWJpb3MvZWRrMi1pMzg2LXNlY3Vy
ZS1jb2RlLmZkLmJ6MiBkaWZmZXIKZGlmZiAtLWdpdCBhL3BjLWJpb3MvZWRrMi14ODZfNjQtY29k
ZS5mZC5iejIgYi9wYy1iaW9zL2VkazIteDg2XzY0LWNvZGUuZmQuYnoyCmluZGV4IDBlMTA4ZmM2
OGE5MS4uZTE2NTRkNDAwM2I3IDEwMDY0NApCaW5hcnkgZmlsZXMgYS9wYy1iaW9zL2VkazIteDg2
XzY0LWNvZGUuZmQuYnoyIGFuZCBiL3BjLWJpb3MvZWRrMi14ODZfNjQtY29kZS5mZC5iejIgZGlm
ZmVyCmRpZmYgLS1naXQgYS9wYy1iaW9zL2VkazIteDg2XzY0LXNlY3VyZS1jb2RlLmZkLmJ6MiBi
L3BjLWJpb3MvZWRrMi14ODZfNjQtc2VjdXJlLWNvZGUuZmQuYnoyCmluZGV4IDUyMmY4Mzc2YWFi
ZS4uNzY3Mjc0YzM4YzdmIDEwMDY0NApCaW5hcnkgZmlsZXMgYS9wYy1iaW9zL2VkazIteDg2XzY0
LXNlY3VyZS1jb2RlLmZkLmJ6MiBhbmQgYi9wYy1iaW9zL2VkazIteDg2XzY0LXNlY3VyZS1jb2Rl
LmZkLmJ6MiBkaWZmZXIKLS0gCjIuMTkuMS4zLmczMDI0N2FhNWQyMDEKCgo=


