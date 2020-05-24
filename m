Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65057C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F942076C
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 21:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F942076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcxzT-00056l-Er
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 17:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcxyx-0004ZS-Ns; Sun, 24 May 2020 17:16:31 -0400
Resent-Date: Sun, 24 May 2020 17:16:31 -0400
Resent-Message-Id: <E1jcxyx-0004ZS-Ns@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcxyv-0000Ji-QU; Sun, 24 May 2020 17:16:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590354976; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZljZe6dgFLCekNce5c+iF+m5itha6iDad4ihcjIyNBaf8E12Ht3gG1RFuOi5qTrTtdIKSXNQDBQtJlb3f2UxDqRQlCB/IMD6FvEnyBmuY04C4vauHW95mo516bzKjCKSZ3K2y3puZwKyqdNhrtzwZ+qkwDL+DqdynHoXiFJF7oM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590354976;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4OdeMSxgOE+kPa1FovXoLPWOTz9KdU3TT24b1E/QTDE=; 
 b=kUj4y4LF1Kvfv6/58LVU2hoCNxJZHk+ngPhGGyPDxPbKQjeMjjiMnVy7do61ykXAFhK4BUThNtP3ypFY80ijqomVCYHZACAeePDbE5a6M6gu4GQQePLOm9gqzQAFQs6uPFmt6zSOo7y85tfOejxpoxVdalo9geW1teAOCBeiwLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590354974595921.812265468479;
 Sun, 24 May 2020 14:16:14 -0700 (PDT)
Message-ID: <159035497298.27266.11303032089691456121@45ef0f9c86ae>
In-Reply-To: <cover.1590344541.git.lukasstraub2@web.de>
Subject: Re: [PATCH v3 0/4] Introduce 'yank' oob qmp command to recover from
 hanging qemu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Sun, 24 May 2020 14:16:14 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 17:16:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwMzQ0NTQxLmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCm1pZ3JhdGlvbi9xZW11LWZpbGUt
Y2hhbm5lbC5vOiBJbiBmdW5jdGlvbiBgY2hhbm5lbF9jbG9zZSc6Ci90bXAvcWVtdS10ZXN0L3Ny
Yy9taWdyYXRpb24vcWVtdS1maWxlLWNoYW5uZWwuYzoxMTA6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYHlhbmtfZ2VuZXJpY19pb2NoYW5uZWwnCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24v
cWVtdS1maWxlLWNoYW5uZWwuYzoxMTA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHlhbmtfdW5y
ZWdpc3Rlcl9mdW5jdGlvbicKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3Rh
dHVzCiAgTElOSyAgICB0ZXN0cy90ZXN0LWN1dGlscwptYWtlOiAqKiogW3Rlc3RzL3Rlc3Qtdm1z
dGF0ZV0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgog
IFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMDEKICBURVNUICAgIGlvdGVzdC1xY293MjogMDAyCi0t
LQpOb3QgcnVuOiAyNTkKRmFpbHVyZXM6IDI2NwpGYWlsZWQgMSBvZiAxMTkgaW90ZXN0cwptYWtl
OiAqKiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxCm1ha2U6ICoqKiB3YWl0
OiBObyBjaGlsZCBwcm9jZXNzZXMuICBTdG9wLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwg
bGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxt
b2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3Vi
cHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2Nr
ZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1kYjQ4M2UxYTdi
Mzc0ZWQ4YTljZjM1MjhhZDIzNTdiMicsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0Jywg
J3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScs
ICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScs
ICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1w
L2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hl
Oi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00
Z21uY2FiYi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTI0LTE3LjA0LjA3LjI0ODA0Oi92YXIvdG1w
L3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAndGVzdC1x
dWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1maWx0ZXI9
bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD1kYjQ4M2UxYTdiMzc0ZWQ4YTljZjM1MjhhZDIz
NTdiMgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBk
aXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC00Z21uY2FiYi9zcmMnCm1ha2U6
ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgMTJt
NS4xMzBzCnVzZXIgICAgMG04LjA4MnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTAzNDQ1NDEuZ2l0Lmx1a2Fzc3RyYXViMkB3
ZWIuZGUvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

