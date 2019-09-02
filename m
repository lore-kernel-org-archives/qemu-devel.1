Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75975C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4140F216C8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 11:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="M6hdzNTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4140F216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4kTl-00056t-Cz
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 07:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i4kT1-0004fj-4o
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i4kSr-0006Pt-Da
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:25:42 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:53349)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i4kSq-00068v-JB
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 07:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1567423528;
 bh=fAk4LexEbpBEggO4XJTqTiAl2svYv5APasXIKhiJaos=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=M6hdzNTQHaFLSrYNJN0GYcdrevL3M6MX1WYc1x2uGbMLhlitW+GiiVanPuLwo2tug
 KxXrFzSW4lIrXQmGyAqptk0L80ycEAXqzfdzluXO0agADyjey4HYlkoGWP3bJJG3PM
 MZzw9EeJRj87mApr/P6+oDv1RJUqy/IpFJdzdbSU=
X-QQ-SSF: 000100000000008000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <tencent_61024D4F136E131E2B085A7DACEA1593D007@qq.com>
References: <tencent_61024D4F136E131E2B085A7DACEA1593D007@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1567423528t126817
From: "=?gb18030?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Mime-Version: 1.0
Date: Mon, 2 Sep 2019 19:25:28 +0800
X-Priority: 3
Message-ID: <tencent_60FF9338731C8E0D678B2C3B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 4226378228
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 02 Sep 2019 19:25:28 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 54.204.34.130
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Uncaught target signal 11 (Segmentation Faullt)
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

QWRkaW5nIHNvbWUgdXNlZnVsIGluZm9ybWF0aW9uLCBlbmFibGluZyBzdHJhY2UgZ2l2ZXMg
bWUgdGhlIGZvbGxvd2luZyBtZXNzYWdlcy4gSXQgbG9va3MgbGlrZSB0aGUgc2VnbWVudGF0
aW9uIGZhdWx0IGlzIHVsdGltYXRlbHkgY2F1c2VkIGJ5IG1pc3NpbmcgbGQuc28ubm9od2Nh
cCBhbmQgbGQuc28ucHJlbG9hZD8NCg0KDQoNCiQgLi9xZW11LW1pcHMgLUwgL3Vzci9taXBz
LWxpbnV4LWdudSAtc3RyYWNlIHRlc3QNCjEwMjU1IGJyayhOVUxMKSA9IDB4MDA0MTIwMDAN
CjEwMjU1IG1tYXAyKE5VTEwsODE5MixQUk9UX1JFQUR8UFJPVF9XUklURSxNQVBfUFJJVkFU
RXxNQVBfQU5PTllNT1VTLC0xLDApID0gMHg3ZjdjODAwMA0KMTAyNTUgdW5hbWUoMHg3ZmZm
ZThjOCkgPSAwDQoxMDI1NSBhY2Nlc3MoIi9ldGMvbGQuc28ubm9od2NhcCIsRl9PSykgPSAt
MSBlcnJubz0yIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0KMTAyNTUgYWNjZXNzKCIv
ZXRjL2xkLnNvLnByZWxvYWQiLFJfT0spID0gLTEgZXJybm89MiAoTm8gc3VjaCBmaWxlIG9y
IGRpcmVjdG9yeSkNCjEwMjU1IG9wZW5hdChBVF9GRENXRCwiL2V0Yy9sZC5zby5jYWNoZSIs
T19SRE9OTFl8T19DTE9FWEVDKSA9IDMNCjEwMjU1IGZzdGF0NjQoMywweDdmZmZlNTE4KSA9
IDANCjEwMjU1IG1tYXAyKE5VTEwsMTA2ODAyLFBST1RfUkVBRCxNQVBfUFJJVkFURSwzLDAp
ID0gMHg3ZjdhZDAwMA0KMTAyNTUgY2xvc2UoMykgPSAwDQotLS0gU0lHU0VHViB7c2lfc2ln
bm89U0lHU0VHViwgc2lfY29kZT0xLCBzaV9hZGRyPTB4MjM5MmQwMDh9IC0tLQ0KcWVtdTog
dW5jYXVnaHQgdGFyZ2V0IHNpZ25hbCAxMSAoU2VnbWVudGF0aW9uIGZhdWx0KSAtIGNvcmUg
ZHVtcGVkDQpbMV0gICAgMTAyNTUgc2VnbWVudGF0aW9uIGZhdWx0IChjb3JlIGR1bXBlZCkg
IC4vcWVtdS1taXBzIC1zdHJhY2UgdGVzdA0KDQoNCg0KDQoNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogICJMaWJvIFpob3UiOzx6
aGxiMjlAZm94bWFpbC5jb20+Ow0KU2VuZCB0aW1lOiBNb25kYXksIFNlcCAyLCAyMDE5IDEy
OjE2IFBNDQpUbzogInFlbXUtZGV2ZWwiPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IA0KDQpT
dWJqZWN0OiAgVW5jYXVnaHQgdGFyZ2V0IHNpZ25hbCAxMSAoU2VnbWVudGF0aW9uIEZhdWxs
dCkNCg0KDQoNCkkgYW0gdHJ5aW5nIHRvIHJ1biBhIHNpbXBsZSBNSVBTIHByb2dyYW0gd2l0
aCBRRU1VIHVzZXIgbW9kZS4NCg0KDQoNCkhvc3Q6IFVidW50dSAxOC4wNCBMVFMgb24geDg2
XzY0DQpRRU1VIGNvbmZpZzogLi4vY29uZmlndXJlIC0tdGFyZ2V0LWxpc3Q9bWlwcy1saW51
eC11c2VyDQoNCkNyb3NzIENvbXBpbGVyOiBzdWRvIGFwdCBpbnN0YWxsIGdjYy1taXBzLWxp
bnV4LWdudQ0KDQoNCk15IHRlc3QuYyBpcyBzaW1wbGU6IGludCBtYWluKHZvaWQpIHtpbnQg
YSA9IDE7IGludCBiID0yOyBpbnQgYzsgYyA9IGEgKyBiOyByZXR1cm4gMDt9DQpBZnRlciBj
b21waWxpbmcgaXQgd2l0aCAibWlwcy1saW51eC1nbnUtZ2NjIHRlc3QuYyAtbyB0ZXN0Iiwg
SSByYW4gaXQgd2l0aCAiLi9xZW11LW1pcHMgLUwgL3Vzci9taXBzLWxpbnV4LWdudSB0ZXN0
IiwgdGhlbiBJIGdvdCB0aGUgZm9sbG93aW5nIGVycm9yIG1lc3NhZ2U6DQpxZW11OiB1bmNh
dWdodCB0YXJnZXQgc2lnbmFsIDExIChTZWdtZW50YXRpb24gZmF1bHQpIC0gY29yZSBkdW1w
ZWQNCg0KDQpEb2VzIGFueW9uZSBoYXZlIGEgc29sdXRpb24gdG8gdGhpcz8gVGhhbmsgeW91
IGluIGFkdmFuY2UuDQoNCg0KQ2hlZXJzLA0KTGlibw==
