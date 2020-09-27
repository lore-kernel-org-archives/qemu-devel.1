Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8407C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40ABB23718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 15:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40ABB23718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMYqW-0006uF-EM
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 11:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMYpy-0006Tn-Jd
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:43:43 -0400
Resent-Date: Sun, 27 Sep 2020 11:43:42 -0400
Resent-Message-Id: <E1kMYpy-0006Tn-Jd@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMYpv-0005V2-Es
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 11:43:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601221411; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dEjGkNUz7qN+YQTXLx1x7Vtpj9EXn16YmGoiemyQk3CSPSOSXKDN1xHeW1UU9kZZDzSpri424mCP+DG6KTPN2A3RYbZ9VVjrfRoyXAaCNp85+xO8FKvUyObG/7OyZBL6eq/o0fB/tXRD1eibyG9zPnckQeXKUPHNuWjviYuP3Q8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601221411;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rRlAu1EvvZnYs3DcK3Mm1y5ILu3xSj8tcdshUFc9oIA=; 
 b=cr13K8WgMr7n/8MA4jlqUMeYjInKqmX/UQBdr7sFPFUCIUJ/rRwUd2ynIHnZ4EBSC0C0VfiLTy6BuH6ZFnRG9RUu7Q0J+jNzRQcmFvRHelLVP73DxT2lFgJ6qISAL/coDvkZzKZvTuDbWC6R3Ca3snIrtmrm0G9Kpu/eE/dbJCU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601221410121647.6309528357335;
 Sun, 27 Sep 2020 08:43:30 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Add physical display dimensions to spice/virtio-gpu
Message-ID: <160122140872.10465.15028305606546079004@66eaa9a8a123>
In-Reply-To: <20200927145751.365446-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Sun, 27 Sep 2020 08:43:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 11:43:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: spice-devel@lists.freedesktop.org, mst@redhat.com, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNzE0NTc1MS4zNjU0
NDYtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIg
Zm9yIHRoZSBob3N0IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUg
ZmFtaWx5OiB4ODZfNjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWls
ZDoxMDogV0FSTklORzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9y
IGZvcndhcmRzIGNvbXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVs
ZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAo
L3Vzci9iaW4vcHl0aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRp
b24KLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAxOApzb2NrZXRfYWNjZXB0IGZhaWxlZDog
UmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUKKioKRVJST1I6Li4vc3JjL3Rlc3RzL3F0
ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3Nl
cnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKLi4vc3JjL3Rlc3Rz
L3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVN
VSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJP
UiBxdGVzdC14ODZfNjQ6IGJpb3MtdGFibGVzLXRlc3QgLSBCYWlsIG91dCEgRVJST1I6Li4vc3Jj
L3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNo
YWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKbWFr
ZTogKioqIFtydW4tdGVzdC0xMzhdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmlu
aXNoZWQgam9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDE5CiAgVEVTVCAgICBpb3Rl
c3QtcWNvdzI6IDAyMAotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBj
bWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4n
LCAnZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD1mNmZlNjg3NzlkNzA0ZmQ4YTY4MjA1ZTM5NWNlMzA0ZicsICctdScsICcxMDAxJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctZScsICdUQVJHRVRfTElTVD0n
LCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQn
LCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0v
dmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC16bmowMjVmaC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA5LTI3LTExLjI2LjE4Ljk0MjQ6L3Zh
ci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0
ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZp
bHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWY2ZmU2ODc3OWQ3MDRmZDhhNjgyMDVl
Mzk1Y2UzMDRmCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2
aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXpuajAyNWZoL3NyYycK
bWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAg
ICAxN205LjM5OHMKdXNlciAgICAwbTIwLjAxNXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTI3MTQ1NzUxLjM2NTQ0Ni0xLW1hcmNh
bmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

