Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A37C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A189A21655
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Sy3qFBFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A189A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCleh-0004P6-AA
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iCkus-0002UV-Hx
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iCkup-0002gu-Ho
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:31:42 -0400
Received: from smtpbg502.qq.com ([203.205.250.69]:58486 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iCkun-0002eh-1n
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569331875;
 bh=jau/CzfV/WC49a7cyN4sIv2G1lC3UVMWEBuEgtQLacQ=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Sy3qFBFo9R4EKDAA2cseeMGjvOzd86DJU3EJxQhlVh3C8PKssFOStxb6kwprvX+da
 nz1D7mZq/TK2evBgen+0pIS+Phn33RSNeDyUvqFX6UvYCtlFn5jA3wffuZnxLg0nhZ
 M5znWkgx66h0JlxhxuGVc/khm5VQRp2w9agiu0NE=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.221.97.28
In-Reply-To: <tencent_6A42D8651281588C41FEE751@qq.com>
References: <tencent_28AAA62B694825C348B1DF49@qq.com>
 <CAFEAcA8+bK0UyUWbXOiutyQZkCMSB_0Be7pJLKONSpA3CV9Pbw@mail.gmail.com>
 <tencent_0084E0586ADE9B2D30176A53@qq.com>
 <tencent_6A42D8651281588C41FEE751@qq.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569331874t931584
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>,
 "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 24 Sep 2019 21:31:14 +0800
X-Priority: 3
Message-ID: <tencent_6DB0EBDC4C098868592B8A79@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 2553603780
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 24 Sep 2019 21:31:15 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.69
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
Cc: =?ISO-8859-1?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk?= <philmd@redhat.com>,
 =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>,
 =?ISO-8859-1?B?QWxla3NhbmRhciBNYXJrb3ZpYw==?= <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+IEkgd291bGQgc3RhcnQgYnkgdXNpbmcgdGhlIFFFTVUgZ2Ric3R1YiB0byBjb25uZWN0
IGEKPiA+IE1JUFMtYXdhcmUgZ2RiLiBUaGVuIHdoZW4gdGhlIFNJR0lMTCBhcnJpdmVzIHlv
dSBjYW4gc2VlCj4gPiB3aGF0IGluc3RydWN0aW9uIHRoZSBndWVzdCBwcm9ncmFtIHdhcyB0
cnlpbmcgdG8gZXhlY3V0ZS4KCj4gSnVzdCB0cmllZCBpdCBhbmQgZm91bmQgc29tZXRoaW5n
IGludGVyZXN0aW5nLgo+IEkgY29ubmVjdGVkIGdkYi1tdWx0aWFyY2ggdG8gUUVNVSBnZGJz
dHViLiBnZGItbXVsdGlhcmNoJ3MgYXJjaGl0ZWN0dXJlIHdhcyBzZXQgdG8gbWlwczozMDAw
IGF1dG9tYXRpY2FsbHkgKGFuZCBXaWtpcGVkaWEgc2F5cyByM2sgdXNlcyBNSVBTLUkpLgoK
PiBXaGVuIEkgZGlkICdsYXlvdXQgYXNtJywgYW5kIGNvbXBhcmVkIHRoZSBpbnN0cnVjdGlv
bnMgZGlzcGxheWVkIGFnYWluc3QgdGVzdC5zIGdlbmVyYXRlZCBieSBteSBtaXBzZWwtbGlu
dXgtdW5rbm93bi1nY2MsIHRoZXkgYXBwZWFyZWQgdG8gYmUgYSBsaXR0bGUgYml0IGRpZmZl
cmVudC4KCj4gVGhlICdzdG9yZSB3b3JkJyBpbnN0cnVjdGlvbiBpbiB0ZXN0LnMgaXMgc2hv
d24gYXMgYSBoZXggJzB4N2YuLi4uLi4oZG9uJ3QgcmVtZW1iZXIgdGhlIHJlc3QpJzsKPiAn
bG9hZCB3b3JkJyBpcyBzaG93biBhcyAnMHg1Zi4uLi4uLic7Cj4gJ2xvYWQgaW1tZWRpYXRl
JyBpcyBzZWVuIGFzICdhZGRpJzsKPiAnaicgYXMgJ2pyJzsKCj4gV2hlbiBJIHNpbmdsZS1z
dGVwcGVkIHRoZSBpbnN0cnVjdGlvbnMsIHRoZSBTSUdJTEwgd2FzIHRocm93biBpbW1lZGlh
dGVseSBhZnRlciB0aGUgZmlyc3QgdW5yZWNvZ25pemVkIDB4N2YuLi4uLi4sIHdoaWNoIGlz
IHN1cHBvc2VkIHRvIGJlIGEgc3RvcmUgd29yZCAoc3cpLgoKPiBIZW5jZSwgY2FuIEkgY29u
Y2x1ZGUgdGhhdCBNSVBTLUkgaXMgbm90IGltcGxlbWVudGVkIGluIFFFTVUgb3V0IG9mIHRo
ZSBib3g/IE9yIGlzIGl0IHBvc3NpYmxlIHRoYXQgbXkgY29tcGlsZXIgZG9lc24ndCBpbXBs
ZW1lbnQgTUlQUy1JIGNvcnJlY3RseT8KCk1vcmUgdXBkYXRlcyBhYm91dCB0aGlzLiBJIGp1
c3QgZGlzYXNzZW1ibGVkIHRoZSB1bnJlY29nbml6ZWQgaGV4IGJ5IGhhbmQsIGFuZCBmaWd1
cmVkIG91dCB0aGF0IHRoZSBzdG9yZSB3b3JkIGFuZCBsb2FkIHdvcmQgb3Bjb2RlcyBhcmUg
bm90IHRoZSBzYW1lIGFzIHNwZWNpZmllZCBpbiB0cmFuc2xhdGUuYy4gV2hpbGUgdGhlIHJl
bWFpbmluZyBmaWVsZHMgb2YgdGhvc2UgdW5yZWNvZ25pemVkIGluc3RydWN0aW9ucyBkbyBt
YXRjaCB3aXRoIHRoZSBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHJlZ2lzdGVycy4=


