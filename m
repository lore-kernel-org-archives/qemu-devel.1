Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 00:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549732067B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 00:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="crj31est"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549732067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfYkz-0007Nf-Ht
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 20:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jfYkJ-0006yC-Ft
 for qemu-devel@nongnu.org; Sun, 31 May 2020 20:56:07 -0400
Received: from m13112.mail.163.com ([220.181.13.112]:61186)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jfYkF-0003IY-Gi
 for qemu-devel@nongnu.org; Sun, 31 May 2020 20:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=tBRRP
 ylaO9dhv+VsT+EBoK7R2HFkt9u2Xx1wW+EBZfU=; b=crj31estuzd692mqMl9Al
 skcWyEl5nqyHPOd8DomJau6Pajt+b89hveoFGV0ccRhp+xemLW+YlA2RevKP7k6c
 +9eRFdjozDdvqXYrLr3OEtZTY0k7Wy+/j5A+PRCs05t0oOpD4wf+RC+4Vtj11d/N
 c/KTKT1mPjVqtJ7/jrivfw=
Received: from 13824125580$163.com ( [61.143.53.198] ) by
 ajax-webmail-wmsvr112 (Coremail) ; Mon, 1 Jun 2020 08:55:47 +0800 (CST)
X-Originating-IP: [61.143.53.198]
Date: Mon, 1 Jun 2020 08:55:47 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: according what does the qemu know to exit current TB and find
 helper functions from environment?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: 96P5cWZvb3Rlcl9odG09MTczNzo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_9688_1206773769.1590972947296"
MIME-Version: 1.0
Message-ID: <37d914ae.a6f.1726d609b61.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cMGowAAXGiwTUtReDRg5AA--.21619W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiVgw2QlqzlQKdUAABsc
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.112; envelope-from=13824125580@163.com;
 helo=m13112.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 20:55:49
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

------=_Part_9688_1206773769.1590972947296
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CgoKICAgYSBxdWVzdGlvbnMgcHV6emxlcyBtZSBkdXJpbmcgcmV2aWV3IHRoZSBx
ZW11IGNvZGUgb2YgNS4wLjAsIHRha2UgdmV4cHJlc3MgZW11bGF0aW9uIGFybSBBOSBvbiBSVE9T
ICBmb3IgZXhhbXBsZS4KdGhlIGVtdWxhdGVkIFJUT1MgaGFzIGl0cyBvd24gInByaW50ZiIgaW1w
bGVtZW50YXRpb25zLCBzbyBkdXJpbmcgdGhlIHFlbXUgZW11bGF0aW9ucywgaXQgd291bGQgZmlu
ZCAKICAgaGVscGVyX2xlX3N0bF9tbXUoKQogICAgICAgICBzdG9yZV9oZWxwZXIoKQogICAgICAg
ICAgIC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAgICBwbDAxMV93cml0ZSgpOwog
ICAgICAgICAgICAgICAgICAgIHdyaXRldigpOyAgLy9zeXNjYWxsCmFuZCBmaW5hbGx5LCB0aGUg
aGVscGVyIHdvdWxkIGNhbGwgdGhlIHBsMDExX3dyaXRlIHRvIGVtdWxhdGUgdGhlIGFjdHVhbCBz
dGRpbyBvdXRwdXQgZnVuY3Rpb25zLgpidXQsIGhvdyBkaWQgdGhlIFRDQiBUQiBibG9jayBrbm93
IHRoaXMgZHVyaW5nIHRoZSB0cmFuc2xhdGlvbnM/IHRoZXJlIG1heSBiZSBvdGhlcnMgZGlmZmVy
ZW50ICJwcmludGYiIGltcGxlbWVudCBpb25zIG9uIGRpZmZlcmVudCAgdGFyZ2V0LCAKaG93IHRo
ZSB0Y2cga25vd3MgdGhhdCBhIHNwZWNpYWwgaGVscGVyIGZ1bmN0aW9ucyBuZWVkIHRvIGJlIGNh
bGxlZCBhbmQgb3RoZXJzIG5vdCwgZnJvbSB0aGUgYmluYXJ5IGNvZGUgZGlzYXNzZW1ibHkgbGFu
Z3VhZ2Ugb2YgdGhlIGVtdWxhdGVkIHRhcmdldCwgdGhlcmUgaXMgbm8Kb2J2aW91cyBzaWduIHRv
IG1ha2UgYW55b25lIGtub3cgd2hpY2ggaW5zdHV0aW9ucyBpcyBzcGVjaWFsIGFuZCBuZWVkIHRv
IGVtdWxhdGlvbiBieSBoZWxwZXIsIEhvdyBnZXQgdGhpcz8KCgpUaGFuayB5b3UuCiAgCgoKCgoK

------=_Part_9688_1206773769.1590972947296
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4m
bmJzcDsgJm5ic3A7YSBxdWVzdGlvbnMgcHV6emxlcyBtZSBkdXJpbmcgcmV2aWV3IHRoZSBxZW11
IGNvZGUgb2YgNS4wLjAsIHRha2UgdmV4cHJlc3MgZW11bGF0aW9uIGFybSBBOSBvbiBSVE9TJm5i
c3A7IGZvciBleGFtcGxlLjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+dGhlIGVtdWxhdGVk
IFJUT1MgaGFzIGl0cyBvd24gInByaW50ZiIgaW1wbGVtZW50YXRpb25zLCBzbyBkdXJpbmcgdGhl
IHFlbXUgZW11bGF0aW9ucywgaXQgd291bGQgZmluZCZuYnNwOzwvZGl2PjxkaXYgc3R5bGU9Im1h
cmdpbjowOyI+Jm5ic3A7ICZuYnNwO2hlbHBlcl9sZV9zdGxfbW11KCk8L2Rpdj48ZGl2IHN0eWxl
PSJtYXJnaW46MDsiPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtzdG9yZV9oZWxw
ZXIoKTwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsuLi4uLi4uLi4uLi4uLi4uLi4uLi4uPC9kaXY+PGRpdiBzdHlsZT0i
bWFyZ2luOjA7Ij4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgcGwwMTFfd3JpdGUoKTs8L2Rpdj48ZGl2IHN0eWxlPSJtYXJnaW46MDsiPiZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyB3cml0ZXYoKTsmbmJzcDsgLy9zeXNjYWxsPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5h
bmQgZmluYWxseSwgdGhlIGhlbHBlciB3b3VsZCBjYWxsIHRoZSBwbDAxMV93cml0ZSB0byBlbXVs
YXRlIHRoZSBhY3R1YWwgc3RkaW8gb3V0cHV0IGZ1bmN0aW9ucy48L2Rpdj48ZGl2IHN0eWxlPSJt
YXJnaW46MDsiPmJ1dCwgaG93IGRpZCB0aGUgVENCIFRCIGJsb2NrIGtub3cgdGhpcyBkdXJpbmcg
dGhlIHRyYW5zbGF0aW9ucz8gdGhlcmUgbWF5IGJlIG90aGVycyBkaWZmZXJlbnQgInByaW50ZiIg
aW1wbGVtZW50IGlvbnMgb24gZGlmZmVyZW50Jm5ic3A7IHRhcmdldCwmbmJzcDs8L2Rpdj48ZGl2
IHN0eWxlPSJtYXJnaW46MDsiPmhvdyB0aGUgdGNnIGtub3dzIHRoYXQgYSBzcGVjaWFsIGhlbHBl
ciBmdW5jdGlvbnMgbmVlZCB0byBiZSBjYWxsZWQgYW5kIG90aGVycyBub3QsIGZyb20gdGhlIGJp
bmFyeSBjb2RlIGRpc2Fzc2VtYmx5IGxhbmd1YWdlIG9mIHRoZSBlbXVsYXRlZCB0YXJnZXQsIHRo
ZXJlIGlzIG5vPC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij5vYnZpb3VzIHNpZ24gdG8gbWFr
ZSBhbnlvbmUga25vdyB3aGljaCBpbnN0dXRpb25zIGlzIHNwZWNpYWwgYW5kIG5lZWQgdG8gZW11
bGF0aW9uIGJ5IGhlbHBlciwgSG93IGdldCB0aGlzPzwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjow
OyI+PGJyPjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+VGhhbmsgeW91LjwvZGl2PjxkaXYg
c3R5bGU9Im1hcmdpbjowOyI+Jm5ic3A7Jm5ic3A7PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7
Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0i
bWFyZ2luOjA7Ij48YnI+PC9kaXY+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZv
b3RlciI+PHA+PGJyLz4mbmJzcDs8L3A+PC9zcGFuPg==
------=_Part_9688_1206773769.1590972947296--


