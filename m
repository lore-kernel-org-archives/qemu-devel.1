Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B33C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9286520674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gGfkSWPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9286520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg6jg-0005mG-BR
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jg6b5-0004eG-ED
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:04:51 -0400
Received: from m13136.mail.163.com ([220.181.13.136]:4727)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jg6ay-0005WW-Tp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=5N/2G
 sUv1Q1Q06PwpVeW2tZadyGme/oPMW37k4hy1Co=; b=gGfkSWPmJn53zGGDn/1jW
 MdRhlozELuDCxYSM8NBWMSwoAA4C5iU9GOWBn7AenfM2Gk6PAsBT3Jen1W9FYDYl
 ar62J2q1i5W+JCg7td6dOpZA7upIRCjP+ZQsUMZMOAW0jVjeoJRxaaTa+MYRPQPr
 Bqq/++h7gD+50ptcinYcWU=
Received: from 13824125580$163.com ( [221.4.213.95] ) by
 ajax-webmail-wmsvr136 (Coremail) ; Tue, 2 Jun 2020 21:04:26 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date: Tue, 2 Jun 2020 21:04:26 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: what is the symbole "leul" mean on this code?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: dG+Lh2Zvb3Rlcl9odG09MjE2OTo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_119544_1981723615.1591103066255"
MIME-Version: 1.0
Message-ID: <7056187f.8098.1727522108f.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: iMGowAAXAvJaTtZeubg6AA--.40149W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiTgg3QlUDDtYmBQACsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.136; envelope-from=13824125580@163.com;
 helo=m13136.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:04:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001, FROM_LOCAL_HEX=0.006,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

------=_Part_119544_1981723615.1591103066255
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SEkgZ3V5czoKICAgaSBhbSBzdHVja2VkIGJ5IHRoZSBmb2xsb3dpbmcgY29kZSxhbmQgaSBjYW4g
ZmluZCBkb2N1bWVudCBpbGx1c3RyYXRpb25zIHRoaXMgbm93aGVyZS4KICAgd2hhdCBkb2VzIHRo
ZSAibGV1bCIgc3RhbmRzIGZvcj8gYW5kIHRoZSBwb3N0Zml4IDEwIG1lYW5zIHdoYXSjvwoKCnRo
YW5rIHlvdSEgICAgCgoKMTAgIC0tLS0gNjAwMTAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgICAgICAg
CgogICAgMTEgIG1vdmlfaTMyIHRtcDMsJDB4NjAwMTAwMjAgICAgICAgICAgICAgICAgcHJlZj1h
bGwKCiAgICAxMiAgbW92X2kzMiB0bXA1LHRtcDMgICAgICAgICAgICAgICAgICAgICAgICBkZWFk
OiAxICBwcmVmPWFsbAoKICAgIDEzICBxZW11X2xkX2kzMiB0bXA0LHRtcDUsbGV1bCwxMCAgICAg
ICAgICAgIGRlYWQ6IDEgIHByZWY9YWxsCgogICAgMTQgIG1vdmlfaTMyIHRtcDMsJDB4ZmZmZmZm
ZmZmZmZmZmZmZSAgICAgICAgcHJlZj1hbGwKCiAgICAxNSAgYW5kX2kzMiBwYyx0bXA0LHRtcDMg
ICAgICAgICAgICAgICAgICAgICBzeW5jOiAwICBkZWFkOiAwIDIgIHByZWY9YWxsCgogICAgMTYg
IG1vdmlfaTMyIHRtcDMsJDB4MSAgICAgICAgICAgICAgICAgICAgICAgcHJlZj1hbGwKCiAgICAx
NyAgYW5kX2kzMiB0bXA0LHRtcDQsdG1wMyAgICAgICAgICAgICAgICAgICBkZWFkOiAxIDIgIHBy
ZWY9YWxsCgogICAgMTggIHN0X2kzMiB0bXA0LGVudiwkMHgyMjAgICAgICAgICAgICAgICAgICAg
ZGVhZDogMCAxCgogICAgMTkgIGV4aXRfdGIgJDB4MCAgICAgICAgICAgICAgICAgICAgICAgICAg
IAoKICAgIDIwICBzZXRfbGFiZWwgJEwwICAgICAKCiAgICAyMSAgZXhpdF90YiAkMHg3ZjBkMDIy
M2MwMDMKCgo=
------=_Part_119544_1981723615.1591103066255
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SEkgZ3V5czo8L2Rpdj48
ZGl2IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDtpIGFtIHN0dWNrZWQgYnkgdGhlIGZv
bGxvd2luZyBjb2RlLGFuZCBpIGNhbiBmaW5kIGRvY3VtZW50IGlsbHVzdHJhdGlvbnMgdGhpcyBu
b3doZXJlLjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7ICZuYnNwO3doYXQgZG9l
cyB0aGUgImxldWwiIHN0YW5kcyBmb3I/IGFuZCB0aGUgcG9zdGZpeCAxMCBtZWFucyB3aGF0o788
L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46
MDsiPnRoYW5rIHlvdSEmbmJzcDsgJm5ic3A7Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2lu
OjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4xMCZuYnNwOyAtLS0tIDYwMDEw
MDAwIDAwMDAwMDAwIDAwMDAwMDAwJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7PC9kaXY+PHAg
c3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7ICZuYnNwOyAxMSZuYnNwOyBtb3ZpX2kzMiB0bXAzLCQw
eDYwMDEwMDIwJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyBwcmVmPWFsbDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IDEy
Jm5ic3A7IG1vdl9pMzIgdG1wNSx0bXAzJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgZGVhZDog
MSZuYnNwOyBwcmVmPWFsbDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij48c3BhbiBzdHlsZT0iYmFj
a2dyb3VuZC1jb2xvcjogcmdiKDIyMSwgNjQsIDUwKTsiPiZuYnNwOyAmbmJzcDsgMTMmbmJzcDsg
cWVtdV9sZF9pMzIgdG1wNCx0bXA1LGxldWwsMTAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyBkZWFkOiAxJm5ic3A7IHByZWY9YWxsPC9zcGFuPjwvcD48cCBzdHlsZT0i
bWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IDE0Jm5ic3A7IG1vdmlfaTMyIHRtcDMsJDB4ZmZmZmZm
ZmZmZmZmZmZmZSZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBwcmVmPWFsbDwvcD48cCBzdHls
ZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IDE1Jm5ic3A7IGFuZF9pMzIgcGMsdG1wNCx0bXAz
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwO3N5bmM6IDAmbmJzcDsgZGVhZDogMCAyJm5ic3A7IHByZWY9YWxs
PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgMTYmbmJzcDsgbW92aV9pMzIg
dG1wMywkMHgxJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtwcmVmPWFsbDwvcD48cCBzdHlsZT0i
bWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IDE3Jm5ic3A7IGFuZF9pMzIgdG1wNCx0bXA0LHRtcDMm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDtkZWFkOiAxIDImbmJzcDsgcHJlZj1hbGw8L3A+PHAgc3R5bGU9Im1hcmdpbjow
OyI+Jm5ic3A7ICZuYnNwOyAxOCZuYnNwOyBzdF9pMzIgdG1wNCxlbnYsJDB4MjIwJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ZGVhZDogMCAxPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgMTkmbmJz
cDsgZXhpdF90YiAkMHgwJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzwv
cD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7IDIwJm5ic3A7IHNldF9sYWJlbCAk
TDAmbmJzcDsgJm5ic3A7ICZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDsgJm5i
c3A7IDIxJm5ic3A7IGV4aXRfdGIgJDB4N2YwZDAyMjNjMDAzPC9wPjxkaXY+PGJyPjwvZGl2Pjwv
ZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxwPjxici8+Jm5ic3A7PC9w
Pjwvc3Bhbj4=
------=_Part_119544_1981723615.1591103066255--


