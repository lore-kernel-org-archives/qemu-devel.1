Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:38:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2242080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2242080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzvF-0003Vs-4o
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMzuA-0002bl-Re; Mon, 28 Sep 2020 16:37:52 -0400
Resent-Date: Mon, 28 Sep 2020 16:37:50 -0400
Resent-Message-Id: <E1kMzuA-0002bl-Re@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMzu4-0002mu-Oc; Mon, 28 Sep 2020 16:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601325446; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LINm2rVRvZF5tpvvRepMbkyNLLSAurXdCLQpDoON+uRqdRETntbchGIbowttf+okHWlyZje0fzvTQoC73Nqs2MOKdZP9+qoAZuUhQfyQqOctpDZrEgVjEFRgMZOHV0k0bbamZxRTHhd8yueIe48FWXq6nks5In21qwQQd2FpV/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601325446;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=u0NUKXyyOEqc+NajKM0H9QRQGrgF68x1kfEc0KCimgI=; 
 b=Ny0J+jaMEkqkJcDNTG9wXUNfWI1+EjgbByVNkBSFl9ocJWtdNsUf90Cwjz4Ycam8vF7EWigtBEizxLNFMKCuiQfSeONxSnQ9CZI0Bc5QoSwmrZ0dqfdmWHZfx0vBs3Ji0ZdScM+hYun3aIQ2okTleqDcswI+GMp5Lp9Y1pekbG0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601325445158311.5253813429715;
 Mon, 28 Sep 2020 13:37:25 -0700 (PDT)
Subject: Re: [PATCH v9 0/9] Apply COR-filter to the block-stream permanently
Message-ID: <160132544320.11341.10317477877027429340@66eaa9a8a123>
In-Reply-To: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Mon, 28 Sep 2020 13:37:25 -0700 (PDT)
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
VGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQ
bGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJ
ZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBp
dApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRv
Y2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1
aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKQyBsaW5rZXIgZm9yIHRoZSBob3N0IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhv
c3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODZfNjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4u
L3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklORzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMg
bm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNvbXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlz
dCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhv
bjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVz
aW5nIGNvbmZpZ3VyYXRpb24KLS0tCkNvbXBpbGluZyBDIG9iamVjdCBsaWJibG9jay5mYS5wL2Js
b2NrX2RtZy1iejIuYy5vCkNvbXBpbGluZyBDIG9iamVjdCBsaWJibG9jay5mYS5wL2Jsb2NrX2Ft
ZW5kLmMubwpDb21waWxpbmcgQyBvYmplY3QgbGliYmxvY2suZmEucC9ibG9ja19xY293Mi1zbmFw
c2hvdC5jLm8KLi4vc3JjL2Jsb2NrL2NvcHktb24tcmVhZC5jOjI5OjMyOiBmYXRhbCBlcnJvcjog
YmxvY2svY29weS1vbi1yZWFkLmg6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRl
ICJibG9jay9jb3B5LW9uLXJlYWQuaCIKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCi0tLQpDb21waWxpbmcgQyBvYmplY3QgbGliYmxvY2su
ZmEucC9ibG9ja190aHJvdHRsZS1ncm91cHMuYy5vCkNvbXBpbGluZyBDIG9iamVjdCBsaWJibG9j
ay5mYS5wL2Jsb2NrX2FjY291bnRpbmcuYy5vCkNvbXBpbGluZyBDIG9iamVjdCBsaWJibG9jay5m
YS5wL2Jsb2NrX25iZC5jLm8KbWFrZTogKioqIFtsaWJibG9jay5mYS5wL2Jsb2NrX2NvcHktb24t
cmVhZC5jLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9j
a2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxl
ZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9y
OiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFi
ZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD1iMmRjYjg4Yzg0ZmE0MzA5OTE2MDQ1MTNhOTBj
ODQzNScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5l
ZCcsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9Jywg
Jy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5W
PTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdics
ICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtOHp2cDdpejIvc3JjL2RvY2tlci1zcmMuMjAy
MC0wOS0yOC0xNi4zMy41OC4xNTc3NTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3
JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8g
ZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9YjJkY2I4OGM4NGZhNDMwOTkxNjA0NTEzYTkwYzg0MzUKbWFrZVsxXTogKioqIFtkb2NrZXIt
cnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3
LXRlc3Rlci10bXAtOHp2cDdpejIvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlj
a0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDNtMjQuNTAzcwp1c2VyICAgIDBtMTguODE2cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTYw
MTI5ODAwMS03NzQwOTYtMS1naXQtc2VuZC1lbWFpbC1hbmRyZXkuc2hpbmtldmljaEB2aXJ0dW96
em8uY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=

