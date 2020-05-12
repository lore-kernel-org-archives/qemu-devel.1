Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACACFCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D16206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D16206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZY0-0005RC-NK
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYZWj-0004CY-VO; Tue, 12 May 2020 14:21:14 -0400
Resent-Date: Tue, 12 May 2020 14:21:13 -0400
Resent-Message-Id: <E1jYZWj-0004CY-VO@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYZWa-00043m-QQ; Tue, 12 May 2020 14:21:10 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589307638; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MqFNSmTs+8on6XbRf0mRnmfQLGStvhaxzqalU3M3Kbmo7SxuK95WR1SEte8dk5XlCMZk61XXqqPkA73qZulKd0Lz/z8/qxks6Q7r5uqtB9uRkpy1bf67SHV5usvvh6NMO0xf2CIuqf9++coQbs4H6kJjd9p2byGevbH3frTYx/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589307638;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1q1PT7vVyTdjPxcVg8vvc0z7vwUZ9yiYsyfIQ5vpR0U=; 
 b=GtJ75KDuSmuT2JKSsnhBEaIQZ7XAz56/d8PUQoRkOXxSYpXBC/6BIxJ12ZBnOnwb/tlTBdYY0A8Yezu54bu3XxDQueFe1AhV8oqpmfwjhqApiBJWTOjx1qVuhJpwGe762U1QcBu+5arJrkBfKnb+x0LOklNcVhab3jrtTCmdVWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589307636638646.9063226772754;
 Tue, 12 May 2020 11:20:36 -0700 (PDT)
Message-ID: <158930763461.4397.5021086568289529940@45ef0f9c86ae>
In-Reply-To: <1589295196-773454-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v3 00/15] Apply COR-filter to the block-stream permanently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 12 May 2020 11:20:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 14:20:59
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5Mjk1MTk2LTc3MzQ1NC0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGJsb2NrL2NvcHktb24tcmVhZC5vCiAgQ0MgICAgICBibG9jay9ibG9j
ay1jb3B5Lm8KICBDQyAgICAgIGJsb2NrL2NyeXB0by5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9jb3B5LW9uLXJlYWQuYzoyOTozMjogZmF0YWwgZXJyb3I6IGJsb2NrL2NvcHktb24tcmVhZC5o
OiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAiYmxvY2svY29weS1vbi1yZWFk
LmgiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpjb21waWxhdGlvbiB0ZXJtaW5h
dGVkLgotLS0KICBDQyAgICAgIHNjc2kvcHItbWFuYWdlci1oZWxwZXIubwogIENDICAgICAgYmxv
Y2svZG1nLWJ6Mi5vCiAgQ0MgICAgICBjcnlwdG8vaGFzaC5vCi90bXAvcWVtdS10ZXN0L3NyYy9i
bG9jay9zdHJlYW0uYzoyMjozMjogZmF0YWwgZXJyb3I6IGJsb2NrL2NvcHktb24tcmVhZC5oOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAiYmxvY2svY29weS1vbi1yZWFkLmgi
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpjb21waWxhdGlvbiB0ZXJtaW5hdGVk
LgogIENDICAgICAgY3J5cHRvL2hhc2gtbmV0dGxlLm8KICBDQyAgICAgIGNyeXB0by9obWFjLm8K
bWFrZTogKioqIFtibG9jay9jb3B5LW9uLXJlYWQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGlu
ZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW2Jsb2NrL3N0cmVhbS5vXSBFcnJv
ciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2Rv
Y2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4o
KSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9j
ZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcics
ICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTA5ZmYwYjQzNjdkNjQ1
ZDA4M2EwODc1MGE4YjRiNGM3JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2Vj
Y29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VY
VFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RF
QlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2Nh
Y2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zh
ci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJmeTZ1
MW5jL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTItMTQuMTguMTkuMzc1MTovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2sn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MDlmZjBiNDM2N2Q2NDVkMDgzYTA4NzUwYThiNGI0YzcK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtcmZ5NnUxbmMvc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtMTQuNjQ0
cwp1c2VyICAgIDBtOC4xMzNzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8xNTg5Mjk1MTk2LTc3MzQ1NC0xLWdpdC1zZW5kLWVtYWlsLWFuZHJl
eS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

