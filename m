Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C04520818
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 03:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="PcSUY8hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C04520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huU69-0003dJ-S4
	for qemu-devel@archiver.kernel.org; Sun, 04 Aug 2019 23:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hope2hope@163.com>) id 1huU5D-0002iZ-S9
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hope2hope@163.com>) id 1huU5C-000545-Mx
 for qemu-devel@nongnu.org; Sun, 04 Aug 2019 23:54:51 -0400
Received: from m13-149.163.com ([220.181.13.149]:31372)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <hope2hope@163.com>)
 id 1huU59-0004tS-05; Sun, 04 Aug 2019 23:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=SCNaE
 oGDwblt1dSp/uIF8vwW9AIBjwy4SfNYLx6ElKM=; b=PcSUY8hD/1+dDBksdfYtc
 PJeWU0hIUOIrI0K7Y8irl2XaWjgFDtHhojRmz61eccUMt6j/+zD1u3d3fRt8qhfU
 bLZbH2nctVWRBj1rBE6NRMQcmdYnYH/Jk2ZJ2AJHjGGkR4Z0bqU5lC5VYLxJg5sr
 vU+ywbJ+smWyocVCKjDRGs=
Received: from hope2hope$163.com ( [36.152.9.226] ) by ajax-webmail-wmsvr149
 (Coremail) ; Mon, 5 Aug 2019 11:39:17 +0800 (CST)
X-Originating-IP: [36.152.9.226]
Date: Mon, 5 Aug 2019 11:39:17 +0800 (CST)
From: ddm <hope2hope@163.com>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20190614(cb3344cf) Copyright (c) 2002-2019 www.mailtech.cn 163com
X-CM-CTRLDATA: 2UlNcmZvb3Rlcl9odG09MTE2ODg6NTY=
MIME-Version: 1.0
Message-ID: <7f455f0d.730d.16c5fdc21af.Coremail.hope2hope@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: lcGowABHZzXmpEddf8XVAQ--.2403W
X-CM-SenderInfo: pkrsvjpkrsvqqrwthudrp/1tbiVwAIK1etdeURRAABsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.13.149
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] How to configure QEMU to support APIC virtualization
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

SGkgZ3V5cywgCgoKSSBoYXZlIHRyaWVkIHZpYSBtb2Rwcm9iZSBrdm1pbnRlbCBlbmFibGVfYXBp
Y3Y9WSAgdG8gYWRqdXN0IEtWTSBwYXJhbWV0ZXIsIGJ1dCBpdCBkb2Vzbid0IGVmZmVjdCwgIGFu
ZCAKY2F0IC9zeXMvbW9kdWxlL2t2bV9pbnRlbC9wYXJhbWV0ZXJzL2VuYWJsZV9hcGljdiBhbHdh
eXMgcmV0dXJuICJOIi4gCkkgZG9uJ3Qga25vdyBob3cgdG8gY29uZmlndXJlIEtWTSBvciBRRU1V
IHRvIHN1cHBvcnQgQVBJQyB2aXJ0dWFsaXphaW9uIGZlYXR1cmU/CgoKTXkgaG9zdCBpbmZvcyBh
cmUgYXMgZm9sbG93czoKQXJjaGl0ZWN0dXJlOiAgICAgICAgICB4ODZfNjQKQ1BVIG9wLW1vZGUo
cyk6ICAgICAgICAzMi1iaXQsIDY0LWJpdApCeXRlIE9yZGVyOiAgICAgICAgICAgIExpdHRsZSBF
bmRpYW4KQ1BVKHMpOiAgICAgICAgICAgICAgICAxCk9uLWxpbmUgQ1BVKHMpIGxpc3Q6ICAgMApU
aHJlYWQocykgcGVyIGNvcmU6ICAgIDEKQ29yZShzKSBwZXIgc29ja2V0OiAgICAxClNvY2tldChz
KTogICAgICAgICAgICAgMQpOVU1BIG5vZGUocyk6ICAgICAgICAgIDEKVmVuZG9yIElEOiAgICAg
ICAgICAgICBHZW51aW5lSW50ZWwKQ1BVIGZhbWlseTogICAgICAgICAgICA2Ck1vZGVsOiAgICAg
ICAgICAgICAgICAgMTQyCk1vZGVsIG5hbWU6ICAgICAgICAgICAgSW50ZWwoUikgQ29yZShUTSkg
aTctODY1MFUgQ1BVIEAgMS45MEdIegpTdGVwcGluZzogICAgICAgICAgICAgIDEwCkNQVSBNSHo6
ICAgICAgICAgICAgICAgMjExMi4wMDEKQm9nb01JUFM6ICAgICAgICAgICAgICA0MjI0LjAwClZp
cnR1YWxpemF0aW9uOiAgICAgICAgVlQteApIeXBlcnZpc29yIHZlbmRvcjogICAgIFZNd2FyZQpW
aXJ0dWFsaXphdGlvbiB0eXBlOiAgIGZ1bGwKTDFkIGNhY2hlOiAgICAgICAgICAgICAzMksKTDFp
IGNhY2hlOiAgICAgICAgICAgICAzMksKTDIgY2FjaGU6ICAgICAgICAgICAgICAyNTZLCkwzIGNh
Y2hlOiAgICAgICAgICAgICAgODE5MksKTlVNQSBub2RlMCBDUFUocyk6ICAgICAwCkZsYWdzOiAg
ICAgICAgICAgICAgICAgZnB1IHZtZSBkZSBwc2UgdHNjIG1zciBwYWUgbWNlIGN4OCBhcGljIHNl
cCBtdHJyIHBnZSBtY2EgY21vdiBwYXQgcHNlMzYgY2xmbHVzaCBtbXggZnhzciBzc2Ugc3NlMiBz
cyBzeXNjYWxsIG54IHBkcGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcmNoX3BlcmZtb24g
bm9wbCB4dG9wb2xvZ3kgdHNjX3JlbGlhYmxlIG5vbnN0b3BfdHNjIGNwdWlkIHBuaSBwY2xtdWxx
ZHEgdm14IHNzc2UzIGZtYSBjeDE2IHBjaWQgc3NlNF8xIHNzZTRfMiB4MmFwaWMgbW92YmUgcG9w
Y250IHRzY19kZWFkbGluZV90aW1lciBhZXMgeHNhdmUgYXZ4IGYxNmMgcmRyYW5kIGh5cGVydmlz
b3IgbGFoZl9sbSBhYm0gM2Rub3dwcmVmZXRjaCBjcHVpZF9mYXVsdCBpbnZwY2lkX3NpbmdsZSBw
dGkgc3NiZCBpYnJzIGlicGIgc3RpYnAgdHByX3NoYWRvdyB2bm1pIGVwdCB2cGlkIGZzZ3NiYXNl
IHRzY19hZGp1c3QgYm1pMSBobGUgYXZ4MiBzbWVwIGJtaTIgaW52cGNpZCBydG0gcmRzZWVkIGFk
eCBzbWFwIHhzYXZlb3B0IGFyYXQgZmx1c2hfbDFkIGFyY2hfY2FwYWJpbGl0aWVzCgoKQ291bGQg
eW91IHRlbGwgbWUgaG93IHRvIGNvbmZpZ3VyZSBpdD8KCgpUaGFua3MhCgo=
