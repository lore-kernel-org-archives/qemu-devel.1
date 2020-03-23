Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BFC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBD0206F8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+rBk453"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBD0206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGSha-0004qq-FR
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 15:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jGSgR-0003gZ-VJ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jGSgQ-0001ab-Sm
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42535)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jGSgQ-0001aE-Oa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 15:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584991462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zXFuoyrRrw8R4/MRKzFpPa6yQ7AUf4yVhMGwVLv3SlI=;
 b=g+rBk453n+gign6YhGzIla6EsKbjktaow1Au0BBXAbyw3bMvAhgMORn97mqGaZeb7sjq+J
 GJOJ6Gpw07DIdCadb1dyaG+Bcc0ARmdypsY6n2psXNbsvMSEmDn25kM75OOEteR6M+CJUv
 Xvql2h7aTlr64q8Cql3bFifgPILBQNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-MRbV8qJQPp-Iy9FwyOOhOQ-1; Mon, 23 Mar 2020 15:24:18 -0400
X-MC-Unique: MRbV8qJQPp-Iy9FwyOOhOQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 710A910557DE;
 Mon, 23 Mar 2020 19:24:17 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2873088859;
 Mon, 23 Mar 2020 19:24:12 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/1] Block patches
Date: Mon, 23 Mar 2020 19:24:10 +0000
Message-Id: <20200323192411.325247-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyOWUwODU1YzVhZjYyYmJiMGIwYjZm
ZWQ3OTJlMDA0ZGFkOTJiYTk1OgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL2VsbWFyY28vdGFncy9zbGlycC1wdWxsLXJlcXVlc3QnIGludG8gc3RhZ2luZyAoMjAyMC0w
My0yMiAyMTowMDozOCArMDAwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0OgoKICBodHRwczovL2dpdGh1Yi5jb20vc3RlZmFuaGEvcWVtdS5naXQgdGFncy9ibG9jay1w
dWxsLXJlcXVlc3QKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBmZjgwN2Q1NTkyMDVh
NDM0ZmQzN2QzMzQzZjAxYTBhYjEyOGJkMTkwOgoKICBhaW8tcG9zaXg6IGZpeCBpb191cmluZyB3
aXRoIGV4dGVybmFsIGV2ZW50cyAoMjAyMC0wMy0yMyAxMTowNTo0NCArMDAwMCkKCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
UHVsbCByZXF1ZXN0CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpTdGVmYW4gSGFqbm9jemkgKDEpOgogIGFpby1wb3NpeDog
Zml4IGlvX3VyaW5nIHdpdGggZXh0ZXJuYWwgZXZlbnRzCgogdXRpbC9mZG1vbi1pb191cmluZy5j
IHwgMTMgKysrKysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKCi0tIAoyLjI0LjEKCg==


