Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7DAC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBC720737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 09:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBC720737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKILU-0001Nx-4a
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 05:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jKIKt-0000sA-ET
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jKIKr-00032F-OM
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 05:09:59 -0400
Resent-Date: Fri, 03 Apr 2020 05:09:59 -0400
Resent-Message-Id: <E1jKIKr-00032F-OM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jKIKr-0002tU-GJ; Fri, 03 Apr 2020 05:09:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585904988; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fArIqLChuQPMHwNPFklwbcxnUB2ZyUc7xNQExRa05EHczAzR5dVk01Ck2g8uHdn+muSeiZMWvJ8bKlQVi3SGGptdIT3cveltUKGOmT8F+byVFaXHrMw5yAMzUoKYXTqehg7WYX9J+97VHJgIwtnE/TSpePMM+v17QSzRGbAOrBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585904988;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mSlohC5U6hBzdM3B6EVhtntx+4ziHJbtkkdHYccyZdg=; 
 b=QU2LKs3GcLQEqrci+MkGG9JdWVol6Ftc881eVpdgspygbjb9dXK/sd7sVBsaNkJ84lk67gLd1U/BCNUsoq54/fKguseoL+YC0c08I/kAf93wl5QVq0VM9egNYRiTQvR2AFM2SLrA3fUV1Xei10pEQHRhO1OnkCAtFeSmDL0P/20=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585904983591144.60493158944462;
 Fri, 3 Apr 2020 02:09:43 -0700 (PDT)
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
Subject: Re: [PATCH v2 00/12] acpi: i386 tweaks
Message-ID: <158590498219.23425.1045940191072602966@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Fri, 3 Apr 2020 02:09:43 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, imammedo@redhat.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 jsnow@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMzA4MDUwMi44MTU0
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKYWNwaS10ZXN0OiBXYXJuaW5nISBE
U0RUIGJpbmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2FtbDovdG1wL2FtbC03RUhPSTBdLCBF
eHBlY3RlZCBbYW1sOnRlc3RzL2RhdGEvYWNwaS9wYy9EU0RUXS4KU2VlIHNvdXJjZSBmaWxlIHRl
c3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3IgaW5zdHJ1Y3Rpb25zIG9uIGhvdyB0byB1
cGRhdGUgZXhwZWN0ZWQgZmlsZXMuCnRvIHNlZSBBU0wgZGlmZiBiZXR3ZWVuIG1pc21hdGNoZWQg
ZmlsZXMgaW5zdGFsbCBJQVNMLCByZWJ1aWxkIFFFTVUgZnJvbSBzY3JhdGNoIGFuZCByZS1ydW4g
dGVzdHMgd2l0aCBWPTEgZW52aXJvbm1lbnQgdmFyaWFibGUgc2V0KioKRVJST1I6L3RtcC9xZW11
LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzo0OTE6dGVzdF9hY3BpX2Fz
bDogYXNzZXJ0aW9uIGZhaWxlZDogKGFsbF90YWJsZXNfbWF0Y2gpCkVSUk9SIC0gQmFpbCBvdXQh
IEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6
NDkxOnRlc3RfYWNwaV9hc2w6IGFzc2VydGlvbiBmYWlsZWQ6IChhbGxfdGFibGVzX21hdGNoKQpt
YWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBm
b3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIFRFU1QgICAgY2hlY2stdW5pdDogdGVzdHMvdGVzdC1o
Yml0bWFwCiAgVEVTVCAgICBjaGVjay11bml0OiB0ZXN0cy90ZXN0LWJkcnYtZHJhaW4KLS0tCiAg
ICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxl
ZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAn
LS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPTdhZDE0NjNhODZjODRmYjM4YzNkMDU2
OGY1YzNlN2IyJywgJy11JywgJzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNv
bmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJ
R1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICct
ZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12
JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2Nh
Y2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTQyZ2QyZ29vL3NyYy9k
b2NrZXItc3JjLjIwMjAtMDQtMDMtMDQuNTMuMTMuNTEyNTovdmFyL3RtcC9xZW11Onoscm8nLCAn
cWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJu
ZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9N2FkMTQ2M2E4NmM4NGZiMzhjM2QwNTY4ZjVjM2U3YjIKbWFrZVsxXTog
KioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFy
L3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNDJnZDJnb28vc3JjJwptYWtlOiAqKiogW2RvY2tlci1y
dW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE2bTI5LjIxNHMKdXNlciAg
ICAwbTguODQ2cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAyMDA0MDMwODA1MDIuODE1NC0xLWtyYXhlbEByZWRoYXQuY29tL3Rlc3Rpbmcu
ZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

