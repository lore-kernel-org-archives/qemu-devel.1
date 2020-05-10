Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0BC54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 09:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6A020820
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 09:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RXFNZaO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6A020820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXi6R-0007li-8T
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 05:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jXi5s-0006qg-LV
 for qemu-devel@nongnu.org; Sun, 10 May 2020 05:17:56 -0400
Received: from m13-43.163.com ([220.181.13.43]:33456)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jXi5o-0003fI-Ps
 for qemu-devel@nongnu.org; Sun, 10 May 2020 05:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=3QqXY
 tqJZ+ze9dBNHG7L67gX/vppgdfl6VrqEZHB/UE=; b=RXFNZaO9NeYuet6+Eyzuw
 sTYhgMrt8/7aabsI+IkeSa8iycqqXyK1lSVk1V4+7PdOe7Ycfho4I59TKulYy9j3
 SML0ydRRWhZ9ZLGyx/1y27IiHePTRVpvBXHjavoHjRpRXaXEO5PLLy95wYl2XpIo
 3+1uMhMcgrzbX9MMCvvT3s=
Received: from 13824125580$163.com ( [113.74.45.41] ) by
 ajax-webmail-wmsvr43 (Coremail) ; Sun, 10 May 2020 17:02:31 +0800 (CST)
X-Originating-IP: [113.74.45.41]
Date: Sun, 10 May 2020 17:02:31 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: is there any way to make qemu stop at the very first instruction of
 the emulation process  and wait for gdb connect?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: Thjoj2Zvb3Rlcl9odG09NDMzOjYx
Content-Type: multipart/alternative; 
 boundary="----=_Part_33596_1736533236.1589101351904"
MIME-Version: 1.0
Message-ID: <41b4d4e6.25f8.171fdd253e0.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: K8GowACHC+4ow7de9JYrAA--.7053W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiVgggQlqzk7DTigAAsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.43; envelope-from=13824125580@163.com;
 helo=m13-43.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 05:02:34
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

------=_Part_33596_1736533236.1589101351904
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

aXMgdGhlcmUgYW55IHdheSB0byBtYWtlIHFlbXUgc3RvcCBhdCB0aGUgdmVyeSBmaXJzdCBpbnN0
cnVjdGlvbiBvZiB0aGUgZW11bGF0aW9uIHByb2Nlc3MgIGFuZCB3YWl0IGZvciBnZGIgY29ubmVj
dD8KZm9yIGkgd2FudCB0byBrbm93IHRoZSBib290IHNlcXVlbmNlIG9mIHRoZSBmaXJzdCBpbnN0
cmN0aW9uIG9mIHRoZSB0YXJnZXQgc3lzdGVtLCBob3cgdG8gZ2V0IHRoaXM/CgoKdGhhbmsgeW91
IC4=
------=_Part_33596_1736533236.1589101351904
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+aXMgdGhlcmUgYW55IHdh
eSB0byBtYWtlIHFlbXUgc3RvcCBhdCB0aGUgdmVyeSBmaXJzdCBpbnN0cnVjdGlvbiBvZiB0aGUg
ZW11bGF0aW9uIHByb2Nlc3MmbmJzcDsgYW5kIHdhaXQgZm9yIGdkYiBjb25uZWN0PzwvZGl2Pjxk
aXYgc3R5bGU9Im1hcmdpbjowOyI+Zm9yIGkgd2FudCB0byBrbm93IHRoZSBib290IHNlcXVlbmNl
IG9mIHRoZSBmaXJzdCBpbnN0cmN0aW9uIG9mIHRoZSB0YXJnZXQgc3lzdGVtLCBob3cgdG8gZ2V0
IHRoaXM/PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0i
bWFyZ2luOjA7Ij50aGFuayB5b3UgLjwvZGl2PjwvZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5l
dGVhc2Vmb290ZXIiPjxwPjxici8+Jm5ic3A7PC9wPjwvc3Bhbj4=
------=_Part_33596_1736533236.1589101351904--


