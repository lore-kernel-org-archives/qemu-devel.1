Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275CDC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4602339D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BG/T3YnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4602339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5qPW-0004vA-QG
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 07:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i5qOo-0004T7-1i
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i5qOm-0003nW-EI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:58:01 -0400
Received: from smtpbg501.qq.com ([203.205.250.101]:54837 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i5qOl-0003io-Ck
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 07:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1567684666;
 bh=xL6bpqY75bkjHONBKgccgcIFVg147uqdKRQLfVRDnYw=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=BG/T3YnEXeQm08rS9RrD0ys8DVB0VTIgKJx8rQCgpRI4tybTs02PdTwvdNsLRmOk6
 IdcDTye73a7Mh1iYvULJNtNUR2dJ2yU6RRmYM3nY4pvnvXZKCMRujgr7YWyXBN+lcG
 HliUrTofB1wpCYH9/WMrl0Q8d15E7gGqd4z1wF7c=
X-QQ-SSF: 000100000000009000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
References: <tencent_3156C5EA2695B7CD53C6114C@qq.com>
 <CAL1e-=hWOXgnTbC0Y2v_CMZOMmQLgdToBAsi+XaW7+9uyN55CA@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1567684664t812879
From: "=?utf-8?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?utf-8?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?=" <aleksandar.m.mail@gmail.com>
Mime-Version: 1.0
Date: Thu, 5 Sep 2019 19:57:44 +0800
X-Priority: 3
Message-ID: <tencent_23ACCA1A48AFB09124C52E70@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 2018763698
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 05 Sep 2019 19:57:45 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.101
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Cc: =?utf-8?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RG8geW91IGtub3cgd2hlcmUgaW4gdGhlIHNvdXJjZSBmaWxlIEkgc2hvdWxkIGxvb2sgaW50
byB0byBhZGQgbXkgY3VzdG9tIGxvZ2dpbmcgZnVuY3Rpb25hbGl0eT8NCg0KDQpPciwgd291
bGQgeW91IHN1Z2dlc3QgdXNpbmcgZ2RiIHRvIGxvb2sgYXQgbXkgdGFyZ2V0IHJlZ2lzdGVy
IGFuZCBtZW1vcnkgY29udGVudHM/IFRoZSBhbnN3ZXIgaW4gdGhpcyBsaW5rIGJlbG93IGxv
b2tzIHJlYWxseSBwcm9taXNpbmcuIEknbSBnb25uYSBnaXZlIGl0IGEgdHJ5IGZpcnN0Lg0K
DQpodHRwczovL3N0YWNrb3ZlcmZsb3cuY29tL3F1ZXN0aW9ucy8zOTUwMzk5Ny9ob3ctdG8t
cnVuLWEtc2luZ2xlLWxpbmUtb2YtYXNzZW1ibHktdGhlbi1zZWUtcjEtYW5kLWNvbmRpdGlv
bi1mbGFncw0KDQoNCg0KSG93ZXZlciwgaWYgSSBhbSBhYmxlIHRvIGN1c3RvbWl6ZSBsb2cs
IGl0IHdpbGwgYmUgc3VwZXIgY29udmVuaWVudC4NCg0KDQoNCkNoZWVycywNCg0KTGlibw0K
DQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLQ0K
RnJvbTogICJBbGVrc2FuZGFyIE1hcmtvdmljIjs8YWxla3NhbmRhci5tLm1haWxAZ21haWwu
Y29tPjsNClNlbmQgdGltZTogVGh1cnNkYXksIFNlcCA1LCAyMDE5IDY6NTQgUE0NClRvOiAi
TGlibyBaaG91Ijx6aGxiMjlAZm94bWFpbC5jb20+OyANCkNjOiAicWVtdS1kZXZlbCI8cWVt
dS1kZXZlbEBub25nbnUub3JnPjsgDQpTdWJqZWN0OiAgUmU6IFtRZW11LWRldmVsXSBRRU1V
IGFzIElTUyAoSW5zdHJ1Y3Rpb24gU2V0IFNpbXVsYXRvcikNCg0KDQoNCjA0LjA5LjIwMTku
IDA1LjIzLCAiTGlibyBaaG91IiA8emhsYjI5QGZveG1haWwuY29tPiA/0LUg0L3QsNC/0LjR
gdCw0L4v0LvQsDoNCj4NCj4gSGkgQWxla3NhbmRhciwNCj4NCj4gSSBoYXZlIHNwZW50IHNv
bWUgdGltZSBsb29raW5nIGF0IHlvdXIgTVhVIEFTRSBwYXRjaC4gSXQncyBzdXBlciBoZWxw
ZnVsLg0KSSBuZWVkIHRvIGRvIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgYXMgeW91IGRpZC4N
Cj4NCj4gTm93IEkganVzdCBuZWVkIGEgd2F5IHRvIG9ic2VydmUgdGhlIG1lbW9yeSBhbmQg
cmVnaXN0ZXIgZmlsZSBjb250ZW50cyB0bw0KZGVidWcgbXkgaW5zdHJ1Y3Rpb24gc2V0IHNp
bXVsYXRvci4gSSBwbGF5ZWQgd2l0aCB0aGUgIi1kIiBzd2l0Y2ggdG8gbG9nIGENCmJ1bmNo
IG9mIGluZm9ybWF0aW9uLCBidXQgaXQgc2VlbXMgdGhhdCBub25lIG9mIHRoZSBpdGVtcyBp
cyBvZiBteQ0KaW50ZXJlc3QuIFRoZSAiLWQgY3B1X3Jlc2V0IiBvcHRpb24gZGlzcGxheXMg
YWxsIHplcm9zIGluIHRoZSBHUFIgbG9nLg0KPg0KDQpJdCBsb29rcyB5b3UgbmVlZCBhIGN1
c3RvbSBsb2dnaW5nIHRhaWxvcmVkIHRvIHlvdXIgbmVlZHMsIGJhc2VkIG9uDQppbnRlcmNl
cHRpbmcgdGhlIGluc3RydWN0aW9ucyB5b3UgYWRkZWQuDQoNCkFsZWtzYW5kYXINCg0KPiBQ
bGVhc2UgdGFrZSB5b3VyIHRpbWUsIGFzIEkgZnVsbHkgdW5kZXJzdGFuZCB5b3UgbmVlZCB0
byB3b3JrIG9uIFFlbXUNCndoaWxlIGFuc3dlcmluZyBhbGwgbXkgcXVlc3Rpb25zLiBBZ2Fp
biwgdGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBoZWxwIQ0KPg0KPiBDaGVlcnMsDQo+
IExpYm8NCj4=
