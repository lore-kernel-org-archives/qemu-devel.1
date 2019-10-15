Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C7ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CEC20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CEC20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQVJ-0001XG-8d
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iKQUf-0000yU-7n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iKQUd-0002yr-T2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:20:21 -0400
Resent-Date: Tue, 15 Oct 2019 13:20:21 -0400
Resent-Message-Id: <E1iKQUd-0002yr-T2@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iKQUa-0002wZ-IM; Tue, 15 Oct 2019 13:20:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571159987; cv=none; d=zoho.com; s=zohoarc; 
 b=TL5UmkmCV5ia9Am98BNh2OuSZbL8r5F8jXIULiGNXPDNqa00bF8ymu7r4r6D6uIWFLBpBJxKgeUrSWLWHWvT2DDiE5Pe5JlKs5xtLAAn4xTE12f8Jwhq5b7SUBdF5fI8posSBy6XsckdGvasDNK/SugdIsNYOmA4qiVLdvB7HCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1571159987;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Aqh5MrCD51ln0ZisFt8LyBN3Xb1lxcypGjm0uTJawJ4=; 
 b=EZhnC4VzedN2XsVwEv1ORgCfxeW21+P88hZFgVM0W+8x+/WMD1/oXOTSH8W7XxUx65Uf4go1OnVCxPNqxIRciYMnReDU9BGtU9D99Xg819s6uU3U1Q1K7pAhsNIEHMbShRQLqFCBZSKpdZD05jXtAdISUSJNVVJZlVIF89OlwdM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571159985851860.0421652292138;
 Tue, 15 Oct 2019 10:19:45 -0700 (PDT)
In-Reply-To: <20191015103900.313928-1-its@irrelevant.dk>
Subject: Re: [PATCH v2 00/20] nvme: support NVMe v1.3d,
 SGLs and multiple namespaces
Message-ID: <157115998396.5946.7933572824392833452@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Tue, 15 Oct 2019 10:19:45 -0700 (PDT)
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
Cc: kwolf@redhat.com, fam@euphon.net, javier@javigon.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, keith.busch@intel.com,
 Paul.Durrant@citrix.com, sbates@raithlin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxNTEwMzkwMC4zMTM5
MjgtMS1pdHNAaXJyZWxldmFudC5kay8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcv
bWlzYy9pbXg3X2dwci5vCiAgQ0MgICAgICBody9taXNjL21zdF9mcGdhLm8KL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2Jsb2NrL252bWUuYzogSW4gZnVuY3Rpb24gJ252bWVfbWFwX3BycCc6Ci90bXAv
cWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6MjMyOjQyOiBlcnJvcjogY2FzdCB0byBwb2lu
dGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJvcj1pbnQtdG8tcG9pbnRl
ci1jYXN0XQogICAgICAgICAgICAgICAgIHRyYWNlX252bWVfZXJyX2FkZHJfcmVhZCgodm9pZCAq
KSBwcnAyKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1w
L3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5jOjI1ODo1MDogZXJyb3I6IGNhc3QgdG8gcG9p
bnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUgWy1XZXJyb3I9aW50LXRvLXBvaW50
ZXItY2FzdF0KICAgICAgICAgICAgICAgICAgICAgICAgIHRyYWNlX252bWVfZXJyX2FkZHJfcmVh
ZCgodm9pZCAqKSBwcnBfZW50KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6IEluIGZ1
bmN0aW9uICdudm1lX21hcF9zZ2wnOgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5j
OjQxNDo0MjogZXJyb3I6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50
IHNpemUgWy1XZXJyb3I9aW50LXRvLXBvaW50ZXItY2FzdF0KICAgICAgICAgICAgICAgICB0cmFj
ZV9udm1lX2Vycl9hZGRyX3JlYWQoKHZvaWQgKikgYWRkcik7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUu
Yzo0Mjk6Mzg6IGVycm9yOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVu
dCBzaXplIFstV2Vycm9yPWludC10by1wb2ludGVyLWNhc3RdCiAgICAgICAgICAgICB0cmFjZV9u
dm1lX2Vycl9hZGRyX3JlYWQoKHZvaWQgKikgYWRkcik7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5jOjQ3ODoz
ODogZXJyb3I6IGNhc3QgdG8gcG9pbnRlciBmcm9tIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUg
Wy1XZXJyb3I9aW50LXRvLXBvaW50ZXItY2FzdF0KICAgICAgICAgICAgIHRyYWNlX252bWVfZXJy
X2FkZHJfcmVhZCgodm9pZCAqKSBhZGRyKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6NDkzOjM0OiBlcnJv
cjogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJv
cj1pbnQtdG8tcG9pbnRlci1jYXN0XQogICAgICAgICB0cmFjZV9udm1lX2Vycl9hZGRyX3JlYWQo
KHZvaWQgKikgYWRkcik7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAv
cWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6IEluIGZ1bmN0aW9uICdudm1lX3Bvc3RfY3Fl
cyc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ody9ibG9jay9udm1lLmM6ODQ3OjM5OiBlcnJvcjogY2Fz
dCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJvcj1pbnQt
dG8tcG9pbnRlci1jYXN0XQogICAgICAgICAgICAgdHJhY2VfbnZtZV9lcnJfYWRkcl93cml0ZSgo
dm9pZCAqKSBhZGRyKTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvaHcvYmxvY2svbnZtZS5jOiBJbiBmdW5jdGlvbiAnbnZtZV9wcm9j
ZXNzX3NxJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2Jsb2NrL252bWUuYzoxOTcxOjM4OiBlcnJv
cjogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdlcnJv
cj1pbnQtdG8tcG9pbnRlci1jYXN0XQogICAgICAgICAgICAgdHJhY2VfbnZtZV9lcnJfYWRkcl9y
ZWFkKCh2b2lkICopIGFkZHIpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsv
dG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9ibG9jay9udm1lLm9dIEVycm9yIDEK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2ViYWNrIChtb3N0
IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxp
bmUgNjYyLCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRj
b2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8n
LCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1
aWQ9OGFhMGE4NWZmZjFmNDU3YzlkYzdjODI2ZDdiMzE4OWQnLCAnLXUnLCAnMTAwMScsICctLXNl
Y3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRf
TElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTJnMWJsNDFzL3NyYy9kb2NrZXItc3JjLjIwMTktMTAtMTUtMTMuMTMuNDguOTkz
Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPThhYTBhODVmZmYxZjQ1N2M5ZGM3
YzgyNmQ3YjMxODlkCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTJnMWJsNDFzL3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFs
ICAgIDVtNTYuNTIycwp1c2VyICAgIDBtNy45MTNzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxNTEwMzkwMC4zMTM5MjgtMS1pdHNA
aXJyZWxldmFudC5kay90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4K
LS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0
Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJl
ZGhhdC5jb20=


