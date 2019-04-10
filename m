Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE9DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E562083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E562083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEAG6-0008DX-Jf
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 06:15:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEAFJ-0007u6-3Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEAFH-0008RM-IB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:21 -0400
Resent-Date: Wed, 10 Apr 2019 06:14:21 -0400
Resent-Message-Id: <E1hEAFH-0008RM-IB@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEAFH-0008FP-8f
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1554891228; cv=none; d=zoho.com; s=zohoarc; 
	b=UMA2oddMENrc01PasPaadlLEZKbPXgiK9IKp1ZfMr8gOMepFcfurwaGYH2d0tYr+BijgPpnzLB1EZpNuLZvkVZWMpVdubz2f+UFk1NWGil9gFGv7DNuB8sdF75yzYi2DCNqvVgZ6rjkRM4+GM9HWDfJrqUxCT4MpFZUL4PHIXE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1554891228;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=MQFLhhOjirXJmRo+45PNqAObYRfX7QNvQX+QtoEDo8U=; 
	b=ZwinQkJUD4rfg0qtcRE0i8emeqDB2pS15UxL5uSizEpWR4WybDYX5mCgajqHQ73JgfJmslEdHb/EzwCiRXaMcnQUiU3e14f6crcD2yVKX5JA7hk/o5F6p/N1r1dSl50RqcBa618dhWeGr7RVL168HVIiKjj2VpAdzLV77cLFosk=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1554891227960492.78858427280545;
	Wed, 10 Apr 2019 03:13:47 -0700 (PDT)
Message-ID: <155489122647.12882.1998091707837473765@76452e4e88f2>
In-Reply-To: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yury-kotov@yandex-team.ru
Date: Wed, 10 Apr 2019 03:13:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, dgilbert@redhat.com,
	yc-core@yandex-team.ru, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410101347.uhvf6XHtVuw-xMbZ7sLoS9JVzVrDD6ohYnt-Qvhxu1o@z>

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


