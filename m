Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93D0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FE120656
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 06:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U7EpCwMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FE120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k11ny-0004qr-VU
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 02:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1k11n4-0004Oy-8W
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 02:11:42 -0400
Received: from m138.mail.163.com ([220.181.13.8]:5042)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1k11my-0004td-48
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 02:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=jB1HT
 MZpVGAi57G0tzywiTo5bqELhnjA6QbkK2fltEA=; b=U7EpCwMh0cusk/1PB/xs9
 axVeBIPk3wHX+00FVyq9WzeoFDaUYD4O2mDXX/aB1ydXtBCLBv1UBIwUpQWmVx85
 LKqPkbcaHXdxjirKWUiWshPyc8UsUU6NLbeyxLxSa5M70XgsOFcgSEytKYOGYnV7
 KmkNmSJ2XGQymH/pjsCtmE=
Received: from 13824125580$163.com ( [221.4.213.95] ) by ajax-webmail-wmsvr8
 (Coremail) ; Thu, 30 Jul 2020 13:54:46 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date: Thu, 30 Jul 2020 13:54:46 +0800 (CST)
From: tugouxp  <13824125580@163.com>
To: "Richard Henderson" <richard.henderson@linaro.org>
Subject: Re:Re: What this mean "dead: 1" and "dead: 0 1" on each tb block
 start?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
In-Reply-To: <a21310ca-b637-5d6e-bfe8-e7834b2498bc@linaro.org>
References: <6807386b.7ba3.1739af8fc12.Coremail.13824125580@163.com>
 <a21310ca-b637-5d6e-bfe8-e7834b2498bc@linaro.org>
X-CM-CTRLDATA: tsAa+mZvb3Rlcl9odG09MTgyMDo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_40470_601492635.1596088486119"
MIME-Version: 1.0
Message-ID: <58c617e6.2b3c.1739e4988e7.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CMGowADXKkKmYCJf66VGAA--.28656W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiHhJxQlSIpnKaHAABsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.8; envelope-from=13824125580@163.com;
 helo=m138.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 01:55:13
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_40=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_40470_601492635.1596088486119
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

U28sIGZsYWcgaXMgYWxzbyB0aGUgcGFyYW10ZXIgaW5kZXggcmlnaHQ/ICx3aGF0IGFib3V0IHRo
ZSBzeW5jID8gICAKCgoKCgoKCgoKCgoKCgoKCgpBdCAyMDIwLTA3LTMwIDAwOjE2OjI1LCAiUmlj
aGFyZCBIZW5kZXJzb24iIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPiB3cm90ZToKPk9u
IDcvMjkvMjAgNzoyNyBBTSwgdHVnb3V4cCB3cm90ZToKPj4gSEkgZm9sa3M6Cj4+ICAgb24gZWFj
aCB0YiBibG9jayBzdGFydCwgdGhlcmUgYXJlIGZvbGxvd2luZyBpciBjb2RlLCBhbmQgdGhlIG1v
c3QgY29uZnVzaW5nCj4+IG1lIGlzIHRoYXQgIHRoZSBwb3N0Zml4IG9mIGVhY2ggbGluZSAiZGVh
ZDoiIGZsYWcsIHdoYXQgaXQgaXMgcmVwcmVzZW50IHByZWNpc2VseT8KPj4gaSBndWVzcyBpdCBt
YXkgYmUgcmVsYXRlZCB0byB0aGUgcmVnaXN0ZXIgb3IgdmFyaWJsZSBsaXZlbmVzcyBmb3IgaGVs
cAo+PiBnZW5lcmF0aW5nIHRnaGUgdGFyZ2V0IG1hY2hpbmUgY29kZSwgYnV0IGkgY2FudCBnZXQg
dGhlIHByZWNpc2VseSBjb25uZWN0aW9uIG9mCj4+IHRoZSBkZWFkIGF0dHJyaWJ1dGUgd2l0aCBx
ZW11ICBpbnRlcm5hbCB2YXJpYmxlcy4KPj4gZm9yIGV4YW1wbGUsIHdoeSB0aGUgbGluZSA2MSB1
c2UgImRlYWQ6MSIgYW5kIHRoZSBsaW5lIDYzIHVzZSAiZGVhZDogMCwgMSI/IAo+PiB3aGF0IGlz
IHRoZSBwcmVjaXNlbHkgbWVhbmluZyBvZiB0aGUgbnVtYmVyIGFmdGVyIHRoZSAiZGVhZDoiIHdv
cmQ/Cj4+IAo+PiB0aGFuayB5b3UhICAgICAKPj4gCj4+IAo+PiAgICAgNjAgT1AgYWZ0ZXIgb3B0
aW1pemF0aW9uIGFuZCBsaXZlbmVzcyBhbmFseXNpczoKPj4gCj4+ICAgICAgNjEgIGxkX2kzMiB0
bXA1LGVudiwkMHhmZmZmZmZmZmZmZmZmZmVjICAgICAgICAgICAgICAgICBkZWFkOiAxCj4+IAo+
PiAgICAgIDYyICBtb3ZpX2kzMiB0bXA2LCQweDAKPj4gCj4+ICAgICAgNjMgIGJyY29uZF9pMzIg
dG1wNSx0bXA2LGx0LCRMMCAgICAgICAgICAgICAgICAgICAgICBkZWFkOiAwIDEKPgo+VGhlIG51
bWJlcnMgYXJlIHRoZSBpbmRleCBvZiB0aGUgYXJndW1lbnQgdGhhdCBpcyBkZWFkLgo+Cj5FLmcu
IGhlcmUsIGJvdGggdG1wNSBhbmQgdG1wNiBhcmUgZGVhZC4KPgo+Cj5yfgo=
------=_Part_40470_601492635.1596088486119
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxwIHN0eWxlPSJtYXJnaW46IDA7Ij5TbywgZmxhZyBpcyBhbHNv
IHRoZSBwYXJhbXRlciBpbmRleCByaWdodD8gLHdoYXQgYWJvdXQgdGhlIHN5bmMgPyZuYnNwOyAm
bmJzcDs8L3A+PHAgc3R5bGU9Im1hcmdpbjogMDsiPjxicj48L3A+PHAgc3R5bGU9Im1hcmdpbjog
MDsiPjxicj48L3A+PHAgc3R5bGU9Im1hcmdpbjogMDsiPjxicj48L3A+PHAgc3R5bGU9Im1hcmdp
bjogMDsiPjxicj48L3A+PGRpdiBzdHlsZT0icG9zaXRpb246cmVsYXRpdmU7em9vbToxIj48L2Rp
dj48ZGl2IGlkPSJkaXZOZXRlYXNlTWFpbENhcmQiPjwvZGl2PjxwIHN0eWxlPSJtYXJnaW46IDA7
Ij48YnI+PC9wPjxwcmU+PGJyPkF0IDIwMjAtMDctMzAgMDA6MTY6MjUsICJSaWNoYXJkIEhlbmRl
cnNvbiIgJmx0O3JpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcmZ3Q7IHdyb3RlOgomZ3Q7T24g
Ny8yOS8yMCA3OjI3IEFNLCB0dWdvdXhwIHdyb3RlOgomZ3Q7Jmd0OyBISSBmb2xrczoKJmd0OyZn
dDsgJm5ic3A7IG9uIGVhY2ggdGIgYmxvY2sgc3RhcnQsIHRoZXJlIGFyZSBmb2xsb3dpbmcgaXIg
Y29kZSwgYW5kIHRoZSBtb3N0IGNvbmZ1c2luZwomZ3Q7Jmd0OyBtZSBpcyB0aGF0Jm5ic3A7IHRo
ZSBwb3N0Zml4IG9mIGVhY2ggbGluZSAiZGVhZDoiIGZsYWcsIHdoYXQgaXQgaXMgcmVwcmVzZW50
IHByZWNpc2VseT8KJmd0OyZndDsgaSBndWVzcyBpdCBtYXkgYmUgcmVsYXRlZCB0byB0aGUgcmVn
aXN0ZXIgb3IgdmFyaWJsZSBsaXZlbmVzcyBmb3IgaGVscAomZ3Q7Jmd0OyBnZW5lcmF0aW5nIHRn
aGUgdGFyZ2V0IG1hY2hpbmUgY29kZSwgYnV0IGkgY2FudCBnZXQgdGhlIHByZWNpc2VseSBjb25u
ZWN0aW9uIG9mCiZndDsmZ3Q7IHRoZSBkZWFkIGF0dHJyaWJ1dGUgd2l0aCBxZW11Jm5ic3A7IGlu
dGVybmFsIHZhcmlibGVzLgomZ3Q7Jmd0OyBmb3IgZXhhbXBsZSwgd2h5IHRoZSBsaW5lIDYxIHVz
ZSAiZGVhZDoxIiBhbmQgdGhlIGxpbmUgNjMgdXNlICJkZWFkOiAwLCAxIj8mbmJzcDsKJmd0OyZn
dDsgd2hhdCBpcyB0aGUgcHJlY2lzZWx5IG1lYW5pbmcgb2YgdGhlIG51bWJlciBhZnRlciB0aGUg
ImRlYWQ6IiB3b3JkPwomZ3Q7Jmd0OyAKJmd0OyZndDsgdGhhbmsgeW91ISZuYnNwOyAmbmJzcDsg
Jm5ic3A7CiZndDsmZ3Q7IAomZ3Q7Jmd0OyAKJmd0OyZndDsgJm5ic3A7ICZuYnNwOyA2MCBPUCBh
ZnRlciBvcHRpbWl6YXRpb24gYW5kIGxpdmVuZXNzIGFuYWx5c2lzOgomZ3Q7Jmd0OyAKJmd0OyZn
dDsgJm5ic3A7ICZuYnNwOyAmbmJzcDs2MSZuYnNwOyBsZF9pMzIgdG1wNSxlbnYsJDB4ZmZmZmZm
ZmZmZmZmZmZlYyZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ZGVhZDogMQomZ3Q7Jmd0OyAKJmd0OyZndDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDs2MiZuYnNwOyBtb3ZpX2kzMiB0bXA2LCQweDAKJmd0OyZndDsgCiZndDsmZ3Q7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7NjMmbmJzcDsgYnJjb25kX2kzMiB0bXA1LHRtcDYsbHQsJEwwJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyBkZWFkOiAwIDEKJmd0OwomZ3Q7VGhlIG51bWJlcnMgYXJlIHRoZSBpbmRl
eCBvZiB0aGUgYXJndW1lbnQgdGhhdCBpcyBkZWFkLgomZ3Q7CiZndDtFLmcuIGhlcmUsIGJvdGgg
dG1wNSBhbmQgdG1wNiBhcmUgZGVhZC4KJmd0OwomZ3Q7CiZndDtyfgo8L3ByZT48L2Rpdj48YnI+
PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48cD48YnIvPiZuYnNwOzwvcD48L3NwYW4+

------=_Part_40470_601492635.1596088486119--


