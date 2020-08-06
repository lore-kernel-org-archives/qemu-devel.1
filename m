Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26182C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E115822D06
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ToYuG3XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E115822D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3ZTx-0007vY-2u
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 02:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ouyangxuan10@163.com>)
 id 1k3VR8-0003O4-2J
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 22:15:18 -0400
Received: from m13132.mail.163.com ([220.181.13.132]:57396)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ouyangxuan10@163.com>)
 id 1k3VR1-0007nu-Ou
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 22:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=OHWPM
 YvQUEmcGGrIT6bMSLY46yF+oKgxTKsRuX6LK3U=; b=ToYuG3XPdgKjYFaLavsf4
 mdpkPqzvGzBajh21yhHkd7o5K9U2+8GwYKXnBOGnnGI35Z18AyjTsUBk9M9h78w3
 tzbB3Yhrx2onpq8fgv+etdJCv1FopSoryQtslXaYuPgoA5gv7Uuee5QYk3Mohfco
 UFFnP5rnGDzadxWzEWFJ5Y=
Received: from ouyangxuan10$163.com ( [106.120.127.15] ) by
 ajax-webmail-wmsvr132 (Coremail) ; Thu, 6 Aug 2020 09:58:51 +0800 (CST)
X-Originating-IP: [106.120.127.15]
Date: Thu, 6 Aug 2020 09:58:51 +0800 (CST)
From: www <ouyangxuan10@163.com>
To: andrew@aj.id.au, joel@jms.id.au, clg@kaod.org, qemu-devel@nongnu.org
Subject: [qemu]: How to use qemu to run 64MB bmc image?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: PdypCGZvb3Rlcl9odG09NTIzOjU2
Content-Type: multipart/alternative; 
 boundary="----=_Part_25373_832287398.1596679131485"
MIME-Version: 1.0
Message-ID: <7c834989.1a25.173c17e115d.Coremail.ouyangxuan10@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: hMGowAC3x6PbYytftvxLAA--.13327W
X-CM-SenderInfo: prx1t0pj0xt0irq6il2tof0z/1tbitxJ42laEE-ll+AACsg
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.132; envelope-from=ouyangxuan10@163.com;
 helo=m13132.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 21:59:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 06 Aug 2020 02:33:24 -0400
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

------=_Part_25373_832287398.1596679131485
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgSm9lbCBTdGFubGV5LCBBbmRyZXcgSmVmZmVyeSwgQ6imZHJpYyBMZSBHb2F0ZXIsCgoKSG93
IHRvIG1vZGlmeSBpdCBzbyB0aGF0IFFFTVUgY2FuIHJ1biA2NE1CIEJNQyBpbWFnZT8KSW4gYWRk
aXRpb24sIGhvdyB0byBsZWFybiB0aGUgc291cmNlIGNvZGUgb2YgUUVNVT8gQXJlIHRoZXJlIGFu
eSBndWlkZWxpbmVzIGFuZCByZWZlcmVuY2UgZG9jdW1lbnRzPwoKCnRoYW5rc6OsCkJ5cm9u
------=_Part_25373_832287398.1596679131485
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkmbmJzcDtKb2VsIFN0
YW5sZXksJm5ic3A7QW5kcmV3IEplZmZlcnksJm5ic3A7Q6imZHJpYyBMZSBHb2F0ZXIsPC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5I
b3cgdG8gbW9kaWZ5IGl0IHNvIHRoYXQgUUVNVSBjYW4gcnVuIDY0TUIgQk1DIGltYWdlPzwvZGl2
PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SW4gYWRkaXRpb24sIGhvdyB0byBsZWFybiB0aGUgc291
cmNlIGNvZGUgb2YgUUVNVT8gQXJlIHRoZXJlIGFueSBndWlkZWxpbmVzIGFuZCByZWZlcmVuY2Ug
ZG9jdW1lbnRzPzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+PGJyPjwvZGl2PjxkaXYgc3R5
bGU9Im1hcmdpbjowOyI+dGhhbmtzo6w8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPkJ5cm9u
PC9kaXY+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3RlciI+PHA+Jm5ic3A7
PC9wPjwvc3Bhbj4=
------=_Part_25373_832287398.1596679131485--


