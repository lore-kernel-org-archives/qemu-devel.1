Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5E0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2C720776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 10:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2C720776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdXAd-0003kj-6J
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 06:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX7c-00071K-KE; Tue, 26 May 2020 06:47:48 -0400
Resent-Date: Tue, 26 May 2020 06:47:48 -0400
Resent-Message-Id: <E1jdX7c-00071K-KE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21775)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jdX7b-0002BU-4M; Tue, 26 May 2020 06:47:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590490049; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hG1Gu6Frg6dRqE4Uj5E4Zw+/xPPlHS0ILk6gG5jhIPSbBmoh9o+0Q5s0NtPgRv5pVg75sewb4kLwL1eE4j7YS41Mz/ArB5eyUxhndjCjb40MZAxDYcY2IoUAxEd8x4fxT3L5gYNHRf/8YuOszOPn08frlvkuGjZCZedGuyk6NvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590490049;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Y/DyOfcdQL00VO0GKUl/NvS+qPS4wZohghKFC9nPQSw=; 
 b=Cugp61F9zm0qZoEgkzhOi699ksuIsLZJAq/h1+Qw4FnciS1CNvC5TKj583rrMrk2O4Xrgi3P2bgMG9hyoO5uJyFRYV+uZFQUcX1dIaoRDC2y46+CAdfKbbCRUKPgmoKb/H87M6tQJRBDflS4rJpd8r3qi0PMljK3nGVcxts9Qr4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159049004653043.47033956487644;
 Tue, 26 May 2020 03:47:26 -0700 (PDT)
Message-ID: <159049004463.9494.8302673029620017182@45ef0f9c86ae>
In-Reply-To: <20200526081740.256236-1-rvkagan@yandex-team.ru>
Subject: Re: [PATCH v5 0/5] block: widen and check consistency of size-related
 BlockConf properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: rvkagan@yandex-team.ru
Date: Tue, 26 May 2020 03:47:26 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, kraxel@redhat.com,
 stefanha@redhat.com, kbusch@kernel.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyNjA4MTc0MC4yNTYy
MzYtMS1ydmthZ2FuQHlhbmRleC10ZWFtLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRv
IGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1v
cmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUyNjA4MTc0MC4yNTYyMzYtMS1ydmth
Z2FuQHlhbmRleC10ZWFtLnJ1ClN1YmplY3Q6IFtQQVRDSCB2NSAwLzVdIGJsb2NrOiB3aWRlbiBh
bmQgY2hlY2sgY29uc2lzdGVuY3kgb2Ygc2l6ZS1yZWxhdGVkIEJsb2NrQ29uZiBwcm9wZXJ0aWVz
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQg
cmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNr
cGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0
aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8g
YSBuZXcgYnJhbmNoICd0ZXN0Jwo2NjExYzUzIGJsb2NrOiBsaWZ0IGJsb2Nrc2l6ZSBwcm9wZXJ0
eSBsaW1pdCB0byAyIE1pQgoxZWZlMDk0IGJsb2NrOiBtYWtlIHNpemUtcmVsYXRlZCBCbG9ja0Nv
bmYgcHJvcGVydGllcyBhY2NlcHQgc2l6ZSBzdWZmaXhlcwpmOWQ4OGRmIHFkZXYtcHJvcGVydGll
czogYmxvY2tzaXplOiB1c2Ugc2FtZSBsaW1pdHMgaW4gY29kZSBhbmQgZGVzY3JpcHRpb24KYmVl
NjZjZiBibG9jazogY29uc29saWRhdGUgYmxvY2tzaXplIHByb3BlcnRpZXMgY29uc2lzdGVuY3kg
Y2hlY2tzCjhiMmZkYzEgdmlydGlvLWJsazogc3RvcmUgb3B0X2lvX3NpemUgd2l0aCBjb3JyZWN0
IHNpemUKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21taXQgOGIyZmRjMWIx
OGIyICh2aXJ0aW8tYmxrOiBzdG9yZSBvcHRfaW9fc2l6ZSB3aXRoIGNvcnJlY3Qgc2l6ZSkKMi81
IENoZWNraW5nIGNvbW1pdCBiZWU2NmNmZGU3NmYgKGJsb2NrOiBjb25zb2xpZGF0ZSBibG9ja3Np
emUgcHJvcGVydGllcyBjb25zaXN0ZW5jeSBjaGVja3MpCjMvNSBDaGVja2luZyBjb21taXQgZjlk
ODhkZjRjMDNlIChxZGV2LXByb3BlcnRpZXM6IGJsb2Nrc2l6ZTogdXNlIHNhbWUgbGltaXRzIGlu
IGNvZGUgYW5kIGRlc2NyaXB0aW9uKQo0LzUgQ2hlY2tpbmcgY29tbWl0IDFlZmUwOTRiNzYzNyAo
YmxvY2s6IG1ha2Ugc2l6ZS1yZWxhdGVkIEJsb2NrQ29uZiBwcm9wZXJ0aWVzIGFjY2VwdCBzaXpl
IHN1ZmZpeGVzKQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzIwMDogRklMRTogaHcv
Y29yZS9xZGV2LXByb3BlcnRpZXMuYzoxMjQ0OgorICAgICAgICAgICAgICAgICAgIlByb3BlcnR5
ICVzLiVzIGRvZXNuJ3QgdGFrZSB2YWx1ZSAnJSIgUFJJZDY0ICInLCBpdCdzIG5vdCBhIHBvd2Vy
IG9mIDIiLAoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDcwIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDQvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1p
dCA2NjExYzUzODkxNWEgKGJsb2NrOiBsaWZ0IGJsb2Nrc2l6ZSBwcm9wZXJ0eSBsaW1pdCB0byAy
IE1pQikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAyMDA1MjYwODE3NDAuMjU2MjM2LTEtcnZrYWdhbkB5YW5kZXgtdGVhbS5ydS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

