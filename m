Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45822C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17163205CB
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 08:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17163205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jglH2-0004OM-CN
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 04:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jglGR-0003uv-UL
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:30:15 -0400
Resent-Date: Thu, 04 Jun 2020 04:30:15 -0400
Resent-Message-Id: <E1jglGR-0003uv-UL@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jglGQ-0005c4-7S
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 04:30:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591259406; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lcX0GudWMdFG8SonAhAad+FZuuNw8Wlyi0tuYspdQBr8tbnFMWkh02BElFAcqKY916wfpuKoSJ0YX+oRJw3X1p4iSQqyWYWP/fLnyYRYDiGf7iYykDAHMR34aatryFBQDuyP6X9dmglayDL7oSZPOM42kaXH9DtW8d5cEEBNJ9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591259406;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=gKKVtoUn+j2eLEoj9tfvCvNchaqEmGCjVXX1qVHJcgQ=; 
 b=lEd4LIU6XZOOVbzEOf7lZc6rB1k6CuRgACMhanTKRLneDXVVyj3PKwXl2tBSi0zazJjjzLCDrRANaH2UeRdKu6ZJBsQoh/xgE0+y/+aqI3uzJxUxoqns1t20fp8+9Gi2EkaKsBVWP4DkOwy2UyM8zfSJZx1d/f8Z8Kb3AbxHQJc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591259404325514.993724496234;
 Thu, 4 Jun 2020 01:30:04 -0700 (PDT)
Message-ID: <159125940304.7948.16142619625477813745@45ef0f9c86ae>
In-Reply-To: <20200604075943.7001-1-kraxel@redhat.com>
Subject: Re: [PATCH 0/2] build qxl as module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Thu, 4 Jun 2020 01:30:04 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 04:23:52
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, dinechin@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNDA3NTk0My43MDAx
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBHRU4gICAgIGRvY3Mv
aW50ZXJvcC9xZW11LXFtcC1yZWYuNwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRl
c3Qvc3JjL2h3L2Rpc3BsYXkvcXhsLmg6MTAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3Fl
bXUtdGVzdC9zcmMvaHcvZGlzcGxheS9xeGwuYzozNzoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1
ZGUvdWkvc3BpY2UtZGlzcGxheS5oOjIxOjEwOiBmYXRhbCBlcnJvcjogc3BpY2UuaDogTm8gc3Vj
aCBmaWxlIG9yIGRpcmVjdG9yeQogI2luY2x1ZGUgPHNwaWNlLmg+CiAgICAgICAgICBefn5+fn5+
fn4KY29tcGlsYXRpb24gdGVybWluYXRlZC4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC90bXAvcWVt
dS10ZXN0L3NyYy9ody9kaXNwbGF5L3F4bC5oOjEwLAogICAgICAgICAgICAgICAgIGZyb20gL3Rt
cC9xZW11LXRlc3Qvc3JjL2h3L2Rpc3BsYXkvcXhsLWxvZ2dlci5jOjI0OgovdG1wL3FlbXUtdGVz
dC9zcmMvaW5jbHVkZS91aS9zcGljZS1kaXNwbGF5Lmg6MjE6MTA6IGZhdGFsIGVycm9yOiBzcGlj
ZS5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CiAjaW5jbHVkZSA8c3BpY2UuaD4KICAgICAg
ICAgIF5+fn5+fn5+fgpjb21waWxhdGlvbiB0ZXJtaW5hdGVkLgogIEFTICAgICAgcGMtYmlvcy9v
cHRpb25yb20vbXVsdGlib290Lm8KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMu
bWFrOjY5OiBody9kaXNwbGF5L3F4bC5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCiAgQVMgICAgICBwYy1iaW9zL29wdGlvbnJvbS9saW51eGJvb3Qu
bwptYWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2Rpc3BsYXkv
cXhsLWxvZ2dlci5vXSBFcnJvciAxCiAgQ0MgICAgICBwYy1iaW9zL29wdGlvbnJvbS9saW51eGJv
b3RfZG1hLm8KICBBUyAgICAgIHBjLWJpb3Mvb3B0aW9ucm9tL2t2bXZhcGljLm8KICBBUyAgICAg
IHBjLWJpb3Mvb3B0aW9ucm9tL3B2aC5vCi0tLQogIEJVSUxEICAgcGMtYmlvcy9vcHRpb25yb20v
bXVsdGlib290LmltZwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2h3
L2Rpc3BsYXkvcXhsLmg6MTAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9z
cmMvaHcvZGlzcGxheS9xeGwtcmVuZGVyLmM6MjM6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRl
L3VpL3NwaWNlLWRpc3BsYXkuaDoyMToxMDogZmF0YWwgZXJyb3I6IHNwaWNlLmg6IE5vIHN1Y2gg
ZmlsZSBvciBkaXJlY3RvcnkKICNpbmNsdWRlIDxzcGljZS5oPgogICAgICAgICAgXn5+fn5+fn5+
CmNvbXBpbGF0aW9uIHRlcm1pbmF0ZWQuCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1
bGVzLm1hazo2OTogaHcvZGlzcGxheS9xeGwtcmVuZGVyLm9dIEVycm9yIDEKICBCVUlMRCAgIHBj
LWJpb3Mvb3B0aW9ucm9tL2xpbnV4Ym9vdC5pbWcKICBCVUlMRCAgIHBjLWJpb3Mvb3B0aW9ucm9t
L2t2bXZhcGljLmltZwogIEJVSUxEICAgcGMtYmlvcy9vcHRpb25yb20vbXVsdGlib290LnJhdwot
LS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3Mu
Q2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1
bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NDEyZmMxN2E0YWI4NGI5MmI5
M2E2NGY2ZjdjMzM2NWQnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21w
PXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFf
Q09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9
JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1w
L2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1lZjEyc2c3cC9z
cmMvZG9ja2VyLXNyYy4yMDIwLTA2LTA0LTA0LjI1LjA3LjI0NTY4Oi92YXIvdG1wL3FlbXU6eixy
bycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJl
dHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20u
cWVtdS5pbnN0YW5jZS51dWlkPTQxMmZjMTdhNGFiODRiOTJiOTNhNjRmNmY3YzMzNjVkCm1ha2Vb
MV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBg
L3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWVmMTJzZzdwL3NyYycKbWFrZTogKioqIFtkb2Nr
ZXItcnVuLXRlc3QtbWluZ3dAZmVkb3JhXSBFcnJvciAyCgpyZWFsICAgIDRtNTYuNjg3cwp1c2Vy
ICAgIDBtOC4yODNzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYwNDA3NTk0My43MDAxLTEta3JheGVsQHJlZGhhdC5jb20vdGVzdGlu
Zy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

