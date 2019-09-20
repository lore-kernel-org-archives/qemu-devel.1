Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FEBC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:01:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CD662086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="pAY+58D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CD662086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKPO-0000gP-FR
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iBKEQ-0005BN-3D
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iBKEH-0003mi-T7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:49:52 -0400
Received: from smtpbg507.qq.com ([203.205.250.51]:51066 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iBKEE-0003hN-57
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1568990971;
 bh=vDKkAVNBkOxeA4WWxVkO596D8bnEx69iURk9qimqrcU=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=pAY+58D/3lDe0SaBBGchbjNSgLjhbIJmBP3tn3/uMYU7esY8tXlRktf4ncn1brU+1
 TURQ+U3/ZQGRkNw0Gtpj+PG9lI346UKkoh2iR9XW1yVmvJmHDmAzLLi7DFVlXuHce6
 xwICgGc3nbfyEBzybZz6wJFUDZmNRKuJ/I8fEhLU=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 123.114.36.138
In-Reply-To: <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
References: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
 <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1568990970t328346
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re:  Initialize data memory in user space emulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Fri, 20 Sep 2019 22:49:30 +0800
X-Priority: 3
Message-ID: <tencent_5378456F7A2F471F74C049FC@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 1577244312
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 20 Sep 2019 22:49:30 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.205.250.51
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
Cc: =?ISO-8859-1?B?cWVtdS1kZXZlbA==?= <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsCgpUaGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb24uIFBsZWFzZSBsZXQgbWUg
YWRkIG1vcmUgZGV0YWlscyBhYm91dCB3aGF0IEkgbmVlZCB0byBkby4KCkkgbmVlZCB0byBl
bXVsYXRlIGEgRGlnaXRhbCBTaWduYWwgUHJvY2Vzc29yLiBUaGUgRFNQIGVzc2VudGlhbGx5
IGhhcyBvbmx5IGJhc2ljIE1JUFMgSVNBLCBhbmQgaXQgbWFuaXB1bGF0ZXMgdGhlIGRhdGEg
c3RvcmVkIGluIGEgImRhdGEgbWVtb3J5Ii4gSSBjYW4gcnVuIGFuIEVMRiB3aXRoIHVzZXIg
c3BhY2UgZW11bGF0aW9uLCB3aGF0IEkgbmVlZCB0byBhZGRpdGlvbmFsbHkgZG8gaXMgdG8g
aW5pdGlhbGl6ZSB0aGUgImRhdGEgbWVtb3J5IiBmaXJzdCwgdGhlbiBydW4gYW4gRUxGIHRo
YXQgbWFuaXB1bGF0ZXMgdGhlIGRhdGEgaW4gdGhlICJkYXRhIG1lbW9yeSIsIGFuZCBmaW5h
bGx5IHNlZSBpZiB0aGUgcmVzdWx0aW5nIGRhdGEgYXJlIGNvcnJlY3Qgb3Igbm90LgoKRG8g
eW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPwoKQ2hlZXJzLApMaWJvIFpob3UKCi0tLS0tLS0t
LS0tLS0tLS0tLSBPcmlnaW5hbCAtLS0tLS0tLS0tLS0tLS0tLS0KRnJvbTogICJQZXRlciBN
YXlkZWxsIjs8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsKU2VuZCB0aW1lOiBGcmlkYXks
IFNlcCAyMCwgMjAxOSA2OjM2IFBNClRvOiAiTGlibyBaaG91Ijx6aGxiMjlAZm94bWFpbC5j
b20+OyAKQ2M6ICJxZW11LWRldmVsIjxxZW11LWRldmVsQG5vbmdudS5vcmc+OyAKU3ViamVj
dDogIFJlOiBJbml0aWFsaXplIGRhdGEgbWVtb3J5IGluIHVzZXIgc3BhY2UgZW11bGF0aW9u
CgpPbiBGcmksIDIwIFNlcCAyMDE5IGF0IDEwOjI1LCBMaWJvIFpob3UgPHpobGIyOUBmb3ht
YWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBhbGwsCj4KPiBJIG5lZWQgYSB3YXkgdG8gbWFuaXB1
bGF0ZSBkYXRhIHNhdmVkIGluIGEgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbiBpbiBsaW51eCB1
c2VyIHNwYWNlIGVtdWxhdGlvbi4gSSBmb3VuZCB0aGUgLUIgb3B0aW9uIHZlcnkgcHJvbWlz
aW5nLiAgRG9jdW1lbnRhdGlvbiBzYXlzIGl0IGlzIHVzZWZ1bCB3aGVuIHRoZSBhZGRyZXNz
IHJlZ2lvbiByZXF1aXJlZCBieSBndWVzdCBhcHBsaWNhdGlvbnMgaXMgcmVzZXJ2ZWQgb24g
dGhlIGhvc3QuCj4KPiBCdXQgaG93IGNhbiBJIGluaXRpYWxpemUgdGhhdCBtZW1vcnkgd2l0
aCBkYXRhPwoKSGkgLS0gdGhpcyBpc24ndCByZWFsbHkgd2hhdCB0aGUgLUIgb3B0aW9uIGRv
ZXMuIFdoYXQgLUIgZG9lcwppcyBzZXQgdGhlICdndWVzdCBiYXNlJywgd2hpY2ggaXMgdGhl
IG9mZnNldCBiZXR3ZWVuIHdoYXQgdGhlCmd1ZXN0IHNlZXMgYXMgaXRzIGFkZHJlc3MgMCBh
bmQgd2hhdCB0aGUgaG9zdCdzIGFkZHJlc3MgaXMuIFNvCmlmIHlvdSB1c2UgLUIgdG8gc2V0
IHRoZSBndWVzdF9iYXNlIHRvIDB4MTAwMDAwMDAsIHRoZW4gd2hlbiB0aGUKZ3Vlc3QgdHJp
ZXMgdG8gbW1hcCgpIGEgZmlsZSB0byBhZGRyZXNzIDB4MjAwMDAwMDAgdGhlbiB3ZSB3aWxs
CnB1dCB0aGUgZmlsZSBhdCBob3N0IGFkZHJlc3MgMHgzMDAwMDAwMCAodGhlIGFkZHJlc3Mg
dGhlIGd1ZXN0CmFza3MgZm9yIHBsdXMgdGhlIGd1ZXN0X2Jhc2UpLgoKVGhlcmUgaXMgbm8g
d2F5IGF0IGFsbCBmb3IgdGhlIGd1ZXN0IHRvIGFjY2VzcyBhbnkgZGF0YSBiZWxvdyB0aGUK
Z3Vlc3RfYmFzZSBhZGRyZXNzLiBUaGUgcmVhc29uIHRoaXMgb3B0aW9uIGV4aXN0cyBpcyBp
biBjYXNlIHRoZQpkZWZhdWx0IHZhbHVlIFFFTVUgY2hvb3NlcyBmb3IgZ3Vlc3RfYmFzZSB3
b3VsZCByZXN1bHQgaW4gdGhlIGd1ZXN0CnRyeWluZyB0byBtbWFwIGZpbGVzIGluIHBsYWNl
cyB0aGF0IGFyZSBhbHJlYWR5IHVzZWQgYnkgdGhlIGhvc3QKUUVNVSBiaW5hcnkgb3IgbGli
cmFyaWVzLiBJdCdzIGFsbW9zdCBuZXZlciBhbiBvcHRpb24gdXNlcnMgbmVlZAp0byBzZXQu
CgpJJ20gbm90IHJlYWxseSBzdXJlIHdoYXQgeW91IG1lYW4gYnkgImEgcmVzZXJ2ZWQgbWVt
b3J5IHJlZ2lvbiIsCnNvIGl0J3MgYSBiaXQgaGFyZCB0byBzYXkgd2hhdCBtaWdodCBiZSB0
aGUgYmVzdCB3YXkgdG8gZG8gd2hhdAp5b3Ugd2FudCB0byBkby4KCnRoYW5rcwotLSBQTU0=


