Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33C5206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33C5206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7blg-0006Ex-1T
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7bl3-0005jr-WE; Mon, 17 Aug 2020 05:48:50 -0400
Resent-Date: Mon, 17 Aug 2020 05:48:49 -0400
Resent-Message-Id: <E1k7bl3-0005jr-WE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7bl2-0003xO-4g; Mon, 17 Aug 2020 05:48:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597657710; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jRusEidMGENMpGDYK3xdxbM0JzsOPJKlyVYRnvLUqN0dPbzVfoBDyrcJxg/peQAUrkfb9kTE6uVA11KFQtCWZQwxd+bLRBwK8mvnZX2tbJ8IqxtqElYdb6dMUTOTOqYLLCT/DzzJdSdWXtT6FZfBTfcEFVJzLoN/fnyZEdCUXnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597657710;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7Jy7b6nJVR7zep514TT9RTNQOyKu3ZlkbWvSEBKmD38=; 
 b=c/YvLLGg5H3mAlLewI739wOxdaZFrN/Q8Vn5i4Ms5ttwZDQX/FXHvsXkpqew8eEU8OurYxAFr/gCg4u9bhksw2uN1NAW8ge6w/XNDyYNx/Qg5HAqfXK5mcDh2iCfMcJZGMWmRNH4vc+nvH2Xp4rR/A3v1wSByCRgK6xdNzsoMZU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597657706800529.4003384209041;
 Mon, 17 Aug 2020 02:48:26 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] preallocate filter
Message-ID: <159765770605.28013.16393052332587484060@66eaa9a8a123>
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 17 Aug 2020 02:48:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:45:58
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxNzA5MTU1My4yODMx
NTUtMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVz
dGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIg
aW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3
IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19F
TlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJs
b2NrL252bWUubwogIENDICAgICAgYmxvY2svbmJkLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2Nr
L2ZpbGUtcG9zaXguYzogSW4gZnVuY3Rpb24gJ2lzX2Z1c2UnOgovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svZmlsZS1wb3NpeC5jOjMzNDozNTogZXJyb3I6ICdGVVNFX1NVUEVSX01BR0lDJyB1bmRl
Y2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbikKICAgICBpZiAocmV0ID09IDAgJiYg
YnVmLmZfdHlwZSA9PSBGVVNFX1NVUEVSX01BR0lDKSB7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svZmlsZS1wb3NpeC5jOjMzNDoz
NTogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNl
IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KICBDQyAgICAgIGJsb2NrL3NoZWVwZG9n
Lm8KbWFrZTogKioqIFtibG9jay9maWxlLXBvc2l4Lm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRp
bmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxh
c3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9k
dWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnBy
b2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2Vy
JywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZWU3ZWJlNjFlNWZk
NGEwMThiYmIyYTE2ZWM0YTVhNTQnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdz
ZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAn
RVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAn
REVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9j
Y2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTov
dmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbzcz
YXA3NG4vc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xNy0wNS40Ni4zOC4yNTEyOTovdmFyL3RtcC9x
ZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVp
Y2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZWU3ZWJlNjFlNWZkNGEwMThiYmIyYTE2ZWM0YTVh
NTQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbzczYXA3NG4vc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDFtNDku
MTQ2cwp1c2VyICAgIDBtOC41MDZzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxNzA5MTU1My4yODMxNTUtMS12c2VtZW50c292QHZp
cnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

