Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7852C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B592073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B592073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjUG0-0000oj-Tl
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjTLi-0003kz-CA
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:58:54 -0400
Resent-Date: Thu, 11 Jun 2020 15:58:54 -0400
Resent-Message-Id: <E1jjTLi-0003kz-CA@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jjTLf-0003qf-NC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:58:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591905524; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KCkepbiye3Ku6PYji+JZs99DmTsagtJVSBpb9s4buZxENMp3W/K2Dv5+y5fwZVtg07CmphYv+ejfYcEV7pqFbuOWnNEKUscxaulvfEbEqMHcbvNouduzgZhbkTAukjouwDXKwEQseoL7icVY4UG4TPKCdzMxJDkaFmT6l4Etgrc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591905524;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=7ZdqJiHVi2ZloZxWY4Ab4JKfr2yw1NfC0wk5p0j6aok=; 
 b=bGdznN1pO83kGgdgfmJHVu2oJfe0VQZaPj7aJM/oOa+qigmuy6A+9qWzYeTinuGwMRR9UlJOeXoTtfM0jRkKu43qnO/1nGgGslzzaBUGe2YPCcaF+TfpZfZS3kpxDOEq38UyEq8IpQNcDf4NA9YKZntbtvfjYTG0m3Rk4By3l5A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591905521126471.9547008095499;
 Thu, 11 Jun 2020 12:58:41 -0700 (PDT)
Message-ID: <159190552015.1247.16865942639831593414@45ef0f9c86ae>
In-Reply-To: <20200611155109.3648-1-filip.bozuta@syrmia.com>
Subject: Re: [PATCH v3 0/6] Add strace support for printing arguments of
 selected syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Thu, 11 Jun 2020 12:58:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 15:58:49
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxMTE1NTEwOS4zNjQ4
LTEtZmlsaXAuYm96dXRhQHN5cm1pYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNjExMTU1MTA5LjM2NDgtMS1maWxpcC5i
b3p1dGFAc3lybWlhLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjMgMC82XSBBZGQgc3RyYWNlIHN1cHBv
cnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBzZWxlY3RlZCBzeXNjYWxscwpUeXBlOiBzZXJp
ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBi
YXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKMDEzZmQ1YiBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50
aW5nIGFyZ3VtZW50cyBvZiBmYWxsb2NhdGUoKQo1ZTZkYjFjIGxpbnV4LXVzZXI6IEFkZCBzdHJh
Y2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcgYXJndW1lbnRzIG9mIGNob3duKCkvbGNob3duKCkKMWE2
OGYwZCBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50
cyBvZiBsc2VlaygpCmY2Mjg3YTIgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBw
cmludGluZyBhcmd1bWVudCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmRlZCBhdHRyaWJ1dGVz
CmE2YmUwYjUgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBhIGdyb3VwIG9mIHN5
c2NhbGxzCjA2NWRlOTAgbGludXgtdXNlcjogRXh0ZW5kIHN0cmFjZSBzdXBwb3J0IHRvIGVuYWJs
ZSBhcmd1bWVudCBwcmludGluZyBhZnRlciBzeXNjYWxsIGV4ZWN1dGlvbgoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS82IENoZWNraW5nIGNvbW1pdCAwNjVkZTkwMjgwNzMgKGxpbnV4LXVzZXI6IEV4
dGVuZCBzdHJhY2Ugc3VwcG9ydCB0byBlbmFibGUgYXJndW1lbnQgcHJpbnRpbmcgYWZ0ZXIgc3lz
Y2FsbCBleGVjdXRpb24pCjIvNiBDaGVja2luZyBjb21taXQgYTZiZTBiNTVlNmU1IChsaW51eC11
c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIGEgZ3JvdXAgb2Ygc3lzY2FsbHMpCjMvNiBDaGVj
a2luZyBjb21taXQgZjYyODdhMjM1MzdlIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIHByaW50aW5nIGFyZ3VtZW50IG9mIHN5c2NhbGxzIHVzZWQgZm9yIGV4dGVuZGVkIGF0dHJp
YnV0ZXMpCjQvNiBDaGVja2luZyBjb21taXQgMWE2OGYwZGM5MWIzIChsaW51eC11c2VyOiBBZGQg
c3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBsc2VlaygpKQo1LzYgQ2hl
Y2tpbmcgY29tbWl0IDVlNmRiMWNjYjY3YyAobGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0
IGZvciBwcmludGluZyBhcmd1bWVudHMgb2YgY2hvd24oKS9sY2hvd24oKSkKNi82IENoZWNraW5n
IGNvbW1pdCAwMTNmZDViOGJlMmYgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
cHJpbnRpbmcgYXJndW1lbnRzIG9mIGZhbGxvY2F0ZSgpKQpFUlJPUjogc3RvcmFnZSBjbGFzcyBz
aG91bGQgYmUgYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgZGVjbGFyYXRpb24KIzcwOiBGSUxFOiBs
aW51eC11c2VyL3N0cmFjZS5jOjExNDc6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBmYWxs
b2NfZmxhZ3NbXSA9IHsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTA0IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDYvNiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MTExNTUxMDkuMzY0
OC0xLWZpbGlwLmJvenV0YUBzeXJtaWEuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

