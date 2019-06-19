Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE8FC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A9B2183F
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A9B2183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdc1X-0006V1-68
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hdc03-0005TM-BH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hdbys-00056J-Vc
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:54:36 -0400
Resent-Date: Wed, 19 Jun 2019 10:54:36 -0400
Resent-Message-Id: <E1hdbys-00056J-Vc@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hdbyq-00052Y-Iz
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:54:33 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560956054; cv=none; d=zoho.com; s=zohoarc; 
 b=dV+1Uc8K3mV2g7kLj5V56b9Mx5se/jwLAuT/fqetXIIs5OP3DQmRXbh1Jg8aKCfj1VRubD3zBVzyRj+12KVPh5/0HyFCpBAN1DPcTJ2mdovyfSaCaNh8AlNYVOKN+4LZ95gI+fM07pmvekU2ynXBMb1G0I65Ng0KU0s55a6n5J4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560956054;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=rxFwGHqbHHUzVwmTm84cvzca7/eyqk/yXNS3SebexZA=; 
 b=M9461DH41RoNmMVzNKKv3vtYjjUNLR++YfRQQgHVLTVOR2GZdlG4KxbMIN/STqSbsYbqL/B54ZVTRiCIe2WZUXSSJrt+Z/qKQcVkL6wXNjyhqywSh3yS0luVbkEFzF28U5OrRQCO2nYnaFYsZ3/UWIabIPXQxcZjHKgXVm/AblU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560956051685813.0168833658159;
 Wed, 19 Jun 2019 07:54:11 -0700 (PDT)
In-Reply-To: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
Message-ID: <156095605075.27251.13698390698984913809@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Wed, 19 Jun 2019 07:54:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v12 0/5]
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYwOTUzODM0LTI5NTg0LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBb
UEFUQ0ggdjEyIDAvNV0KVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NjA5NTM4MzQtMjk1ODQt
MS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251
bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFs
Z29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNl
Li4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNo
ZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAgICAgIHBhdGNoZXcvMTU2MDk1
MzgzNC0yOTU4NC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29t
IC0+IHBhdGNoZXcvMTU2MDk1MzgzNC0yOTU4NC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIu
bWFya292aWNAcnQtcmsuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZGE5NDU4
OGY2OCBsaW51eC11c2VyOiBGaXggZmxvY2sgc3RydWN0dXJlIGZvciBNSVBTIE82NCBBQkkKNjFh
OTk4MGFjYSBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Igc3RyYWNlIGZvciBzdGF0eCgpIHN5
c2NhbGwKNTA1OGM5Y2ZjNyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24g
b2Ygc3RhdHgoKSBzeXNjYWxsCjdiNzFkMWI2NWEgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9y
IHNldHNvY2tvcHQoKSBvcHRpb24gU09MX0FMRwoxNzQ5MDNlN2E5IGxpbnV4LXVzZXI6IEFkZCBz
dXBwb3J0IGZvciBzZXRzb2Nrb3B0KCkgb3B0aW9ucyBJUFY2XzxBRER8RFJPUD5fTUVNQkVSU0hJ
UAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1pdCAxNzQ5MDNlN2E5N2Mg
KGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzZXRzb2Nrb3B0KCkgb3B0aW9ucyBJUFY2XzxB
RER8RFJPUD5fTUVNQkVSU0hJUCkKMi81IENoZWNraW5nIGNvbW1pdCA3YjcxZDFiNjVhMzQgKGxp
bnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzZXRzb2Nrb3B0KCkgb3B0aW9uIFNPTF9BTEcpCjMv
NSBDaGVja2luZyBjb21taXQgNTA1OGM5Y2ZjN2RlIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBm
b3IgdHJhbnNsYXRpb24gb2Ygc3RhdHgoKSBzeXNjYWxsKQpXQVJOSU5HOiBhcmNoaXRlY3R1cmUg
c3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojNjA6IEZJTEU6IGxpbnV4LXVzZXIv
c3lzY2FsbC5jOjMyMzoKKyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9zdGF0eCkgJiYgZGVmaW5lZChf
X05SX3N0YXR4KQoKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxk
IGJlIGF2b2lkZWQKIzcyOiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzo2NTI5OgorI2lmIGRl
ZmluZWQoVEFSR0VUX05SX3N0YXR4KSAmJiBkZWZpbmVkKF9fTlJfc3RhdHgpCgpXQVJOSU5HOiBh
cmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojMTQyOiBGSUxF
OiBsaW51eC11c2VyL3N5c2NhbGwuYzoxMDIzOToKKyNpZiBkZWZpbmVkKF9fTlJfc3RhdHgpCgp0
b3RhbDogMCBlcnJvcnMsIDMgd2FybmluZ3MsIDIwNyBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzUg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNC81IENoZWNraW5nIGNvbW1pdCA2MWE5OTgwYWNh
ZjggKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzdHJhY2UgZm9yIHN0YXR4KCkgc3lzY2Fs
bCkKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhl
IGRlY2xhcmF0aW9uCiMyNzogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzo5Nzk6CitVTlVTRUQg
c3RhdGljIHN0cnVjdCBmbGFncyBzdGF0eF9mbGFnc1tdID0gewoKRVJST1I6IHN0b3JhZ2UgY2xh
c3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM0OTogRklM
RTogbGludXgtdXNlci9zdHJhY2UuYzoxMDAxOgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mg
c3RhdHhfbWFza1tdID0gewoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggNC81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzUgQ2hlY2tp
bmcgY29tbWl0IGRhOTQ1ODhmNjg3ZCAobGludXgtdXNlcjogRml4IGZsb2NrIHN0cnVjdHVyZSBm
b3IgTUlQUyBPNjQgQUJJKQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQg
d2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8xNTYwOTUzODM0LTI5NTg0LTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5t
YXJrb3ZpY0BydC1yay5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


