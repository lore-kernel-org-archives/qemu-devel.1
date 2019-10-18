Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1929CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755F020854
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755F020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVTD-00032M-I1
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iLVSL-00026n-Pv
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iLVSJ-0000fA-GW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:24 -0400
Resent-Date: Fri, 18 Oct 2019 12:50:24 -0400
Resent-Message-Id: <E1iLVSJ-0000fA-GW@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iLVSJ-0000ea-96
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:50:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571417406; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ah1BBq2sj6uq9yyjUeqgU1zB+o7dgN88hiSp7hfyc2W1NRYKtJ43phIMG9OcEUL3+mp263WRVAi1q/7AknOY4BIeSuYpzkL6zQ23XFLynabUV888rNigxIqgU9NjxmR6RVfkmWS104ApNJlK3yGS4MePSNASCljE3C2dcRJD/y0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571417406;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lCRxQndVMWw580CPFSP2puM0BF6Sa+i89VhFf4OZrDE=; 
 b=mngBavJdA7mzgZLSllpuOfjCC6mxAL91tXP8Nqj64y7OkWEG6QRMb5PmIYpLQCqtG4xtsIOtY9TKnuAszwRaodaMiDEqpqLOhpSO7v7ZiUC+QzawRKWJOdY8l4ElpA+6B2knm2wVG+bABG9YGYZWI8jZr9EyUwlkBtx8xTiIj1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571417405255312.60141177390335;
 Fri, 18 Oct 2019 09:50:05 -0700 (PDT)
In-Reply-To: <20191018004850.9888-1-richardw.yang@linux.intel.com>
Subject: Re: [PATCH 0/6] migration/postcopy: enable compress during postcopy
Message-ID: <157141740394.24734.9600428911119666435@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richardw.yang@linux.intel.com
Date: Fri, 18 Oct 2019 09:50:05 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxODAwNDg1MC45ODg4
LTEtcmljaGFyZHcueWFuZ0BsaW51eC5pbnRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0
ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tl
ciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFr
ZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody90aW1lci9hbGx3aW5uZXItYTEwLXBpdC5vCkluIGZp
bGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL3JhbS5jOjI5Ogov
dG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL3JhbS5jOiBJbiBmdW5jdGlvbiAncmFtX2xvYWRf
cG9zdGNvcHknOgovdG1wL3FlbXUtdGVzdC9zcmMvbWlncmF0aW9uL3JhbS5jOjQxNzc6NTY6IGVy
cm9yOiBjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2Vy
cm9yPXBvaW50ZXItdG8taW50LWNhc3RdCiAgICAgICAgICAgICB2b2lkICpwbGFjZV9kZXN0ID0g
KHZvaWQgKilRRU1VX0FMSUdOX0RPV04oKHVuc2lnbmVkIGxvbmcpaG9zdCwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10
ZXN0L3NyYy9pbmNsdWRlL3FlbXUvb3NkZXAuaDoyNjg6MzM6IG5vdGU6IGluIGRlZmluaXRpb24g
b2YgbWFjcm8gJ1FFTVVfQUxJR05fRE9XTicKICNkZWZpbmUgUUVNVV9BTElHTl9ET1dOKG4sIG0p
ICgobikgLyAobSkgKiAobSkpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZVsxXTogKioqIFsvdG1w
L3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBtaWdyYXRpb24vcmFtLm9dIEVycm9yIDEKbWFr
ZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIHg4Nl82
NC1zb2Z0bW11L3RhcmdldC9pMzg2L2FyY2hfZHVtcC5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRt
bXUvaHcvdXNiL3R1c2I2MDEwLm8KLS0tCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJt
L3hsbngtenlucW1wLm8KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9t
aWdyYXRpb24vcmFtLmM6Mjk6Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vcmFtLmM6IElu
IGZ1bmN0aW9uICdyYW1fbG9hZF9wb3N0Y29weSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRp
b24vcmFtLmM6NDE3Nzo1NjogZXJyb3I6IGNhc3QgZnJvbSBwb2ludGVyIHRvIGludGVnZXIgb2Yg
ZGlmZmVyZW50IHNpemUgWy1XZXJyb3I9cG9pbnRlci10by1pbnQtY2FzdF0KICAgICAgICAgICAg
IHZvaWQgKnBsYWNlX2Rlc3QgPSAodm9pZCAqKVFFTVVfQUxJR05fRE9XTigodW5zaWduZWQgbG9u
Zylob3N0LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9vc2RlcC5oOjI2ODozMzog
bm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAnUUVNVV9BTElHTl9ET1dOJwogI2RlZmluZSBR
RU1VX0FMSUdOX0RPV04obiwgbSkgKChuKSAvIChtKSAqIChtKSkKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9y
cwptYWtlWzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IG1pZ3JhdGlv
bi9yYW0ub10gRXJyb3IgMQptYWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgptYWtlOiAqKiogW01ha2VmaWxlOjQ4MjogYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3Ig
MgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgptYWtlOiAqKiogW01h
a2VmaWxlOjQ4MjogeDg2XzY0LXNvZnRtbXUvYWxsXSBFcnJvciAyClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2MiwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxs
ZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJv
cjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdj
b20ucWVtdS5pbnN0YW5jZS51dWlkPTkwNTcwNDM0ODgwMzQ0MjQ5Y2ZmNzAxYmFhMTg4MTYzJywg
Jy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0t
cm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScs
ICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VO
Vj0nLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1kaDhwNmYyNy9zcmMvZG9ja2VyLXNyYy4yMDE5
LTEwLTE4LTEyLjQ3LjE5LjQxNjQ6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
OTA1NzA0MzQ4ODAzNDQyNDljZmY3MDFiYWExODgxNjMKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtZGg4cDZmMjcvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0Bm
ZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgMm00NS42OTFzCnVzZXIgICAgMG04LjM5MHMKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDE4
MDA0ODUwLjk4ODgtMS1yaWNoYXJkdy55YW5nQGxpbnV4LmludGVsLmNvbS90ZXN0aW5nLmRvY2tl
ci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


