Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDCCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C4D206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 09:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C4D206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7bj6-0005D0-1E
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 05:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7biQ-0004gu-8R; Mon, 17 Aug 2020 05:46:06 -0400
Resent-Date: Mon, 17 Aug 2020 05:46:06 -0400
Resent-Message-Id: <E1k7biQ-0004gu-8R@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k7biM-0003mc-57; Mon, 17 Aug 2020 05:46:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597657538; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kSrdw9N3zPPRv0KXgu3o3KhLTP/Bv1tECAqqwdadbnfc5Ny55mgJQvIOowXtL0M1vUTwzcy5riQ7a5aH+RVzznTAaiKfJIXBiGRggFn3Z+Sa+dE59E1ADNhvE51bruZTCfA8G+Ncx0VS3F3PrH9f1JRwTuC/GT8XKTH5a75XIV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597657538;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DmhLc0RZuHqoULT0H71+cVBkNVQ0Ytyq2zbJ51GNqx4=; 
 b=KHkvycY9fq4r5QffULa7gZn0MAq73wAA9ALXNXyGuPhB2FNIvpdH06dbKneyPhRCgdMhwh+HTCWh5XlchgTjorszq48YzpWHS4iMkwc4+e3k33Br4zvFGR+tJBA+YMKP4I9C07TNWOuFOa+sAB2Azf3ajGve/ea+CYF/m3jThfU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597657533828714.4502854783645;
 Mon, 17 Aug 2020 02:45:33 -0700 (PDT)
Subject: Re: [PATCH v3 00/12] preallocate filter
Message-ID: <159765753240.28013.15878373545034383880@66eaa9a8a123>
In-Reply-To: <20200817091553.283155-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Mon, 17 Aug 2020 02:45:33 -0700 (PDT)
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
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBk
b2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBMSU5L
ICAgIHFlbXUtZWRpZC5leGUKL3Vzci9saWIvZ2NjL3g4Nl82NC13NjQtbWluZ3czMi85LjIuMS8u
Li8uLi8uLi8uLi94ODZfNjQtdzY0LW1pbmd3MzIvYmluL2xkOiBibG9jay9xY293Mi5vOiBpbiBm
dW5jdGlvbiBgcWNvdzJfdnpfaW5zZXJ0X3ByZWFsbG9jX2ZpbHRlcic6Ci90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay9xY293Mi5jOjE4Nzg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfaXNf
ZmlsZV9vbl9mdXNlJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMK
bWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjEyNDogcWVtdS1pby5leGVd
IEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBHRU4g
ICAgIHg4Nl82NC1zb2Z0bW11L2htcC1jb21tYW5kcy5oCiAgR0VOICAgICB4ODZfNjQtc29mdG1t
dS9obXAtY29tbWFuZHMtaW5mby5oCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3L2Fy
bS94bG54LXp5bnFtcC5vCi91c3IvbGliL2djYy94ODZfNjQtdzY0LW1pbmd3MzIvOS4yLjEvLi4v
Li4vLi4vLi4veDg2XzY0LXc2NC1taW5ndzMyL2Jpbi9sZDogLi4vYmxvY2svcWNvdzIubzogaW4g
ZnVuY3Rpb24gYHFjb3cyX3Z6X2luc2VydF9wcmVhbGxvY19maWx0ZXInOgovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzIuYzoxODc4OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2lz
X2ZpbGVfb25fZnVzZScKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVz
Cm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjE5OiBxZW11LXN5c3RlbS14ODZfNjR3LmV4ZV0gRXJy
b3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjUyNzogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAy
CiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL3hsbngtemN1MTAyLm8KICBDQyAgICAg
IGFhcmNoNjQtc29mdG1tdS9ody9hcm0veGxueC12ZXJzYWwubwogIENDICAgICAgYWFyY2g2NC1z
b2Z0bW11L2h3L2FybS94bG54LXZlcnNhbC12aXJ0Lm8KLS0tCiAgTElOSyAgICBhYXJjaDY0LXNv
ZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2NHcuZXhlCi91c3IvbGliL2djYy94ODZfNjQtdzY0LW1p
bmd3MzIvOS4yLjEvLi4vLi4vLi4vLi4veDg2XzY0LXc2NC1taW5ndzMyL2Jpbi9sZDogLi4vYmxv
Y2svcWNvdzIubzogaW4gZnVuY3Rpb24gYHFjb3cyX3Z6X2luc2VydF9wcmVhbGxvY19maWx0ZXIn
OgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIuYzoxODc4OiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBiZHJ2X2lzX2ZpbGVfb25fZnVzZScKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5l
ZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjE5OiBxZW11LXN5c3RlbS1h
YXJjaDY0dy5leGVdIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29m
dG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgogICAg
c3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2Rl
LCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAn
LW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
NDZjOTM5YmZjNDI4NDhjNmJmOThhY2MzMmU3NjlmYjAnLCAnLXUnLCAnMTAwMycsICctLXNlY3Vy
aXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElT
VD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9
MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElS
PS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2Nr
ZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC12OXQ4MXc5eS9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTE3LTA1LjQwLjUwLjE2MDI4
Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11L2ZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTQ2YzkzOWJmYzQyODQ4YzZiZjk4
YWNjMzJlNzY5ZmIwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXY5dDgxdzl5L3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFs
ICAgIDRtNDMuMjE3cwp1c2VyICAgIDBtOC45NDVzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDgxNzA5MTU1My4yODMxNTUtMS12c2Vt
ZW50c292QHZpcnR1b3p6by5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

