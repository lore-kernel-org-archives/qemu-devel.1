Received: from eggs.gnu.org ([209.51.188.92]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEAFJ-0007u6-3Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEAFH-0008RM-IB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:21 -0400
Resent-Message-Id: <E1hEAFH-0008RM-IB@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEAFH-0008FP-8f
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:19 -0400
Message-ID: <155489122647.12882.1998091707837473765@76452e4e88f2>
In-Reply-To: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 10 Apr 2019 03:13:47 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yury-kotov@yandex-team.ru
Cc: fam@euphon.net, dgilbert@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMDA5MjY1Mi4yMjYx
Ni0xLXl1cnkta290b3ZAeWFuZGV4LXRlYW0ucnUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKICBDQyAgICAgIG1pZ3JhdGlvbi94YnpybGUubwogIENDICAgICAgbWlncmF0aW9uL3Bvc3Rj
b3B5LXJhbS5vCi90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vZmQuYzogSW4gZnVuY3Rpb24g
J2ZkX3N0YXJ0X291dGdvaW5nX21pZ3JhdGlvbic6Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRp
b24vZmQuYzo0MDoxNDogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdx
ZW11X2R1cCc7IGRpZCB5b3UgbWVhbiAncWVtdV9oZXhkdW1wJz8gWy1XZXJyb3I9aW1wbGljaXQt
ZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgZHVwX2ZkID0gcWVtdV9kdXAoZmQpOwogICAgICAg
ICAgICAgIF5+fn5+fn5+CiAgICAgICAgICAgICAgcWVtdV9oZXhkdW1wCi90bXAvcWVtdS10ZXN0
L3NyYy9taWdyYXRpb24vZmQuYzo0MDoxNDogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRp
b24gb2YgJ3FlbXVfZHVwJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2MxOiBhbGwgd2Fybmlu
Z3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMv
cnVsZXMubWFrOjY5OiBtaWdyYXRpb24vZmQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTAwOTI2NTIuMjI2MTYtMS15dXJ5LWtvdG92QHlh
bmRleC10ZWFtLnJ1L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==
