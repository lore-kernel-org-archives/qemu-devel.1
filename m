Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A56C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807352070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 11:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KG7TAzcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807352070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxUKk-0001xF-QS
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 07:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jxUAp-0004a3-1l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:41:35 -0400
Received: from m1356.mail.163.com ([220.181.13.56]:48379)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jxUAl-0005ha-7E
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 07:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Ly8OJ
 8uMASI5B7MkFqvZtC2Ca3KjKsEwR0CG/Wa4DBM=; b=KG7TAzcpONPhp+jwBzeXQ
 KqSTRPtbGULhbgEmd4s+yt4DRnazfpSmfl+ac4afDhe3HjVkacfrasYqFnt7lJD8
 Hp85i0FZHfIYu0i2cmyxdOuuQVau1HICgDt7zlGa5qpVYqSXX0e9Xe7d8we6N5/0
 ukwMNntgMnyVQOWVnAyTmk=
Received: from 13824125580$163.com ( [221.4.213.95] ) by
 ajax-webmail-wmsvr56 (Coremail) ; Mon, 20 Jul 2020 19:41:18 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date: Mon, 20 Jul 2020 19:41:18 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: What is this mean of the comment?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: mlpbcmZvb3Rlcl9odG09MTU0Njo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_117423_920996197.1595245278822"
MIME-Version: 1.0
Message-ID: <63109e68.7dc9.1736c073666.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: OMGowAC3vwPeghVfdQFXAA--.7482W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiYwFnQlaEBOpDggACs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.56; envelope-from=13824125580@163.com;
 helo=m1356.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 07:41:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

------=_Part_117423_920996197.1595245278822
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CgoKIGluIGZsb2xsb3dpbmcgY29tbWVudCBvZiB0Y2cuaCwgaXQgc2F5cyBldmVy
eSBoZWxwZXIgbWF4IG5lZWQgNiBpbnB1dCBhcmd1bWVudCBhbmQgMSBvdXRwdXQgYXJndW1lbnQs
CmJ1dCB3aHkgaGVyZSBib3RoIG11bHRpcGx5IGJ5IDIgIGluIGhlcmU/ICAKCgp3aGF0ICBpcyB0
aGUgMTQgbWVhbj8KCgp0aGFuayAgeW91IQoKCiA1MjAgLyogV2hpbGUgd2UgbGltaXQgaGVscGVy
cyB0byA2IGFyZ3VtZW50cywgZm9yIDMyLWJpdCBob3N0cywgd2l0aCBwYWRkaW5nLAoKIDUyMSAg
ICB0aGlzIGltcGxlcyBhIG1heCBvZiA2KjIgKDY0LWJpdCBpbikgKyAyICg2NC1iaXQgb3V0KSA9
IDE0IG9wZXJhbmRzLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAKCiA1MjIgICAgVGhlcmUgYXJlIG5ldmVyIG1vcmUgdGhhbiAyIG91dHB1
dHMsIHdoaWNoIG1lYW5zIHRoYXQgd2UgY2FuIHN0b3JlIGFsbAoKIDUyMyAgICBkZWFkICsgc3lu
YyBkYXRhIHdpdGhpbiAxNiBiaXRzLiAgKi8KCiA1MjQgI2RlZmluZSBERUFEX0FSRyAgNAoKCg==

------=_Part_117423_920996197.1595245278822
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4m
bmJzcDtpbiBmbG9sbG93aW5nIGNvbW1lbnQgb2YgdGNnLmgsIGl0IHNheXMgZXZlcnkgaGVscGVy
IG1heCBuZWVkIDYgaW5wdXQgYXJndW1lbnQgYW5kIDEgb3V0cHV0IGFyZ3VtZW50LDwvZGl2Pjxk
aXYgc3R5bGU9Im1hcmdpbjowOyI+YnV0IHdoeSBoZXJlIGJvdGggbXVsdGlwbHkgYnkgMiZuYnNw
OyBpbiBoZXJlPyZuYnNwOyZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwv
ZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+d2hhdCZuYnNwOyBpcyB0aGUgMTQgbWVhbj88L2Rp
dj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsi
PnRoYW5rJm5ic3A7IHlvdSE8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxicj48L2Rpdj48
ZGl2IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOzUyMCAvKiBXaGlsZSB3ZSBsaW1pdCBoZWxwZXJz
IHRvIDYgYXJndW1lbnRzLCBmb3IgMzItYml0IGhvc3RzLCB3aXRoIHBhZGRpbmcsPC9kaXY+PHAg
c3R5bGU9Im1hcmdpbjowOyI+PHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29sb3I6IHJnYigyMjEs
IDY0LCA1MCk7Ij4mbmJzcDs1MjEmbmJzcDsgJm5ic3A7IHRoaXMgaW1wbGVzIGEgbWF4IG9mIDYq
MiAoNjQtYml0IGluKSArIDIgKDY0LWJpdCBvdXQpID0gMTQgb3BlcmFuZHMuJm5ic3A7ICZuYnNw
OyAmbmJzcDs8L3NwYW4+ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDs1MjImbmJzcDsgJm5ic3A7IFRoZXJlIGFy
ZSBuZXZlciBtb3JlIHRoYW4gMiBvdXRwdXRzLCB3aGljaCBtZWFucyB0aGF0IHdlIGNhbiBzdG9y
ZSBhbGw8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7NTIzJm5ic3A7ICZuYnNwOyBkZWFk
ICsgc3luYyBkYXRhIHdpdGhpbiAxNiBiaXRzLiZuYnNwOyAqLzwvcD48cCBzdHlsZT0ibWFyZ2lu
OjA7Ij4mbmJzcDs1MjQgI2RlZmluZSBERUFEX0FSRyZuYnNwOyA0PC9wPjxkaXY+PGJyPjwvZGl2
PjwvZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxwPjxici8+Jm5ic3A7
PC9wPjwvc3Bhbj4=
------=_Part_117423_920996197.1595245278822--


