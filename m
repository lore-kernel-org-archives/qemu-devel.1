Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BAC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42696205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42696205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieObz-0000X1-BU
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 14:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ieObJ-000072-UD
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ieObI-0007ug-Cs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:21:45 -0500
Resent-Date: Mon, 09 Dec 2019 14:21:45 -0500
Resent-Message-Id: <E1ieObI-0007ug-Cs@eggs.gnu.org>
Received: from sender4-of-o50.zoho.com ([136.143.188.50]:21082)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ieObH-0007sO-DG
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 14:21:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575919297; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TYzRvkcGyDD2tUs1gqvWaHF8mMfsQ0vG4ta1N+UAs6I/8eG+NulMvzX6mKzzFfJUe6MqRqFBZ+cGh5XNJ6SEGNkrUn7x2vLkhyQo6P5GDEB95UPyQGw/BL9PmbAMOCbvHxd4BYegiPFJoWJDf21ytQPPl58ZxS2UV0DCxZFAeh8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575919297;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gQBVG2A655uiX485itPXFcS2V6fnsGtTAPRaf22q02k=; 
 b=bfYjqlCpoIP/JkxO3vZDj3ViZBu1JTZz5ak321QpC0yqWpONfapzsnSjR40aJgnur/g/cokICqVhMUJKF8TmLsl87qPw5RH0FmtJxhk1B3n9a6yddBfEYBfX4rwcShd25xTzH/8UQszQrmyIRtwtgOqpQVTx8d0oJ/poxqk35Qk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575919296631836.7507798722489;
 Mon, 9 Dec 2019 11:21:36 -0800 (PST)
In-Reply-To: <20191209110759.35227-1-stefanha@redhat.com>
Subject: Re: [PATCH] virtio-fs: fix MSI-X nvectors calculation
Message-ID: <157591929547.7675.6748980312331616134@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Mon, 9 Dec 2019 11:21:36 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.50
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
Cc: mst@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTIwOTExMDc1OS4zNTIy
Ny0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBO
RVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBK
PTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3VibW9kdWxlICdkdGMnICho
dHRwczovL2dpdC5xZW11Lm9yZy9naXQvZHRjLmdpdCkgcmVnaXN0ZXJlZCBmb3IgcGF0aCAnZHRj
JwpDbG9uaW5nIGludG8gJ2R0YycuLi4KcmVtb3RlOiBDb3VudGluZyBvYmplY3RzOiA1MjgwLCBk
b25lLiAgICAgICAgCmVycm9yOiBSUEMgZmFpbGVkOyByZXN1bHQ9MTgsIEhUVFAgY29kZSA9IDIw
MApmYXRhbDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkKZmF0YWw6IHByb3Rv
Y29sIGVycm9yOiBiYWQgcGFjayBoZWFkZXIKQ2xvbmUgb2YgJ2h0dHBzOi8vZ2l0LnFlbXUub3Jn
L2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1vZHVsZSBwYXRoICdkdGMnIGZhaWxlZApmYWlsZWQgdG8g
dXBkYXRlIHN1Ym1vZHVsZSBkdGMKU3VibW9kdWxlICdkdGMnIChodHRwczovL2dpdC5xZW11Lm9y
Zy9naXQvZHRjLmdpdCkgdW5yZWdpc3RlcmVkIGZvciBwYXRoICdkdGMnCm1ha2VbMV06ICoqKiBb
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXgzcnBsODk5L3NyYy9kb2NrZXItc3JjLjIwMTkt
MTItMDktMTQuMTYuMTIuMTU5NjVdIEVycm9yIDEKbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rvcnkg
YC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC14M3JwbDg5OS9zcmMnCm1ha2U6ICoqKiBbZG9j
a2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwgICAgNW0yNC4wOTBzCnVz
ZXIgICAgMG0yLjU0NHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRj
aGV3Lm9yZy9sb2dzLzIwMTkxMjA5MTEwNzU5LjM1MjI3LTEtc3RlZmFuaGFAcmVkaGF0LmNvbS90
ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


