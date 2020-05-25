Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A96A02071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A02071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdCx6-0002sP-QX
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdCwO-0002Fy-So; Mon, 25 May 2020 09:14:52 -0400
Resent-Date: Mon, 25 May 2020 09:14:52 -0400
Resent-Message-Id: <E1jdCwO-0002Fy-So@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdCwM-0003Zt-QE; Mon, 25 May 2020 09:14:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590412467; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cQn666l+/rOs8rMSVemdNT+zicCV/e0zk4VpK2ltQd18vNEPP0LlgnXRkDAgDnFsyniBxRLsKHbXNBEAsRoimbuNUH21XBzYbgF1cRThjD+K5M38RI1i7BQDG4K2UybRQv5QZw5K/I8o3VEbZL3XHI8pv8naCLRc51PvJ4hXdY0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590412467;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=K4GOrPvo7VzYygt5v6oqI995MLvPL4BmedPsJD+5Fgk=; 
 b=I80Wxp+sytSQFDa4yieEPRLPrxax7uVJsDY0DzTk/a3P54JG/fhY9BcWMG96MtajkTiI76zTZKD8MjnBZy2FHgjUw7EDCMzqzuA8FbG2TeZDhSlUjInjtvez33P34KsN98Jty8YuDLTUJobM3aHamqiQDLh32obPMLUjp0+FS/w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590412466104984.6108148138353;
 Mon, 25 May 2020 06:14:26 -0700 (PDT)
Message-ID: <159041246428.2646.2773751210145691653@45ef0f9c86ae>
In-Reply-To: <20200525100801.13859-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 0/5] coroutines: generate wrapper code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 25 May 2020 06:14:26 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 09:14:48
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNTEwMDgwMS4xMzg1
OS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpibG9jay92aGR4LWxv
Zy5vOiBJbiBmdW5jdGlvbiBgdmhkeF9sb2dfd3JpdGVfYW5kX2ZsdXNoJzoKL3RtcC9xZW11LXRl
c3Qvc3JjL2Jsb2NrL3ZoZHgtbG9nLmM6MTA0OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRy
dl9mbHVzaCcKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3ZoZHgtbG9nLmM6MTA2MTogdW5kZWZp
bmVkIHJlZmVyZW5jZSB0byBgYmRydl9mbHVzaCcKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5l
ZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbcWVtdS1uYmRdIEVycm9yIDEKbWFrZTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBMSU5LICAgIHZob3N0LXVzZXItaW5wdXQK
YmxvY2subzogSW4gZnVuY3Rpb24gYGJkcnZfaW52YWxpZGF0ZV9jYWNoZV9hbGwnOgotLS0KYmxv
Y2svdmhkeC1sb2cubzogSW4gZnVuY3Rpb24gYHZoZHhfbG9nX3dyaXRlX2FuZF9mbHVzaCc6Ci90
bXAvcWVtdS10ZXN0L3NyYy9ibG9jay92aGR4LWxvZy5jOjEwNDk6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGJkcnZfZmx1c2gnCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay92aGR4LWxvZy5jOjEw
NjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfZmx1c2gnCmNvbGxlY3QyOiBlcnJvcjog
bGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlOiAqKiogW3FlbXUtc3RvcmFnZS1kYWVtb25d
IEVycm9yIDEKYmxvY2subzogSW4gZnVuY3Rpb24gYGJkcnZfaW52YWxpZGF0ZV9jYWNoZV9hbGwn
OgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2suYzo1Njk3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBiZHJ2X2ludmFsaWRhdGVfY2FjaGUnCmJsb2NrLm86IEluIGZ1bmN0aW9uIGBiZHJ2X2Nsb3Nl
JzoKLS0tCmJsb2NrL3ZoZHgtbG9nLm86IEluIGZ1bmN0aW9uIGB2aGR4X2xvZ193cml0ZV9hbmRf
Zmx1c2gnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDQ5OiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhk
eC1sb2cuYzoxMDYxOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwpjb2xsZWN0
MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtxZW11LWlvXSBF
cnJvciAxCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9obXAtY29tbWFuZHMuaAogIEdFTiAgICAg
eDg2XzY0LXNvZnRtbXUvaG1wLWNvbW1hbmRzLWluZm8uaAogIEdFTiAgICAgeDg2XzY0LXNvZnRt
bXUvY29uZmlnLWRldmljZXMuaAotLS0KLi4vYmxvY2svdmhkeC1sb2cubzogSW4gZnVuY3Rpb24g
YHZoZHhfbG9nX3dyaXRlX2FuZF9mbHVzaCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay92aGR4
LWxvZy5jOjEwNDk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfZmx1c2gnCi90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay92aGR4LWxvZy5jOjEwNjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YGJkcnZfZmx1c2gnCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwpt
YWtlWzFdOiAqKiogW3FlbXUtc3lzdGVtLXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogW3g4Nl82
NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgouLi9ibG9ja2Rldi5vOiBJbiBmdW5jdGlvbiBgZXh0ZXJu
YWxfc25hcHNob3RfcHJlcGFyZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9ja2Rldi5jOjE0ODA6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfZmx1c2gnCi4uL2Jsb2NrLm86IEluIGZ1bmN0
aW9uIGBiZHJ2X2ludmFsaWRhdGVfY2FjaGVfYWxsJzoKLS0tCi4uL2Jsb2NrL3ZoZHgtbG9nLm86
IEluIGZ1bmN0aW9uIGB2aGR4X2xvZ193cml0ZV9hbmRfZmx1c2gnOgovdG1wL3FlbXUtdGVzdC9z
cmMvYmxvY2svdmhkeC1sb2cuYzoxMDQ5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2Zs
dXNoJwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDYxOiB1bmRlZmluZWQg
cmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEg
ZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtxZW11LXN5c3RlbS1hYXJjaDY0XSBFcnJvciAxCm1h
a2U6ICoqKiBbYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVj
ZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2
NjQsIGluIDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVk
UHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6
IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29t
LnFlbXUuaW5zdGFuY2UudXVpZD1jYjM4NTMzZGYxMmE0ODM1OTVkZGYwODRlYjBhOTQ5MycsICct
dScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJt
JywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAn
LWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9
MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRj
aGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAn
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWdhX2psODdkL3NyYy9kb2NrZXItc3JjLjIwMjAt
MDUtMjUtMDkuMTEuMDMuMTgzOTE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PWNiMzg1MzNkZjEyYTQ4MzU5NWRkZjA4NGViMGE5NDkzCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLWdhX2psODdkL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tA
Y2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTIxLjI0N3MKdXNlciAgICAwbTguNDczcwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1
MjUxMDA4MDEuMTM4NTktMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXIt
cXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

