Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26926C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 03:47:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2A72075C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 03:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="OCVqprlP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2A72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i65E2-0006eb-1z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 23:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <18781374080@163.com>) id 1i65DL-0006Fq-I6
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <18781374080@163.com>) id 1i65DI-0006PC-7w
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:47:09 -0400
Received: from m13-141.163.com ([220.181.13.141]:44269)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <18781374080@163.com>) id 1i65DG-0006Gk-IB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 23:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=WYSfr
 3+jiTJ5JdjbYhmBIBBjvLIJrMsiOBDu/ZCjDII=; b=OCVqprlPhHBx+mwrP08dg
 UD3m8P/037YkjNEnwt/rYrxSmc8pGA9Lb+ntaMsKbHtZT0Zg8+SxV660PNGRmIk6
 TWX04GJYtJwA/vww0nyDbm4kUNTSrnCypBsuH7Nbbn46OMI1K6AXFoo8dS0lgMAs
 EVoWz2FjF0/7JRQuJxqGOA=
Received: from 18781374080$163.com ( [110.184.114.204] ) by
 ajax-webmail-wmsvr141 (Coremail) ; Fri, 6 Sep 2019 11:47:00 +0800
 (GMT+08:00)
X-Originating-IP: [110.184.114.204]
Date: Fri, 6 Sep 2019 11:47:00 +0800 (GMT+08:00)
From: 18781374080 <18781374080@163.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180820(5a019900) Copyright (c) 2002-2019 www.mailtech.cn 163com
MIME-Version: 1.0
Message-ID: <7a3a247c.c681.16d04aeb0fe.Coremail.18781374080@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: jcGowAA3phy01nFdwplVAA--.57803W
X-CM-SenderInfo: jprylmartxkiiyq6il2tof0z/1tbiMhgo8lWBk9UozgABsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.13.141
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] Could not transaction encrypted image
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

CgpoaSDvvIxldmVyeW9uZSEKSSBhbSBhIG5ld2NvbWVyIHRvIFFFTVUsIGFuZCBJIGRvbid0IGtu
b3cgaWYgaXQncyBhIG5hdGl2ZSBxdWVzdGlvbgpJIGNyZWF0ZSBzbmFwc2hvdHMgb2YgdmlydHVh
bCBtYWNoaW5lcyB0aGF0IHVzZSBlbmNyeXB0ZWQgZGlzaywgVGhlIGNvbnNvbGUgZ2F2ZSBtZSB0
aGUgZm9sbG93aW5nIGVycm9yOgoyMDE5LTA5LTA2IDEwOjEzOjQxLDkwMiswODAwIEVSUk9SIChq
c29ucnBjLzApIFt2aXJ0LnZtXSAodm1JZD0nZWJkYjhiODItYjhjMC00NmIxLWJiMmEtNjc4ODcz
ZDQ2ZDJmJykgVW5hYmxlIHRvIHRha2Ugc25hcHNob3QgKHZtOjQ2MTYpCgoKVHJhY2ViYWNrKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgICBGaWxlICIvdXNyL2xpYi9weXRob24yLjcvc2l0ZS1w
YWNrYWdlcy92ZHNtL3ZpcnQvdm0ucHkiLGxpbmUgNDYxMywgaW4gc25hcHNob3QKICAgICAgICAg
IHNlbGYuX2RvbSxzbmFwc2hvdENyZWF0ZVhNTChzbmFweG1sLCBzbmFwRmxhZ3MpCiAgICBGaWxl
ICIvdXNyL2xpYi9weXRob24yLjcvc2l0ZS1wYWNrYWdlcy92ZHNtL3ZpcnQvdmlyZG9tYWluLnB5
IiwgaW4gbGluZSA5OCwgaW4gZiAKICAgICAgICAgICByZXQgPSBhdHRyKCphcmdzLCAqKmt3YXJn
cykKICAgIEZpbGUgIi91c3IvbGliL3B5dGhvbjIuNy9zaXRlLXBhY2thZ2VzL3Zkc20vY29tbW9u
L2xpYnZpcnRjb25uZWN0aW9uLnB5IiwgbGluZSAxMzAsIGluIHdyYXBwZXIKICAgIHJldCA9IGYo
KmFyZ3MsICoqa3dhcmdzKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjIuNy9zaXRlLXBhY2thZ2Vz
L3Zkc20vY29tbW9uL2Z1bmN0aW9uLnB5IiwgbGluZSA5MiwgaW4gd3JhcHBlcgogICAgcmV0dXJu
IGZ1bmMoaW5zdCwgKmFyZ3MsICoqa3dhcmdzKQogIEZpbGUgIi91c3IvbGliNjQvcHl0aG9uMi43
L3NpdGUtcGFja2FnZXMvbGlidmlydC5weSIsIGxpbmUgMjYyMCwgaW4gc25hcHNob3RDcmVhdGVY
TUwKICAgIGlmIHJldCBpcyBOb25lOnJhaXNlIGxpYnZpcnRFcnJvcigndmlyRG9tYWluU25hcHNo
b3RDcmVhdGVYTUwoKSBmYWlsZWQnLCBkb209c2VsZikKIGxpYnZpcnRFcnJvcjogaW50ZXJuYWwg
ZXJyb3I6IHVuYWJsZSB0byBleGVjdXRlIFFFTVUgY29tbWFuZCAndHJhbnNhY3Rpb24nOiBQYXJh
bWV0ZXIgJ2VuY3J5cHQua2V5LXNlY3JldCcgaXMgcmVxdWlyZWQgZm9yIGNpcGhlcgoKCgoKCkkg
a25vdyBJIG5lZWQgdG8gYWRkIGVuY3J5cHQgaW4gJ3RyYW5zYWN0b24nIGNvbW1hbmQuIFRoZSBr
ZXkgLSBzZWNyZXQgaW5mb3JtYXRpb24sIHRocm91Z2ggdGhlIHNlYXJjaCBhZnRlciBJIGZvdW5k
IHRoZSBRRU1VIGNvbW1hbmQgaXMgdGhyb3VnaCBRTVAsIGJ1dCBJIGRvbid0IGtub3cgaG93IHRv
IGNvbXBpbGUgYW5kIGFkZCB0aGUgcmVxdWlyZWQgaW5mb3JtYXRpb27jgIIKCkFueSBoZWxwIG9y
IHJlbWluZGVyIGlzIGFwcHJlY2lhdGVkISB0aGFuayB5b3UhCgp8IHwKMTg3ODEzNzQwODAKfAp8
CjE4NzgxMzc0MDgwQDE2My5jb20KfArnrb7lkI3nlLHnvZHmmJPpgq7nrrHlpKfluIjlrprliLY=
