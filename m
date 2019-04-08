Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4AEC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D8F20870
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D8F20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xiyoulinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDSKw-0005jD-4q
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:21:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghorges@xiyoulinux.org>) id 1hDSK2-0005RJ-4K
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghorges@xiyoulinux.org>) id 1hDSK1-00008i-0f
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:20:18 -0400
Received: from [103.7.28.233] (port=20187 helo=smtpbg65.qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghorges@xiyoulinux.org>)
	id 1hDSK0-0008K8-AI
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:20:16 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 0010000000000040
X-QQ-FEAT: nLUbXEU1eY8KWcfMsE5mkPx7B0D1Pe4/46z3/JZXR6L1Xc+KL0z8yNh9MUcUy
	75YcS6rB6nMf1j3NWs+961zmmUroGQaWAldQEl41krHzYC4xLIIpobD1G/HAEQWaWU5hOOM
	J8ffCoWzEo2iFtqyhmXMtvW+DyYFEVgj0J5r6ItNqL1EnSmm9VITB++wfBPC8G14ThUleyg
	Qhn7ddblhq62JVD7ukyg5DMEkR0EczWMeAAQRcR2FCwjmisdGFuTBBTW4BIjxU0vrnxQd2Q
	CmItaJ+fdN1v0aTyD0YXqhgPeLSSa7FI2THg==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.32.244.134
X-QQ-STYLE: 
X-QQ-mid: bizmailfree42t1554722393t6685
From: "=?utf-8?B?6ams6Im66K+a?=" <ghorges@xiyoulinux.org>
To: "=?utf-8?B?S2V2aW4gV29sZg==?=" <kwolf@redhat.com>
Mime-Version: 1.0
Date: Mon, 8 Apr 2019 19:19:53 +0800
X-Priority: 3
Message-ID: <tencent_63CD3C0B2F1F67D51C95257F@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20190408084056.26212-1-ghorges@xiyoulinux.org>
	<20190408103939.GC11997@linux.fritz.box>
In-Reply-To: <20190408103939.GC11997@linux.fritz.box>
X-QQ-ReplyHash: 2142472457
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
	id ; Mon, 08 Apr 2019 19:19:54 +0800 (CST)
Feedback-ID: bizmailfree:xiyoulinux.org:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.4.x
X-Received-From: 103.7.28.233
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Wshadow in qemu/linux-user/syscall.c
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?utf-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
	=?utf-8?B?cWVtdS1ibG9jaw==?= <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408111953.AWoNr2Zv_iRH3Fu4fGhJ4xkj_lYmsEO8Q6sDGwfaAwA@z>

U29ycnksIEkgYW0gYSBuZXdiaWUuIEkgaGF2ZSBuZXZlciB1c2VkIHRoaXMga2luZCBvZiB0
aGluZyBiZWZvcmUuIA0KDQoNCkkgd2lsbCBkZWZpbml0ZWx5IHBheSBhdHRlbnRpb24gbmV4
dCB0aW1lLg0KIA0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0t
LS0tLQ0KRnJvbTogICJLZXZpbiBXb2xmIjxrd29sZkByZWRoYXQuY29tPjsNCkRhdGU6ICBN
b24sIEFwciA4LCAyMDE5IDA2OjM5IFBNDQpUbzogICJnaG9yZ2VzIjxnaG9yZ2VzQHhpeW91
bGludXgub3JnPjsgDQpDYzogICJxZW11LWRldmVsIjxxZW11LWRldmVsQG5vbmdudS5vcmc+
OyAicWVtdS1ibG9jayI8cWVtdS1ibG9ja0Bub25nbnUub3JnPjsgDQpTdWJqZWN0OiAgUmU6
IFtRZW11LWRldmVsXSBXc2hhZG93IGluIHFlbXUvbGludXgtdXNlci9zeXNjYWxsLmMNCg0K
IA0KDQpBbSAwOC4wNC4yMDE5IHVtIDEwOjQwIGhhdCBnaG9yZ2VzIGdlc2NocmllYmVuOg0K
PiAtLS0NCj4gIGxpbnV4LXVzZXIvc3lzY2FsbC5jIHwgNjYgKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNl
cnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCg0KVGhvbWFzIGFscmVhZHkgZ2F2ZSB5b3Ug
c29tZSBoaW50cyB3aGF0IHRvIGltcHJvdmUuIEknZCBqdXN0IGxpa2UgdG8gYWRkDQp0aGF0
IHlvdSBzaG91bGRuJ3Qgc2VuZCB0aGUgZW1haWwgdG8gdGhlIHFlbXUtYmxvY2sgbWFpbGlu
ZyBsaXN0IGlmIHRoZQ0KcGF0Y2ggaXMgbm90IGFib3V0IHRoZSBibG9jayBsYXllciBhdCBh
bGwuDQoNCktldmlu
