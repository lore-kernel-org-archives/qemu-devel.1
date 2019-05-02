Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E0DC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C6EF2075E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 08:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6EF2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47612 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM7Kh-0003Nb-Uj
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 04:44:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM78h-0001Hz-Tq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hM78f-0001c3-NH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:22 -0400
Resent-Date: Thu, 02 May 2019 04:32:22 -0400
Resent-Message-Id: <E1hM78f-0001c3-NH@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hM78d-00011L-MV
	for qemu-devel@nongnu.org; Thu, 02 May 2019 04:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556785857; cv=none; d=zoho.com; s=zohoarc; 
	b=Za0vU+t5i4e8WDwYIbwTma8Vpj1f4pbrv8JzA2C9BmditiUvig36xBVEQZWmxbBRU7Xl8ADd+/+9CMxIj+N13qFQq2vOINfBqExPyI8GqSecLtDZMVRBv11c1XrvfLxT8pfF1nar318SVktNiiIV6vFQuWQgzYF7C3raei/di2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556785857;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=Opg2r1dzBW971eTM7WZgugWRmw3NFcFeGQBLsUBHAr8=; 
	b=cqIDAaHZ7Sks0W0hs9D7eulBYJ1Cwuh/jdDEQ/G2WsLA3ptbXMy99f1rDeU03pW6JbOBUTFBlXq1V7dcv02LUFex7ssoJyb7aagXVBKpEoI5z1I4GXXktRbFMe03SPIu4sY9mfCH84r3EnLfm+XXB3ZM8sMlIVgtNNGQgkPu7+8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556785855324709.5455113681036;
	Thu, 2 May 2019 01:30:55 -0700 (PDT)
In-Reply-To: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Message-ID: <155678585404.10667.17833237501293004416@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: wangjie88@huawei.com
Date: Thu, 2 May 2019 01:30:55 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
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
Cc: fam@euphon.net, mst@redhat.com, eric.fangyi@huawei.com,
	qemu-devel@nongnu.org, wangjie88@huawei.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502083055.VGDQKoe_V1TMhBMbj-Y3bXMrQN_eJrPtVz8L_CbaVlE@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU2NjA1NzczLTQyMDE5LTEt
Z2l0LXNlbmQtZW1haWwtd2FuZ2ppZTg4QGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMg
ZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRo
ZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERv
Y2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9
PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVz
dC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKICBDT1BZICAgIFJVTk5FUgogICAgUlVOIHRlc3QtbWluZ3cgaW4gcWVtdTpmZWRv
cmEgCmNvbnRhaW5lcl9saW51eC5nbzoyNDc6IHN0YXJ0aW5nIGNvbnRhaW5lciBwcm9jZXNzIGNh
dXNlZCAicHJvY2Vzc19saW51eC5nbzoyNTg6IGFwcGx5aW5nIGNncm91cCBjb25maWd1cmF0aW9u
IGZvciBwcm9jZXNzIGNhdXNlZCBcIlRoZSBtYXhpbXVtIG51bWJlciBvZiBhY3RpdmUgY29ubmVj
dGlvbnMgZm9yIFVJRCAwIGhhcyBiZWVuIHJlYWNoZWRcIiIKL3Vzci9iaW4vZG9ja2VyLWN1cnJl
bnQ6IEVycm9yIHJlc3BvbnNlIGZyb20gZGFlbW9uOiBvY2kgcnVudGltZSBlcnJvcjogVGhlIG1h
eGltdW0gbnVtYmVyIG9mIGFjdGl2ZSBjb25uZWN0aW9ucyBmb3IgVUlEIDAgaGFzIGJlZW4gcmVh
Y2hlZC4KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMv
ZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjE1LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFp
bigpKQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTU1NjYwNTc3My00MjAxOS0xLWdpdC1zZW5kLWVtYWlsLXdhbmdqaWU4OEBodWF3ZWkuY29t
L3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


