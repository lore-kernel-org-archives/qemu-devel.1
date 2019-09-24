Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D7C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B042064A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 02:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="HE5azJcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B042064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCah4-0001dS-8R
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 22:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iCaff-0000VH-52
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iCafe-0002Xz-2P
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:35:19 -0400
Received: from smtpbg514.qq.com ([203.205.250.64]:42552 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iCafd-0002Wf-HZ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 22:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569292512;
 bh=UR1m1fqBSnUflUb3OHwrIEsr0aW7Vdf7OvzZsxL2w8c=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=HE5azJcpl9kSvmbq54s/KqSE1ct7rw3wI7djo1Z4ZKJaYPWpTHrLjYUyv3LzREiwK
 8MWQz2HAGrJX9qO33l3BsZEcCeMlhYiLB7RsPyaEKhdCkKwbnfltjnoCsYNuyfgyKx
 SUuIdvRY7VNgVc1jj0Ch87aQQCuHx+5aPSdolp3w=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
In-Reply-To: <tencent_3BE0CBCB7BA7249A0F92A863@qq.com>
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <tencent_6E390A001F25D33F67930C37@qq.com>
 <CAFEAcA98asDEZru6ht3PVN6g9duXnTTEHsuUzckFHZmV3+sqXw@mail.gmail.com>
 <tencent_3BE0CBCB7BA7249A0F92A863@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569291828t43725
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>,
 "=?ISO-8859-1?B?UGhpbGlwcGUmIzM4O25ic3A7TWF0aGlldS1EYXVk?="
 <philmd@redhat.com>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_5D897E33_0B46CBB8_494011E5"
Content-Transfer-Encoding: 8Bit
Date: Tue, 24 Sep 2019 10:23:47 +0800
X-Priority: 3
Message-ID: <tencent_47F32438770E30027BF2F5D1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 4022236700
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 24 Sep 2019 10:23:48 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.64
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

This is a multi-part message in MIME format.

------=_NextPart_5D897E33_0B46CBB8_494011E5
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

PiBJIHdvdWxkIHN0YXJ0IGJ5IHVzaW5nIHRoZSBRRU1VIGdkYnN0dWIgdG8gY29ubmVjdCBh
DQo+IE1JUFMtYXdhcmUgZ2RiLiBUaGVuIHdoZW4gdGhlIFNJR0lMTCBhcnJpdmVzIHlvdSBj
YW4gc2VlDQo+IHdoYXQgaW5zdHJ1Y3Rpb24gdGhlIGd1ZXN0IHByb2dyYW0gd2FzIHRyeWlu
ZyB0byBleGVjdXRlLg0KDQpKdXN0IHRyaWVkIGl0IGFuZCBmb3VuZCBzb21ldGhpbmcgaW50
ZXJlc3RpbmcuDQpJIGNvbm5lY3RlZCBnZGItbXVsdGlhcmNoIHRvIFFFTVUgZ2Ric3R1Yi4g
Z2RiLW11bHRpYXJjaCdzIGFyY2hpdGVjdHVyZSB3YXMgc2V0IHRvIG1pcHM6MzAwMCBhdXRv
bWF0aWNhbGx5IChhbmQgV2lraXBlZGlhIHNheXMgcjNrIHVzZXMgTUlQUy1JKS4NCg0KV2hl
biBJIGRpZCAnbGF5b3V0IGFzbScsIGFuZCBjb21wYXJlZCB0aGUgaW5zdHJ1Y3Rpb25zIGRp
c3BsYXllZCBhZ2FpbnN0IHRlc3QucyBnZW5lcmF0ZWQgYnkgbXkgbWlwc2VsLWxpbnV4LXVu
a25vd24tZ2NjLCB0aGV5IGFwcGVhcmVkIHRvIGJlIGEgbGl0dGxlIGJpdCBkaWZmZXJlbnQu
DQoNClRoZSAnc3RvcmUgd29yZCcgaW5zdHJ1Y3Rpb24gaW4gdGVzdC5zIGlzIHNob3duIGFz
IGEgaGV4ICcweDdmLi4uLi4uKGRvbid0IHJlbWVtYmVyIHRoZSByZXN0KSc7DQonbG9hZCB3
b3JkJyBpcyBzaG93biBhcyAnMHg1Zi4uLi4uLic7DQonbG9hZCBpbW1lZGlhdGUnIGlzIHNl
ZW4gYXMgJ2FkZGknOw0KJ2onIGFzICdqcic7DQoNCldoZW4gSSBzaW5nbGUtc3RlcHBlZCB0
aGUgaW5zdHJ1Y3Rpb25zLCB0aGUgU0lHSUxMIHdhcyB0aHJvd24gaW1tZWRpYXRlbHkgYWZ0
ZXIgdGhlIGZpcnN0IHVucmVjb2duaXplZCAweDdmLi4uLi4uLCB3aGljaCBpcyBzdXBwb3Nl
ZCB0byBiZSBhIHN0b3JlIHdvcmQgKHN3KS4NCg0KSGVuY2UsIGNhbiBJIGNvbmNsdWRlIHRo
YXQgTUlQUy1JIGlzIG5vdCBpbXBsZW1lbnRlZCBpbiBRRU1VIG91dCBvZiB0aGUgYm94Pw0K
DQoNCkVESVQ6IE9yIG15IGNvbXBpbGVyIGlzbid0IGltcGxlbWVudGluZyBNSVBTLUkgY29y
cmVjdGx5IGJlY2F1c2UgZ2RiLW11bHRpYXJjaCdzIHIzayBkb2Vzbid0IHJlY29nbml6ZSBz
b21lIGhleGVzPw==

------=_NextPart_5D897E33_0B46CBB8_494011E5
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64

Jmd0OyBJIHdvdWxkIHN0YXJ0IGJ5IHVzaW5nIHRoZSBRRU1VIGdkYnN0dWIgdG8gY29ubmVj
dCBhPGJyPjxkaXY+Jmd0OyBNSVBTLWF3YXJlIGdkYi4gVGhlbiB3aGVuIHRoZSBTSUdJTEwg
YXJyaXZlcyB5b3UgY2FuIHNlZTxicj4mZ3Q7IHdoYXQgaW5zdHJ1Y3Rpb24gdGhlIGd1ZXN0
IHByb2dyYW0gd2FzIHRyeWluZyB0byBleGVjdXRlLjxicj48YnI+SnVzdCB0cmllZCBpdCBh
bmQgZm91bmQgc29tZXRoaW5nIGludGVyZXN0aW5nLjxicj5JIGNvbm5lY3RlZCBnZGItbXVs
dGlhcmNoIHRvIFFFTVUgZ2Ric3R1Yi4gZ2RiLW11bHRpYXJjaCdzIGFyY2hpdGVjdHVyZSB3
YXMgc2V0IHRvIG1pcHM6MzAwMCBhdXRvbWF0aWNhbGx5IChhbmQgV2lraXBlZGlhIHNheXMg
cjNrIHVzZXMgTUlQUy1JKS48YnI+PGJyPldoZW4gSSBkaWQgJ2xheW91dCBhc20nLCBhbmQg
Y29tcGFyZWQgdGhlIGluc3RydWN0aW9ucyBkaXNwbGF5ZWQgYWdhaW5zdCB0ZXN0LnMgZ2Vu
ZXJhdGVkIGJ5IG15IG1pcHNlbC1saW51eC11bmtub3duLWdjYywgdGhleSBhcHBlYXJlZCB0
byBiZSBhIGxpdHRsZSBiaXQgZGlmZmVyZW50Ljxicj48YnI+VGhlICdzdG9yZSB3b3JkJyBp
bnN0cnVjdGlvbiBpbiB0ZXN0LnMgaXMgc2hvd24gYXMgYSBoZXggJzB4N2YuLi4uLi4oZG9u
J3QgcmVtZW1iZXIgdGhlIHJlc3QpJzs8YnI+J2xvYWQgd29yZCcgaXMgc2hvd24gYXMgJzB4
NWYuLi4uLi4nOzxicj4nbG9hZCBpbW1lZGlhdGUnIGlzIHNlZW4gYXMgJ2FkZGknOzxicj4n
aicgYXMgJ2pyJzs8YnI+PGJyPldoZW4gSSBzaW5nbGUtc3RlcHBlZCB0aGUgaW5zdHJ1Y3Rp
b25zLCB0aGUgU0lHSUxMIHdhcyB0aHJvd24gaW1tZWRpYXRlbHkgYWZ0ZXIgdGhlIGZpcnN0
IHVucmVjb2duaXplZCAweDdmLi4uLi4uLCB3aGljaCBpcyBzdXBwb3NlZCB0byBiZSBhIHN0
b3JlIHdvcmQgKHN3KS48YnI+PGJyPkhlbmNlLCBjYW4gSSBjb25jbHVkZSB0aGF0IE1JUFMt
SSBpcyBub3QgaW1wbGVtZW50ZWQgaW4gUUVNVSBvdXQgb2YgdGhlIGJveD88L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PkVESVQ6IE9yIG15IGNvbXBpbGVyIGlzbid0IGltcGxlbWVudGlu
ZyBNSVBTLUkgY29ycmVjdGx5IGJlY2F1c2UgZ2RiLW11bHRpYXJjaCdzIHIzayBkb2Vzbid0
IHJlY29nbml6ZSBzb21lIGhleGVzPzxicj48L2Rpdj4=

------=_NextPart_5D897E33_0B46CBB8_494011E5--


