Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F13C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921462082F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg3YpkTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921462082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKKsw-0008QT-Lu
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jKKs0-0006xv-MY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jKKrz-0002qE-7k
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44417
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jKKrz-0002po-3l
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 07:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585914738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1G13JDH4E9P1UjPvAn1RGzM3ssI78Yc8xbLk35CaLEU=;
 b=cg3YpkTUa4i669O6dekxAoB5EssMDsVulM69CDL+wnvbc4Ox1Su/DxBX49Eg/2yOovf85y
 LArDV371zKW7zxXu9EGFLZp0KtgrF540a73jgQ/0WXgcm9jQTRzMRuu1KTl7kGO3oP2eqQ
 X/FbCPm0zCxkl4EKXFSzT60AS8z2a0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-wQnnaqDKOkuq6vdQp1Ekew-1; Fri, 03 Apr 2020 07:52:15 -0400
X-MC-Unique: wQnnaqDKOkuq6vdQp1Ekew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA6E800D50;
 Fri,  3 Apr 2020 11:52:14 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF08EA63D4;
 Fri,  3 Apr 2020 11:52:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 0/1] Block patches
Date: Fri,  3 Apr 2020 12:52:08 +0100
Message-Id: <20200403115209.145810-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA1MTQyY2EwNzhkMWNiYzBmNzdiMGYz
ODVkMjhjZGIzZTUwNGU2MmJkOgoKICBNZXJnZSByZW1vdGUtdHJhY2tpbmcgYnJhbmNoICdyZW1v
dGVzL2JvbnppbmkvdGFncy9mb3ItdXBzdHJlYW0nIGludG8gc3RhZ2luZyAoMjAyMC0wNC0wMiAy
MDoxODoyNSArMDEwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBodHRwczovL2dpdGh1Yi5jb20vc3RlZmFuaGEvcWVtdS5naXQgdGFncy9ibG9jay1wdWxsLXJl
cXVlc3QKCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBhZTYwYWI3ZWIyMDcxNWZhNjNj
Y2ExYjBiYjQ0OTNlMTYwZGE1MWNlOgoKICBhaW8tcG9zaXg6IGZpeCB0ZXN0LWFpbyAvYWlvL2V2
ZW50L3dhaXQgd2l0aCBmZG1vbi1pb191cmluZyAoMjAyMC0wNC0wMyAxMjo0Mjo0MCArMDEwMCkK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KUHVsbCByZXF1ZXN0CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpTdGVmYW4gSGFqbm9jemkgKDEpOgogIGFp
by1wb3NpeDogZml4IHRlc3QtYWlvIC9haW8vZXZlbnQvd2FpdCB3aXRoIGZkbW9uLWlvX3VyaW5n
CgogdXRpbC9mZG1vbi1pb191cmluZy5jIHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgotLSAKMi4yNS4xCgo=


