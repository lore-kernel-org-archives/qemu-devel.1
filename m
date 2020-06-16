Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39967C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059692078D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059692078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIDD-00011E-AU
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlICe-0000HV-Sv; Tue, 16 Jun 2020 16:29:04 -0400
Resent-Date: Tue, 16 Jun 2020 16:29:04 -0400
Resent-Message-Id: <E1jlICe-0000HV-Sv@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jlICc-00079Q-AW; Tue, 16 Jun 2020 16:29:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592339320; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nVbpeeSYbh1BRAp89QxBiCVe28OsGholhUE5uYT2/qN+txjBIT6AHl9BAC3G9Ww7iL42HsWqJ5gAAHeOBd4mFM6Sn2Mn8ZKjSsGWX/B7fvTltK8cU+EHcljlvp/WfuYRa3c3diiycbJBU8PQEQycSNejX12MGijSv6nLUmQtfzE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592339320;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=w4mpMyzXLvX7y+0PGrt7SXEH0j1hSxlNh2h4W1RWe3g=; 
 b=NWe/HyKsjfb/1CaEiBcvPRP0myqXitXF8jnrtFtU9mXDD5WFLL1YZi4bxgoQzyJdpRV3eEtLwqpB1P3/YUZ0+5R38cYPrrqLJanegilgjVkWehtVhk7hyEEFoxkJUEZOOlaceSAzwZKv6yQVM0sc0CwkJF0HN0/3JGhshV/HHkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592339318597240.28253489928113;
 Tue, 16 Jun 2020 13:28:38 -0700 (PDT)
Message-ID: <159233931679.9045.8660578431308415612@d1fd068a5071>
Subject: Re: [PATCH v4 0/4] block: seriously improve savevm performance
In-Reply-To: <20200616162035.29857-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: den@openvz.org
Date: Tue, 16 Jun 2020 13:28:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 16:28:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, dplotnikov@virtuozzo.com, stefanha@redhat.com,
 den@openvz.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYxNjE2MjAzNS4yOTg1
Ny0xLWRlbkBvcGVudnoub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjQgMC80XSBibG9jazogc2VyaW91c2x5IGltcHJvdmUg
c2F2ZXZtIHBlcmZvcm1hbmNlClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDYxNjE2MjAz
NS4yOTg1Ny0xLWRlbkBvcGVudnoub3JnCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU1MTgyNmUgYmxvY2svaW86IGltcHJvdmUg
c2F2ZXZtIHBlcmZvcm1hbmNlCjgxYTkzZmQgYmxvY2ssIG1pZ3JhdGlvbjogYWRkIGJkcnZfZmx1
c2hfdm1zdGF0ZSBoZWxwZXIKMDVlMzM5NSBibG9jay9haW9fdGFzazogZHJvcCBhaW9fdGFza19w
b29sX3dhaXRfb25lKCkgaGVscGVyCjYxZTBjZTMgYmxvY2svYWlvX3Rhc2s6IGFsbG93IHN0YXJ0
L3dhaXQgdGFzayBmcm9tIGFueSBjb3JvdXRpbmUKZDA0YTcxNiBtaWdyYXRpb24vc2F2ZXZtOiBy
ZXNwZWN0IHFlbXVfZmNsb3NlKCkgZXJyb3IgY29kZSBpbiBzYXZlX3NuYXBzaG90KCkKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgZDA0YTcxNjBkMmMwIChtaWdyYXRp
b24vc2F2ZXZtOiByZXNwZWN0IHFlbXVfZmNsb3NlKCkgZXJyb3IgY29kZSBpbiBzYXZlX3NuYXBz
aG90KCkpCjIvNSBDaGVja2luZyBjb21taXQgNjFlMGNlMzJkMzIwIChibG9jay9haW9fdGFzazog
YWxsb3cgc3RhcnQvd2FpdCB0YXNrIGZyb20gYW55IGNvcm91dGluZSkKMy81IENoZWNraW5nIGNv
bW1pdCAwNWUzMzk1MDBhZjggKGJsb2NrL2Fpb190YXNrOiBkcm9wIGFpb190YXNrX3Bvb2xfd2Fp
dF9vbmUoKSBoZWxwZXIpCjQvNSBDaGVja2luZyBjb21taXQgODFhOTNmZGY3NGE5IChibG9jaywg
bWlncmF0aW9uOiBhZGQgYmRydl9mbHVzaF92bXN0YXRlIGhlbHBlcikKV0FSTklORzogQmxvY2sg
Y29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzkzOiBGSUxFOiBp
bmNsdWRlL2Jsb2NrL2Jsb2NrLmg6NTc1OgorLyogYmRydl9mbHVzaF92bXN0YXRlKCkgaXMgbWFu
ZGF0b3J5IHRvIGNvbW1pdCB2bXN0YXRlIGNoYW5nZXMgaWYKCldBUk5JTkc6IEJsb2NrIGNvbW1l
bnRzIHVzZSAqIG9uIHN1YnNlcXVlbnQgbGluZXMKIzk0OiBGSUxFOiBpbmNsdWRlL2Jsb2NrL2Js
b2NrLmg6NTc2OgorLyogYmRydl9mbHVzaF92bXN0YXRlKCkgaXMgbWFuZGF0b3J5IHRvIGNvbW1p
dCB2bXN0YXRlIGNoYW5nZXMgaWYKKyAgIGJkcnZfc2F2ZV92bXN0YXRlKCkgd2FzIGV2ZXIgY2Fs
bGVkICovCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNl
cGFyYXRlIGxpbmUKIzk0OiBGSUxFOiBpbmNsdWRlL2Jsb2NrL2Jsb2NrLmg6NTc2OgorICAgYmRy
dl9zYXZlX3Ztc3RhdGUoKSB3YXMgZXZlciBjYWxsZWQgKi8KCkVSUk9SOiBicmFjZXMge30gYXJl
IG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBzdGF0ZW1lbnQKIzEwODogRklMRTogbWln
cmF0aW9uL3NhdmV2bS5jOjE1NDoKKyAgICBpZiAoZXJyIDwgMCkKWy4uLl0KCnRvdGFsOiAxIGVy
cm9ycywgMyB3YXJuaW5ncywgNjAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC81IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo1LzUgQ2hlY2tpbmcgY29tbWl0IDU1MTgyNmU0YWU2NiAoYmxvY2sv
aW86IGltcHJvdmUgc2F2ZXZtIHBlcmZvcm1hbmNlKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1
c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojMTMyOiBGSUxFOiBibG9jay9pby5j
OjI3MTE6CisgICAgICAgIC8qIENhbGxlciBpcyByZXNwb25zaWJsZSBmb3IgY2xlYW51cC4gV2Ug
c2hvdWxkIGJsb2NrIGFsbCBmdXJ0aGVyCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSB0
cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzEzMzogRklMRTogYmxvY2svaW8uYzoyNzEy
OgorICAgICAgICAgKiBzYXZlIG9wZXJhdGlvbnMgZm9yIHRoaXMgZXhhY3Qgc3RhdGUgKi8KCnRv
dGFsOiAwIGVycm9ycywgMiB3YXJuaW5ncywgMTc5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvNSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYxNjE2MjAzNS4yOTg1Ny0xLWRlbkBvcGVudnoub3Jn
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

