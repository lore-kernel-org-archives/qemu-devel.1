Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7137C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A224A20772
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 07:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224A20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Ism-0000n5-UO
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 03:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8Is5-00008c-FD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 03:50:57 -0400
Resent-Date: Wed, 19 Aug 2020 03:50:57 -0400
Resent-Message-Id: <E1k8Is5-00008c-FD@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8Is3-0005QH-3g
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 03:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597823444; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RKYV8+Qkj1gxT8guUwHUh+fibQUNhH54A6KfwW4rjObQWko5WNNPX5xBMPwu2t84xEA7A9g15ihxcZybjsAgnUMyGBUVdfWCJyyU8ww//37SLcQ5ip5QOl9UYCOO8PJt3BHQ+MOo9EAl/OfgiVvtTYMMW9+I/EWEwTXTRcAFjVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597823444;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Wk93AfsfczPW8EDvMM72lD7TzZ5tuAorvoAxcZk/bOk=; 
 b=cf0zHyrjb2U/1Qq+iey8Dxv+cYfoUgn5mT8TOR4Y8f5hlTioaGjm+g2A0QP/dS7f+GE2xT0+glI91BfWLh/IwEkfDwk1ORlc4vQl+9FpnkY447xb/NHgQ2dA2qmi6aCJxmc2nfTsYwgrfif9/q5YL18qp5Xasy+Gb2AzykWx4a0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597823441931723.583491478047;
 Wed, 19 Aug 2020 00:50:41 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k: QOMify the mcf5206 system integration module
Message-ID: <159782344069.25250.8248669151591715233@66eaa9a8a123>
In-Reply-To: <20200819065201.4045-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: huth@tuxfamily.org
Date: Wed, 19 Aug 2020 00:50:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 03:50:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxOTA2NTIwMS40MDQ1
LTEtaHV0aEB0dXhmYW1pbHkub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11bml0
OiB0ZXN0cy90ZXN0LWNoYXIKVW5leHBlY3RlZCBlcnJvciBpbiBvYmplY3RfcHJvcGVydHlfdHJ5
X2FkZCgpIGF0IC90bXAvcWVtdS10ZXN0L3NyYy9xb20vb2JqZWN0LmM6MTE4MToKYXR0ZW1wdCB0
byBhZGQgZHVwbGljYXRlIHByb3BlcnR5ICdzZXJpYWwtaWQnIHRvIG9iamVjdCAodHlwZSAnY29u
dGFpbmVyJykKRVJST1IgdGVzdC1jaGFyIC0gdG9vIGZldyB0ZXN0cyBydW4gKGV4cGVjdGVkIDM4
LCBnb3QgOSkKbWFrZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5n
IGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyNAogIFRF
U1QgICAgaW90ZXN0LXFjb3cyOiAwMjUKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3Io
cmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydz
dWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPWM3MDQzYTI3M2JkNDQyYmI5YTlhZGZmY2YwMTA0NjY3JywgJy11JywgJzEwMDEnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFS
R0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICct
ZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3Fl
bXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtbjhndWd0bHYvc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xOS0wMy4zNy4w
NS4xMDQ0MTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3Fl
bXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4K
ZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzcwNDNhMjczYmQ0
NDJiYjlhOWFkZmZjZjAxMDQ2NjcKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1h
a2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbjhn
dWd0bHYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJv
ciAyCgpyZWFsICAgIDEzbTM2LjIwOXMKdXNlciAgICAwbTguOTA5cwoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTkwNjUyMDEuNDA0
NS0xLWh1dGhAdHV4ZmFtaWx5Lm9yZy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

