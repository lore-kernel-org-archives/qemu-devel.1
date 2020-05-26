Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C42020776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 05:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C42020776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSTF-0005R2-CU
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 01:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdSSk-00050G-PN; Tue, 26 May 2020 01:49:18 -0400
Resent-Date: Tue, 26 May 2020 01:49:18 -0400
Resent-Message-Id: <E1jdSSk-00050G-PN@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdSSi-00057z-2w; Tue, 26 May 2020 01:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590472118; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=b4peTZWYbd+bIcwXbMuqQ+eQEmUtiIJgFYA9gO1gSDjoIZKlJKTHrYuh4J6M/qh8/gZBs7reoOUCylQ50RpyRzfJG4D5miezKK6Vfnn1RjOcFh6ALkYnmamLrTqaXIzChHt3l/BI0OQ8Q4gGSgFG54pLjJP1nL5FdUOFckBINGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590472118;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5oeFC2NUNXxSMUL6rg6xiYOqT/k6JrsTVmOROYu8K8I=; 
 b=FFrPqEGVx3alKmqWoi9DDiEjJVKmkZB4uJZGq3vMqhyaUHoHOVwrdQfDHdUs+NaCWw9Q0WBmv7hMioZ4/XOIEmbfpgpq3rl2T1avjFbZLlRyPkQxf3nCWLYdCw9SiWS+UJkBo9oLNBxCfZ3smpJW2XbhNDxDHckEe/+X2N392S0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590472116822720.1229900688425;
 Mon, 25 May 2020 22:48:36 -0700 (PDT)
Message-ID: <159047211532.7716.9183830140088606268@45ef0f9c86ae>
In-Reply-To: <cover.1590429901.git.berto@igalia.com>
Subject: Re: [PATCH v7 00/32] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 25 May 2020 22:48:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:17:51
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkwNDI5OTAxLmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9udm1lLm8K
ICBDQyAgICAgIGJsb2NrL25iZC5vCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVz
dGVyLmM6IEluIGZ1bmN0aW9uICdxY293Ml9nZXRfaG9zdF9vZmZzZXQnOgovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ3MzoxOTogZXJyb3I6ICdleHBlY3RlZF90eXBl
JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5
YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAgfSBlbHNlIGlmICh0eXBlICE9IGV4cGVjdGVkX3R5
cGUpIHsKICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cy
LWNsdXN0ZXIuYzo0NDk6MjU6IG5vdGU6ICdleHBlY3RlZF90eXBlJyB3YXMgZGVjbGFyZWQgaGVy
ZQogICAgIFFDb3cyU3ViY2x1c3RlclR5cGUgZXhwZWN0ZWRfdHlwZSwgdHlwZTsKICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIu
Yzo0NzU6MTk6IGVycm9yOiAnY2hlY2tfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVk
IGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAg
fSBlbHNlIGlmIChjaGVja19vZmZzZXQpIHsKICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDc6MTA6IG5vdGU6ICdjaGVja19vZmZz
ZXQnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgYm9vbCBjaGVja19vZmZzZXQ7CiAgICAgICAgICBe
Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDc2OjI5OiBlcnJvcjog
J2V4cGVjdGVkX29mZnNldCcgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0
aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdCiAgICAgICAgICAgICBleHBlY3RlZF9v
ZmZzZXQgKz0gcy0+Y2x1c3Rlcl9zaXplOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
L3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NDg6MTQ6IG5vdGU6ICdl
eHBlY3RlZF9vZmZzZXQnIHdhcyBkZWNsYXJlZCBoZXJlCiAgICAgdWludDY0X3QgZXhwZWN0ZWRf
b2Zmc2V0OwogICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBh
cyBlcnJvcnMKbWFrZTogKioqIFtibG9jay9xY293Mi1jbHVzdGVyLm9dIEVycm9yIDEKbWFrZTog
KioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGJsb2NrL3NoZWVw
ZG9nLm8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENh
bGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywg
J2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NTRjNmU0ZWY1ODBiNGU0MjkxMGFjMTQ1NzExYjllYzgn
LCAnLXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAn
LS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9
JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1df
RU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUv
cGF0Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12
JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16d3JjeTFueS9zcmMvZG9ja2VyLXNyYy4y
MDIwLTA1LTI2LTAxLjQ2LjIxLjkwODE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9z
NycsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJv
IGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51
dWlkPTU0YzZlNGVmNTgwYjRlNDI5MTBhYzE0NTcxMWI5ZWM4Cm1ha2VbMV06ICoqKiBbZG9ja2Vy
LXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hl
dy10ZXN0ZXItdG1wLXp3cmN5MW55L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVp
Y2tAY2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTE0LjY4NXMKdXNlciAgICAwbTQuMzg0cwoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292
ZXIuMTU5MDQyOTkwMS5naXQuYmVydG9AaWdhbGlhLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0Bj
ZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

