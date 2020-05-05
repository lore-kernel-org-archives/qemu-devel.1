Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACAEC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0B092068E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 08:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B092068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVssq-0002fq-PH
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 04:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVsri-0001Dy-1T
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:23:46 -0400
Resent-Date: Tue, 05 May 2020 04:23:46 -0400
Resent-Message-Id: <E1jVsri-0001Dy-1T@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVsrh-00044X-2r
 for qemu-devel@nongnu.org; Tue, 05 May 2020 04:23:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588667020; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HxFOuyrt5fJp0LROZ3BPBhpUNli/CtTCYj4Xn6tJrLcotZg+01m27UfH1Fi/HR+Ohia/S4rpZl4moGCIp2YPxLbdYtHAB9nImSz52tngGDviJscuCEruK+MzSJmIKKSZKu7OOLuFXReKCXp5ZJUBjlDwldD6b8DL0GD7iKJfgcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588667020;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=oRC6V4vbomi9rndBy59iDkgyEcHAGSliHAg3qMjL630=; 
 b=QkbDYkoRXkAVtYVbOrwa3bukIVHElBbFFYEZWIfhqkGFBnJ41Ijtio+BaqFa87QAkmpPtQ6V716WGharHXF5bc0cCqaTkpsDSzhhEPHRWueC/Ge51c1u6/J4FCM7sRrHojNgJUF3kEpDX2s92eo7TsbsZvD67EAD6c1MCfMOkA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588667019037650.7481432547995;
 Tue, 5 May 2020 01:23:39 -0700 (PDT)
Message-ID: <158866701783.24779.8664836395868070369@45ef0f9c86ae>
In-Reply-To: <87tv0vzrwj.fsf@dusky.pond.sub.org>
Subject: Re: Infinite loop in bus_unparent(), qdev bug or qdev misuse?
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: armbru@redhat.com
Date: Tue, 5 May 2020 01:23:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 04:16:46
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS84N3R2MHZ6cndqLmZzZkBkdXNr
eS5wb25kLnN1Yi5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxkIHRlc3Qgb24g
RnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxsIGJlIGludm9r
ZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0byBhIGNvbW1p
dCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIKIyBicmFuY2gK
aWYgcWVtdS1zeXN0ZW0teDg2XzY0IC0taGVscCA+L2Rldi9udWxsIDI+JjE7IHRoZW4KICBRRU1V
PXFlbXUtc3lzdGVtLXg4Nl82NAplbGlmIC91c3IvbGliZXhlYy9xZW11LWt2bSAtLWhlbHAgPi9k
ZXYvbnVsbCAyPiYxOyB0aGVuCiAgUUVNVT0vdXNyL2xpYmV4ZWMvcWVtdS1rdm0KZWxzZQogIGV4
aXQgMQpmaQptYWtlIHZtLWJ1aWxkLWZyZWVic2QgSj0yMSBRRU1VPSRRRU1VCmV4aXQgMAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy84N3R2MHZ6cndqLmZzZkBkdXNreS5wb25kLnN1Yi5vcmcvdGVz
dGluZy5GcmVlQlNELz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

