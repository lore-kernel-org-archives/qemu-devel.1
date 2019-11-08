Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F462C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BEA206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 19:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BEA206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTABc-0006Xf-KP
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 14:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iTAAN-0005Rv-Gw
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:43:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iTAAM-0002US-1X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 14:43:31 -0500
Resent-Date: Fri, 08 Nov 2019 14:43:31 -0500
Resent-Message-Id: <E1iTAAM-0002US-1X@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iTAAL-0002TJ-Q2; Fri, 08 Nov 2019 14:43:29 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573242198; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AUApxiHdzIQtZNswcMjpdG9HDYKdKjXehSNfWLenJYkN4neTRZvYvTOvyEltavQOp7jdLu3TIW01Bbf3CfhYTRUCWcvcoCVw0n8+6dhFIw4SFqarI/u+ISub2EOKEmUs8l5c9aNAP31AfOC6qOs+wWeM2xM1+2e8nUUGfy7kpHo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573242198;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fOvlGWWxJ57pV35k8/EEZDYgFAuujoSG0MtuOuoCWhU=; 
 b=j2EMYfjxOE4P0zBgSS7Dki69fjUJO1GK7trRAlQLcjcoXSYB7yXySrLmOs7DHFRXaWtjuORvxU2fbME1FNC4SeUty7A2mmuzor0xPtW/U0MiEUToMw/g5Hh/kJrqzHVlMRcz0c0dhGcckhsFpCFXGmXxor7KDR0/WITY+W3kFhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157324219731081.98744667723304;
 Fri, 8 Nov 2019 11:43:17 -0800 (PST)
In-Reply-To: <20191108134249.19004-1-dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2 0/1] virtio: fix IO request length in virtio SCSI/block
Message-ID: <157324219615.8646.11640144980232368551@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Fri, 8 Nov 2019 11:43:17 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwODEzNDI0OS4xOTAw
NC0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgY2hl
Y2stcXRlc3QteDg2XzY0OiB0ZXN0cy9haGNpLXRlc3QKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRl
c3RzL3Rlc3QtYWlvLW11bHRpdGhyZWFkCnRlc3QtYWlvLW11bHRpdGhyZWFkOiAvdG1wL3FlbXUt
dGVzdC9zcmMvdXRpbC9hc3luYy5jOjI3OTogYWlvX2N0eF9maW5hbGl6ZTogQXNzZXJ0aW9uIGAo
KCZjdHgtPnNjaGVkdWxlZF9jb3JvdXRpbmVzKS0+c2xoX2ZpcnN0ID09ICgodm9pZCAqKTApKScg
ZmFpbGVkLgpFUlJPUiAtIHRvbyBmZXcgdGVzdHMgcnVuIChleHBlY3RlZCA2LCBnb3QgMikKbWFr
ZTogKioqIFtjaGVjay11bml0XSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlz
aGVkIGpvYnMuLi4uCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAxMwogIFRFU1QgICAgaW90ZXN0
LXFjb3cyOiAwMTcKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywg
J2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTY2ZjY3
Njg1ZWYzNTQ3Nzg4ZGRiZmNhNDNlMGU5MjUwJywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1v
cHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9Jywg
Jy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0Jywg
Jy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zh
ci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNj
YWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtb2M1aHFsZmQvc3JjL2RvY2tlci1zcmMuMjAxOS0xMS0wOC0xNC4zMi4xNC4yMTU3MTovdmFy
L3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rl
c3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmls
dGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NjZmNjc2ODVlZjM1NDc3ODhkZGJmY2E0
M2UwZTkyNTAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZp
bmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb2M1aHFsZmQvc3JjJwpt
YWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAg
IDExbTEuODIwcwp1c2VyICAgIDBtOC41MDdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTEwODEzNDI0OS4xOTAwNC0xLWRwbG90bmlr
b3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


