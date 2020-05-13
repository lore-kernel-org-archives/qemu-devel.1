Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B883C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713B02078C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 00:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713B02078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYeyq-0000B7-Gb
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 20:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYey6-00080Q-2f; Tue, 12 May 2020 20:09:50 -0400
Resent-Date: Tue, 12 May 2020 20:09:50 -0400
Resent-Message-Id: <E1jYey6-00080Q-2f@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jYey4-0005V8-Dk; Tue, 12 May 2020 20:09:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589328568; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O1S9nlx9cbT3vNBmQgzjej9cO3/mX/Xg+wlQKHUsz0KZEqAqp8syCKBrMhR84HxZAfqoN/ag/iUtl0D8+Dy9cSnloqnGaj/zximPvD7gr6Ct/P9Kjx5BHtCX37/oqrW/7mSHJciCASl9SqZXl+PnkcP8XhGu+uETxNkZhAQM7FI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589328568;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5qX22g0/2MWI15bKHM/DkjswTBvZgc7Bt7vN6lp/vAI=; 
 b=P48esilDsU7n327OnL9a9adVDOKEtoDD+GwJa5DksxuIvjT6bStpNO5ZC1HSygmcNsQ21lRAjDFT6QH5KeVUIWJ8eHRNIwkLQe4wqhH84niK9T9Tvr0i868tlm4z2BWAKiKzTCXUys1n91zStSh+bGCbZB+XswbRLKsG1dVsE2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589328567074829.0461248543188;
 Tue, 12 May 2020 17:09:27 -0700 (PDT)
Message-ID: <158932856538.9905.5879207349699688975@45ef0f9c86ae>
In-Reply-To: <1589302245-893269-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [PATCH v4 00/15] Apply COR-filter to the block-stream permanently
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: andrey.shinkevich@virtuozzo.com
Date: Tue, 12 May 2020 17:09:27 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 19:44:32
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg5MzAyMjQ1LTg5MzI2OS0x
LWdpdC1zZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vCgoKCkhpLAoK
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKICBDQyAgICAgIGNyeXB0by9pdmdlbi1wbGFpbi5vCiAgQ0MgICAgICBjcnlwdG8vaXZn
ZW4tcGxhaW42NC5vCiAgQ0MgICAgICBjcnlwdG8vYWZzcGxpdC5vCi90bXAvcWVtdS10ZXN0L3Ny
Yy9ibG9jay9jb3B5LW9uLXJlYWQuYzoyOTozMjogZmF0YWwgZXJyb3I6IGJsb2NrL2NvcHktb24t
cmVhZC5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAiYmxvY2svY29weS1v
bi1yZWFkLmgiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpjb21waWxhdGlvbiB0
ZXJtaW5hdGVkLgotLS0KICBDQyAgICAgIGlvL2Rucy1yZXNvbHZlci5vCiAgQ0MgICAgICBpby9u
ZXQtbGlzdGVuZXIubwogIENDICAgICAgaW8vdGFzay5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9j
ay9zdHJlYW0uYzoyMjozMjogZmF0YWwgZXJyb3I6IGJsb2NrL2NvcHktb24tcmVhZC5oOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSAiYmxvY2svY29weS1vbi1yZWFkLmgiCiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgot
LS0KICBDQyAgICAgIGpvYi1xbXAubwogIENDICAgICAgb3MtcG9zaXgubwogIENDICAgICAgbW9u
aXRvci9tb25pdG9yLm8KbWFrZTogKioqIFtibG9jay9jb3B5LW9uLXJlYWQub10gRXJyb3IgMQpt
YWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW2Jsb2Nr
L3N0cmVhbS5vXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBG
aWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1vZHVsZT4KICAg
IHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PTU1ZTc3ZTBjZWEyOTRkNmQ4ZTRkZWMxYWY2NTAwMDVjJywgJy11JywgJzEwMDMnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTJ0dW15MzhsL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMTItMjAuMDcuMTMuNjE3
MzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NTVlNzdlMGNlYTI5NGQ2ZDhl
NGRlYzFhZjY1MDAwNWMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtMnR1bXkzOGwv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpy
ZWFsICAgIDJtMTMuMTE3cwp1c2VyICAgIDBtOC4yMzRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg5MzAyMjQ1LTg5MzI2OS0xLWdpdC1z
ZW5kLWVtYWlsLWFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

