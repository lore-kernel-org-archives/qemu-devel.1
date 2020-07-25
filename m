Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7467EC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 01:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACE020674
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 01:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pku.edu.cn header.i=@pku.edu.cn header.b="FWnh+8GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACE020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pku.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz8Xr-0000Wm-Hk
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 21:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gxt@pku.edu.cn>)
 id 1jz8XF-0008Vn-4O; Fri, 24 Jul 2020 20:59:33 -0400
Received: from mx21.pku.edu.cn ([162.105.129.184]:51785 helo=pku.edu.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gxt@pku.edu.cn>)
 id 1jz8XA-0004EW-1B; Fri, 24 Jul 2020 20:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID; bh=u+sOaml5GCjq5xFIWyWNy53Vb1BRFM3TGbmJ
 y3yTKUU=; b=FWnh+8GXxZGTLx6xEGOGRpDk0DKDHM5rNphwby8Sp8LJfl6Y9bad
 RTUhRmDOy35b4VqLiR4oaFDNNAuFnHxdsn0q0ttBNefdEkzh2vM0FR7GqNCYB9x2
 WTOswTK0wsO55on+xzjYIeOOaw9GEZL7N+Gw0mq142WeCRbkZv0REj4=
Received: by ajax-webmail-mailfront03 (Coremail) ; Sat, 25 Jul 2020 08:59:13
 +0800 (GMT+08:00)
X-Originating-IP: [10.1.22.182]
Date: Sat, 25 Jul 2020 08:59:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Guan Xuetao" <gxt@pku.edu.cn>
To: "thomas huth" <thuth@redhat.com>
Subject: Re: [PATCH] target/unicore32: Remove CURSES stuff from the
 Makefile.objs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn  pku.edu.cn
In-Reply-To: <20200723132219.2956-1-thuth@redhat.com>
References: <20200723132219.2956-1-thuth@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <73be33e7.54667.173837b29db.Coremail.gxt@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 84FpogC3O3zhgxtf3qzwAQ--.44632W
X-CM-SenderInfo: qqqqliixuslio6sn3hxhgxhubq/1tbiAQIHBysxYCIIpAANs6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
 CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
 daVFxhVjvjDU=
Received-SPF: pass client-ip=162.105.129.184; envelope-from=gxt@pku.edu.cn;
 helo=pku.edu.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 20:59:18
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, richard henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?philippe_mathieu-daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhdCdzIE9LIGZvciB1bmljb3JlMzIgdGFyZ2V0LgoKQWNrZWQtYnk6IEd1YW4gWHVldGFvIDxn
eHRAcGt1LmVkdS5jbj4KCgo+IC0tLS0t5Y6f5aeL6YKu5Lu2LS0tLS0KPiDlj5Hku7bkuro6ICJU
aG9tYXMgSHV0aCIgPHRodXRoQHJlZGhhdC5jb20+Cj4g5Y+R6YCB5pe26Ze0OiAyMDIwLTA3LTIz
IDIxOjIyOjE5ICjmmJ/mnJ/lm5spCj4g5pS25Lu25Lq6OiAiR3VhbiBYdWV0YW8iIDxneHRAbXBy
Yy5wa3UuZWR1LmNuPiwgcWVtdS1kZXZlbEBub25nbnUub3JnCj4g5oqE6YCBOiAiUGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kiIDxmNGJ1Z0BhbXNhdC5vcmc+LCBxZW11LXRyaXZpYWxAbm9uZ251Lm9y
ZywgIlJpY2hhcmQgSGVuZGVyc29uIiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4KPiDk
uLvpopg6IFtQQVRDSF0gdGFyZ2V0L3VuaWNvcmUzMjogUmVtb3ZlIENVUlNFUyBzdHVmZiBmcm9t
IHRoZSBNYWtlZmlsZS5vYmpzCj4gCj4gVGhlIGRlcGVuZGVuY3kgb24gY3Vyc2VzIGhhcyBiZWVu
IHJlbW92ZWQgaW4gY29tbWl0IGM3YTg1NmI0MmU0MDNlMmIKPiAoInRhcmdldC91bmljb3JlMzI6
IFByZWZlciBxZW11X3NlbWlob3N0aW5nX2xvZ19vdXQoKSBvdmVyIGN1cnNlcyIpLgo+IFNvIHdl
IGNhbiByZW1vdmUgdGhlIHJlbGF0ZWQgbGluZXMgaW4gdGhlIE1ha2VmaWxlIG5vdywgdG9vLgo+
IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPgo+IC0tLQo+
ICB0YXJnZXQvdW5pY29yZTMyL01ha2VmaWxlLm9ianMgfCA0IC0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC91bmljb3JlMzIvTWFr
ZWZpbGUub2JqcyBiL3RhcmdldC91bmljb3JlMzIvTWFrZWZpbGUub2Jqcwo+IGluZGV4IDM1ZDhi
ZjUzMGQuLjZiNDFiMWU5ZWYgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3VuaWNvcmUzMi9NYWtlZmls
ZS5vYmpzCj4gKysrIGIvdGFyZ2V0L3VuaWNvcmUzMi9NYWtlZmlsZS5vYmpzCj4gQEAgLTIsNyAr
MiwzIEBAIG9iai15ICs9IHRyYW5zbGF0ZS5vIG9wX2hlbHBlci5vIGhlbHBlci5vIGNwdS5vCj4g
IG9iai15ICs9IHVjZjY0X2hlbHBlci5vCj4gIAo+ICBvYmotJChDT05GSUdfU09GVE1NVSkgKz0g
c29mdG1tdS5vCj4gLQo+IC0jIEh1aD8gVXNlcyBjdXJzZXMgZGlyZWN0bHkgaW5zdGVhZCBvZiB1
c2luZyB1aS9jb25zb2xlLmggaW50ZXJmYWNlcyAuLi4KPiAtaGVscGVyLm8tY2ZsYWdzIDo9ICQo
Q1VSU0VTX0NGTEFHUykKPiAtaGVscGVyLm8tbGlicyA6PSAkKENVUlNFU19MSUJTKQo+IC0tIAo+
IDIuMTguMQo=

