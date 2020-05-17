Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F89C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10CB6207D4
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 13:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10CB6207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaJj0-0002BM-4t
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 09:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaJiU-0001j7-67
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:52:34 -0400
Resent-Date: Sun, 17 May 2020 09:52:34 -0400
Resent-Message-Id: <E1jaJiU-0001j7-67@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21351)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaJiS-00025O-Io
 for qemu-devel@nongnu.org; Sun, 17 May 2020 09:52:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589723516; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U+7b7Qnh7PyOqp7v/k/OAl4MKp8DfBBMh97SlkZjOsBe+thdo3O2PIx7EsS11ettoiqCUQOYe3NzBn5oM6/ZBo5DxFNM9QNFkLGV7nu8dhWKEvk7zz1IbWrplkiZdDCx+mbBEeO/vLByLVdpy+auteU03BwTgeP0k3tevGYtSL4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589723516;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rJxVF8kRMMDqmY8WhrwPk0yDudk5Ri1Y9YVIe0tRA1Y=; 
 b=jrH372AFNsfue0AgDa6KO8eSMQ5gKbxOIaLwByIaQT1uCG0vj0/Axk5v6fHnn6AOmdxq2DlPulyTc4V5I64l/BvetukHyYbJb90n4TM5TmIaNU0fOWo7ML+m0ENMzA4b86gGz/pDyKwFcMScgwagAlusW7cQ8ZWYWD+1uDb9kCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589723514581435.70172398097225;
 Sun, 17 May 2020 06:51:54 -0700 (PDT)
Message-ID: <158972351258.15373.3545994368762600778@45ef0f9c86ae>
In-Reply-To: <20200517113804.9063-1-f4bug@amsat.org>
Subject: Re: [RFC PATCH 0/2] exec: Fix (too) short device accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 17 May 2020 06:51:54 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 08:08:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, tony.nguyen@bt.com,
 aik@ozlabs.ru, jusual@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 f4bug@amsat.org, alxndr@bu.edu, pbonzini@redhat.com, sgarzare@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNzExMzgwNC45MDYz
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay1xdGVzdC14
ODZfNjQ6IHRlc3RzL3F0ZXN0L3RwbS1jcmItc3d0cG0tdGVzdAogIFRFU1QgICAgY2hlY2stcXRl
c3QteDg2XzY0OiB0ZXN0cy9xdGVzdC90cG0tY3JiLXRlc3QKKioKRVJST1I6L3RtcC9xZW11LXRl
c3Qvc3JjL3Rlc3RzL3F0ZXN0L3RwbS1jcmItdGVzdC5jOjUzOnRwbV9jcmJfdGVzdDogYXNzZXJ0
aW9uIGZhaWxlZCAoY2FkZHIgPiBUUE1fQ1JCX0FERFJfQkFTRSk6ICgtMSA+IDQyNzUzMDY0OTYp
CkVSUk9SIC0gQmFpbCBvdXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC90
cG0tY3JiLXRlc3QuYzo1Mzp0cG1fY3JiX3Rlc3Q6IGFzc2VydGlvbiBmYWlsZWQgKGNhZGRyID4g
VFBNX0NSQl9BRERSX0JBU0UpOiAoLTEgPiA0Mjc1MzA2NDk2KQptYWtlOiAqKiogW2NoZWNrLXF0
ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgpxZW11LXN5c3RlbS1hYXJjaDY0OiAtYWNjZWwga3ZtOiBpbnZhbGlkIGFjY2VsZXJhdG9y
IGt2bQpxZW11LXN5c3RlbS1hYXJjaDY0OiBmYWxsaW5nIGJhY2sgdG8gdGNnCi0tLQogIFRFU1Qg
ICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvdGVzdC1obXAKICBURVNUICAgIGNo
ZWNrLXF0ZXN0LWFhcmNoNjQ6IHRlc3RzL3F0ZXN0L3Fvcy10ZXN0CioqCkVSUk9SOi90bXAvcWVt
dS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9zZGhjaS10ZXN0LmM6NDI6Y2hlY2tfY2FwYWJfY2FwYXJl
ZzogYXNzZXJ0aW9uIGZhaWxlZCAoY2FwYWIgPT0gZXhwZWNfY2FwYWIpOiAoMHhmZmZmZmZmZmZm
ZmZmZmZmID09IDB4MjgwNzM3ZWM2NDgxKQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvcXRlc3Qvc2RoY2ktdGVzdC5jOjQyOmNoZWNrX2NhcGFiX2NhcGFy
ZWc6IGFzc2VydGlvbiBmYWlsZWQgKGNhcGFiID09IGV4cGVjX2NhcGFiKTogKDB4ZmZmZmZmZmZm
ZmZmZmZmZiA9PSAweDI4MDczN2VjNjQ4MSkKbWFrZTogKioqIFtjaGVjay1xdGVzdC1hYXJjaDY0
XSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rl
c3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0
KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpz
dWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2Rv
Y2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTg2OThiNjRj
MzYwNTQ4Mjk5YTdmMjg1NjNjYjZkZTc5JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQn
LCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1l
JywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1l
JywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90
bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTM2M2Y2YzlqL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTctMDkuMzcuMDEuMTIwMTg6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0
LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRl
cj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTg2OThiNjRjMzYwNTQ4Mjk5YTdmMjg1NjNj
YjZkZTc5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5n
IGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTM2M2Y2YzlqL3NyYycKbWFr
ZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAx
NG01MS44NjZzCnVzZXIgICAgMG04LjE1MHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTE3MTEzODA0LjkwNjMtMS1mNGJ1Z0BhbXNh
dC5vcmcvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

