Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D10C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF24420757
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 19:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF24420757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUxW2-0004h3-7D
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 15:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUxVI-00040h-Ln
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:08:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUxVI-0006Ez-5S
 for qemu-devel@nongnu.org; Sat, 02 May 2020 15:08:48 -0400
Resent-Date: Sat, 02 May 2020 15:08:48 -0400
Resent-Message-Id: <E1jUxVI-0006Ez-5S@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUxVF-00069h-O3; Sat, 02 May 2020 15:08:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588446507; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UcJxxp5UUHuAt5RYGwlMKmZ3VN2kzDmMc+JotxOFQT/0avpghG9bWzwOIFQAnSuK2vcKQDBR1MVRjM/bkizvUMZevyC/1dd1pksokNATSx/t9zmV/iM+w2mBeUm8bLpkpN+Rm8APSQIw0SqKmzcBZTqYVxMBVs6v1Ee/e9V3PnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588446507;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KFjoiPKfD87k8xMyIgAD8t6t9iqRl3U5714tlw+mXX8=; 
 b=ZqBuq8j6tbrmbs1rceeFq8+L3sY0LaQdgI5QXYZI3pZlSvtu0B/pVigzwUxpOEBLZ48tC9XAI+tA8nU/5aQcMF3/xGtLCsOaJjlUFd8Q0jbGfygfdxWwoLFh0K2mkXGtl9PJaQMrjskxbsSY0IEbjkbhIFaG4iWPSkkeyk1vn0k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588446504368949.7949285442028;
 Sat, 2 May 2020 12:08:24 -0700 (PDT)
Message-ID: <158844650239.31413.10730868025544781165@45ef0f9c86ae>
In-Reply-To: <1588441994-21447-1-git-send-email-sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH 00/10] Cadence GEM Fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sai.pavan.boddu@xilinx.com
Date: Sat, 2 May 2020 12:08:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 15:08:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Alistair.Francis@wdc.com,
 edgar.iglesias@gmail.com, tong.ho@xilinx.com, philmd@redhat.com,
 rfried.dev@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg4NDQxOTk0LTIxNDQ3LTEt
Z2l0LXNlbmQtZW1haWwtc2FpLnBhdmFuLmJvZGR1QHhpbGlueC5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14
ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRv
Y2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGh3L3VzYi9kZXYtd2Fjb20ubwogIENDICAgICAgaHcvdXNiL2Rldi1z
dG9yYWdlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC9jYWRlbmNlX2dlbS5jOiBJbiBmdW5j
dGlvbiAnZ2VtX3JlY2VpdmUnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvbmV0L2NhZGVuY2VfZ2Vt
LmM6OTkzOjE0OiBlcnJvcjogZm9ybWF0ICclbGQnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAn
bG9uZyBpbnQnLCBidXQgYXJndW1lbnQgMyBoYXMgdHlwZSAnc2l6ZV90JyB7YWthICdsb25nIGxv
bmcgdW5zaWduZWQgaW50J30gWy1XZXJyb3I9Zm9ybWF0PV0KICAgICBEQl9QUklOVCgiY29uZmln
IGJ1ZnNpemU6ICVkIHBhY2tldCBzaXplOiAlbGRcbiIsIHJ4YnVmc2l6ZSwgc2l6ZSk7CiAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+ICAgICAgICAg
ICAgIH5+fn4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L25ldC9jYWRlbmNlX2dlbS5jOjQzOjE4OiBu
b3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICdEQl9QUklOVCcKICAgICAgICAgcWVtdV9sb2co
X19WQV9BUkdTX18pOyBcCiAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+CmNjMTogYWxsIHdh
cm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qv
c3JjL3J1bGVzLm1hazo2OTogaHcvbmV0L2NhZGVuY2VfZ2VtLm9dIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBp
biA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Njk0OGU2
NThmMGIwNDY3NWEzZTYwMWNmMDMxMWQzY2UnLCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9w
dCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2Fj
aGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LTkyZzVocl83L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMDItMTUuMDUuMzIuMjExMjU6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
bWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9Njk0OGU2NThmMGIwNDY3NWEzZTYwMWNmMDMx
MWQzY2UKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOTJnNWhyXzcvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm01
MC44MTlzCnVzZXIgICAgMG04LjY4N3MKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1ODg0NDE5OTQtMjE0NDctMS1naXQtc2VuZC1lbWFpbC1z
YWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

