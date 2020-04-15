Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA93C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5492076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 14:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5492076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOj3j-0003NF-9b
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 10:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOj2y-0002Oz-P5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOj2x-0006lj-Cw
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 10:29:48 -0400
Resent-Date: Wed, 15 Apr 2020 10:29:48 -0400
Resent-Message-Id: <E1jOj2x-0006lj-Cw@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOj2s-0006gq-Pu; Wed, 15 Apr 2020 10:29:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586960963; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hqf3lkzTHNdAbD6nQlxTJRM8ewp6EvnefUS1zSeDnVktLZaK5R+ZwqJPxjkfEa0OdjYbkReOiyo4rasXB0yvL4bsCi68o3EcnMjqIBX+1Fj4HgJWxYA/VKOpGpMDi7k1gG7WdLvsQQHEzr3Edcyb7QqhqDq3fO2tUEKosaDCX+E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586960963;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=TIHLJppVsG8MBeqQOcoyCf+QiNluKG9msgASLHFgaEE=; 
 b=AdqaM8uDbBWrkSTNunu1rVjX0HqN0fDBYfvTkSJAllFdoOBQK+/ut+4AWeK60uYqvCSXe7qoQ0AbHLeDvQmA4C2PFJN3fXRM7gte0R4R4H1h2Vj8CZTfXCevZGNGkTGdeZBxoJUW59ZNd5fod5eFNe1vYzRsr0iyPfR0+NDAVv0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586960961793958.0738871584068;
 Wed, 15 Apr 2020 07:29:21 -0700 (PDT)
In-Reply-To: <20200415130159.611361-1-its@irrelevant.dk>
Subject: Re: [PATCH v2 00/16] nvme: refactoring and cleanups
Message-ID: <158696095983.10493.2643884634295715253@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Wed, 15 Apr 2020 07:29:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: kwolf@redhat.com, beata.michalska@linaro.org, qemu-block@nongnu.org,
 k.jensen@samsung.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 kbusch@kernel.org, its@irrelevant.dk, javier.gonz@samsung.com,
 mlevitsk@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNTEzMDE1OS42MTEz
NjEtMS1pdHNAaXJyZWxldmFudC5kay8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYyIDAwLzE2XSBudm1lOiByZWZhY3RvcmluZyBh
bmQgY2xlYW51cHMKTWVzc2FnZS1pZDogMjAyMDA0MTUxMzAxNTkuNjExMzYxLTEtaXRzQGlycmVs
ZXZhbnQuZGsKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmEwZTgwOGQgbnZtZTogZmFjdG9yIG91dCBjb250
cm9sbGVyIGlkZW50aWZ5IHNldHVwCmVhMmQyOTUgbnZtZTogZmFjdG9yIG91dCBjbWIgc2V0dXAK
YzNjMWU1MSBudm1lOiBmYWN0b3Igb3V0IHBjaSBzZXR1cApiNGI2YzU1IG52bWU6IGZhY3RvciBv
dXQgbmFtZXNwYWNlIHNldHVwCjc5MjI5YWUgbnZtZTogYWRkIG5hbWVzcGFjZSBoZWxwZXJzCmM3
ZDBmMmIgbnZtZTogZmFjdG9yIG91dCBibG9jayBiYWNrZW5kIHNldHVwCjA4MDIyMTggbnZtZTog
ZmFjdG9yIG91dCBkZXZpY2Ugc3RhdGUgc2V0dXAKYjQwN2ZmYSBudm1lOiBmYWN0b3Igb3V0IHBy
b3BlcnR5L2NvbnN0cmFpbnQgY2hlY2tzCmE3YjRhYzAgbnZtZTogcmVtb3ZlIHJlZHVuZGFudCBj
bWJsb2MvY21ic3ogbWVtYmVycwpiZjhkNGNjIG52bWU6IGFkZCBtYXhfaW9xcGFpcnMgZGV2aWNl
IHBhcmFtZXRlcgplZWYxNjA3IG52bWU6IHJlZmFjdG9yIG52bWVfYWRkcl9yZWFkCmMwNjNiNzcg
bnZtZTogdXNlIGNvbnN0YW50cyBpbiBpZGVudGlmeQo5YzFhZDc1IG52bWU6IG1vdmUgZGV2aWNl
IHBhcmFtZXRlcnMgdG8gc2VwYXJhdGUgc3RydWN0CjcyMTI0Y2YgbnZtZTogcmVtb3ZlIHN1cGVy
Zmx1b3VzIGJyZWFrcwo4Y2JhZjllIG52bWU6IHJlbmFtZSB0cmFjZSBldmVudHMgdG8gcGNpX252
bWUKODI2YjBjYSBudm1lOiBmaXggcGNpIGRvb3JiZWxsIHNpemUgY2FsY3VsYXRpb24KCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29tbWl0IDgyNmIwY2FmMWJlZCAobnZtZTog
Zml4IHBjaSBkb29yYmVsbCBzaXplIGNhbGN1bGF0aW9uKQoyLzE2IENoZWNraW5nIGNvbW1pdCA4
Y2JhZjllOThlMDAgKG52bWU6IHJlbmFtZSB0cmFjZSBldmVudHMgdG8gcGNpX252bWUpCjMvMTYg
Q2hlY2tpbmcgY29tbWl0IDcyMTI0Y2ZjOGUzNSAobnZtZTogcmVtb3ZlIHN1cGVyZmx1b3VzIGJy
ZWFrcykKNC8xNiBDaGVja2luZyBjb21taXQgOWMxYWQ3NTgxN2U3IChudm1lOiBtb3ZlIGRldmlj
ZSBwYXJhbWV0ZXJzIHRvIHNlcGFyYXRlIHN0cnVjdCkKRVJST1I6IE1hY3JvcyB3aXRoIGNvbXBs
ZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRoZXNpcwojMTgyOiBGSUxFOiBo
dy9ibG9jay9udm1lLmg6NjoKKyNkZWZpbmUgREVGSU5FX05WTUVfUFJPUEVSVElFUyhfc3RhdGUs
IF9wcm9wcykgXAorICAgIERFRklORV9QUk9QX1NUUklORygic2VyaWFsIiwgX3N0YXRlLCBfcHJv
cHMuc2VyaWFsKSwgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigiY21iX3NpemVfbWIiLCBfc3Rh
dGUsIF9wcm9wcy5jbWJfc2l6ZV9tYiwgMCksIFwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoIm51
bV9xdWV1ZXMiLCBfc3RhdGUsIF9wcm9wcy5udW1fcXVldWVzLCA2NCkKCnRvdGFsOiAxIGVycm9y
cywgMCB3YXJuaW5ncywgMTgyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvMTYgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCjUvMTYgQ2hlY2tpbmcgY29tbWl0IGMwNjNiNzdlMjE4ZSAobnZtZTog
dXNlIGNvbnN0YW50cyBpbiBpZGVudGlmeSkKNi8xNiBDaGVja2luZyBjb21taXQgZWVmMTYwNzQ2
MzhlIChudm1lOiByZWZhY3RvciBudm1lX2FkZHJfcmVhZCkKNy8xNiBDaGVja2luZyBjb21taXQg
YmY4ZDRjYzY3NDU4IChudm1lOiBhZGQgbWF4X2lvcXBhaXJzIGRldmljZSBwYXJhbWV0ZXIpCjgv
MTYgQ2hlY2tpbmcgY29tbWl0IGE3YjRhYzBhOWNiZSAobnZtZTogcmVtb3ZlIHJlZHVuZGFudCBj
bWJsb2MvY21ic3ogbWVtYmVycykKOS8xNiBDaGVja2luZyBjb21taXQgYjQwN2ZmYWU4OWY4IChu
dm1lOiBmYWN0b3Igb3V0IHByb3BlcnR5L2NvbnN0cmFpbnQgY2hlY2tzKQoxMC8xNiBDaGVja2lu
ZyBjb21taXQgMDgwMjIxOGNhMThiIChudm1lOiBmYWN0b3Igb3V0IGRldmljZSBzdGF0ZSBzZXR1
cCkKMTEvMTYgQ2hlY2tpbmcgY29tbWl0IGM3ZDBmMmIxN2MwOCAobnZtZTogZmFjdG9yIG91dCBi
bG9jayBiYWNrZW5kIHNldHVwKQoxMi8xNiBDaGVja2luZyBjb21taXQgNzkyMjlhZWY1OTg4IChu
dm1lOiBhZGQgbmFtZXNwYWNlIGhlbHBlcnMpCjEzLzE2IENoZWNraW5nIGNvbW1pdCBiNGI2YzU1
Y2Q1YWYgKG52bWU6IGZhY3RvciBvdXQgbmFtZXNwYWNlIHNldHVwKQoxNC8xNiBDaGVja2luZyBj
b21taXQgYzNjMWU1MTIxZGI2IChudm1lOiBmYWN0b3Igb3V0IHBjaSBzZXR1cCkKMTUvMTYgQ2hl
Y2tpbmcgY29tbWl0IGVhMmQyOTUwN2MxZSAobnZtZTogZmFjdG9yIG91dCBjbWIgc2V0dXApCjE2
LzE2IENoZWNraW5nIGNvbW1pdCBhMGU4MDhkMmZjYTUgKG52bWU6IGZhY3RvciBvdXQgY29udHJv
bGxlciBpZGVudGlmeSBzZXR1cCkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAyMDA0MTUxMzAxNTkuNjExMzYxLTEtaXRzQGlycmVsZXZhbnQuZGsv
dGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0
b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5k
IHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

