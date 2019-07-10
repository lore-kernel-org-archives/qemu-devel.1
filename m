Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40F8C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C8120844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C8120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJcp-0000HV-UL
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlJbt-0007qd-7r
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlJbr-0000Yw-2D
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:54:40 -0400
Resent-Date: Wed, 10 Jul 2019 16:54:40 -0400
Resent-Message-Id: <E1hlJbr-0000Yw-2D@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlJbq-0000VA-Ft
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562792053; cv=none; d=zoho.com; s=zohoarc; 
 b=Nensz3ZZK40Q+/fVQq6gpnOBk/8Tno6ADYudMmpr+x3w9Bgsrj0OA6IdEqQdgGfagQOFdfVfFSdTzKVrabEmEd7KMbEA4iZ3S3M1V/cuN8fhPGwAnUEhtUBEPv0VyLMAyIE5quBJ2q8or729PMGoW4f+TJTZNPq5RVTSP+geaPs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562792053;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OmBYen+6PmJmKiJX9dAaTxb8QncqF53K/tFkEJtKm/0=; 
 b=D5B5Z0wwhL2++K8+T+3LQSB47Hz4QAQmFC57P4GYT3PlJQIslykXMpiVPE0fjxFvvYJ9K4jeNK5ElzF59TAyO+9qme9+Iqs5HgpP867Dhu8IqQ+08/FuL+TOQx1HU0mt8INjHDjcbHHWuBBMpSnFhnQS08AmAsKk5sKgePnF0C4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562792052303420.14554292743105;
 Wed, 10 Jul 2019 13:54:12 -0700 (PDT)
Message-ID: <156279205106.7449.9428591736937282769@c4a48874b076>
In-Reply-To: <20190710202219.25939-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: brijesh.singh@amd.com
Date: Wed, 10 Jul 2019 13:54:12 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 00/13] Add SEV guest live migration
 support
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
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, ehabkost@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxMDIwMjIxOS4yNTkz
OS0xLWJyaWplc2guc2luZ2hAYW1kLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVp
bGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxs
IGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0
byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIK
IyBicmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09IgplbnYKCmVjaG8KZWNobyAi
PT09IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0gVU5BTUUgPT09Igp1bmFt
ZSAtYQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQV0QvYnVp
bGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JDL2NvbmZp
Z3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2UgbmVlZCBy
ZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwKPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhbHBoYS1zb2Z0bW11L2h3L3Njc2kvdmlydGlv
LXNjc2ktZGF0YXBsYW5lLm8KL3Vzci9iaW4vbGQ6IHFhcGkvcWFwaS1jb21tYW5kcy1taXNjLXRh
cmdldC5vOiBpbiBmdW5jdGlvbiBgcW1wX21hcnNoYWxfbWlncmF0ZV9zZXRfc2V2X2luZm8nOgov
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaWluam8xYmkvc3JjL2J1aWxkL3FhcGkvcWFwaS1j
b21tYW5kcy1taXNjLXRhcmdldC5jOjM2MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcW1wX21p
Z3JhdGVfc2V0X3Nldl9pbmZvJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBz
dGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFlbXUtc3lzdGVtLWNyaXNdIEVycm9y
IDEKbWFrZTogKioqIFtNYWtlZmlsZTo0NzI6IGNyaXMtc29mdG1tdS9hbGxdIEVycm9yIDIKbWFr
ZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KLS0tCiAgQ0MgICAgICBhYXJj
aDY0LXNvZnRtbXUvaHcvbWlzYy9iY20yODM1X21ib3gubwovdXNyL2Jpbi9sZDogcWFwaS9xYXBp
LWNvbW1hbmRzLW1pc2MtdGFyZ2V0Lm86IGluIGZ1bmN0aW9uIGBxbXBfbWFyc2hhbF9taWdyYXRl
X3NldF9zZXZfaW5mbyc6Ci92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1paW5qbzFiaS9zcmMv
YnVpbGQvcWFwaS9xYXBpLWNvbW1hbmRzLW1pc2MtdGFyZ2V0LmM6MzYzOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBxbXBfbWlncmF0ZV9zZXRfc2V2X2luZm8nCmNvbGxlY3QyOiBlcnJvcjogbGQg
cmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjIwODogcWVtdS1z
eXN0ZW0tYWxwaGFdIEVycm9yIDEKbWFrZTogKioqIFtNYWtlZmlsZTo0NzI6IGFscGhhLXNvZnRt
bXUvYWxsXSBFcnJvciAyCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvbWlzYy9iY20yODM1
X3Byb3BlcnR5Lm8KLS0tCiAgQ0MgICAgICBhcm0tc29mdG1tdS90YXJnZXQvYXJtL2RlYnVnX2hl
bHBlci5vCi91c3IvYmluL2xkOiBxYXBpL3FhcGktY29tbWFuZHMtbWlzYy10YXJnZXQubzogaW4g
ZnVuY3Rpb24gYHFtcF9tYXJzaGFsX21pZ3JhdGVfc2V0X3Nldl9pbmZvJzoKL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLWlpbmpvMWJpL3NyYy9idWlsZC9xYXBpL3FhcGktY29tbWFuZHMtbWlz
Yy10YXJnZXQuYzozNjM6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHFtcF9taWdyYXRlX3NldF9z
ZXZfaW5mbycKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2Vb
MV06ICoqKiBbTWFrZWZpbGU6MjA4OiBxZW11LXN5c3RlbS1hYXJjaDY0XSBFcnJvciAxCm1ha2U6
ICoqKiBbTWFrZWZpbGU6NDcyOiBhYXJjaDY0LXNvZnRtbXUvYWxsXSBFcnJvciAyCiAgR0VOICAg
ICBhcm0tc29mdG1tdS90YXJnZXQvYXJtL2RlY29kZS12ZnAuaW5jLmMKLS0tCiAgTElOSyAgICBh
cm0tc29mdG1tdS9xZW11LXN5c3RlbS1hcm0KL3Vzci9iaW4vbGQ6IHFhcGkvcWFwaS1jb21tYW5k
cy1taXNjLXRhcmdldC5vOiBpbiBmdW5jdGlvbiBgcW1wX21hcnNoYWxfbWlncmF0ZV9zZXRfc2V2
X2luZm8nOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaWluam8xYmkvc3JjL2J1aWxkL3Fh
cGkvcWFwaS1jb21tYW5kcy1taXNjLXRhcmdldC5jOjM2MzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
byBgcW1wX21pZ3JhdGVfc2V0X3Nldl9pbmZvJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVk
IDEgZXhpdCBzdGF0dXMKbWFrZVsxXTogKioqIFtNYWtlZmlsZToyMDg6IHFlbXUtc3lzdGVtLWFy
bV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQ3MjogYXJtLXNvZnRtbXUvYWxsXSBFcnJv
ciAyCj09PSBPVVRQVVQgRU5EID09PQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0
cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA3MTAyMDIyMTkuMjU5MzktMS1icmlqZXNoLnNpbmdo
QGFtZC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


