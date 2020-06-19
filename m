Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:36:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0CA207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0CA207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKvy-0007UL-LE
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmKoS-00039c-KX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:28:24 -0400
Resent-Date: Fri, 19 Jun 2020 13:28:24 -0400
Resent-Message-Id: <E1jmKoS-00039c-KX@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jmKoQ-0007aj-5l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:28:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592587692; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CXh2QkBfkFIv2HLn2hUqhqbgKp3kxkw+6Z46/yZMTYGEjixS7GPXDm9yafGhxh3rz3ReLGX8ozq3D0FMVjwdfKY1YiXWaV4cOpuD7rtmc3ciXBHX7varx3qiypqCkG2kwFLHMbl2b6YcLn0noGS8dxWP2GZfTm7Kv1N8Ag2Nr2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592587692;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Jxcw8K+GBDeOEbY9W/8lFOGl0tMdg/YmA4qiQVfw12g=; 
 b=k1Ms+OUivkqT089emY9FQuuZpqxK/Ca6Dui5RXgYQAvBLHrtnt04bDYDDIpzML9hB57T2jjtHvbM9tIET1kY/9avutfNlg19S8bYpMGRBBkDtixtd+zi85nqLQQRKDKl8J4+qsPzhCtRc72FKjDssmUexcyAhZrJzBoUth0SzBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592587691810265.06228852569814;
 Fri, 19 Jun 2020 10:28:11 -0700 (PDT)
Message-ID: <159258769056.3204.17489445378227772958@d1fd068a5071>
Subject: Re: [PATCH v2] docs/devel: add some notes on tcg-icount for developers
In-Reply-To: <20200619170930.11704-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 19 Jun 2020 10:28:11 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 10:14:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, dovgaluk@ispras.ru, pbonzini@redhat.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxOTE3MDkzMC4xMTcw
NC0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGNyeXB0by90bHNzZXNzaW9uLm8KICBDQyAgICAgIGNyeXB0by9zZWNyZXRfY29tbW9uLm8KCldh
cm5pbmcsIHRyZWF0ZWQgYXMgZXJyb3I6Ci90bXAvcWVtdS10ZXN0L3NyYy9kb2NzL2RldmVsL3Rj
Zy1pY291bnQucnN0OmRvY3VtZW50IGlzbid0IGluY2x1ZGVkIGluIGFueSB0b2N0cmVlCiAgQ0Mg
ICAgICBjcnlwdG8vc2VjcmV0Lm8KICBDQyAgICAgIGNyeXB0by9wYmtkZi5vCi0tLQogIENDICAg
ICAgY3J5cHRvL2l2Z2VuLm8KICBDQyAgICAgIGNyeXB0by9pdmdlbi1lc3Npdi5vCiAgQ0MgICAg
ICBjcnlwdG8vaXZnZW4tcGxhaW4ubwptYWtlOiAqKiogW01ha2VmaWxlOjEwODg6IGRvY3MvZGV2
ZWwvaW5kZXguaHRtbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBq
b2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0
cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2Ug
Q2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNz
RXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwn
LCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD00YjI2NTRlOTEyNDU0NjU2OGY4NzU3MjAwMGFhYzI0
NScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcs
ICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BU
Uz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hP
V19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21l
L3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAn
LXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTF4enByM3B3L3NyYy9kb2NrZXItc3Jj
LjIwMjAtMDYtMTktMTMuMjUuMjYuMjAxNzU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVk
b3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXpl
cm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNl
LnV1aWQ9NGIyNjU0ZTkxMjQ1NDY1NjhmODc1NzIwMDBhYWMyNDUKbWFrZVsxXTogKioqIFtkb2Nr
ZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRj
aGV3LXRlc3Rlci10bXAtMXh6cHIzcHcvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1t
aW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm00NC4yNjNzCnVzZXIgICAgMG05LjA2OHMK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MjAwNjE5MTcwOTMwLjExNzA0LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy90ZXN0aW5nLmRvY2tl
ci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

