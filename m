Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A8FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 579E82080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579E82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzrZ-0001K2-AY
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMzqP-000875-O2; Mon, 28 Sep 2020 16:33:57 -0400
Resent-Date: Mon, 28 Sep 2020 16:33:57 -0400
Resent-Message-Id: <E1kMzqP-000875-O2@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMzqM-0002EZ-FZ; Mon, 28 Sep 2020 16:33:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601325211; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UNs1H/qdVbyaLP0B9psoepEtr2Jj6Dmz5zspIe5En52o/w02/6kP4wlFUpp3DpNnVOm/HFSqOeSACWYJBvK32zIYh8rYU1jm8JpUI+N/k836UbtqBR1k/E9Wtz7kphb3mslczVz9j1N0xJDoux7Fgmv7xUta2NeKb9YdtOSijH4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601325211;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mLr37FDY3YDx1X5PzBrWh12PqZLwNiOylHPT/w7nvRw=; 
 b=IpDhBeWlx3qWDk2Y+JLYh2ev/9nD8/lNyZjTnA59gnf/9WwqOrKQW8dtq1Bx8zKPoGQRcop7YKoUYCS+sBosDhK9YSOP8LsBZH9I/HY+GsavYfKxYfFXugfjOArLIUQXKRDjbCZHRyUEr+OLzx8/kgyu67+yjhuGK8VLByes1fY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 160132521072659.93211959348912;
 Mon, 28 Sep 2020 13:33:30 -0700 (PDT)
Subject: Re: [PATCH v9 0/9] Apply COR-filter to the block-stream permanently
Message-ID: <160132520866.11341.5214779024425803660@66eaa9a8a123>
In-Reply-To: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Mon, 28 Sep 2020 13:33:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 16:33:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, andrey.shinkevich@virtuozzo.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAxMjk4MDAxLTc3NDA5Ni0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBs
ZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElm
IHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0
CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQg
QVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBt
YWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJ
UFQgRU5EID09PQoKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0ClRhcmdldCBtYWNoaW5lIGNwdSBm
YW1pbHk6IHg4NgpUYXJnZXQgbWFjaGluZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6
MTA6IFdBUk5JTkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBm
b3J3YXJkcyBjb21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVh
c2VzLgpQcm9ncmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91
c3IvYmluL3B5dGhvbjMpCkNvbmZpZ3VyaW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9u
Ci0tLQpDb21waWxpbmcgQyBvYmplY3QgbGliYmxvY2suZmEucC9ibG9ja19ib2Nocy5jLm9iagpD
b21waWxpbmcgQyBvYmplY3QgbGliYmxvY2suZmEucC9ibG9ja19maWx0ZXItY29tcHJlc3MuYy5v
YmoKQ29tcGlsaW5nIEMgb2JqZWN0IGxpYmJsb2NrLmZhLnAvYmxvY2tfcWNvdzIuYy5vYmoKLi4v
c3JjL2Jsb2NrL2NvcHktb24tcmVhZC5jOjI5OjEwOiBmYXRhbCBlcnJvcjogYmxvY2svY29weS1v
bi1yZWFkLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICAgMjkgfCAjaW5jbHVkZSAiYmxv
Y2svY29weS1vbi1yZWFkLmgiCiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgptYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjg4Nzog
bGliYmxvY2suZmEucC9ibG9ja19jb3B5LW9uLXJlYWQuYy5vYmpdIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBp
biA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQp
CnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAn
ZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0wMjZkNTFhMjJkODY0OWZmODMxYTlhYjhhOTdmZmZmMCcsICctdScsICcxMDAzJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctZScsICdUQVJHRVRfTElTVD0nLCAn
LWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAn
LWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIv
dG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2Nh
Y2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRt
cC1fNXlpbzN5aC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA5LTI4LTE2LjI4LjU1Ljg0Njk6L3Zhci90
bXAvcWVtdTp6LHJvJywgJ3FlbXUvZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
bWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDI2ZDUxYTIyZDg2NDlmZjgzMWE5YWI4YTk3
ZmZmZjAKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtXzV5aW8zeWgvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG0z
My40MzBzCnVzZXIgICAgMG0xOC45NzBzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNjAxMjk4MDAxLTc3NDA5Ni0xLWdpdC1zZW5kLWVtYWls
LWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVk
b3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQ
YXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sg
dG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

