Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A662DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8294A208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8294A208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDMx-0005Ya-QT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlD6x-0000ss-Gq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:02:52 -0400
Resent-Date: Tue, 16 Jun 2020 11:02:51 -0400
Resent-Message-Id: <E1jlD6x-0000ss-Gq@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlD6t-0006YQ-CC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:02:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592319756; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=h0XIgXAB9X4zhuW+QSpUIENl8ykqJsblnJGAkPWkzxI3ogGjl3SkQOCMMfj0JMmA1efPI0s0iTrgVb1b8encn+39XzJjWgp1t7qhCSrCTqG0gDGQd1fdcbNABovQcMqHHtSgho4lu3R5Nb7w2hdgG+yBw399k6VON1HJm0eVHlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592319756;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=WTFJ0lCrrgZ+EQsCRS7VifNq1WtLP58Zg/tp/gkyi50=; 
 b=VGdHlXvdSYE060vAh7Z5sVD5xPMLJsww0lyc0vP2b4thD6GPgvaYRANDlWasdmSmCuOLAqd5Q+sB6vVen85lydzckCQewSi3DID7uYS3DwVGwYPjfULhKMCgD6Lz2LwhAk+fj/CJNhumQns7x/bsqEn2diPoXzvs+Vebib3kKLc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592319752260462.925225260788;
 Tue, 16 Jun 2020 08:02:32 -0700 (PDT)
Message-ID: <159231975128.8107.705730976028764844@d1fd068a5071>
Subject: Re: [PATCH v4 0/6] Add strace support for printing arguments of
 selected syscalls
In-Reply-To: <20200616103927.20222-1-filip.bozuta@syrmia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Tue, 16 Jun 2020 08:02:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 10:15:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNjEwMzkyNy4yMDIy
Mi0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjQgMC82XSBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBzZWxlY3RlZCBzeXNjYWxscwpUeXBlOiBzZXJp
ZXMKTWVzc2FnZS1pZDogMjAyMDA2MTYxMDM5MjcuMjAyMjItMS1maWxpcC5ib3p1dGFAc3lybWlh
LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNl
IGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKNzU2NjA0ZSBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBmYWxsb2NhdGUoKQoyNTY4MGQ1IGxpbnV4LXVzZXI6
IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGNob3duKCkvbGNo
b3duKCkKY2FkZDY1ZCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5n
IGFyZ3VtZW50cyBvZiBsc2VlaygpCmViNDA2MjcgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBw
b3J0IGZvciBwcmludGluZyBhcmd1bWVudCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmRlZCBh
dHRyaWJ1dGVzCjQ3MjI2ZTggbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBhIGdy
b3VwIG9mIHN5c2NhbGxzCjNlNTMxZDAgbGludXgtdXNlcjogRXh0ZW5kIHN0cmFjZSBzdXBwb3J0
IHRvIGVuYWJsZSBhcmd1bWVudCBwcmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1dGlvbgoKPT09
IE9VVFBVVCBCRUdJTiA9PT0KMS82IENoZWNraW5nIGNvbW1pdCAzZTUzMWQwNDcwZDIgKGxpbnV4
LXVzZXI6IEV4dGVuZCBzdHJhY2Ugc3VwcG9ydCB0byBlbmFibGUgYXJndW1lbnQgcHJpbnRpbmcg
YWZ0ZXIgc3lzY2FsbCBleGVjdXRpb24pCjIvNiBDaGVja2luZyBjb21taXQgNDcyMjZlODY3NGE3
IChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMp
CjMvNiBDaGVja2luZyBjb21taXQgZWI0MDYyN2IxMTk2IChsaW51eC11c2VyOiBBZGQgc3RyYWNl
IHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVu
ZGVkIGF0dHJpYnV0ZXMpCjQvNiBDaGVja2luZyBjb21taXQgY2FkZDY1ZDlmODY2IChsaW51eC11
c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBsc2Vlaygp
KQo1LzYgQ2hlY2tpbmcgY29tbWl0IDI1NjgwZDVlMWIwMSAobGludXgtdXNlcjogQWRkIHN0cmFj
ZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKSkKNi82
IENoZWNraW5nIGNvbW1pdCA3NTY2MDRlZWZlMDYgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3Vw
cG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpKQpFUlJPUjogc3RvcmFn
ZSBjbGFzcyBzaG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzY5
OiBGSUxFOiBsaW51eC11c2VyL3N0cmFjZS5jOjExNDY6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBm
bGFncyBmYWxsb2NfZmxhZ3NbXSA9IHsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA0
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYvNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09
IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTYx
MDM5MjcuMjAyMjItMS1maWxpcC5ib3p1dGFAc3lybWlhLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

