Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C821C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD56C2098B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bfEdTDCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXaA-0001RM-WA
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jlXZ9-0007uW-6E
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:53:19 -0400
Received: from m1343.mail.163.com ([220.181.13.43]:36885)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <13824125580@163.com>)
 id 1jlXZ2-0006KF-7q
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Szgmj
 fVLEMGWuNKB0UhgdM5EO/N/SHuaTruYULQ6j8I=; b=bfEdTDCkRzOTIaHEZOG7P
 lzfvn+mxZOrQ1s44Vcoxu93gTOpU7bt+OQ3A3pXBrQd1PQxwmr5v7vscHNo565Xt
 iVoJ89/5/YUp1tHWgcjVCzjf1no301ymMmN3mG/XIQUtH6KHnf5X3jzT9OOBYHsG
 BPYcuOMDalWYBiNtf6D4wU=
Received: from 13824125580$163.com ( [221.4.213.95] ) by
 ajax-webmail-wmsvr43 (Coremail) ; Wed, 17 Jun 2020 20:52:58 +0800 (CST)
X-Originating-IP: [221.4.213.95]
Date: Wed, 17 Jun 2020 20:52:58 +0800 (CST)
From: tugouxp <13824125580@163.com>
To: qemu-devel@nongnu.org
Subject: What is the "E10, E20_0 XXX" Flag means on arm port?
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 163com
X-CM-CTRLDATA: uWlPkWZvb3Rlcl9odG09MjQxNTo2MQ==
Content-Type: multipart/alternative; 
 boundary="----=_Part_112464_1332627061.1592398378842"
MIME-Version: 1.0
Message-ID: <7f3f1607.7942.172c256f75a.Coremail.13824125580@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: K8GowACH9O4qEupetR5EAA--.26579W
X-CM-SenderInfo: bprtmjyurskkiyq6il2tof0z/1tbiGAZGQlv2cBiMoQACsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Received-SPF: pass client-ip=220.181.13.43; envelope-from=13824125580@163.com;
 helo=m1343.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 08:53:00
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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

------=_Part_112464_1332627061.1592398378842
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

SGkgZm9sa3M6CgoKIEkgS25vdyB0aGUgYXJtIHByZWxpZGdlIGxldmVsIGNhbiBiZSBkaXZpZWRl
ZCBpbnRvIEVMMCwgRUwxLCBFTDIgYW5kIEVMMywgYnV0IGkgYW0gY29uZnVzZWQgYnkgdGhlIGZv
bGxvd2luZyAgZGVmaW5pdGlvbiBvbiBxZW11IGFybSBwb3J0LgogZm9yIGV4YW1wbGUsIHdoeSBF
MTAgYXJlIHBvc3RmaXggd2l0aCBfMCBhbmQgXzEsIHdoYXQgaXMgdGhpcyBtZWFuc2luZ3M/CgoK
IHR5cGVkZWYgZW51bSBBUk1NTVVJZHggewoKMjg3OSAgICAgLyogCgoyODgwICAgICDCpiogQS1w
cm9maWxlLgoKMjg4MSAgICAgwqYqLwoKMjg4MiAgICAgQVJNTU1VSWR4X0UxMF8wICAgICAgPSAg
MCB8IEFSTV9NTVVfSURYX0EsICAgICAKCjI4ODMgICAgIEFSTU1NVUlkeF9FMjBfMCAgICAgID0g
IDEgfCBBUk1fTU1VX0lEWF9BLCAgICAgCgoyODg0ICAgICAgICAKCjI4ODUgICAgIEFSTU1NVUlk
eF9FMTBfMSAgICAgID0gIDIgfCBBUk1fTU1VX0lEWF9BLCAgICAgCgoyODg2ICAgICBBUk1NTVVJ
ZHhfRTEwXzFfUEFOICA9ICAzIHwgQVJNX01NVV9JRFhfQSwKCjI4ODcgICAgICAgICAgICAgICAg
ICAgICAKCjI4ODggICAgIEFSTU1NVUlkeF9FMiAgICAgICAgID0gIDQgfCBBUk1fTU1VX0lEWF9B
LCAgICAgCgoyODg5ICAgICBBUk1NTVVJZHhfRTIwXzIgICAgICA9ICA1IHwgQVJNX01NVV9JRFhf
QSwgICAgIAoKMjg5MCAgICAgQVJNTU1VSWR4X0UyMF8yX1BBTiAgPSAgNiB8IEFSTV9NTVVfSURY
X0EsCgoyODkxICAgICAgICAKCjI4OTIgICAgIEFSTU1NVUlkeF9TRTEwXzAgICAgID0gNyB8IEFS
TV9NTVVfSURYX0EsCgoyODkzICAgICBBUk1NTVVJZHhfU0UxMF8xICAgICA9IDggfCBBUk1fTU1V
X0lEWF9BLAoKMjg5NCAgICAgQVJNTU1VSWR4X1NFMTBfMV9QQU4gPSA5IHwgQVJNX01NVV9JRFhf
QSwKCjI4OTUgICAgIEFSTU1NVUlkeF9TRTMgICAgICAgID0gMTAgfCBBUk1fTU1VX0lEWF9BLCAg
ICAgCgoyODk2ICAgICAgICAKCjI4OTcgICAgIEFSTU1NVUlkeF9TdGFnZTIgICAgID0gMTEgfCBB
Uk1fTU1VX0lEWF9BLCAgICA=
------=_Part_112464_1332627061.1592398378842
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXYgc3R5bGU9Im1hcmdpbjowOyI+SGkgZm9sa3M6PC9kaXY+
PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4m
bmJzcDtJIEtub3cgdGhlIGFybSBwcmVsaWRnZSBsZXZlbCBjYW4gYmUgZGl2aWVkZWQgaW50byBF
TDAsIEVMMSwgRUwyIGFuZCBFTDMsIGJ1dCBpIGFtIGNvbmZ1c2VkIGJ5IHRoZSBmb2xsb3dpbmcm
bmJzcDsgZGVmaW5pdGlvbiBvbiBxZW11IGFybSBwb3J0LjwvZGl2PjxkaXYgc3R5bGU9Im1hcmdp
bjowOyI+Jm5ic3A7Zm9yIGV4YW1wbGUsIHdoeSBFMTAgYXJlIHBvc3RmaXggd2l0aCBfMCBhbmQg
XzEsIHdoYXQgaXMgdGhpcyBtZWFuc2luZ3M/PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij48
YnI+PC9kaXY+PGRpdiBzdHlsZT0ibWFyZ2luOjA7Ij4mbmJzcDt0eXBlZGVmIGVudW0gQVJNTU1V
SWR4IHs8L2Rpdj48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODc5Jm5ic3A7ICZuYnNwOyAmbmJzcDsv
KiZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODgwJm5ic3A7ICZuYnNwOyAmbmJzcDvC
piogQS1wcm9maWxlLjwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODgxJm5ic3A7ICZuYnNwOyAm
bmJzcDvCpiovPC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPjI4ODImbmJzcDsgJm5ic3A7ICZuYnNw
O0FSTU1NVUlkeF9FMTBfMCZuYnNwOyAmbmJzcDsgJm5ic3A7ID0mbmJzcDsgMCB8IEFSTV9NTVVf
SURYX0EsJm5ic3A7ICZuYnNwOyAmbmJzcDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Mjg4MyZu
YnNwOyAmbmJzcDsgJm5ic3A7QVJNTU1VSWR4X0UyMF8wJm5ic3A7ICZuYnNwOyAmbmJzcDsgPSZu
YnNwOyAxIHwgQVJNX01NVV9JRFhfQSwmbmJzcDsgJm5ic3A7ICZuYnNwOzwvcD48cCBzdHlsZT0i
bWFyZ2luOjA7Ij4yODg0Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7Jm5ic3A7PC9wPjxwIHN0
eWxlPSJtYXJnaW46MDsiPjI4ODUmbmJzcDsgJm5ic3A7ICZuYnNwO0FSTU1NVUlkeF9FMTBfMSZu
YnNwOyAmbmJzcDsgJm5ic3A7ID0mbmJzcDsgMiB8IEFSTV9NTVVfSURYX0EsJm5ic3A7ICZuYnNw
OyAmbmJzcDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Mjg4NiZuYnNwOyAmbmJzcDsgJm5ic3A7
QVJNTU1VSWR4X0UxMF8xX1BBTiZuYnNwOyA9Jm5ic3A7IDMgfCBBUk1fTU1VX0lEWF9BLDwvcD48
cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODg3Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzwvcD48cCBzdHlsZT0i
bWFyZ2luOjA7Ij4yODg4Jm5ic3A7ICZuYnNwOyAmbmJzcDtBUk1NTVVJZHhfRTImbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7PSZuYnNwOyA0IHwgQVJNX01NVV9JRFhfQSwmbmJzcDsg
Jm5ic3A7ICZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODg5Jm5ic3A7ICZuYnNwOyAm
bmJzcDtBUk1NTVVJZHhfRTIwXzImbmJzcDsgJm5ic3A7ICZuYnNwOyA9Jm5ic3A7IDUgfCBBUk1f
TU1VX0lEWF9BLCZuYnNwOyAmbmJzcDsgJm5ic3A7PC9wPjxwIHN0eWxlPSJtYXJnaW46MDsiPjI4
OTAmbmJzcDsgJm5ic3A7ICZuYnNwO0FSTU1NVUlkeF9FMjBfMl9QQU4mbmJzcDsgPSZuYnNwOyA2
IHwgQVJNX01NVV9JRFhfQSw8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Mjg5MSZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyZuYnNwOzwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODkyJm5ic3A7
ICZuYnNwOyAmbmJzcDtBUk1NTVVJZHhfU0UxMF8wJm5ic3A7ICZuYnNwOyAmbmJzcDs9IDcgfCBB
Uk1fTU1VX0lEWF9BLDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODkzJm5ic3A7ICZuYnNwOyAm
bmJzcDtBUk1NTVVJZHhfU0UxMF8xJm5ic3A7ICZuYnNwOyAmbmJzcDs9IDggfCBBUk1fTU1VX0lE
WF9BLDwvcD48cCBzdHlsZT0ibWFyZ2luOjA7Ij4yODk0Jm5ic3A7ICZuYnNwOyAmbmJzcDtBUk1N
TVVJZHhfU0UxMF8xX1BBTiA9IDkgfCBBUk1fTU1VX0lEWF9BLDwvcD48cCBzdHlsZT0ibWFyZ2lu
OjA7Ij4yODk1Jm5ic3A7ICZuYnNwOyAmbmJzcDtBUk1NTVVJZHhfU0UzJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ID0gMTAgfCBBUk1fTU1VX0lEWF9BLCZuYnNwOyAmbmJzcDsgJm5ic3A7PC9w
PjxwIHN0eWxlPSJtYXJnaW46MDsiPjI4OTYmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsmbmJz
cDs8L3A+PHAgc3R5bGU9Im1hcmdpbjowOyI+Mjg5NyZuYnNwOyAmbmJzcDsgJm5ic3A7QVJNTU1V
SWR4X1N0YWdlMiZuYnNwOyAmbmJzcDsgJm5ic3A7PSAxMSB8IEFSTV9NTVVfSURYX0EsJm5ic3A7
ICZuYnNwOyZuYnNwOzwvcD48L2Rpdj48YnI+PGJyPjxzcGFuIHRpdGxlPSJuZXRlYXNlZm9vdGVy
Ij48cD48YnIvPiZuYnNwOzwvcD48L3NwYW4+
------=_Part_112464_1332627061.1592398378842--


