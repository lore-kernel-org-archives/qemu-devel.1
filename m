Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02FA206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FA206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7D5-0000fV-Vo
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg7Bt-00070h-2S
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:42:53 -0400
Resent-Date: Tue, 02 Jun 2020 09:42:53 -0400
Resent-Message-Id: <E1jg7Bt-00070h-2S@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg7Bq-0006Pk-ML
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:42:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591105362; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XtJtXoH5ZaDb0OOAzePlY3fll10Nrg+wFPzk4KUYspmo+RewV04LzkmR2pXZE2JzsDzYPh0Jsn/0DkHQ3DCGyDGspGjwWL0TepZMW0VexU86nMLsShjrBIgYOQd5bSMkvPHvlt47ni6WFkDoTEeYHsyeU7GI9zcvKFcW9wCb0Xk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591105362;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JLIHhs9A73jFCozU2+NLdLOo4EfX5fk4d3vT7+S+d4E=; 
 b=O/QXpWnFCnH8COv/jJwcof4QucCBhMBKR15H+GWN6rbs2X+5yKW9OMjIdjBGlgYYh9RbixNp+PlxEeNnOEfRuUXpJgUMJyf/SQnOx0Mk9I7b+Ae67rj5Ct/RJhEwKquD5wRuFna2K7u0IHwI6BRHuVGSAZ2HntuIxws8J89T35s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591105360023761.4720915540548;
 Tue, 2 Jun 2020 06:42:40 -0700 (PDT)
Message-ID: <159110535897.18153.16227717409361479133@45ef0f9c86ae>
In-Reply-To: <20200602115331.1659-1-filip.bozuta@syrmia.com>
Subject: Re: [PATCH 0/5] Add strace support for printing arguments of selected
 syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: filip.bozuta@syrmia.com
Date: Tue, 2 Jun 2020 06:42:40 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:42:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjExNTMzMS4xNjU5
LTEtZmlsaXAuYm96dXRhQHN5cm1pYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNjAyMTE1MzMxLjE2NTktMS1maWxpcC5i
b3p1dGFAc3lybWlhLmNvbQpTdWJqZWN0OiBbUEFUQ0ggMC81XSBBZGQgc3RyYWNlIHN1cHBvcnQg
Zm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBzZWxlY3RlZCBzeXNjYWxscwpUeXBlOiBzZXJpZXMK
Cj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNl
ID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1p
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9j
YWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFp
bGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMy
MWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3Bh
dGNoZXctcHJvamVjdC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA1Mjky
MjE0NTAuMjY2NzMtMS1hbHhuZHJAYnUuZWR1IC0+IHBhdGNoZXcvMjAyMDA1MjkyMjE0NTAuMjY2
NzMtMS1hbHhuZHJAYnUuZWR1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYjU1MDc2
NSBsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBv
ZiBmYWxsb2NhdGUoKQo1MzMwMTQ2IGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
cHJpbnRpbmcgYXJndW1lbnRzIG9mIGNob3duKCkvbGNob3duKCkKOTg5ZTRlNyBsaW51eC11c2Vy
OiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBsc2VlaygpCmI3
ODNhZDQgbGludXgtdXNlcjogQWRkIHN0cmFjZSBzdXBwb3J0IGZvciBwcmludGluZyBhcmd1bWVu
dCBvZiBzeXNjYWxscyB1c2VkIGZvciBleHRlbmQgYXR0cmlidXRlcwozZThhNWIwIGxpbnV4LXVz
ZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBzeXNjYWxscwoKPT09IE9VVFBV
VCBCRUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1pdCAzZThhNWIwZWI0OGEgKGxpbnV4LXVzZXI6
IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgYSBncm91cCBvZiBzeXNjYWxscykKMi81IENoZWNraW5n
IGNvbW1pdCBiNzgzYWQ0YmY2MmUgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3Ig
cHJpbnRpbmcgYXJndW1lbnQgb2Ygc3lzY2FsbHMgdXNlZCBmb3IgZXh0ZW5kIGF0dHJpYnV0ZXMp
CjMvNSBDaGVja2luZyBjb21taXQgOTg5ZTRlNzczZmFlIChsaW51eC11c2VyOiBBZGQgc3RyYWNl
IHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3VtZW50cyBvZiBsc2VlaygpKQpXQVJOSU5HOiBCbG9j
ayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjQ6IEZJTEU6
IGxpbnV4LXVzZXIvc3RyYWNlLmM6MTc5NzoKKyAgICAgICAgcWVtdV9sb2coIiAvKiBTRUVLXz8/
PyAqLyIpOwoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA0NiBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAzLzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNC81IENoZWNraW5nIGNvbW1pdCA1
MzMwMTQ2N2ZlODIgKGxpbnV4LXVzZXI6IEFkZCBzdHJhY2Ugc3VwcG9ydCBmb3IgcHJpbnRpbmcg
YXJndW1lbnRzIG9mIGNob3duKCkvbGNob3duKCkpCjUvNSBDaGVja2luZyBjb21taXQgYjU1MDc2
NTc1YTJhIChsaW51eC11c2VyOiBBZGQgc3RyYWNlIHN1cHBvcnQgZm9yIHByaW50aW5nIGFyZ3Vt
ZW50cyBvZiBmYWxsb2NhdGUoKSkKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRo
ZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM2NTogRklMRTogbGludXgtdXNlci9zdHJh
Y2UuYzoxMTE2OgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3MgZmFsbG9jX2ZsYWdzW10gPSB7
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDgyIGxpbmVzIGNoZWNrZWQKClBhdGNoIDUv
NSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA2MDIxMTUzMzEuMTY1OS0xLWZpbGlwLmJvenV0
YUBzeXJtaWEuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

