Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE3EC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207C520739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ig058A6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207C520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFK3k-0002EG-9H
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <13824125580@163.com>) id 1jFIwn-0007yU-Oh
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <13824125580@163.com>) id 1jFIwg-0005yO-BZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:48:24 -0400
Received: from m13-128.163.com ([220.181.13.128]:58003)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <13824125580@163.com>) id 1jFIwe-0005gg-TC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 10:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=rQrjm
 yrq3F3ij3g2ONO+ApmSiQ2C/LZGmM0e2zAhpv0=; b=Ig058A6SREIu439ZlnpqK
 XTXvU+1/gQQcylBTUFnuKFX1Qb0YapbnlskBPMuRWPW4/WhkkXANJqOCwz/dC99T
 o33Ifip672ah68EewZbCF2H/8aawMN/XK4opvBdIHpLB4tBX0zoGvINJeX0y4ajc
 RKMUbDaCB/PscSDbnDCH1s=
Received: from 13824125580$163.com ( [113.74.45.27] ) by
 ajax-webmail-wmsvr128 (Coremail) ; Fri, 20 Mar 2020 22:32:31 +0800 (CST)
X-Originating-IP: [113.74.45.27]
Date: Fri, 20 Mar 2020 22:32:31 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: Is there anyway to get the emulation rates  MIPS (instructions in a
 period, not mips cpu) of qemu?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: sG/ESGZvb3Rlcl9odG09NDAzOjYx
Content-Type: multipart/alternative; 
 boundary="----=_Part_162136_1795683453.1584714751772"
MIME-Version: 1.0
Message-ID: <49c677c.aa9b.170f85c1f1c.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gMGowADX38cA1HRei30EAA--.38953W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiVhvsQlqzkKn3AAABsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.13.128
X-Mailman-Approved-At: Fri, 20 Mar 2020 11:58:33 -0400
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

------=_Part_162136_1795683453.1584714751772
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SEkgZm9sa3M6CkkgbmVlZCB0byBnZXQgdGhlIG1pcHMgb3Z1bGF0aW9uIGFib3V0IHRoZSBYODYg
aG9zdCBlbXVsYXRlZCBhcm0zMiBwbGF0Zm9ybSwgc28gSXMgdGhlcmUgYW55d2F5IHRvIGdldCB0
aGUgZW11bGF0aW9uIHJhdGVzICBNSVBTIChpbnN0cnVjdGlvbnMgaW4gYSBwZXJpb2QsIG5vdCBt
aXBzIGNwdSkgb2YgcWVtdT8KCgp0aGFuayB5b3U=
------=_Part_162136_1795683453.1584714751772
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SEkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5JIG5lZWQgdG8gZ2V0IHRoZSBtaXBzIG92dWxhdGlvbiBh
Ym91dCB0aGUgWDg2IGhvc3QgZW11bGF0ZWQgYXJtMzIgcGxhdGZvcm0sIHNvIElzIHRoZXJlIGFu
eXdheSB0byBnZXQgdGhlIGVtdWxhdGlvbiByYXRlcyZuYnNwOyBNSVBTIChpbnN0cnVjdGlvbnMg
aW4gYSBwZXJpb2QsIG5vdCBtaXBzIGNwdSkgb2YgcWVtdT88L2Rpdj48ZGl2IHN0eWxlPSJtYXJn
aW46MDsiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPnRoYW5rIHlvdTwvZGl2Pjwv
ZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxwPjxici8+Jm5ic3A7PC9w
Pjwvc3Bhbj4=
------=_Part_162136_1795683453.1584714751772--


