Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C1EC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 04:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2C4206BB
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 04:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NjXr29e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEQTL-00037I-Uk
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 00:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iEQRm-00024W-DU
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 00:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iEQRe-0002L8-GS
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 00:04:28 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:36660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iEQRd-0002Gx-E7
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 00:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569729851;
 bh=t6B4yjDIptDZYWZ3YLUKAQC1J5/7xcRrf8WEw4ZRG/E=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=NjXr29e/itJiZ6StMOxz9rUjupj5ZYRcNedz3bsA0f9VB3I4ozQ6RQ/jjnugZQ628
 5kKJVYpI/ET0GDqU4yaS9t5++61uqwT04wNRiJHXjqWTM2yn6+2wMNdlO3N3Wl5s1o
 fWmcUlG9bByJfafWkXrHbxyJHXaKEqqMuP/+ZstY=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 159.226.200.178
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569729849t832211
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Subject: Why on earth is this code giving me Segfaults?
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Sun, 29 Sep 2019 12:04:09 +0800
X-Priority: 3
Message-ID: <tencent_76DBE21F6D585D0B6F510084@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Sun, 29 Sep 2019 12:04:10 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 52.59.177.22
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQWxsLAoKSSBoYXZlIGEgY3VzdG9tIElTQSB0aGF0J3MgYmFzZWQgb24gTUlQUy4gVGhl
IExXIGFuZCBTVyBpbnN0cnVjdGlvbnMnIG9wY29kZXMgYXJlIGNoYW5nZWQgaW50byAweDE3
KE9QQ19CR1RaTCkgYW5kIDB4MUYoT1BDX1NQRUNJQUwzKS4KCkkgaGF2ZSBtYWRlIHRoZSBm
b2xsb3dpbmcgY2hhbmdlcyBpbiB0YXJnZXQvbWlwcy90cmFuc2xhdGUuYzoKCkBAIC0yOTMz
MSw3ICsyOTMzMSwxMSBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfb3BjKENQVU1JUFNTdGF0ZSAq
ZW52LCBEaXNhc0NvbnRleHQgKmN0eCkKICAgICAgICAgICAgIGRlY29kZV9vcGNfc3BlY2lh
bDMoZW52LCBjdHgpOwogICAgICAgICB9CiAjZWxzZQotICAgICAgICBkZWNvZGVfb3BjX3Nw
ZWNpYWwzKGVudiwgY3R4KTsKKyAgICAgICAgaWYgKGN0eC0+aW5zbl9mbGFncyAmIElOU05f
TVlJU0EpIHsKKyAgICAgICAgICAgIGdlbl9zdChjdHgsIE9QQ19TVywgcnQsIHJzLCBpbW0p
OyAvKiBPUENfTVlJU0FfU1cgKi8KKyAgICAgICAgfSBlbHNlIHsKKyAgICAgICAgICAgIGRl
Y29kZV9vcGNfc3BlY2lhbDMoZW52LCBjdHgpOworICAgICAgICB9CiAjZW5kaWYKICAgICAg
ICAgYnJlYWs7CiAgICAgY2FzZSBPUENfUkVHSU1NOgpAQCAtMjk1ODksNiArMjk2MDMsOCBA
QCBzdGF0aWMgdm9pZCBkZWNvZGVfb3BjKENQVU1JUFNTdGF0ZSAqZW52LCBEaXNhc0NvbnRl
eHQgKmN0eCkKICAgICAgICAgICAgIH0KICAgICAgICAgICAgIC8qIE9QQ19CR1RaQywgT1BD
X0JMVFpDLCBPUENfQkxUQyAqLwogICAgICAgICAgICAgZ2VuX2NvbXB1dGVfY29tcGFjdF9i
cmFuY2goY3R4LCBvcCwgcnMsIHJ0LCBpbW0gPDwgMik7CisgICAgICAgIH0gZWxzZSBpZiAo
Y3R4LT5pbnNuX2ZsYWdzICYgSU5TTl9NWUlTQSkgeworICAgICAgICAgICAgZ2VuX2xkKGN0
eCwgT1BDX0xXLCBydCwgcnMsIGltbSk7IC8qIE9QQ19NWUlTQV9MVyAqLwogICAgICAgICB9
IGVsc2UgewogICAgICAgICAgICAgLyogT1BDX0JHVFpMICovCiAgICAgICAgICAgICBnZW5f
Y29tcHV0ZV9icmFuY2goY3R4LCBvcCwgNCwgcnMsIHJ0LCBpbW0gPDwgMiwgNCk7CgpJIHVz
ZWQgZ2Ric3R1YiB0byBzaW5nbGVzdGVwIG15IHByb2dyYW0sIGFuZCBJIGZvdW5kIHRoYXQg
bXkgc3cgaW5zdHJ1Y3Rpb24gaXMgd29ya2luZyBmaW5lLCBidXQgbHcgZ2l2ZXMgbWUgYSBz
ZWdmYXVsdC4gSSBoYXZlIGJlZW4gc3R1Y2sgb24gdGhpcyBmb3IgYSBsb25nIHdoaWxlLCBz
aW5jZSBpdCBsb29rcyBsaWtlIEkgb25seSBuZWVkIHRvIGFkZCB0aGF0IG9uZSBsaW5lIG9m
IGdlbl9sZCBmdW5jdGlvbi4gSSBhbHNvIHRyaWVkIGRlYnVnZ2luZyBRRU1VIHd0aWggZ2Ri
LCBidXQgdGhlIHNlZ2ZhdWx0IHdhc24ndCB0aHJvd24gaW1tZWRpYXRlbHkgYWZ0ZXIgbHcg
aW5zdHJ1Y3Rpb24gbGlrZSBnZGJzdHViIGRvZXMuCgpEb2VzIGFueW9uZSBoYXZlIGFueSBh
ZHZpY2U/CgpUaGFua3MsCkxpYm8gWmhvdQ==




