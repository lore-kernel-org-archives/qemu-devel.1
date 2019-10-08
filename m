Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7D0C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0738320659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Xxdn6Fgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0738320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHrS5-0000uE-7q
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iHrR1-0008Tm-8O
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iHrQs-00081Z-B7
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:29:53 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:34248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iHrQq-0007zV-Lm
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1570548577;
 bh=KRxyWMGwYHsc2PLtzTuJhSwgWwS1OaAhdo/4qyfGDVc=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Xxdn6FgcHijfI5WkVzOACaTFe8I3Jv+rgedPHEZXGlES4SmyfSZSkOsA2fH2rjFAu
 UL++1fdoV0cbwRcc9n/NNy4L5oW9J0x4bVeGFxw0FCZ8LAM9qFpdnIJc0TNcuE5BEy
 9ujVAM6ZrLXvRIcu7uny6lM7jWNOePNEPsCO26B4=
X-QQ-SSF: 00010000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 123.114.118.157
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1570548576t439649
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGV0ZXIgTWF5ZGVsbA==?=" <peter.maydell@linaro.org>
Subject: Re: gdbstub and gbd segfaults on different instructions in
 userspaceemulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Tue, 8 Oct 2019 23:29:36 +0800
X-Priority: 1
Message-ID: <tencent_0B7AB6717DF477C06F3539D3@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 08 Oct 2019 23:29:37 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 54.207.22.56
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

T24gVHVlc2RheSwgT2N0IDgsIDIwMTkgYXQgNTo1NyBQTSwgUGV0ZXIgTWF5ZGVsbCA8cGV0
ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToKPgo+IE9uIFR1ZSwgOCBPY3QgMjAxOSBh
dCAxMDo1MCwgTGlibyBaaG91IDx6aGxiMjlAZm94bWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBJ
cyB0aGVyZSBhbnkgZm9sbG93LXVwIGd1eXM/IEhlbHAgd291bGQgYmUgYXBwcmVjaWF0ZWQu
Cj4KPiBOb3QgcmVhbGx5LiBZb3UncmUgdXNpbmcgYSBsb2NhbGx5IG1vZGlmaWVkIFFFTVUg
dGhhdAo+IHlvdSBhcHBlYXIgdG8gYmUgdHJ5aW5nIHRvIGdldCB0byBzdXBwb3J0IHNvbWUg
bm9uLXN0YW5kYXJkCj4gdmFyaWFudCBDUFUsIHNvIHlvdSdyZSBvbiB5b3VyIG93biBmb3Ig
dHJ5aW5nIHRvIGRlYnVnCj4gaXQgYmV5b25kIHRoZSBzb3J0IG9mIGdlbmVyYWwgc3VnZ2Vz
dGlvbnMgSSBhbHJlYWR5Cj4gZ2F2ZSB5b3UsIEknbSBhZnJhaWQuCgpPa2F5LiBUaGFuayB5
b3UgZm9yIHlvdXIgaGVscCByZWNlbnRseSBhbnl3YXkgOikKCkkgYW0gc3VzcGVjdGluZyB0
aGF0IG15IG93biB0b29sIGNoYWluIGRvZXNuJ3Qgd29yayB3aXRoIFFFTVUgb3V0IG9mIHRo
ZSBib3guIEluIHRoYXQgY2FzZSB0aGUgbWFpbGluZyBsaXN0IHByb2JhYmx5IGNvdWxkbid0
IGhlbHAuIEhvd2V2ZXIsIG1heSBJIHN0aWxsIGFzayBmb3Igc29tZSBhZHZpY2Ugb24gd29y
a2Fyb3VuZD8gSSB0aGluayBpdCdzIHRvbyBlYXJseSBmb3IgbWUgdG8gZ2l2ZSB1cCBvbiBR
RU1VLgoKV2hlbiBJIHVzZWQgbXkgb2JqZHVtcCAtZCB0byBkaXNhc3NlbWJsZSB0aGUgRUxG
IHByb2R1Y2VkIGJ5IG15IGN1c3RvbSBnY2MsIGl0IG9ubHkgY29udGFpbmVkIHRoZSA8bWFp
bj4gc2VjdGlvbiBpbiB0aGUgKmVudGlyZSogRUxGOyBXaGVuIEkgdXNlZCB0aGUgb2ZmaWNp
YWwgdG9vbCBjaGFpbiBmcm9tIE1JUFMgdG8gY29tcGlsZSB0aGUgc2FtZSBDIHNvdXJjZSwg
dGhlIG9iamR1bXAgLWQgZ2F2ZSBtZSBhIGxvdCBvZiBzZWN0aW9ucywgc3VjaCBhcyA8X19s
aWJjX3N0YXJ0X21haW4+LCBldGMuIEFuZCB0aGUgb2JqZHVtcCBpcyBjb25zaXN0ZW50IHdp
dGggdGhlIC1kIGluX2FzbSBsb2dnaW5nIG9wdGlvbiBmcm9tIFFFTVUuIEhlbmNlLCBJIHRo
aW5rIHRoaXMgY291bGQgYmUgdGhlIHJlYXNvbiB3aHkgb25seSBjaGFuZ2luZyB0aGUgb3Bj
b2RlIGZpZWxkcyBkb2Vzbid0IHdvcmsuIEkgb25seSBjaGFuZ2VkIHRoZSBJU0EsIGJ1dCBJ
IGRpZG4ndCBjaGFuZ2Ugb3RoZXIgcGFydHMgb2YgdGhlIENQVSB0byBhY2NvbW1vZGF0ZSBt
eSBuZWVkcy4gQXMgeW91IG1lbnRpb25lZCwgSSBoYXZlIGJlZW4gdHJ5aW5nIHRvIHN1cHBv
cnQgYSBub24tc3RhbmRhcmQgdmFyaWFudCBDUFUuCgpTbywgSSdkIGxpa2UgdG8gZ2l2ZSBp
dCBhIHRyeSB0byBjcmVhdGUgbXkgb3duIHRhcmdldC9teWNwdSwgd2hpY2ggaGFzIHZlcnkg
bGltaXRlZCBmdW5jdGlvbmFsaXR5LiBJdHMgY29tcGxleGl0eSBpcyBtdWNoIGxvd2VyIHRo
YW4gYWxsIHRoZSB2YXJpYW50cyBvZiBNSVBTLiBOb25ldGhlbGVzcywgaG93IHdvdWxkIHlv
dSBldmFsdWF0ZSB0aGUgZWZmb3J0IG5lZWRlZCB0byBkbyB0aGlzIGZyb20gc2NyYXRjaD8K
Ci0gTGlibyBaaG91




