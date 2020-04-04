Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA0C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 02:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD982063A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 02:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD982063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKYxF-0004Ad-DI
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 22:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jKYwY-0003gK-KS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 22:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jKYwW-00081U-Ds
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 22:53:57 -0400
Resent-Date: Fri, 03 Apr 2020 22:53:57 -0400
Resent-Message-Id: <E1jKYwW-00081U-Ds@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jKYwW-0007yq-6F; Fri, 03 Apr 2020 22:53:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585968801; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HvaRFzwxBlp9pbxJkPeHGR5WZJWMPTDCQR9K/YyQrYUyCLmxb/bfb+Jfopg4NcduSfAcN9IIxAb6hcr7B/URwafp4J7RtWzINyB03QO2QOzCn8qtS8W3bAdzZ6huRN5vNfMpc0bt5UiClXLA7edDH/pS4FlVCGQtN+gn8+jt1VU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585968801;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=W3PIw/zztqZcCyZiNeN9sqJsIgG+Tlao/X2X9V4+r6g=; 
 b=Z/HaJZfrM59RXzCuq5nv4ijIqpVSPcSrI38dYze9SimqDWrJTKt+YM0wQ1oBJ2G1IvRLjpTqzwagYMvlJsdyl3lsIfm+M5ez7aCmYHQ3KR2mMZt89K+HxfE9lLqs01A5HoG/nxioYHmu3yH1OeAd+t0b4OkZpz69hAyqsBSS45U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585968797208487.2354965944198;
 Fri, 3 Apr 2020 19:53:17 -0700 (PDT)
In-Reply-To: <20200403165752.18009-1-berto@igalia.com>
Subject: Re: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Message-ID: <158596879542.23425.4558100332300922178@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Fri, 3 Apr 2020 19:53:17 -0700 (PDT)
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, pbutsykin@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwMzE2NTc1Mi4xODAw
OS0xLWJlcnRvQGlnYWxpYS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKTm90IHJ1bjogMjU5CkZhaWx1cmVz
OiAwNTMKRmFpbGVkIDEgb2YgMTE2IGlvdGVzdHMKbWFrZTogKioqIFtjaGVjay10ZXN0cy9jaGVj
ay1ibG9jay5zaF0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgogIFRFU1QgICAgY2hlY2stcXRlc3QtYWFyY2g2NDogdGVzdHMvcXRlc3QvcW9zLXRlc3QK
VHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxlZFBy
b2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBD
b21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9YmJlZGQ3MDM3MzNkNDdlMDk0NTNlZTVkOWFlMTM1ZTEnLCAnLXUn
LCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScs
ICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1l
JywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEn
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdTRvaWxsNmUvc3JjL2RvY2tlci1zcmMuMjAyMC0w
NC0wMy0yMi4zOS4xNC4yODgzMTovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
YmJlZGQ3MDM3MzNkNDdlMDk0NTNlZTVkOWFlMTM1ZTEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtdTRvaWxsNmUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE0bTEuNTQ2cwp1c2VyICAgIDBtOC40OTdzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDQw
MzE2NTc1Mi4xODAwOS0xLWJlcnRvQGlnYWxpYS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2Vu
dG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

