Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E5C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D5A20640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Mt1L0BJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D5A20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCm0t-0001sY-Si
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iCllH-0003aG-8R
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:25:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iCll8-00069P-3V
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:25:42 -0400
Received: from smtpbg515.qq.com ([203.205.250.53]:38435 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iCll6-00062e-JD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:25:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569335131;
 bh=Cfr5PYtJn5Bfp4nsdpS2qrV4WaGK5oiw2LV9n73vTE8=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Mt1L0BJ8ctRkEnbgNTDi2xtF3S8x4QPY2JtYiwtFYTxX7LLKbhqtmxaJs26n8RUhg
 7Jap+iv890VfVZMpbg8FF32acSdRv7tUsUUnvuKT9Bq83W2OKHTfORO4OPUsez7Yfd
 h+5iT2r9R6dE+hUpX7ItRGiq1KpZlOeqrBbWWryw=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.221.97.28
In-Reply-To: <b4bc1f35-817d-79a0-df4d-07eaa2fdffe5@redhat.com>
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
 <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
 <tencent_0084E0586ADE9B2D30176A53@qq.com>
 <tencent_6A42D8651281588C41FEE751@qq.com>
 <tencent_6DB0EBDC4C098868592B8A79@qq.com>
 <b4bc1f35-817d-79a0-df4d-07eaa2fdffe5@redhat.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569334484t569226
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk?=" <philmd@redhat.com>,
 "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re: illegal hardware instruction during MIPS-I ELF linuxuseremulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 24 Sep 2019 22:14:44 +0800
X-Priority: 3
Message-ID: <tencent_27BC7EC25610890B701F563B@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3007157609
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 24 Sep 2019 22:14:45 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.53
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
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?ISO-8859-1?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?= <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+IE1vcmUgdXBkYXRlcyBhYm91dCB0aGlzLiBJIGp1c3QgZGlzYXNzZW1ibGVkIHRoZSB1
bnJlY29nbml6ZWQgaGV4IGJ5IGhhbmQsIGFuZCBmaWd1cmVkIG91dCB0aGF0IHRoZSBzdG9y
ZSB3b3JkIGFuZCBsb2FkIHdvcmQgb3Bjb2RlcyBhcmUgbm90IHRoZSBzYW1lIGFzIHNwZWNp
ZmllZCBpbiB0cmFuc2xhdGUuYy4gV2hpbGUgdGhlIHJlbWFpbmluZyBmaWVsZHMgb2YgdGhv
c2UgdW5yZWNvZ25pemVkIGluc3RydWN0aW9ucyBkbyBtYXRjaCB3aXRoIHRoZSBzb3VyY2Ug
YW5kIGRlc3RpbmF0aW9uIHJlZ2lzdGVycy4KCj4gV2hhdCBpcyB5b3VyIGNvbXBpbGVyL2Fz
c2VtYmxlciB2ZXJzaW9ucyAob24gYm90aCBtYWNoaW5lcyB5b3UgdXNlZCk/CgpJIGRvbid0
IGhhdmUgYWNjZXNzIHRvIHRoZSBtYWNoaW5lIGZvciBub3cgYW5kIEkgbWF5IG5vdCByZW1l
bWJlciB0aGUgZXhhY3QgdmVyc2lvbiBudW1iZXJzLgoKVGhlIGNyb3NzIGNvbXBpbGVyIEkg
dXNlZCBpcyBhIGN1c3RvbSBjb21waWxlciBiYXNlZCBvbiBnY2MgNC40LjAgKHZhZ3VlbHkg
cmVtZW1iZXIpLiBJdCBnZW5lcmF0ZWQgTUlQUy1JIGNvZGUgdGhhdCBkaWRuJ3Qgd29yayBv
biBRRU1VLiBTcGVjaWZpY2FsbHkgc29tZSBnZW5lcmF0ZWQgb3Bjb2RlcyBkaWRuJ3QgbWF0
Y2ggdGhvc2UgaW4gdGFyZ2V0L21pcHMvdHJhbnNsYXRlLmMuIEhvd2V2ZXIsIEkganVzdCBj
aGVja2VkIFdpa2lwZWRpYSdzIE1JUFMtSSBvcGNvZGUgdGFibGUgYW5kIEkgdGhpbmsgUUVN
VSBpbXBsZW1lbnRzIGl0IGNvcnJlY3RseS4gVGhlIHNpbmdsZSBhbmQgZG91YmxlIGZsb2F0
aW5nIHBvaW50IG9wY29kZSBsb29rZWQgYSBsaXR0bGUgb2ZmIGZvciBtZSB0aG91Z2gsIGJ1
dCBJIGRpZG4ndCB1c2UgRlAgb3BzIGluIG15IGNhc2UuCgpPbiBteSBvd24gUEMgSSB1c2Vk
IG1pcHNlbC1saW51eC1nbnUtZ2NjIHZlcnNpb24gNy40LjAuIEl0IGp1c3Qgd29ya2VkIGZp
bmUgb24gUUVNVS4=


