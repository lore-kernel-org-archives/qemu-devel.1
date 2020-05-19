Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89BDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA6D2081A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA6D2081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Pp-0003CK-NL
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jb5O0-0001UL-JV
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:46:36 -0400
Resent-Date: Tue, 19 May 2020 12:46:36 -0400
Resent-Message-Id: <E1jb5O0-0001UL-JV@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jb5Ny-0005YI-Py
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589906778; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J6n2+vAGcNvvsJ0aA4iSJ5NlcJf39C1vMvrIsZ9AeIw4BdZattZ3CDiiBCBMeUQt82aCOMMaHuHn8uxLFYBuCHYv32CNKBZwEv2p8eho+Z2FfhWQRqOTlBiEv2XFoVh90j2UvvblAXPxEbyrE1RiXaSehPDnYeXtKSw4BSJKk6E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589906778;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=89aX4COzLHEGPUVN/MHrH7XFDLTaOD6up4GFXpHc+sw=; 
 b=ECAB2srvFEbOH8jKW2hufDbs1xP/FCeF0NaCBg+w+rKitAvnewGfn1m0HpxXqKrfXtP2OdNGmtDR1U9+jcYzaZ9VcBStinreY17tdyEmi/SktHOw65cSP7LAEUyr+CH8OvW3IHAgJDNAY04Z6fFLeSQzCrhfzwGzZDv8B3YW+5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589906776159610.1156520240578;
 Tue, 19 May 2020 09:46:16 -0700 (PDT)
Message-ID: <158990677467.13497.15634757771693162183@45ef0f9c86ae>
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
Subject: Re: [PATCH v3 00/10] vhost-user: Lift Max Ram Slots Limitation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: raphael.norwitz@nutanix.com
Date: Tue, 19 May 2020 09:46:16 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 12:46:29
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
Cc: raphael.s.norwitz@gmail.com, mst@redhat.com, qemu-devel@nongnu.org,
 raphael.norwitz@nutanix.com, marcandre.lureau@gmail.com,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTg4NDczNjgzLTI3MDY3LTEt
Z2l0LXNlbmQtZW1haWwtcmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tLwoKCgpIaSwKClRoaXMg
c2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVn
QGZlZG9yYSBUQVJHRVRfTElTVD14ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVT
VCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIGJhY2tlbmRzL3JuZy1idWlsdGluLm8KICBDQyAg
ICAgIGJhY2tlbmRzL3RwbS5vCiAgQ0MgICAgICBiYWNrZW5kcy9ybmctcmFuZG9tLm8KL3RtcC9x
ZW11LXRlc3Qvc3JjL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmM6NjcxOjQy
OiBlcnJvcjogdGFraW5nIGFkZHJlc3Mgb2YgcGFja2VkIG1lbWJlciAncGF5bG9hZCcgb2YgY2xh
c3Mgb3Igc3RydWN0dXJlICdWaG9zdFVzZXJNc2cnIG1heSByZXN1bHQgaW4gYW4gdW5hbGlnbmVk
IHBvaW50ZXIgdmFsdWUgWy1XZXJyb3IsLVdhZGRyZXNzLW9mLXBhY2tlZC1tZW1iZXJdCiAgICBW
aG9zdFVzZXJNZW1vcnlSZWdpb24gKm1zZ19yZWdpb24gPSAmdm1zZy0+cGF5bG9hZC5tZW1yZWcu
cmVnaW9uOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUtdGVzdC9zcmMvY29udHJpYi9saWJ2aG9zdC11
c2VyL2xpYnZob3N0LXVzZXIuYzo3ODQ6NDI6IGVycm9yOiB0YWtpbmcgYWRkcmVzcyBvZiBwYWNr
ZWQgbWVtYmVyICdwYXlsb2FkJyBvZiBjbGFzcyBvciBzdHJ1Y3R1cmUgJ1Zob3N0VXNlck1zZycg
bWF5IHJlc3VsdCBpbiBhbiB1bmFsaWduZWQgcG9pbnRlciB2YWx1ZSBbLVdlcnJvciwtV2FkZHJl
c3Mtb2YtcGFja2VkLW1lbWJlcl0KICAgIFZob3N0VXNlck1lbW9yeVJlZ2lvbiAqbXNnX3JlZ2lv
biA9ICZ2bXNnLT5wYXlsb2FkLm1lbXJlZy5yZWdpb247CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CjIgZXJyb3JzIGdl
bmVyYXRlZC4KbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBjb250
cmliL2xpYnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2NCwgaW4gPG1v
ZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTE5MWM2ZTA3OGRl
OTQzY2RhMWVkZmZlMjE2NDBhZTI3JywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9eDg2XzY0LXNv
ZnRtbXUnLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywg
J0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVf
RElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1k
b2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXct
dGVzdGVyLXRtcC1yaDh0eGIzdy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTE5LTEyLjQyLjUzLjI3
MTg3Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcvdmFyL3RtcC9xZW11L3J1
bicsICd0ZXN0LWRlYnVnJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRl
cj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTE5MWM2ZTA3OGRlOTQzY2Rh
MWVkZmZlMjE2NDBhZTI3Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFd
OiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLXJoOHR4YjN3
L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtZGVidWdAZmVkb3JhXSBFcnJvciAyCgpy
ZWFsICAgIDNtMjEuMjAxcwp1c2VyICAgIDBtOC4wMDdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTg4NDczNjgzLTI3MDY3LTEtZ2l0LXNl
bmQtZW1haWwtcmFwaGFlbC5ub3J3aXR6QG51dGFuaXguY29tL3Rlc3RpbmcuYXNhbi8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

