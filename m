Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7138C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A524D21D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Gy0c6ufH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A524D21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUql-0003l4-PI
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1iDUol-0001qM-9s
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1iDUof-0003Nu-6i
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:32:22 -0400
Received: from smtpbg510.qq.com ([203.205.250.17]:54176 helo=smtpbg.qq.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1iDUod-0003KU-UP
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1569508296;
 bh=eSnwZMlMvs0GtGMSfcqxX2KHGfH6yhpa7IuUcQfdhUw=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=Gy0c6ufHLlU1kqY2yjYbB6RIpZPWoLAZYj1zRMYsCRbJKL1lVtWQ72xQiY/BS60Wj
 wkHFJCQ8gcK58vam8VSJ49OVrhxoLCjs0slXaWglivJs5DZc2RoJgtJgC4I1EumXWy
 D23SiNjt9Q0AOQ5ZAvelmkrFxXEsBpZ7hdngxkJc=
X-QQ-SSF: 00000000000000F000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 221.221.97.28
In-Reply-To: <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
References: <tencent_5D6D8ED31E83C5675AB8AA3C@qq.com>
 <c722d11e-e0ff-8a91-d8f3-ee0a31f1df33@redhat.com>
X-QQ-STYLE: 
X-QQ-mid: webenglish1t1569508295t602967
From: "=?ISO-8859-1?B?TGlibyBaaG91?=" <zhlb29@foxmail.com>
To: "=?ISO-8859-1?B?UGhpbGlwcGUgTWF0aGlldS1EYXVk?=" <philmd@redhat.com>,
 "=?ISO-8859-1?B?UGV0ZXImIzM4O25ic3A7TWF5ZGVsbA==?="
 <peter.maydell@linaro.org>
Subject: Re: illegal hardware instruction during MIPS-I ELF linux useremulation
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date: Thu, 26 Sep 2019 22:31:35 +0800
X-Priority: 3
Message-ID: <tencent_7AB3CDCC529EAE38265539A9@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 156644286
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 26 Sep 2019 22:31:35 +0800 (CST)
Feedback-ID: webenglish:foxmail.com:bgweb:bgweb2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 203.205.250.17
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
 =?ISO-8859-1?B?QWxla3NhbmRhciYjMzg7bmJzcDtNYXJrb3ZpYw==?=
 <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBJZiB5b3UgbG9vayBhdCB0aGUgbWlwc19kZWZzW10gYXJyYXkgaW4KPiB0YXJnZXQvbWlw
cy90cmFuc2xhdGVfaW5pdC5pbmMuYywgdGhlIG9sZGVyIElTQSBpbXBsZW1lbnRlZCBpcyBN
SVBTLUlJOgoKPiAkIGdpdCBncmVwIC5pbnNuX2ZsYWdzIHRhcmdldC9taXBzL3RyYW5zbGF0
ZV9pbml0LmluYy5jCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6NzU6ICAgICAgICAuaW5zbl9m
bGFncyA9IENQVV9NSVBTMzIsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6OTc6ICAgICAgICAu
aW5zbl9mbGFncyA9IENQVV9NSVBTMzIgfCBBU0VfTUlQUzE2LAo+IHRyYW5zbGF0ZV9pbml0
LmluYy5jOjExNzogICAgICAgIC5pbnNuX2ZsYWdzID0gQ1BVX01JUFMzMiwKPiB0cmFuc2xh
dGVfaW5pdC5pbmMuYzoxMzc6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBTMzIgfCBB
U0VfTUlQUzE2LAo+IHRyYW5zbGF0ZV9pbml0LmluYy5jOjE1ODogICAgICAgIC5pbnNuX2Zs
YWdzID0gQ1BVX01JUFMzMlIyLAo+IHRyYW5zbGF0ZV9pbml0LmluYy5jOjE3OTogICAgICAg
IC5pbnNuX2ZsYWdzID0gQ1BVX01JUFMzMlIyIHwgQVNFX01JUFMxNiwKPiB0cmFuc2xhdGVf
aW5pdC5pbmMuYzoyMDE6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBTMzJSMiB8IEFT
RV9NSVBTMTYsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6MjIzOiAgICAgICAgLmluc25fZmxh
Z3MgPSBDUFVfTUlQUzMyUjIgfCBBU0VfTUlQUzE2IHwgQVNFX0RTUCwKPiB0cmFuc2xhdGVf
aW5pdC5pbmMuYzoyNDk6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBTMzJSMiB8IEFT
RV9NSVBTMTYsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6Mjk3OiAgICAgICAgLmluc25fZmxh
Z3MgPSBDUFVfTUlQUzMyUjIgfCBBU0VfTUlQUzE2IHwgQVNFX0RTUCB8IEFTRV9NVCwKPiB0
cmFuc2xhdGVfaW5pdC5pbmMuYzozMjM6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBT
MzJSMiB8IEFTRV9NSVBTMTYgfCBBU0VfRFNQIHwgQVNFX0RTUF9SMiwKPiB0cmFuc2xhdGVf
aW5pdC5pbmMuYzozNDM6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBTMzJSMiB8IEFT
RV9NSUNST01JUFMsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6MzY0OiAgICAgICAgLmluc25f
ZmxhZ3MgPSBDUFVfTUlQUzMyUjIgfCBBU0VfTUlDUk9NSVBTLAo+IHRyYW5zbGF0ZV9pbml0
LmluYy5jOjQxMDogICAgICAgIC5pbnNuX2ZsYWdzID0gQ1BVX01JUFMzMlI1IHwgQVNFX01T
QSwKPiB0cmFuc2xhdGVfaW5pdC5pbmMuYzo0NDk6ICAgICAgICAuaW5zbl9mbGFncyA9IENQ
VV9NSVBTMzJSNiB8IEFTRV9NSUNST01JUFMsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6NDg4
OiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVfTkFOT01JUFMzMiB8IEFTRV9EU1AgfCBBU0Vf
RFNQX1IyIHwgQVNFX0RTUF9SMyB8Cj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6NTExOiAgICAg
ICAgLmluc25fZmxhZ3MgPSBDUFVfTUlQUzMsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6NTMx
OiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVfVlI1NFhYLAo+IHRyYW5zbGF0ZV9pbml0Lmlu
Yy5jOjU1MjogICAgICAgIC5pbnNuX2ZsYWdzID0gQ1BVX01JUFM2NCwKPiB0cmFuc2xhdGVf
aW5pdC5pbmMuYzo1Nzg6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9NSVBTNjQsCj4gdHJh
bnNsYXRlX2luaXQuaW5jLmM6NjA3OiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVfTUlQUzY0
IHwgQVNFX01JUFMzRCwKPiB0cmFuc2xhdGVfaW5pdC5pbmMuYzo2MzY6ICAgICAgICAuaW5z
bl9mbGFncyA9IENQVV9NSVBTNjRSMiB8IEFTRV9NSVBTM0QsCj4gdHJhbnNsYXRlX2luaXQu
aW5jLmM6NjU3OiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVfTUlQUzY0UjIsCj4gdHJhbnNs
YXRlX2luaXQuaW5jLmM6NjgxOiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVfTUlQUzY0UjIs
Cj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6NzIxOiAgICAgICAgLmluc25fZmxhZ3MgPSBDUFVf
TUlQUzY0UjYgfCBBU0VfTVNBLAo+IHRyYW5zbGF0ZV9pbml0LmluYy5jOjc2MTogICAgICAg
IC5pbnNuX2ZsYWdzID0gQ1BVX01JUFM2NFI2IHwgQVNFX01TQSwKPiB0cmFuc2xhdGVfaW5p
dC5pbmMuYzo3ODE6ICAgICAgICAuaW5zbl9mbGFncyA9IENQVV9MT09OR1NPTjJFLAo+IHRy
YW5zbGF0ZV9pbml0LmluYy5jOjgwMTogICAgICAgIC5pbnNuX2ZsYWdzID0gQ1BVX0xPT05H
U09OMkYsCj4gdHJhbnNsYXRlX2luaXQuaW5jLmM6ODMwOiAgICAgICAgLmluc25fZmxhZ3Mg
PSBDUFVfTUlQUzY0UjIgfCBBU0VfRFNQIHwgQVNFX0RTUF9SMiwKCj4gU28gY3VycmVudGx5
IHRoZXJlIGlzIG5vIE1JUFMtSSBvbmx5IENQVS4KPiBOb3RlIHRoYXQgdGhlIGNvZGUgZ290
IHdyaXR0ZW4gd2l0aCBNSVBTMzIgaW4gbWluZCwgYW5kIGltcGxlbWVudGluZwo+IE1JUFMt
SSByZXF1aXJlcyBhIGNvbnNpZGVyYWJsZSBhbW91bnQgb2YgY2hhbmdlIGluIHRoZSBjb2Rl
YmFzZS4KCkhpIFBoaWxpcHBlLAoKSSBqdXN0IGZpZ3VyZWQgb3V0IHdoYXQgdGhlIHByb2Js
ZW0gd2FzLiBUaGUgY3VzdG9tIGNvbXBpbGVyIEkgdXNlZCBqdXN0IG1vZGlmaWVkIHRoZSBv
cGNvZGUgZmllbGRzIG9mIHN3IGFuZCBsdyBpbnN0cnVjdGlvbnMgb2YgTUlQUywgc28gUUVN
VSBkaWRuJ3QgcmVjb2duaXplIHRoZW0gb3V0IG9mIHRoZSBib3guCkkganVzdCBhZGRlZCB0
aGUgc3VwcG9ydCBpbiBkZWNvZGVfb3BjIGZ1bmN0aW9uIGluIHRyYW5zbGF0ZS5jLCBhbmQg
SSBhbHNvIGFkZGVkIG15IG93biBDUFUgbW9kZWwgaW4gdHJhbnNsYXRlX2luaXQuaW5jLmMu
IEhvd2V2ZXIsIHRoZSBpbGxlZ2FsIGluc3RydWN0aW9uIGV4Y2VwdGlvbiBpcyBzdGlsbCB0
aGVyZS4KCkkgYW0gc3VzcGVjdGluZyB0aGF0IHRoZSB3YXkgSSBhZGRlZCBteSBvd24gQ1BV
IG1vZGVsIGluIHRyYW5zbGF0ZV9pbml0LmluYy5jIGlzIHdyb25nLiBCZWxvdyBpcyB3aGF0
IEkgYWRkZWQ6Ci4uLgoreworICAgIC5uYW1lID0gIk15Q1BVIiwKKyAgICAuaW5zbl9mbGFn
cyA9IENQVV9NSVBTMSB8IElOU05fTVlDUFUsCit9LAouLi4KSSBqdXN0IG5lZWQgdG8gc2lt
dWxhdGUgaXQncyBpbnN0cnVjdGlvbiBzZXQgaW4gbGludXggdXNlciBlbXVsYXRpb24sIEkg
ZGlkbid0IGluY2x1ZGUgQ1AwKiBpdGVtcyBpbiB0aGUgbGlzdC4gSXMgdGhpcyBnb29kIGVu
b3VnaCB0byBhZGQgYSBuZXcgQ1BVIG1vZGVsPwoKVGhhbmtzLApMaWJvIFpob3U=


