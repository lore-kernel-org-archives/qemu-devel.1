Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF4AC2BA18
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 04:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB51420719
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 04:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB51420719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLJa7-0000SZ-2N
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 00:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLJZY-0008UY-7P
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 00:41:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLJZW-0007sJ-Kt
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 00:41:19 -0400
Resent-Date: Mon, 06 Apr 2020 00:41:19 -0400
Resent-Message-Id: <E1jLJZW-0007sJ-Kt@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLJZW-0007qm-DY
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 00:41:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586148073; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=T/fKre9mgEUDEMUw81xg3ukVO/nqFY99xmrUzh0uxz7V0ogZe+JOXMWadcHXRxmj9IE8elTxqiPRS6fb4wzEMcG9yRVJHGUMO+v27Ist6amDARfMHLx1uQwy84ocyvc//qRVNfQOKrNy/HG4b/ZWT4QP/gyJBJ+7JDKxAZUOxaw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586148073;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=UrjGaTpbsLPI18L/84g9pFMxbZz4/+j5nzb/9aYt9z8=; 
 b=gwATeAnTVDT9fm5knKJe/0DitCeTlfvV9axY0ouI46KG3JK8qoKK4nfzc+ZM9AtRhG+5Pg05he++jW2FwGX5a2xhzY46/kL3k3uejEQNKrE2q85jOOznb5q7x/feN8/N2YVte8dlrE6TJSNqh2fOpCCIv21Yom+JVT9DIy4JjLs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586148068225917.0282468296472;
 Sun, 5 Apr 2020 21:41:08 -0700 (PDT)
In-Reply-To: <20200406035016.609-1-bowen.wang@intel.com>
Subject: Re: [PATCH] hax: Dynamic allocate vcpu state structure
Message-ID: <158614806661.1460.17647585306143207307@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: bowen.wang@intel.com
Date: Sun, 5 Apr 2020 21:41:08 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: bowen.wang@intel.com, wenchao.wang@intel.com, qemu-devel@nongnu.org,
 colin.xu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwNjAzNTAxNi42MDkt
MS1ib3dlbi53YW5nQGludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBoYXg6IER5bmFtaWMgYWxsb2NhdGUgdmNwdSBz
dGF0ZSBzdHJ1Y3R1cmUKTWVzc2FnZS1pZDogMjAyMDA0MDYwMzUwMTYuNjA5LTEtYm93ZW4ud2Fu
Z0BpbnRlbC5jb20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowZjI5OTA4IGhheDogRHluYW1p
YyBhbGxvY2F0ZSB2Y3B1IHN0YXRlIHN0cnVjdHVyZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJS
T1I6IHNwYWNlIHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBicmFjZSAneycKIzQ1OiBGSUxFOiB0
YXJnZXQvaTM4Ni9oYXgtYWxsLmM6MjYyOgorICAgIGlmIChtYXhfY3B1cyA+IEhBWF9NQVhfVkNQ
VSl7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQ2OiBGSUxFOiB0YXJnZXQvaTM4
Ni9oYXgtYWxsLmM6MjYzOgorICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkZhaWxlZCB0byBjcmVh
dGUgdm0sIG1heGltdW0gcG9zc2libGUgVkNQVSBudW1iZXIgc3VwcG9ydGVkIGJ5IFFFTVUgaXMg
JWRcbiIsIEhBWF9NQVhfVkNQVSk7CgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBv
cGVuIGJyYWNlICd7JwojNTI6IEZJTEU6IHRhcmdldC9pMzg2L2hheC1hbGwuYzoyNjk6CisgICAg
Zm9yKGkgPSAwOyBpIDwgdm0tPm51bXZjcHVzOyBpKyspewoKRVJST1I6IHNwYWNlIHJlcXVpcmVk
IGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzUyOiBGSUxFOiB0YXJnZXQvaTM4Ni9o
YXgtYWxsLmM6MjY5OgorICAgIGZvcihpID0gMDsgaSA8IHZtLT5udW12Y3B1czsgaSsrKXsKCkVS
Uk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJz0nIChjdHg6VnhWKQojNTM6IEZJTEU6
IHRhcmdldC9pMzg2L2hheC1hbGwuYzoyNzA6CisgICAgICAgIHZtLT52Y3B1c1tpXT1OVUxMOwog
ICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogNSBlcnJvcnMsIDAgd2FybmluZ3MsIDg1IGxp
bmVzIGNoZWNrZWQKCkNvbW1pdCAwZjI5OTA4OGJkNzUgKGhheDogRHluYW1pYyBhbGxvY2F0ZSB2
Y3B1IHN0YXRlIHN0cnVjdHVyZSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MDYwMzUwMTYu
NjA5LTEtYm93ZW4ud2FuZ0BpbnRlbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

