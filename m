Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B57C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3252083B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3252083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PUq-0001oX-AB
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8PUI-0001O6-Gd
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:54:50 -0400
Resent-Date: Wed, 19 Aug 2020 10:54:50 -0400
Resent-Message-Id: <E1k8PUI-0001O6-Gd@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8PUF-0004Ui-OV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:54:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597848831; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WB+TD1CYS8z1clsVvCJRRxBp/XBDIrWALi/p5ftcwrQRwVrt6ShCwHsslNCv+/0CamREkyv8vsofSWH2WTaoJut58dtp/AJEST7r6Zq8pIRGfS+8hOZQbz5N9rliXJH2clZEZDuEmtK4PALW6/nWwIiEu5WeCbKENJdWKCqApQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597848831;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yqp7Diary776Sz9hxYBF3RlYDLJCfsUYmuDlmu5OLXw=; 
 b=Wea3JvTsyQFiqFMn/pMqzAh0YZ9sHSD1CiVx7ieqDv2QbKoTWyWJgn+s/KHiRJUBcs1IvaAmzHQQmhVfDKjIZjUPBOv2LKJBAq3Gxg+V++f+SovU/vIa9Z3WPel6v1quWfQPQMDslbVNd/luzyxUxfOA/8YwiT920O1VkRzzt7U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597848828050834.1573245532893;
 Wed, 19 Aug 2020 07:53:48 -0700 (PDT)
Subject: Re: [PATCH] qtest: add fuzz test case
Message-ID: <159784882659.26721.5915554716194814676@66eaa9a8a123>
In-Reply-To: <20200819141533.66354-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liq3ea@163.com
Date: Wed, 19 Aug 2020 07:53:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:54:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, thuth@redhat.com, liq3ea@163.com, liq3ea@gmail.com,
 qemu-devel@nongnu.org, alxndr@bu.edu, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxOTE0MTUzMy42NjM1
NC0xLWxpcTNlYUAxNjMuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi0uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgorLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uRS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4KKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KK0VSUk9SOiB0ZXN0X3BhdXNlIChfX21h
aW5fXy5UZXN0U2luZ2xlQmxvY2tkZXZVbmFsaWduZWRMZW5ndGgpCistLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCitU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CisgIEZpbGUgIjA0MSIsIGxpbmUgMTA5
LCBpbiB0ZXN0X3BhdXNlCi0tLQogUmFuIDEwNCB0ZXN0cwogCi1PSworRkFJTEVEIChlcnJvcnM9
MSkKICBURVNUICAgIGlvdGVzdC1xY293MjogMDQyCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0
MwpDb3VsZCBub3QgYWNjZXNzIEtWTSBrZXJuZWwgbW9kdWxlOiBObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5Ci0tLQpxZW11LXN5c3RlbS14ODZfNjQ6IC90bXAvcWVtdS10ZXN0L3NyYy9ody9zY3Np
L3Njc2ktZGlzay5jOjI5Mjogc2NzaV9kbWFfY29tcGxldGU6IEFzc2VydGlvbiBgci0+cmVxLmFp
b2NiICE9ICgodm9pZCAqKTApJyBmYWlsZWQuCkJyb2tlbiBwaXBlCi90bXAvcWVtdS10ZXN0L3Ny
Yy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE3NToga2lsbF9xZW11KCkgZGV0ZWN0ZWQgUUVNVSBk
ZWF0aCBmcm9tIHNpZ25hbCA2IChBYm9ydGVkKSAoY29yZSBkdW1wZWQpCkVSUk9SIGZ1enotdGVz
dCAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCAxLCBnb3QgMCkKbWFrZTogKioqIFtjaGVj
ay1xdGVzdC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMTU5CiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDE2MQotLS0KICBURVNUICAgIGlvdGVzdC1xY293MjogMTkwCnNvY2tldF9hY2NlcHQgZmFp
bGVkOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQoqKgpFUlJPUjovdG1wL3FlbXUt
dGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3Ft
cF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+
PSAwKQovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNjY6IGtpbGxf
cWVtdSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4
aXQgc3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIGZ1enotdGVzdCAtIEJhaWwgb3V0ISBFUlJP
UjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5p
dF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYm
IHMtPnFtcF9mZCA+PSAwKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LWFhcmNoNjRdIEVycm9yIDEK
ICBURVNUICAgIGlvdGVzdC1xY293MjogMTkxCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDE5Mgog
IFRFU1QgICAgaW90ZXN0LXFjb3cyOiAxOTUKLS0tCk5vdCBydW46IDI1OQpGYWlsdXJlczogMDQx
CkZhaWxlZCAxIG9mIDEyMCBpb3Rlc3RzCm1ha2U6ICoqKiBbY2hlY2stdGVzdHMvY2hlY2stYmxv
Y2suc2hdIEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUg
Ii4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgogICAgc3lz
LmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4n
LCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjZj
ZDJiMzYxNmVmNGIyZjhmM2M2MmNlYjU5M2UzZDInLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5
LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0n
LCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQn
LCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC14MWlzYzF6bS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTE5LTEwLjQwLjM3Ljc4MjM6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWI2Y2QyYjM2MTZlZjRiMmY4ZjNjNjJj
ZWI1OTNlM2QyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXgxaXNjMXptL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAxM20xMC4yOTdzCnVzZXIgICAgMG05LjQ4M3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwODE5MTQxNTMzLjY2MzU0LTEtbGlxM2Vh
QDE2My5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

